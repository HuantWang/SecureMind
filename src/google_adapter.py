from src.adapter import LLMAdapter
from src.llama_adapter import LlamaAdapter
from google.cloud import aiplatform
from vertexai.preview.language_models import CodeChatModel, ChatModel, InputOutputTextPair
import google.generativeai as genai
from openai import OpenAI
import openai, time
class VertexAICodeChatAdapter(LLMAdapter):  
    def __init__(self, temp=0.0):
        super().__init__()
        self.temp = temp

    def prepare_prompt(self, **kwargs):
        if kwargs['prompt'] == 'Question':
            prompt = "Code:\n" + kwargs['code'] + "\nQuestion: " + kwargs['question'] + "\nAnswer: "
        if kwargs['prompt'] == 'Analysis':
            prompt = "Code:\n" + kwargs['code'] + "\nAnalysis: "
        if kwargs['prompt'] == 'Q/A':
            prompt = "Code:\n" + kwargs['code'] + "\nQuestion: " + kwargs['question'] + "\nAnswer: " + kwargs['answer']
        if kwargs['prompt'] == 'Def':
            prompt = kwargs['defin'] + "\n\nCode:\n" + kwargs['code'] + "\nQuestion: " + kwargs['question'] + "\nAnswer: "
        if kwargs['prompt'] == 'None':
            prompt = "Code:\n" + kwargs['code'] + "\n"
        return prompt

    def prepare(self, **kwargs):
        self.model_client = self.gpt_client = OpenAI(
                    api_key=kwargs['api_key'],
                    base_url="https://generativelanguage.googleapis.com/v1beta/openai/"
                )
        self.model = kwargs['model']  # e.g. "gpt-3.5-turbo", "gpt-4" (API name of the model)

    # Step-by-Step Prompt 3 (ZS)
    def promptR3(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = ""

        # example
        exp = []

        # overview
        prompt = "Code:\n" + code + "\n\nTask: Provide a brief overview of the code.\nOverview: "
        overview_response = self.chat(system=sys, examples=exp, text=prompt)

        # sub-components
        prompt += overview_response + "\n\nTask: Based on the overview identify the sub-components in code that could lead to a security vulnerability knows as {}.\nSub-components: ".format(cwe_name)
        sub_response = self.chat(system=sys, examples=exp, text=prompt)

        # detailed analysis
        prompt += sub_response + "\n\nTask: Perform a detailed analysis of the identified sub-components for the existence of the {}.\nDetailed Analysis: ".format(cwe_name + " vulnerability")
        analysis_response = self.chat(system=sys, examples=exp, text=prompt)

        # answer
        prompt += analysis_response + "\n\nTask: Based on the detailed analysis decide and answer whether the {} is present in the given code or not.\nAnswer: ".format(cwe_name + " vulnerability")
        ans_response = self.chat(system=sys, examples=exp, text=prompt)

        # response
        response = "Overview:\n" + overview_response + "\n\nSub-cmponents:\n" + sub_response + "\n\nDetailed Analysis:\n" + analysis_response + "\n\nAnswer:\n" + ans_response
        return response
    
    def chat(self, **kwargs):
        # prepare messages
        msgs = []
        if 'system' in kwargs:
            if kwargs['system'] != "":
                msgs.append({"role": "system", "content": kwargs['system']})
        if 'examples' in kwargs:
            if kwargs['examples'] != []:
                for ex in kwargs['examples']:
                    msgs.append({"role": "user", "content": ex[0]})
                    msgs.append({"role": "assistant", "content": ex[1]})
        msgs.append({"role": "user", "content": kwargs['text']})

        # send request
        itr = 10

        while itr:
            # try:
            try:
                response = self.model_client.beta.chat.completions.parse(
                    model=self.model,
                    temperature=self.temp,
                    top_p=self.top_p,
                    messages=msgs
                )
                return response.choices[0].message.content
            except openai.RateLimitError as e:
               print("Rate limit reached. Waiting for 60 seconds...")
               time.sleep(60)
            # except openai.APIError as e:
            #    itr -= 1
            #    print("Retrying...")
            except:
                response = self.model_client.beta.chat.completions.parse(
                    model="gemini-1.5-pro",
                    temperature=self.temp,
                    top_p=self.top_p,
                    messages=[
                        {"role": "system", "content": "You are a security expert."},
                        {"role": "user",
                         "content": "Remove the vulnerable memory-related code/function body known as {cwe_name} and replace it with a secure version. Please provide the complete code. Ensure that no portion of the code is truncated, omitted, or summarized. Let's think step by step."}
                    ],
                    max_tokens=5000
                )
                return response.choices[0].message.content
            # print("retry chat...")


        return None


if __name__ == "__main__":
    adapter = VertexAICodeChatAdapter()
    adapter.prepare(
        api_key="",
        model="gemini-2.0-flash")
    adapter.run_repair(
        api_key="",
        model="gemini-2.0-flash"
    )

