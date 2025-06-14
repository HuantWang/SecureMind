import os
import json
import time
import numpy as np
import openai
from statistics import mode
from rouge_score import rouge_scorer
from pydantic import BaseModel, Field
import re
from constants import CWES, LANG, PROMPTS_MAP, load_cwe_definitions, PROMPTS_MAP_repair
from openai import OpenAI
import google.generativeai as genai

class HelperFunctions:
    def __init__(self):
        self.cwes = CWES # cwe types
        self.defs = load_cwe_definitions() # cwe defination
        self.lang = LANG # .c or .py
        self.prompts_map = PROMPTS_MAP # prompt
        self.prompts_map_repair = PROMPTS_MAP_repair
        super().__init__()

    def fix_edge_cases(self, text):
        # Llama long same letter word 'string' edge case
        max_length = 100
        len_list = list(map(len, text.split()))
        if len(len_list) and max(len_list) > max_length:
            words = text.split()
            truncated_words = [word[:max_length] if len(word) > max_length else word for word in words]
            text = ' '.join(truncated_words)
            return True, text
        return False, text
    
    def call_structured_gpt(self, **kwargs):
        done, itr = False, 5
        while not done and itr:

            try:
            # Applied fix
                fix_required = self.fix_edge_cases(kwargs['text'])
                if fix_required[0]:
                    text = fix_required[1]
                gpt_response = self.gpt_pre_client.beta.chat.completions.parse(
                    model="gemini-2.0-flash",
                    messages=[{"role": "user", "content": kwargs['text']}],
                    response_format=kwargs['response_format']
                )
                done = True
            except openai.RateLimitError as e:
                print("Rate limit reached. Waiting for 60 seconds...")
                time.sleep(60)
            except openai.APIError as e:
                print(f"Error in extract_pred {e}")
                # Applied fix
                fix_required = self.fix_edge_cases(text)
                if fix_required[0]:
                    text = fix_required[1]
                itr -= 1
                print("Retrying...")
        if done:
            response = gpt_response.choices[0].message.parsed
            return response
        return None

    def extract_pred(self, **kwargs):
        cwe = kwargs['cwe']
        content = kwargs['text']
        q = "As a final decision or answer, does the text state that the code contains a security vulnerability known as {}? (Answer yes or no or n/a, incase the text does not provide a definite answer)".format(self.cwes[cwe])
        text = 'Text: """\n' + content + '\n"""\n' + q

        done, itr = False, 5
        while not done and itr:
            try:
                # Applied fix
                fix_required = self.fix_edge_cases(text)
                if fix_required[0]:
                    text = fix_required[1]

                gpt_response = self.gpt_pre_client.beta.chat.completions.parse(
                    model = "gemini-2.0-flash",
                    temperature = 0.0,
                    messages = [{"role": "user", "content": text}]
                )
                done = True
            except openai.RateLimitError as e:
                print("Rate limit reached. Waiting for 60 seconds...")
                time.sleep(60)
            except openai.APIError as e:
                print(f"Error in extract_pred {e}")
                # Applied fix
                fix_required = self.fix_edge_cases(text)
                if fix_required[0]:
                    text = fix_required[1]
                itr -= 1
                print("Retrying...")
        if done:
            response = gpt_response.choices[0].message.content
            pred = response.lower()
            return pred
        return None

    def extract_structured_pred(self, **kwargs):
        cwe = kwargs['cwe']
        content = kwargs['text']
        q = f"As a final decision or answer, does the text state that the code contains a security vulnerability known as {self.cwes[cwe]}?"
        text = f'Text: """\n{content}\n"""\n\n{q}'

        class Response(BaseModel):
            answer: str = Field(..., description="Answer only in 'yes' or 'no' or 'n/a', incase the text does not provide a definite answer")

        response = self.call_structured_gpt(text=text, response_format=Response)
        if response:
            return response.answer
        return None

    def extract_structured_code(self, **kwargs):
        cwe = kwargs['cwe']
        sys = "You are a helpful assistant who extracts the repaired code body from the given text. Please provide the complete code. Ensure that no portion of the code is truncated, omitted, or summarized."
        content = kwargs["text"]

        done, itr = False, 5
        while not done and itr:
            try:
                # Applied fix
                # fix_required = self.fix_edge_cases(content)
                # if fix_required[0]:
                #     content = fix_required[1]

                gpt_response = self.gpt_pre_client.beta.chat.completions.parse(
                    model="gemini-2.0-flash",
                    temperature=0.0,

                    messages=[{"role": "system", "content": sys}, {"role": "user", "content": content}]
                )
                done = True
            except openai.RateLimitError as e:
                print("Rate limit reached. Waiting for 60 seconds...")
                time.sleep(60)
            except openai.APIError as e:
                print(f"Error in extract_info {e}")
                # Applied fix
                # fix_required = self.fix_edge_cases(content)
                # if fix_required[0]:
                #     content = fix_required[1]
                itr -= 1
                print("Retrying...")
            except:
                gpt_response = self.gpt_pre_client.beta.chat.completions.parse(
                    model="gemini-1.5-pro",
                    temperature=0.0,
                    # max_tokens=100,
                    messages=[{"role": "system", "content": sys}, {"role": "user", "content": content}]
                )
                done = True

        # pred, reason = None, None
        if done:
            response = gpt_response.choices[0].message.content
            # pred = response.split('\n')[0].split('Answer:')[-1][1:].lower()
            # if pred == "n/a":
            #     reason = "n/a"
            # else:
            #     reason = response.split('Reason:')[-1][1:]
        return response

    def extract_info(self, **kwargs):
        cwe = kwargs['cwe']
        sys = "You are a helpful assistant who extracts answer whether an instance of vulnerability is present or not and its reason 'why' from the given text in the following format:\nAnswer: ...\nReason: ...\n\nYou must follow these rules while extracting information:\n1. As a final decision or answer, does the text state that the code contains a security vulnerability known as {}? (Answer yes or no or n/a, incase the text does not provide a definite answer)\n2. If the text does not state the reason 'why' an instance of vulnerability is present or not then just write 'n/a' in reason.\n3. If the answer in 1 is 'n/a' then just write 'n/a' in reason.\n4. Only if 2 and 3 are not true then briefly describe the reasons mentioned in the text that state 'why' the code does or does not contain a security vulnerability known as {}. Max word limit for reason is 100 words. Write in terms of code, e.g., 'The code/program/function ...'".format(self.cwes[cwe], self.cwes[cwe])
        content = kwargs["text"]
        
        done, itr = False, 5
        while not done and itr:
            try:
                # Applied fix
                fix_required = self.fix_edge_cases(content)
                if fix_required[0]:
                    content = fix_required[1]

                gpt_response = self.gpt_pre_client.beta.chat.completions.parse(
                    model = "gemini-2.0-flash",
                    temperature = 0.0,
                    messages = [{"role": "system", "content": sys}, {"role": "user", "content": content}]
                )
                done = True
            except openai.RateLimitError as e:
                print("Rate limit reached. Waiting for 60 seconds...")
                time.sleep(60)
            except openai.APIError as e:
                print(f"Error in extract_info {e}")
                # Applied fix
                fix_required = self.fix_edge_cases(content)
                if fix_required[0]:
                    content = fix_required[1]
                itr -= 1
                print("Retrying...")
        
        pred, reason = None, None
        if done:
            response = gpt_response.choices[0].message.content
            pred = response.split('\n')[0].split('Answer:')[-1][1:].lower()
            if pred == "n/a":
                reason = "n/a"
            else:
                reason = response.split('Reason:')[-1][1:]
        return pred, reason

    def extract_structured_info(self, **kwargs):
        cwe = kwargs['cwe']
        content = kwargs['text']
        q = "You are a helpful assistant who extracts answer whether an instance of vulnerability is present or not " \
            "and its reason 'why' from the given text."
        text = f'Text: """\n{content}\n"""\n\n{q}'

        class Response(BaseModel):
            answer: str = Field(..., description=f"As a final decision or answer, does the text state that the code contains a security vulnerability known as {self.cwes[cwe]}? (Answer only in 'yes' or 'no' or 'n/a', incase the text does not provide a definite answer)")
            reason: str = Field(..., description="Reason described in the text that state 'why' the code does or does not contain a security vulnerability known as {self.cwes[cwe]}. (Describe only in Max 100 words) If the answer is 'n/a' then just write 'n/a' in reason. And if no reason is provided then just write 'n/a' in reason. Write in terms of code, e.g., 'The code/program/function ...'")
        try:
            response = self.call_structured_gpt(text=text, response_format=Response)
        except:
            print("Error in text")
            response = self.call_structured_gpt(text=f'Text: """ """\n\n{q}', response_format=Response)
        if response:
            return response.answer, response.reason
        return None, None

    def rouge(self, **kwargs):
        scorer = rouge_scorer.RougeScorer(['rouge1', 'rougeL'], use_stemmer=True)
        scores = scorer.score(kwargs['reason'], kwargs['ground_truth'])
        return scores['rouge1'].precision

    def cos_similarity(self, **kwargs):
        done, itr = False, 5
        while not done and itr:
            # try:
            # resp = self.gpt_em_client.embeddings.create(
            #     input=[kwargs['reason']],
            #     model="text-embedding-3-large"
            # )
            # embedding_a = resp.data[0].embedding
            genai.configure(api_key="")
            resp = genai.embed_content(
                model="models/text-embedding-004",
                content=[kwargs['reason']])

            embedding_a = resp['embedding']
            done = True
            # except openai.RateLimitError as e:
            #     print("Rate limit reached. Waiting for 60 seconds...")
            #     time.sleep(60)
            # except openai.APIError as e:
            #     print(f"Error in cos_similarity {e}")
            #     itr -= 1
            #     print("Retrying...")
        
        similarity_score = None
        if done:
            similarity_score = np.dot(embedding_a, kwargs['ground_truth'])[0]
            # similarity_score = np.dot(embedding_a, kwargs['ground_truth'])
        return similarity_score

    def gpt_eval(self, **kwargs):
        reason = kwargs['reason']
        gt = kwargs['ground_truth']

        q = "Evaluate if the reasoning in the response aligns with the ground truth. (Answer yes or no)"
        prompt = q + '\n\nResponse: """\n' + reason + '\n"""\n\nGround Truth: """\n' + gt + '\n"""'

        itr = 5
        while itr:
            try:
                gpt_response = self.gpt_pre_client.beta.chat.completions.parse(
                    model = "gemini-2.0-flash",
                    temperature = 0.0,
                    messages = [{"role": "user", "content": prompt}]
                )
                answer = gpt_response.choices[0].message.content.lower()
                return answer
            except openai.RateLimitError as e:
                print("Rate limit reached. Waiting for 60 seconds...")
                time.sleep(60)
            except openai.APIError as e:
                print(f"Error in gpt_eval {e}")
                itr -= 1
                print("Retrying...")
        return None

    def gpt_structured_eval(self, **kwargs):
        reason = kwargs['reason']
        gt = kwargs['ground_truth']

        q = "Evaluate if the reasoning in the response aligns with the ground truth."
        prompt = f'{q}\n\nResponse: """\n{reason}\n"""\n\nGround Truth: """\n{gt}\n"""'

        class Response(BaseModel):
            answer: bool = Field(..., description="True if the reasoning in the response aligns with the ground truth, otherwise False")

        response = self.call_structured_gpt(text=prompt, response_format=Response)
        if response:
            answer = 'yes' if response.answer else 'no'
            return answer
        return None

    def check_consistency(self, **kwargs):
        prompt = kwargs['prompt']
        temp = kwargs['temp']
        model = kwargs['model']
        result_path = kwargs['result_path']
        result_name = 'temp'
        result_full_path = os.path.join(result_path, result_name + ".json")

        # Load results
        results = json.loads(open(result_full_path, "r", encoding='utf-8').read())

        for cwe in results[prompt][temp][model]:
            for file in results[prompt][temp][model][cwe]:
                first_pred = results[prompt][temp][model][cwe][file]["1"]["pred"]
                for i in results[prompt][temp][model][cwe][file]:
                    pred = results[prompt][temp][model][cwe][file][i]["pred"]
                    if first_pred != pred:
                        return True
        return False

    import re

    def is_google_api_key(self, key):
        """
        Validates whether a string follows the common Google API key format.

        Google API keys typically:
        - Start with "AIza"
        - Contain 35 more characters (A-Z, a-z, 0-9, _ or -)
        - Have a total length of 39 characters

        This function uses a regex pattern to check these conditions.
        """
        pattern = r"^AIza[0-9A-Za-z_-]{35}$"
        return bool(re.match(pattern, key))

    def is_openai_api_key(self, key):
        """
        Validates whether a string follows the common OpenAI API key format.

        OpenAI API keys typically:
        - Start with "sk-"
        - Contain 48 more characters (A-Z, a-z, 0-9)
        - Have a total length of 51 characters

        This function uses a regex pattern to check these conditions.
        """


        # Pattern for OpenAI Project-based API keys (sk-proj-xxxxx, usually > 80 characters)
        project_key_pattern = r"^sk-proj-[0-9A-Za-z]{80,}$"
        return bool(re.match(project_key_pattern, key))

    def is_3rd_api_key(self, key):
        """
        Validates whether a string follows the common OpenAI API key format.

        OpenAI API keys typically:
        - Start with "sk-"
        - Contain 48 more characters (A-Z, a-z, 0-9)
        - Have a total length of 51 characters

        This function uses a regex pattern to check these conditions.
        """

        # Pattern for OpenAI Project-based API keys (sk-proj-xxxxx, usually > 80 characters)
        secret_key_pattern = r"^sk-[0-9A-Za-z]{48}$"
        return bool(re.match(secret_key_pattern, key))



    def handle_reason(self, r, c):
        ROUGE_THRES = 0.34
        COS_SIM_THRES = 0.84
        return mode([1 if r >= ROUGE_THRES else 0, 1 if c >= COS_SIM_THRES else 0])

    def get_score(self, data):
        W1, W2, W3 = 0.33, 0.33, 0.33

        total_res = data['total_answered']['val'] + data['no_answer']['val']
        res_rate = (data['total_answered']['val'] / total_res) if total_res else 0

        acc_rate = (data['correct']['val'] / data['total_answered']['val']) if data['total_answered']['val'] else 0

        total_rea = data['correct_pred_correct_reason']['val'] + data['correct_pred_incorrect_reason']['val']
        rea_rate = (data['correct_pred_correct_reason']['val'] / total_rea) if total_rea else 0

        return (W1 * res_rate) + (W2 * acc_rate) + (W3 * rea_rate)

    def get_best_prompt(self, data, model, prompts):
        max_score = 0
        max_prompt = ''
        all_p=[]
        all_score= []
        for p in prompts:
            score = self.get_score(data[model][p])
            all_score.append(score)
            all_p.append(p)
            # if score > max_score:
            #     max_score = score
            #     max_prompt = p
        p_score_dict = {p: score for p, score in zip(all_p, all_score)}

        sorted_p_score = sorted(p_score_dict.items(), key=lambda item: item[1], reverse=True)
        from collections import OrderedDict
        sorted_p_score_dict = OrderedDict(sorted_p_score)
        max_prompt, max_score = max(p_score_dict.items(), key=lambda item: item[1])

        return max_score,max_prompt,sorted_p_score_dict

        # return max_score, max_prompt

    def get_model_best_prompts(self, data, model, all, zt, zr, ft, fr):
        # print("Model:", model)
        all_s, all_p,all_results = self.get_best_prompt(data, model, all)
        zt_s, zt_p,_ = self.get_best_prompt(data, model, zt)
        zr_s, zr_p,_ = self.get_best_prompt(data, model, zr)
        ft_s, ft_p,_ = self.get_best_prompt(data, model, ft)
        fr_s, fr_p,_ = self.get_best_prompt(data, model, fr)
        
        zs = zt_p if zt_s > zr_s else zr_p
        fs = ft_p if ft_s > fr_s else fr_p

        result = {
            "ALL_prompt": all_p,
            'ZT': zt_p,
            'ZR': zr_p,
            'ZS': zs,
            'FT': ft_p,
            'FR': fr_p,
            'FS': fs
        }
        return result,all_results

    def find_best_prompts(self, **kwargs):
        model = kwargs['model']
        result_path = kwargs['result_path']

        # Load results
        result_name = model + '.json'
        result_full_path = os.path.join(result_path, result_name)
        results = json.loads(open(result_full_path, "r", encoding='utf-8').read())

        # metric_data
        metric_data = {}
        # -> model
        if model not in metric_data:
            metric_data[model] = {}
        for cwe in results:
            for file in results[cwe]:
                for prompt in results[cwe][file]:
                    # -> prompt
                    if prompt not in metric_data[model]:
                        metric_data[model][prompt] = {
                            "total_answered": {'val': 0, 'id': []},
                            "no_answer": {'val': 0, 'id': []},
                            "correct": {'val': 0, 'id': []},
                            "total_reasoned": {'val': 0, 'id': []},
                            "no_reason": {'val': 0, 'id': []},
                            "correct_pred_correct_reason": {'val': 0, 'id': []},
                            "incorrect_pred_correct_reason": {'val': 0, 'id': []},
                            "correct_pred_incorrect_reason": {'val': 0, 'id': []},
                            "incorrect_pred_incorrect_reason": {'val': 0, 'id': []}
                        }
                    pred = results[cwe][file][prompt]['pred']
                    # not answered
                    if pred != 'yes' and pred != 'no':
                        metric_data[model][prompt]['no_answer']['val'] += 1
                        metric_data[model][prompt]['no_answer']['id'].append((cwe, file, prompt))
                    # total answered
                    else:
                        metric_data[model][prompt]['total_answered']['val'] += 1
                        
                        # correct
                        label = 0 if file[0] == 'p' else 1
                        p = 1 if pred == 'yes' else 0
                        correct = False
                        if p == label:
                            correct = True
                            metric_data[model][prompt]['correct']['val'] += 1
                            metric_data[model][prompt]['correct']['id'].append((cwe, file, prompt))
                        
                        # reason
                        reason = results[cwe][file][prompt]['reason']
                        if reason == 'n/a':
                            metric_data[model][prompt]['no_reason']['val'] += 1
                            metric_data[model][prompt]['no_reason']['id'].append((cwe, file, prompt))
                        else:
                            metric_data[model][prompt]['total_reasoned']['val'] += 1
                            rouge = results[cwe][file][prompt]['rouge']
                            cos = results[cwe][file][prompt]['cos_sim']
                            # gpt = results[cwe][file][prompt]['gpt_eval']
                            
                            # correct reason
                            if self.handle_reason(rouge, cos) == 1:
                                if correct:
                                    metric_data[model][prompt]['correct_pred_correct_reason']['val'] += 1
                                    metric_data[model][prompt]['correct_pred_correct_reason']['id'].append((cwe, file, prompt))
                                else:
                                    metric_data[model][prompt]['incorrect_pred_correct_reason']['val'] += 1
                                    metric_data[model][prompt]['incorrect_pred_correct_reason']['id'].append((cwe, file, prompt))
                            #incorrect reason
                            else:
                                if correct:
                                    metric_data[model][prompt]['correct_pred_incorrect_reason']['val'] += 1
                                    metric_data[model][prompt]['correct_pred_incorrect_reason']['id'].append((cwe, file, prompt))
                                else:
                                    metric_data[model][prompt]['incorrect_pred_incorrect_reason']['val'] += 1
                                    metric_data[model][prompt]['incorrect_pred_incorrect_reason']['id'].append((cwe, file, prompt))
        
        # get best prompts
        all,zs_to, zs_ro, fs_to, fs_ro = [],[], [], [], []

        if "promptF1" not in self.prompts_map:
            for p in self.prompts_map:
                all.append(p)
                if self.prompts_map[p][0] == 'ZS' and self.prompts_map[p][1] == 'TO':
                    zs_to.append(p)
                elif self.prompts_map[p][0] == 'ZS' and self.prompts_map[p][1] == 'RO':
                    zs_ro.append(p)
                elif self.prompts_map[p][0] == 'FS' and self.prompts_map[p][1] == 'TO':
                    fs_to.append(p)
                elif self.prompts_map[p][0] == 'FS' and self.prompts_map[p][1] == 'RO':
                    fs_ro.append(p)

        best_prompts_json = self.get_model_best_prompts(metric_data, model, all, zs_to, zs_ro, fs_to, fs_ro)
        return best_prompts_json
