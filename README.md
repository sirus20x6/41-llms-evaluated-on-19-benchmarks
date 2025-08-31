# 41 Open-Source LLMs Evaluated on 19 Benchmarks

This project benchmarks 41 open-source large language models across 19 evaluation tasks using the lm-evaluation-harness library.
Benchmarks are grouped into three categories, with the corresponding tasks and metrics listed below.

All evaluations were performed locally on a personal computer.

### Reasoning & Math 
Tasks: gsm8k(exact_match,strict-match), bbh(exact_match,get-answer), arc_challenge(acc_norm,none), anli_r1(acc,none), anli_r2(acc,none), anli_r3(acc,none), gpqa_main_zeroshot(acc_norm,none)
### Commonsense & Natural Language Inference 
Tasks: hellaswag(acc_norm,none), piqa(acc_norm,none), winogrande(acc,none), boolq(acc,none), openbookqa(acc_norm,none), sciq(acc_norm,none), qnli(acc,none)
### Knowledge & Reading 
Tasks: mmlu(acc,none), nq_open(exact_match,remove_whitespace), drop(f1,none), truthfulqa_mc1(acc,none), truthfulqa_mc2(acc,none), triviaqa(exact_match,remove_whitespace)


# Table Fields
### Model Name:
Models are listed as Company_ModelName.

If a model was run with quantization, (8bit) is appended to the model name.

### Total Time:
Total system runtime (wall-clock time) spent completing all benchmarks for the model.

### GPU Util Time: 
Equivalent RTX 5090 GPU time at 100% utilization. GPU utilization was logged once per minute, and the effective utilization time was calculated using the following equation:


<p align="center">
  <img src="results_json/gpu_util_equation_dark.svg#gh-dark-mode-only"  alt="Equation">
  <img src="results_json/gpu_util_equation_light.svg#gh-light-mode-only" alt="Equation">
</p>


**Where:**
- interval: 1 minute
- u_i = GPU utilization (%) during interval $i$
- Delta t = duration of interval $i$ (in seconds)

### Rank:
Overall and group ranks are calculated by averaging task scores, which are reported on a scale between 0 and 1.

### Mean Score:
Average performance across benchmark tasks, reported as the arithmetic mean of each task’s score. Values range from 0 to 1, with higher scores indicating better overall accuracy.

---
### Repository Contents
Scripts used to run the benchmarks, Jupyter notebooks for table generation, Excel and CSV files containing all fields and scores, stdout logs, result JSON files from lm-evaluation-harness, and GPU utilization logs are all included in this repository.

