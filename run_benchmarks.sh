#!/bin/bash
set -euo pipefail

# Prefer GPU. Allow override via CUDA_VISIBLE_DEVICES.
export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:-0}
export HF_HUB_DISABLE_TELEMETRY=1

# Resolve repo root and standard paths (prefer relative paths)
ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
RESULTS_DIR="$ROOT_DIR/results/bench_project_1/"
LOGS_DIR="$ROOT_DIR/results/bench_project_1/logs"
GPU_DIR="$ROOT_DIR/results/bench_project_1/gpu_usage"
RAW_JSON_DIR="$ROOT_DIR/results_json"

mkdir -p "$RESULTS_DIR" "$LOGS_DIR" "$GPU_DIR" "$RAW_JSON_DIR"

MAIN_LOG="$LOGS_DIR/main_loop_log.txt"
PROGRESS_LOG="$LOGS_DIR/progress.jsonl"  # structured JSONL events

# Resume behavior
# - When enabled, skip tasks that already have a completed JSON in $RESULTS_DIR
# - Default: enabled. Disable with RESUME=0 env or --no-resume flag.
RESUME=${RESUME:-1}

# CLI flags
USER_MODELS=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --no-resume)
      RESUME=0; shift ;;
    --resume)
      RESUME=1; shift ;;
    --models)
      shift
      IFS=',' read -ra USER_MODELS <<< "${1:-}"
      shift ;;
    --tasks)
      shift
      CLI_TASKS_INPUT="${1:-}"
      export TASKS="$CLI_TASKS_INPUT"
      shift ;;
    *)
      echo "[WARN] Unknown arg: $1" >&2; shift ;;
  esac
done

