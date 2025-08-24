#!/bin/bash

LOG_FILE="/mnt/data8tb/Documents/lm-evaluation-harness/results/bench_project_1/logs/main_loop_log.txt"
COMBINED_LOG_FILE="/mnt/data8tb/Documents/lm-evaluation-harness/results/bench_project_1/logs"

# List of HuggingFace-style model directories
models=(

    # "/mnt/data8tb/Documents/llm/llm_models/deepseek-ai_deepseek-moe-16b-base"
    # "/mnt/data8tb/Documents/llm/llm_models/Deepseek-ai_deepseek-moe-16b-chat"
    # "/mnt/data8tb/Documents/llm/llm_models/Qwen_Qwen-7B-Chat"
    # "/mnt/data8tb/Documents/llm/llm_models/Qwen_Qwen-7B"
    # "/mnt/data8tb/Documents/llm/llm_models/baichuan-inc_Baichuan2-13B-Chat"
    # "/mnt/data8tb/Documents/llm/llm_models/Qwen_Qwen2.5-14B-Instruct"
    # "/mnt/data8tb/Documents/llm/llm_models/Qwen_Qwen3-14B"


    "/mnt/data8tb/Documents/llm/llm_models/openai_gpt-oss-20b"
)

# Benchmark task (customize if needed)
task="mmlu,arc_challenge,gsm8k,bbh,truthfulqa,piqa,hellaswag,winogrande,boolq,drop,triviaqa,\
nq_open,sciq,qnli,gpqa,openbookqa,anli_r1,anli_r2,anli_r3"

# Output directory
output_dir="/mnt/data8tb/Documents/lm-evaluation-harness/results/bench_project_1/results"

# CUDA device
device="cuda:0"

        # --model_args pretrained="${model_path}",trust_remote_code=True,device_map=auto \
# Loop through models
for model_path in "${models[@]}"; do

    model_name=$(basename "$model_path")
    ERR_FILE="$COMBINED_LOG_FILE/${model_name}_stderr.log"

    {
    gpu_log_file="/mnt/data8tb/Documents/lm-evaluation-harness/results/bench_project_1/gpu_usage/${model_name}_gpu_usage.csv"

    echo "==== New Run: $(date) ====" >> "$gpu_log_file"
    nvidia-smi --query-gpu=timestamp,utilization.gpu,memory.used --format=csv -l 60 >> "$gpu_log_file" &
    SMI_PID=$!
    trap "kill $SMI_PID" EXIT  
    START=$(date +%s)

    echo "🔥 Starting benchmark for $model_name"

    output_file="${output_dir}"

    lm_eval \
        --model hf \
        --model_args pretrained="${model_path}",trust_remote_code=True,device_map=auto \
        --tasks "${task}" \
        --device "${device}" \
        --batch_size auto\
        --output_path "${output_file}" 

    
    END=$(date +%s)
    DURATION=$((END - START))

    HOURS=$((DURATION / 3600))
    MINUTES=$(((DURATION % 3600) / 60))
    SECONDS=$((DURATION % 60))

    echo "$model_name: ${HOURS}h ${MINUTES}m ${SECONDS}s"
    kill $SMI_PID

    # Check if previous command failed
    if [ $? -ne 0 ]; then
        echo "❌ Benchmark failed for $model_name. Skipping to next..."
        continue
    fi

    echo "✅ Benchmark completed for $model_name"
    echo ""
    } > >(tee -a "$LOG_FILE" | tee -a "$ERR_FILE") 2> >(tee -a "$ERR_FILE" >&2)
done

echo "🏁 ALL DONE!"