Benchmarks were referenced from [leobeeson/llm_benchmarks](https://github.com/leobeeson/llm_benchmarks). Detailed descriptions of each benchmark can be found in this repository.



# Overall Rank (Average Rank)
| Model Name                                | Total Time   | GPU Util Time   |   Overall Rank |   Mean Score |
|:------------------------------------------|:-------------|:----------------|---------------:|-------------:|
| google_gemma-3-12b-it                     | 15h 45m      | 14h 8m          |              1 |       0.6038 |
| Qwen_Qwen3-14B (8bit)                     | 29h 45m      | 17h 29m         |              2 |       0.5961 |
| openchat_openchat-3.6-8b-20240522         | 7h 51m       | 6h 59m          |              3 |       0.5871 |
| Qwen_Qwen3-8B                             | 15h 31m      | 13h 44m         |              4 |       0.5859 |
| Qwen_Qwen2.5-7B-Instruct                  | 9h 36m       | 8h 33m          |              5 |       0.5788 |
| Qwen_Qwen2.5-14B-Instruct (8bit)          | 52h 44m      | 29h 32m         |              6 |       0.5775 |
| 01-ai_Yi-1.5-9B                           | 11h 43m      | 10h 26m         |              7 |       0.5676 |
| Qwen_Qwen2.5-7B-Instruct-1M               | 11h 17m      | 10h 10m         |              8 |       0.5672 |
| meta-llama_Llama-3.1-8B-Instruct          | 12h 19m      | 10h 52m         |              9 |       0.5653 |
| 01-ai_Yi-1.5-9B-Chat                      | 13h 54m      | 12h 15m         |             10 |       0.5621 |
| mistralai_Ministral-8B-Instruct-2410      | 10h 46m      | 9h 27m          |             11 |       0.5576 |
| meta-llama_Meta-Llama-3-8B-Instruct       | 6h 30m       | 5h 46m          |             12 |       0.5528 |
| Qwen_Qwen3-4B                             | 5h 51m       | 5h 3m           |             13 |       0.551  |
| NousResearch_Hermes-2-Pro-Mistral-7B      | 8h 27m       | 7h 28m          |             14 |       0.548  |
| mistralai_Mistral-7B-Instruct-v0.3        | 8h 38m       | 7h 41m          |             15 |       0.5451 |
| google_gemma-3-4b-it                      | 4h 51m       | 3h 50m          |             16 |       0.5368 |
| 01-ai_Yi-1.5-6B-Chat                      | 8h 4m        | 7h 1m           |             17 |       0.5335 |
| 01-ai_Yi-1.5-6B                           | 4h 28m       | 3h 54m          |             18 |       0.5312 |
| Qwen_Qwen2-7B-Instruct                    | 11h 30m      | 10h 11m         |             19 |       0.5271 |
| deepseek-ai_DeepSeek-R1-0528-Qwen3-8B     | 17h 57m      | 15h 30m         |             20 |       0.5219 |
| meta-llama_Llama-3.2-3B-Instruct          | 7h 12m       | 5h 57m          |             21 |       0.5048 |
| Qwen_Qwen2.5-3B-Instruct                  | 7h 48m       | 6h 30m          |             22 |       0.4939 |
| Qwen_Qwen2.5-Math-7B                      | 27h 21m      | 24h 38m         |             23 |       0.4907 |
| deepseek-ai_deepseek-llm-7b-chat          | 10h 6m       | 9h 8m           |             24 |       0.4869 |
| deepseek-ai_DeepSeek-R1-Distill-Llama-8B  | 11h 46m      | 10h 36m         |             25 |       0.483  |
| meta-llama_Llama-2-13b-hf                 | 19h 21m      | 17h 38m         |             26 |       0.4819 |
| meta-llama_Llama-2-13b-chat-hf            | 17h 8m       | 15h 37m         |             27 |       0.4813 |
| deepseek-ai_DeepSeek-R1-Distill-Qwen-7B   | 6h 28m       | 5h 43m          |             28 |       0.4644 |
| Qwen_Qwen2.5-1.5B-Instruct                | 3h 20m       | 2h 36m          |             29 |       0.4608 |
| Qwen_Qwen3-1.7B                           | 4h 25m       | 3h 36m          |             30 |       0.4597 |
| Qwen_Qwen2.5-Math-7B-Instruct             | 5h 37m       | 4h 57m          |             31 |       0.4596 |
| meta-llama_Llama-2-7b-chat-hf             | 6h 57m       | 6h 7m           |             32 |       0.4525 |
| meta-llama_Llama-2-7b-hf                  | 5h 42m       | 4h 59m          |             33 |       0.4516 |
| deepseek-ai_deepseek-llm-7b-base          | 7h 11m       | 6h 26m          |             34 |       0.4451 |
| deepseek-ai_deepseek-math-7b-rl           | 8h 2m        | 7h 12m          |             35 |       0.4419 |
| meta-llama_Llama-3.2-1B-Instruct          | 3h 30m       | 2h 35m          |             36 |       0.4219 |
| google_gemma-3-1b-it                      | 6h 50m       | 4h 52m          |             37 |       0.4013 |
| deepseek-ai_DeepSeek-R1-Distill-Qwen-1.5B | 3h 40m       | 2h 52m          |             38 |       0.3986 |
| Qwen_Qwen2.5-Math-1.5B-Instruct           | 3h 25m       | 2h 39m          |             39 |       0.3838 |
| Qwen_Qwen3-0.6B                           | 3h 45m       | 2h 53m          |             40 |       0.3816 |
| Qwen_Qwen2.5-0.5B-Instruct                | 2h 34m       | 1h 48m          |             41 |       0.3799 |


# Reasoning & Math (Average Rank)

| Model Name                                | Total Time   | GPU Util Time   |   Reasoning & Math Avg. Rank |   Reasoning & Math Mean Score |
|:------------------------------------------|:-------------|:----------------|-----------------------------:|------------------------------:|
| google_gemma-3-12b-it                     | 15h 45m      | 14h 8m          |                            1 |                        0.6266 |
| Qwen_Qwen3-8B                             | 15h 31m      | 13h 44m         |                            2 |                        0.6214 |
| Qwen_Qwen3-14B (8bit)                     | 29h 45m      | 17h 29m         |                            3 |                        0.586  |
| Qwen_Qwen3-4B                             | 5h 51m       | 5h 3m           |                            4 |                        0.5712 |
| Qwen_Qwen2.5-7B-Instruct                  | 9h 36m       | 8h 33m          |                            5 |                        0.5541 |
| openchat_openchat-3.6-8b-20240522         | 7h 51m       | 6h 59m          |                            6 |                        0.5505 |
| Qwen_Qwen2.5-14B-Instruct (8bit)          | 52h 44m      | 29h 32m         |                            7 |                        0.5488 |
| mistralai_Ministral-8B-Instruct-2410      | 10h 46m      | 9h 27m          |                            8 |                        0.5446 |
| 01-ai_Yi-1.5-9B-Chat                      | 13h 54m      | 12h 15m         |                            9 |                        0.5399 |
| deepseek-ai_DeepSeek-R1-0528-Qwen3-8B     | 17h 57m      | 15h 30m         |                           10 |                        0.5387 |
| google_gemma-3-4b-it                      | 4h 51m       | 3h 50m          |                           11 |                        0.5374 |
| meta-llama_Llama-3.1-8B-Instruct          | 12h 19m      | 10h 52m         |                           12 |                        0.5366 |
| meta-llama_Meta-Llama-3-8B-Instruct       | 6h 30m       | 5h 46m          |                           13 |                        0.5286 |
| Qwen_Qwen2-7B-Instruct                    | 11h 30m      | 10h 11m         |                           14 |                        0.5285 |
| Qwen_Qwen2.5-7B-Instruct-1M               | 11h 17m      | 10h 10m         |                           15 |                        0.5245 |
| 01-ai_Yi-1.5-9B                           | 11h 43m      | 10h 26m         |                           16 |                        0.5206 |
| NousResearch_Hermes-2-Pro-Mistral-7B      | 8h 27m       | 7h 28m          |                           17 |                        0.5184 |
| Qwen_Qwen2.5-Math-7B                      | 27h 21m      | 24h 38m         |                           18 |                        0.501  |
| 01-ai_Yi-1.5-6B-Chat                      | 8h 4m        | 7h 1m           |                           19 |                        0.5006 |
| Qwen_Qwen2.5-Math-7B-Instruct             | 5h 37m       | 4h 57m          |                           20 |                        0.4997 |
| deepseek-ai_DeepSeek-R1-Distill-Qwen-7B   | 6h 28m       | 5h 43m          |                           21 |                        0.4841 |
| mistralai_Mistral-7B-Instruct-v0.3        | 8h 38m       | 7h 41m          |                           22 |                        0.4704 |
| meta-llama_Llama-3.2-3B-Instruct          | 7h 12m       | 5h 57m          |                           23 |                        0.4688 |
| 01-ai_Yi-1.5-6B                           | 4h 28m       | 3h 54m          |                           24 |                        0.4495 |
| Qwen_Qwen3-1.7B                           | 4h 25m       | 3h 36m          |                           25 |                        0.4493 |
| deepseek-ai_DeepSeek-R1-Distill-Llama-8B  | 11h 46m      | 10h 36m         |                           26 |                        0.4469 |
| deepseek-ai_deepseek-llm-7b-chat          | 10h 6m       | 9h 8m           |                           27 |                        0.4244 |
| meta-llama_Llama-2-13b-chat-hf            | 17h 8m       | 15h 37m         |                           28 |                        0.4143 |
| Qwen_Qwen2.5-Math-1.5B-Instruct           | 3h 25m       | 2h 39m          |                           29 |                        0.4085 |
| deepseek-ai_DeepSeek-R1-Distill-Qwen-1.5B | 3h 40m       | 2h 52m          |                           30 |                        0.4009 |
| Qwen_Qwen2.5-1.5B-Instruct                | 3h 20m       | 2h 36m          |                           31 |                        0.3874 |
| Qwen_Qwen2.5-3B-Instruct                  | 7h 48m       | 6h 30m          |                           32 |                        0.3823 |
| meta-llama_Llama-2-13b-hf                 | 19h 21m      | 17h 38m         |                           33 |                        0.3719 |
| deepseek-ai_deepseek-math-7b-rl           | 8h 2m        | 7h 12m          |                           34 |                        0.3702 |
| meta-llama_Llama-2-7b-chat-hf             | 6h 57m       | 6h 7m           |                           35 |                        0.3674 |
| Qwen_Qwen3-0.6B                           | 3h 45m       | 2h 53m          |                           36 |                        0.3494 |
| meta-llama_Llama-3.2-1B-Instruct          | 3h 30m       | 2h 35m          |                           37 |                        0.345  |
| deepseek-ai_deepseek-llm-7b-base          | 7h 11m       | 6h 26m          |                           38 |                        0.3377 |
| meta-llama_Llama-2-7b-hf                  | 5h 42m       | 4h 59m          |                           39 |                        0.3361 |
| google_gemma-3-1b-it                      | 6h 50m       | 4h 52m          |                           40 |                        0.3312 |
| Qwen_Qwen2.5-0.5B-Instruct                | 2h 34m       | 1h 48m          |                           41 |                        0.2914 |

# Commonsense & NLI (Average Rank)

| Model Name                                | Total Time   | GPU Util Time   |   Commonsense & NLI Avg. Rank |   Commonsense & NLI Mean Score |
|:------------------------------------------|:-------------|:----------------|------------------------------:|-------------------------------:|
| Qwen_Qwen2.5-14B-Instruct (8bit)          | 52h 44m      | 29h 32m         |                             1 |                         0.7941 |
| Qwen_Qwen3-14B (8bit)                     | 29h 45m      | 17h 29m         |                             2 |                         0.7807 |
| google_gemma-3-12b-it                     | 15h 45m      | 14h 8m          |                             3 |                         0.7737 |
| Qwen_Qwen2.5-7B-Instruct                  | 9h 36m       | 8h 33m          |                             4 |                         0.773  |
| openchat_openchat-3.6-8b-20240522         | 7h 51m       | 6h 59m          |                             5 |                         0.7726 |
| 01-ai_Yi-1.5-9B-Chat                      | 13h 54m      | 12h 15m         |                             6 |                         0.7691 |
| Qwen_Qwen2.5-7B-Instruct-1M               | 11h 17m      | 10h 10m         |                             7 |                         0.7564 |
| Qwen_Qwen3-8B                             | 15h 31m      | 13h 44m         |                             8 |                         0.7468 |
| mistralai_Mistral-7B-Instruct-v0.3        | 8h 38m       | 7h 41m          |                             9 |                         0.7403 |
| 01-ai_Yi-1.5-6B-Chat                      | 8h 4m        | 7h 1m           |                            10 |                         0.7374 |
| Qwen_Qwen2.5-3B-Instruct                  | 7h 48m       | 6h 30m          |                            11 |                         0.7367 |
| mistralai_Ministral-8B-Instruct-2410      | 10h 46m      | 9h 27m          |                            12 |                         0.7328 |
| NousResearch_Hermes-2-Pro-Mistral-7B      | 8h 27m       | 7h 28m          |                            13 |                         0.7284 |
| Qwen_Qwen2-7B-Instruct                    | 11h 30m      | 10h 11m         |                            14 |                         0.7274 |
| 01-ai_Yi-1.5-9B                           | 11h 43m      | 10h 26m         |                            15 |                         0.7266 |
| Qwen_Qwen3-4B                             | 5h 51m       | 5h 3m           |                            16 |                         0.7266 |
| meta-llama_Llama-3.1-8B-Instruct          | 12h 19m      | 10h 52m         |                            17 |                         0.7249 |
| 01-ai_Yi-1.5-6B                           | 4h 28m       | 3h 54m          |                            18 |                         0.7199 |
| google_gemma-3-4b-it                      | 4h 51m       | 3h 50m          |                            19 |                         0.7167 |
| meta-llama_Llama-2-13b-hf                 | 19h 21m      | 17h 38m         |                            20 |                         0.7157 |
| meta-llama_Llama-2-13b-chat-hf            | 17h 8m       | 15h 37m         |                            21 |                         0.7153 |
| meta-llama_Meta-Llama-3-8B-Instruct       | 6h 30m       | 5h 46m          |                            22 |                         0.7147 |
| deepseek-ai_DeepSeek-R1-0528-Qwen3-8B     | 17h 57m      | 15h 30m         |                            23 |                         0.7094 |
| deepseek-ai_deepseek-llm-7b-chat          | 10h 6m       | 9h 8m           |                            24 |                         0.709  |
| meta-llama_Llama-2-7b-chat-hf             | 6h 57m       | 6h 7m           |                            25 |                         0.6978 |
| meta-llama_Llama-2-7b-hf                  | 5h 42m       | 4h 59m          |                            26 |                         0.6956 |
| deepseek-ai_DeepSeek-R1-Distill-Llama-8B  | 11h 46m      | 10h 36m         |                            27 |                         0.6928 |
| deepseek-ai_deepseek-llm-7b-base          | 7h 11m       | 6h 26m          |                            28 |                         0.6886 |
| Qwen_Qwen2.5-1.5B-Instruct                | 3h 20m       | 2h 36m          |                            29 |                         0.6803 |
| meta-llama_Llama-3.2-3B-Instruct          | 7h 12m       | 5h 57m          |                            30 |                         0.6788 |
| deepseek-ai_deepseek-math-7b-rl           | 8h 2m        | 7h 12m          |                            31 |                         0.6711 |
| Qwen_Qwen2.5-Math-7B                      | 27h 21m      | 24h 38m         |                            32 |                         0.6587 |
| Qwen_Qwen3-1.7B                           | 4h 25m       | 3h 36m          |                            33 |                         0.6442 |
| deepseek-ai_DeepSeek-R1-Distill-Qwen-7B   | 6h 28m       | 5h 43m          |                            34 |                         0.6422 |
| google_gemma-3-1b-it                      | 6h 50m       | 4h 52m          |                            35 |                         0.6267 |
| meta-llama_Llama-3.2-1B-Instruct          | 3h 30m       | 2h 35m          |                            36 |                         0.6264 |
| Qwen_Qwen2.5-Math-7B-Instruct             | 5h 37m       | 4h 57m          |                            37 |                         0.6184 |
| Qwen_Qwen2.5-0.5B-Instruct                | 2h 34m       | 1h 48m          |                            38 |                         0.6039 |
| deepseek-ai_DeepSeek-R1-Distill-Qwen-1.5B | 3h 40m       | 2h 52m          |                            39 |                         0.5703 |
| Qwen_Qwen3-0.6B                           | 3h 45m       | 2h 53m          |                            40 |                         0.5696 |
| Qwen_Qwen2.5-Math-1.5B-Instruct           | 3h 25m       | 2h 39m          |                            41 |                         0.5181 |


# Knowledge & Reading (Average Rank)

| Model Name                                | Total Time   | GPU Util Time   |   Knowledge & Reading Avg. Rank |   Knowledge & Reading Mean Score |
|:------------------------------------------|:-------------|:----------------|--------------------------------:|---------------------------------:|
| 01-ai_Yi-1.5-9B                           | 11h 43m      | 10h 26m         |                               1 |                           0.4369 |
| openchat_openchat-3.6-8b-20240522         | 7h 51m       | 6h 59m          |                               2 |                           0.4136 |
| meta-llama_Llama-3.1-8B-Instruct          | 12h 19m      | 10h 52m         |                               3 |                           0.4127 |
| 01-ai_Yi-1.5-6B                           | 4h 28m       | 3h 54m          |                               4 |                           0.4063 |
| mistralai_Mistral-7B-Instruct-v0.3        | 8h 38m       | 7h 41m          |                               5 |                           0.4045 |
| Qwen_Qwen2.5-7B-Instruct-1M               | 11h 17m      | 10h 10m         |                               6 |                           0.3963 |
| Qwen_Qwen3-14B (8bit)                     | 29h 45m      | 17h 29m         |                               7 |                           0.3926 |
| meta-llama_Meta-Llama-3-8B-Instruct       | 6h 30m       | 5h 46m          |                               8 |                           0.3923 |
| Qwen_Qwen2.5-7B-Instruct                  | 9h 36m       | 8h 33m          |                               9 |                           0.381  |
| google_gemma-3-12b-it                     | 15h 45m      | 14h 8m          |                              10 |                           0.3791 |
| NousResearch_Hermes-2-Pro-Mistral-7B      | 8h 27m       | 7h 28m          |                              11 |                           0.3719 |
| mistralai_Ministral-8B-Instruct-2410      | 10h 46m      | 9h 27m          |                              12 |                           0.3683 |
| Qwen_Qwen2.5-14B-Instruct (8bit)          | 52h 44m      | 29h 32m         |                              13 |                           0.3581 |
| Qwen_Qwen3-8B                             | 15h 31m      | 13h 44m         |                              14 |                           0.3566 |
| 01-ai_Yi-1.5-9B-Chat                      | 13h 54m      | 12h 15m         |                              15 |                           0.3467 |
| meta-llama_Llama-3.2-3B-Instruct          | 7h 12m       | 5h 57m          |                              16 |                           0.3438 |
| Qwen_Qwen2.5-3B-Instruct                  | 7h 48m       | 6h 30m          |                              17 |                           0.3406 |
| meta-llama_Llama-2-13b-hf                 | 19h 21m      | 17h 38m         |                              18 |                           0.3374 |
| 01-ai_Yi-1.5-6B-Chat                      | 8h 4m        | 7h 1m           |                              19 |                           0.3339 |
| google_gemma-3-4b-it                      | 4h 51m       | 3h 50m          |                              20 |                           0.3261 |
| Qwen_Qwen3-4B                             | 5h 51m       | 5h 3m           |                              21 |                           0.3226 |
| meta-llama_Llama-2-7b-hf                  | 5h 42m       | 4h 59m          |                              22 |                           0.3018 |
| deepseek-ai_deepseek-llm-7b-chat          | 10h 6m       | 9h 8m           |                              23 |                           0.3007 |
| Qwen_Qwen2-7B-Instruct                    | 11h 30m      | 10h 11m         |                              24 |                           0.2919 |
| Qwen_Qwen2.5-1.5B-Instruct                | 3h 20m       | 2h 36m          |                              25 |                           0.2903 |
| meta-llama_Llama-2-13b-chat-hf            | 17h 8m       | 15h 37m         |                              26 |                           0.2864 |
| deepseek-ai_deepseek-llm-7b-base          | 7h 11m       | 6h 26m          |                              27 |                           0.2864 |
| deepseek-ai_DeepSeek-R1-0528-Qwen3-8B     | 17h 57m      | 15h 30m         |                              28 |                           0.2834 |
| Qwen_Qwen2.5-Math-7B                      | 27h 21m      | 24h 38m         |                              29 |                           0.2827 |
| deepseek-ai_DeepSeek-R1-Distill-Llama-8B  | 11h 46m      | 10h 36m         |                              30 |                           0.2805 |
| meta-llama_Llama-3.2-1B-Instruct          | 3h 30m       | 2h 35m          |                              31 |                           0.2731 |
| meta-llama_Llama-2-7b-chat-hf             | 6h 57m       | 6h 7m           |                              32 |                           0.2656 |
| deepseek-ai_deepseek-math-7b-rl           | 8h 2m        | 7h 12m          |                              33 |                           0.2581 |
| Qwen_Qwen3-1.7B                           | 4h 25m       | 3h 36m          |                              34 |                           0.2567 |
| deepseek-ai_DeepSeek-R1-Distill-Qwen-7B   | 6h 28m       | 5h 43m          |                              35 |                           0.234  |
| Qwen_Qwen2.5-Math-7B-Instruct             | 5h 37m       | 4h 57m          |                              36 |                           0.2276 |
| Qwen_Qwen2.5-0.5B-Instruct                | 2h 34m       | 1h 48m          |                              37 |                           0.2218 |
| google_gemma-3-1b-it                      | 6h 50m       | 4h 52m          |                              38 |                           0.2202 |
| Qwen_Qwen3-0.6B                           | 3h 45m       | 2h 53m          |                              39 |                           0.2    |
| Qwen_Qwen2.5-Math-1.5B-Instruct           | 3h 25m       | 2h 39m          |                              40 |                           0.1983 |
| deepseek-ai_DeepSeek-R1-Distill-Qwen-1.5B | 3h 40m       | 2h 52m          |                              41 |                           0.1954 |

---
This project required 18 days 8 hours of machine runtime and 14 days 23 hours of RTX 5090 GPU time, calculated as if the GPU were running at 100% utilization.

The environmental impact caused by this project was mitigated through my active use of public transportation.