# List of HuggingFace-style model directories (can override via --models "path1,path2")
models=(
  "/thearray/git/ob/text-generation-webui/models/Qwen3-32B-abliterated/"
  "/thearray/git/ob/text-generation-webui/models/Qwen3-32B/"
)
if (( ${#USER_MODELS[@]} > 0 )); then
  models=("${USER_MODELS[@]}")
fi

# Benchmark tasks (customize if needed)
task="mmlu,arc_challenge,gsm8k,bbh,truthfulqa,piqa,hellaswag,winogrande,boolq,drop,triviaqa,\\
nq_open,sciq,qnli,gpqa,openbookqa,anli_r1,anli_r2,anli_r3"

# Resolve tasks list and check gated dataset access (GPQA)
# Allow override with env TASKS or CLI --tasks "a,b,c"
tasks="${TASKS:-$task}"

# Detect GPQA access via Hugging Face Hub API
if ! python <<'PY'
from huggingface_hub import HfApi, HfFolder
token = HfFolder.get_token()
assert token, "No HF token found"
HfApi().repo_info('Idavidrein/gpqa', repo_type='dataset', token=token)
print('OK')
PY
then
  echo "[WARN] GPQA access not detected on this machine; removing 'gpqa' from tasks. Run 'huggingface-cli login' to enable it." >&2
  IFS=',' read -ra _arr <<< "$tasks"
  _filtered=()
  for _t in "${_arr[@]}"; do
    if [ "$_t" != "gpqa" ]; then _filtered+=("$_t"); fi
  done
  tasks=$(IFS=','; echo "${_filtered[*]}")
fi

# CUDA device (default to first visible GPU)
device="cuda:0"

# Quick sanity checks to ensure CUDA backend is available
if ! command -v nvidia-smi >/dev/null 2>&1; then
  echo "[WARN] nvidia-smi not found. CUDA drivers may be missing; runs may fall back to CPU." >&2
fi

if ! python <<'PY'
import torch
assert torch.cuda.is_available(), "torch.cuda.is_available() is False"
print(f"[INFO] Using CUDA device: {torch.cuda.get_device_name(0)}")
PY
then
  echo "[ERROR] PyTorch CUDA not available. Install a CUDA-enabled torch build (pip install torch --index-url https://download.pytorch.org/whl/cuXXX)." >&2
  exit 1
fi

# Emit event to progress log (JSONL)
emit_event() {
  # args: type, model, task, message, extra_json
  local _type="$1"; shift || true
  local _model="$1"; shift || true
  local _task="$1"; shift || true
  local _msg="$1"; shift || true
  local _extra="${1:-}"
  local _ts
  _ts=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  printf '{"ts":"%s","event":"%s","model":"%s","task":"%s","msg":"%s"%s}\n' \
    "$_ts" "$_type" "$_model" "$_task" "$_msg" "${_extra:+,$_extra}" >> "$PROGRESS_LOG"
}

# Helper: check if a task is already done for a model (by result JSON existence)
task_done() {
  local _model_name="$1"; local _task="$2"
  local _outfile="$RESULTS_DIR/${_model_name}__${_task}.json"
  [[ -s "$_outfile" ]]
}

# Loop through models
for model_path in "${models[@]}"; do
  model_name=$(basename "$model_path")
  ERR_FILE="$LOGS_DIR/${model_name}_stderr.log"
  GPU_LOG_FILE="$GPU_DIR/${model_name}_gpu_usage.csv"

  {
    echo "== $(date '+%F %T') | start model: $model_name =="

    # Start GPU logging (60s interval). Ensure header once per process section.
    echo "==== New Run: $(date) ====" >> "$GPU_LOG_FILE"
    if command -v nvidia-smi >/dev/null 2>&1; then
      nvidia-smi --query-gpu=timestamp,utilization.gpu,memory.used --format=csv -l 60 >> "$GPU_LOG_FILE" &
      SMI_PID=$!
      trap 'kill ${SMI_PID:-0} >/dev/null 2>&1 || true' EXIT
    else
      SMI_PID=0
    fi

    IFS=',' read -ra TASKS_ARR <<< "$tasks"
    for t in "${TASKS_ARR[@]}"; do
      # Trim whitespace
      t="${t// /}"
      [[ -z "$t" ]] && continue

      OUT_FILE="$RESULTS_DIR/${model_name}__${t}.json"
      DATE_TAG=$(date +%F)
      RAW_JSON_FILE="$RAW_JSON_DIR/${model_name}_${t}_${DATE_TAG}.json"

      if [[ "$RESUME" == "1" ]] && task_done "$model_name" "$t"; then
        echo "[SKIP] $model_name / $t already has results."
        emit_event "skip" "$model_name" "$t" "already_done" "\"output\":\"$OUT_FILE\""
        continue
      fi

      echo "🔥 Starting: model=$model_name task=$t"
      emit_event "start" "$model_name" "$t" "begin" "\"output\":\"$OUT_FILE\""
      START=$(date +%s)

      set +e
      lm_eval \
        --model hf \
        --model_args pretrained="${model_path}",trust_remote_code=True,dtype=float16 \
        --tasks "$t" \
        --device "$device" \
        --batch_size auto \
        --output_path "$OUT_FILE"
      exit_code=$?
      set -e

      END=$(date +%s)
      DURATION=$((END - START))
      HOURS=$((DURATION / 3600))
      MINUTES=$(((DURATION % 3600) / 60))
      SECONDS=$((DURATION % 60))

      if [[ $exit_code -ne 0 ]]; then
        echo "❌ Failed: $model_name / $t (code=$exit_code) in ${HOURS}h ${MINUTES}m ${SECONDS}s"
        emit_event "fail" "$model_name" "$t" "exit_$exit_code" "\"duration_sec\":$DURATION,\"output\":\"$OUT_FILE\""
        # Continue to next task
        continue
      fi

      # Copy/duplicate raw JSON to results_json with date tag for historical record
      if [[ -s "$OUT_FILE" ]]; then
        cp -f "$OUT_FILE" "$RAW_JSON_FILE" || true
      fi

      echo "✅ Done: $model_name / $t in ${HOURS}h ${MINUTES}m ${SECONDS}s"
      emit_event "done" "$model_name" "$t" "ok" "\"duration_sec\":$DURATION,\"output\":\"$OUT_FILE\""
    done

    # Stop GPU logger
    if [[ ${SMI_PID:-0} -gt 0 ]]; then
      kill "$SMI_PID" >/dev/null 2>&1 || true
      wait "$SMI_PID" 2>/dev/null || true
    fi

    echo "== $(date '+%F %T') | end model: $model_name =="
  } > >(tee -a "$MAIN_LOG" | tee -a "$ERR_FILE") 2> >(tee -a "$ERR_FILE" >&2)
done

echo "🏁 ALL DONE!"
