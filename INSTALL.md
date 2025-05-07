##  Build an `adapter` to evaluate your LLM from scratch
To evaluate your LLM using our framework, you need to create an adapter. 
You can do this by simply modifying the src/openai_adapter.py and implementing 
the following steps in it:

* **Get OpenAI API-KEY:** You need to provide your own API-KEY. (e.g. [OpenAI's official documentation](https://platform.openai.com/docs/quickstart/step-2-set-up-your-api-key))

* **Add Model's Name:** This model will be used evaluate for your tasks.

## Environments
After you have created your adapter, please go ahead and follow these steps to run your evaluation:

1. Create python environment
```
python3.10 -m venv env
source env/bin/activate
```
2. Install the required packages
```
pip install -r requirements.txt
```

> **Note:** For need to manually install all packages that are required to run your LLM

3. Configuration
```
    adapter = LlamaAdapter() # input class
    adapter.prepare(
        api_key="",
        model="Pro/deepseek-ai/DeepSeek-R1") # input your LLM API and LLM
    adapter.run_repair(
        api_key="",
        model="Pro/deepseek-ai/DeepSeek-R1"
    ) 
```