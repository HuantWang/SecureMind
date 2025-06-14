import os

class PromptTemplates:
    def __init__(self):
        self.prompts = {
            "promptS0": self.promptS0,
            "promptS1": self.promptS1,
            "promptS2": self.promptS2,
            "promptS3": self.promptS3,
            "promptS4": self.promptS4,
            "promptS5": self.promptS5,
            "promptS6": self.promptS6,
            "promptR0": self.promptR0,
            "promptR1": self.promptR1,
            "promptR2": self.promptR2,
            "promptR3": self.promptR3,
            "promptR4": self.promptR4,
            "promptR5": self.promptR5,
            "promptR6": self.promptR6,

        }
        self.repair_prompts = {
            "promptF1": self.promptF1,
            "promptF2": self.promptF2,
            "promptF3": self.promptF3,
            "promptF4": self.promptF4,
            "promptF5": self.promptF5,
            "promptF6": self.promptF6,
            "promptF7": self.promptF7,
            "promptF8": self.promptF8,
            "promptF9": self.promptF9,
            "promptF10": self.promptF10
        }
        super().__init__()

    ############################
    # Standard Prompts
    ############################
    def promptS0(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = ""

        # example
        exp = []

        # text
        q = f"Does this code contain instances of the memory-related security vulnerability?"
        text = self.prepare_prompt(code=code, question=q, prompt="Question")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    # Statndard Prompt 1 (ZS) (TO)
    def promptS1(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = ""

        # example
        exp = []

        # text
        q = f"Does this code contain instances of the memory-related security vulnerability known as {cwe_name}?"
        text = self.prepare_prompt(code=code, question=q, prompt="Question")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response
    
    # Statndard Prompt 2 (ZS) (RO)
    def promptS2(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']
        
        # system
        sys = "You are a helpful assistant."

        # example
        exp = []

        # text
        q = f"Does this code contain instances of the memory-related security vulnerability known as {cwe_name}?"
        text = self.prepare_prompt(code=code, question=q, prompt="Question")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response
    
    # Statndard Prompt 3 (ZS) (RO)
    def promptS3(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']
        
        # system
        sys = "You are a code security expert."

        # example
        exp = []

        # text
        q = f"Does this code contain instances of the memory-related security vulnerability known as {cwe_name}?"
        text = self.prepare_prompt(code=code, question=q, prompt="Question")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response
    
    # Statndard Prompt 4 (ZS) (RO)
    def promptS4(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']
        
        # system
        sys = f"You are a code security expert who analyzes the given code for the memory-related security vulnerability known as {cwe_name}."

        # example
        exp = []

        # text
        text = self.prepare_prompt(code=code, prompt="Analysis")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    # Statndard Prompt 5 (FS) (TO)
    def promptS5(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        dir_path = os.path.join(os.path.dirname(__file__), "..", "datasets", "few-shot")
        
        # system
        sys = ""

        # example
        q = f"Does this code contain instances of the memory-related security vulnerability known as {cwe_name}?"
        vuln_code = open(os.path.join(dir_path, "examples", f"{cwe}.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        patch_code = open(os.path.join(dir_path, "examples", f"{cwe}-p.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        vuln_reason = open(os.path.join(dir_path, "reasoning", f"{cwe}.txt"), "r",encoding="utf-8").read()
        patch_reason = open(os.path.join(dir_path, "reasoning", f"{cwe}-p.txt"), "r", encoding="utf-8").read()
        vuln_prompt = self.prepare_prompt(code=vuln_code, question=q, prompt="Question")
        patch_prompt = self.prepare_prompt(code=patch_code, question=q, prompt="Question")
        vuln = (vuln_prompt, vuln_reason)
        patch = (patch_prompt, patch_reason)
        exp = [vuln, patch]

        # text
        prompt = self.prepare_prompt(code=kwargs['code'], question=q, prompt="Question")
        text = prompt

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response
    
    # Statndard Prompt 6 (FS) (RO)
    def promptS6(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        dir_path = os.path.join(os.path.dirname(__file__), "..", "datasets", "few-shot")
        
        # system
        sys = "You are a code security expert who analyzes the given code for the memory-related security vulnerability known as {}.".format(cwe_name)

        # example
        vuln_code = open(os.path.join(dir_path, "examples", f"{cwe}.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        patch_code = open(os.path.join(dir_path, "examples", f"{cwe}-p.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        vuln_reason = open(os.path.join(dir_path, "reasoning", f"{cwe}.txt"), "r",encoding="utf-8").read()
        patch_reason = open(os.path.join(dir_path, "reasoning", f"{cwe}-p.txt"), "r", encoding="utf-8").read()
        vuln_prompt = self.prepare_prompt(code=vuln_code, prompt="Analysis")
        patch_prompt = self.prepare_prompt(code=patch_code, prompt="Analysis")
        vuln = (vuln_prompt, vuln_reason)
        patch = (patch_prompt, patch_reason)
        exp = [vuln, patch]

        # text
        text = self.prepare_prompt(code=kwargs['code'], prompt="Analysis")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    ############################
    # Step-by-Step Prompts
    ############################
    def promptR0(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = ""

        # example
        exp = []

        # text
        q = f"Does this code contain instances of the memory-related security vulnerability?"
        answer = "Let's think step by step."
        prompt = self.prepare_prompt(code=code, question=q, answer=answer, prompt="Q/A")
        text = prompt

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    # Step-by-Step Prompt 1 (ZS) (TO)
    def promptR1(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = ""

        # example
        exp = []

        # text
        q = f"Does this code contain instances of the memory-related security vulnerability known as {cwe_name}?"
        answer = "Let's think step by step."
        prompt = self.prepare_prompt(code=code, question=q, answer=answer, prompt="Q/A")
        text = prompt

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response
    
    # Step-by-Step Prompt 2 (ZS) (RO)
    def promptR2(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = (f"You are a code security expert who analyzes the given code for the security vulnerability known as {cwe_name} "
               f"with a special focus on memory-related issues following these four steps:\n"
               f"1. First you describe the overview of the code\n"
               f"2. Then based on the overview you identify the sub-components in code that could lead to {cwe_name}\n"
               f"3. After that you do a detailed analysis of the identified sub-components for the existence of the {cwe_name} vulnerability.\n"
               f"4. Based on the detailed analysis you decide and answer whether the {cwe_name} vulnerability is present in the given code or not")

        # example
        exp = []

        # text
        text = self.prepare_prompt(code=code, prompt="Analysis")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response
    
    # Step-by-Step Prompt 3 (ZS) (TO)
    def promptR3(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = ""

        # example
        exp = []

        # overview
        prompt_code = self.prepare_prompt(code=code, prompt="None")
        overview = "Provide a brief overview of the code."
        prompt = prompt_code + "\n\n" + overview
        overview_response = self.chat(system=sys, examples=exp, text=prompt)
        exp.append((prompt, overview_response))

        # sub-components
        sub_components = f"Based on the overview identify the sub-components in code that could lead to a memory related security vulnerability knows as {cwe_name}."
        sub_response = self.chat(system=sys, examples=exp, text=sub_components)
        exp.append((sub_components, sub_response))

        # detailed analysis
        detailed_analysis = f"Perform a detailed analysis of the identified sub-components for the existence of the {cwe_name} vulnerability. Especially pay attention to any memory handling logic, such as array/buffer usage, pointer arithmetic, or dynamic allocation, that could indicate potential {cwe_name} vulnerabilities."
        analysis_response = self.chat(system=sys, examples=exp, text=detailed_analysis)
        exp.append((detailed_analysis, analysis_response))

        # answer
        answer = f"Based on the detailed analysis decide and answer whether the {cwe_name} vulnerability is present in the given code or not."
        ans_response = self.chat(system=sys, examples=exp, text=answer)

        # response
        response = "Overview:\n" + overview_response + "\n\nSub-cmponents:\n" + sub_response + "\n\nDetailed Analysis:\n" + analysis_response + "\n\nAnswer:\n" + ans_response
        return response

    # Step-by-Step Prompt 4 (FS) (RO)
    def promptR4(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        dir_path = os.path.join(os.path.dirname(__file__), "..", "datasets", "few-shot")

        # system
        sys = f"You are a code security expert who analyzes the given code for the security vulnerability known as {cwe_name} and you specifically check for memory-related weaknesses or exploitation vectors."

        # example
        vuln_code = open(os.path.join(dir_path, "examples", f"{cwe}.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        patch_code = open(os.path.join(dir_path, "examples", f"{cwe}-p.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        vuln_reason = open(os.path.join(dir_path, "step-by-step-reasoning", f"{cwe}.txt"), "r",encoding="utf-8").read()
        patch_reason = open(os.path.join(dir_path, "step-by-step-reasoning", f"{cwe}-p.txt"), "r", encoding="utf-8").read()
        vuln_prompt = self.prepare_prompt(code=vuln_code, prompt="Analysis")
        patch_prompt = self.prepare_prompt(code=patch_code, prompt="Analysis")
        vuln = (vuln_prompt, vuln_reason)
        patch = (patch_prompt, patch_reason)
        exp = [vuln, patch]

        # text
        text = self.prepare_prompt(code=kwargs['code'], prompt="Analysis")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    # Step-by-Step Prompt 5 (FS) (RO)
    def promptR5(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        dir_path = os.path.join(os.path.dirname(__file__), "..", "datasets", "few-shot")

        # system
        sys = "You are a code security expert who analyzes the given code for the security vulnerability known as {} following detailed steps with following detailed steps, with emphasis on memory management flaws:\n1. First you describe the overview of the code\n2. Then based on the overview you identify the sub-components in code that could lead to {}\n3. After that you do a detailed analysis of the identified sub-components for the existence of the {}\n4. Based on the detailed analysis you decide and answer whether the {} is present in the given code or not".format(cwe_name, cwe_name, cwe_name + " vulnerability", cwe_name + " vulnerability")

        # example
        vuln_code = open(os.path.join(dir_path, "examples", f"{cwe}.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        patch_code = open(os.path.join(dir_path, "examples", f"{cwe}-p.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        vuln_reason = open(os.path.join(dir_path, "step-by-step-reasoning", f"{cwe}.txt"), "r",encoding="utf-8").read()
        patch_reason = open(os.path.join(dir_path, "step-by-step-reasoning", f"{cwe}-p.txt"), "r", encoding="utf-8").read()
        vuln_prompt = self.prepare_prompt(code=vuln_code, prompt="Analysis")
        patch_prompt = self.prepare_prompt(code=patch_code, prompt="Analysis")
        vuln = (vuln_prompt, vuln_reason)
        patch = (patch_prompt, patch_reason)
        exp = [vuln, patch]

        # text
        text = self.prepare_prompt(code=kwargs['code'], prompt="Analysis")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response
    
    # Step-by-Step Prompt 6 (FS) (TO)
    def promptR6(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        dir_path = os.path.join(os.path.dirname(__file__), "..", "datasets", "few-shot")

        # system
        sys = "Guidelines to analyze the given code for the security vulnerability known as {}, especially regarding memory-safety issues such as buffer overflows, out-of-bounds access, or memory corruption:\n1. First describe the overview of the code\n2. Then based on the overview identify the sub-components in code that could lead to {}\n3. After that do a detailed analysis of the identified sub-components for the existence of the {}\n4. Based on the detailed analysis decide and answer whether the {} is present in the given code or not".format(cwe_name, cwe_name, cwe_name + " vulnerability", cwe_name + " vulnerability")

        # example
        vuln_code = open(os.path.join(dir_path, "examples", f"{cwe}.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        patch_code = open(os.path.join(dir_path, "examples", f"{cwe}-p.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        vuln_reason = open(os.path.join(dir_path, "step-by-step-reasoning", f"{cwe}.txt"), "r",encoding="utf-8").read()
        patch_reason = open(os.path.join(dir_path, "step-by-step-reasoning", f"{cwe}-p.txt"), "r", encoding="utf-8").read()
        vuln_prompt = self.prepare_prompt(code=vuln_code, prompt="Analysis")
        patch_prompt = self.prepare_prompt(code=patch_code, prompt="Analysis")
        vuln = (vuln_prompt, vuln_reason)
        patch = (patch_prompt, patch_reason)
        exp = [vuln, patch]

        # text
        text = self.prepare_prompt(code=kwargs['code'], prompt="Analysis")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response


    ############################
    # Definition Prompts
    ############################

    # Definition Prompt 1 (ZS) (TO)
    def promptD1(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = ""

        # example
        exp = []

        # text
        q = f"Does this code contain instances of the security vulnerability known as {cwe_name}?"
        text = self.prepare_prompt(defin=self.defs[cwe], code=code, question=q, prompt="Def")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    # Definition Prompt 2 (ZS) (RO)
    def promptD2(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = f"You are a code security expert who analyzes the given code for the security vulnerability known as {cwe_name}, with special emphasis on potential memory-related vulnerabilities.\n\n{self.defs[cwe]}"

        # example
        exp = []

        # text
        text = self.prepare_prompt(code=code, prompt="Analysis")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    # Definition Prompt 3 (FS) (RO)
    def promptD3(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        dir_path = os.path.join(os.path.dirname(__file__), "..", "datasets", "few-shot")

        # system
        sys = f"You are a code security expert who analyzes the given code for the security vulnerability known as {cwe_name}.\n\n{self.defs[cwe]}"

        # example
        vuln_code = open(os.path.join(dir_path, "examples", f"{cwe}.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        patch_code = open(os.path.join(dir_path, "examples", f"{cwe}-p.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        vuln_reason = open(os.path.join(dir_path, "reasoning", f"{cwe}.txt"), "r",encoding="utf-8").read()
        patch_reason = open(os.path.join(dir_path, "reasoning", f"{cwe}-p.txt"), "r", encoding="utf-8").read()
        vuln_prompt = self.prepare_prompt(code=vuln_code, prompt="Analysis")
        patch_prompt = self.prepare_prompt(code=patch_code, prompt="Analysis")
        vuln = (vuln_prompt, vuln_reason)
        patch = (patch_prompt, patch_reason)
        exp = [vuln, patch]

        # text
        text = self.prepare_prompt(code=kwargs['code'], prompt="Analysis")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    # Definition Prompt 4 (FS) (RO)
    def promptD4(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        dir_path = os.path.join(os.path.dirname(__file__), "..", "datasets", "few-shot")

        # system
        sys = "You are a code security expert who analyzes the given code for the security vulnerability known as {}.\n\n{}".format(cwe_name, self.defs[cwe])

        # example
        vuln_code = open(os.path.join(dir_path, "examples", f"{cwe}.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        patch_code = open(os.path.join(dir_path, "examples", f"{cwe}-p.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        vuln_reason = open(os.path.join(dir_path, "step-by-step-reasoning", f"{cwe}.txt"), "r",encoding="utf-8").read()
        patch_reason = open(os.path.join(dir_path, "step-by-step-reasoning", f"{cwe}-p.txt"), "r", encoding="utf-8").read()
        vuln_prompt = self.prepare_prompt(code=vuln_code, prompt="Analysis")
        patch_prompt = self.prepare_prompt(code=patch_code, prompt="Analysis")
        vuln = (vuln_prompt, vuln_reason)
        patch = (patch_prompt, patch_reason)
        exp = [vuln, patch]

        # text
        text = self.prepare_prompt(code=kwargs['code'], prompt="Analysis")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response
    
    # Definition Prompt 5 (FS) (TO)
    def promptD5(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        dir_path = os.path.join(os.path.dirname(__file__), "..", "datasets", "few-shot")

        # system
        sys = "Analyze the given code for the security vulnerability known as {}, focusing on memory-safety concerns such as buffer overflows, pointer mismanagement, or memory leaks, in a step-by-step manner.\n\n{}".format(cwe_name, self.defs[cwe])

        # example
        vuln_code = open(os.path.join(dir_path, "examples", f"{cwe}.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        patch_code = open(os.path.join(dir_path, "examples", f"{cwe}-p.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        vuln_reason = open(os.path.join(dir_path, "step-by-step-reasoning", f"{cwe}.txt"), "r",encoding="utf-8").read()
        patch_reason = open(os.path.join(dir_path, "step-by-step-reasoning", f"{cwe}-p.txt"), "r", encoding="utf-8").read()
        vuln_prompt = self.prepare_prompt(code=vuln_code, prompt="Analysis")
        patch_prompt = self.prepare_prompt(code=patch_code, prompt="Analysis")
        vuln = (vuln_prompt, vuln_reason)
        patch = (patch_prompt, patch_reason)
        exp = [vuln, patch]

        # text
        text = self.prepare_prompt(code=kwargs['code'], prompt="Analysis")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response   

    def promptF1(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = ""

        # example
        exp = []

        # text
        q = f"Remove the vulnerable memory-related code/function body known as {cwe_name} and replace it with a secure version. Please provide the complete code. Ensure that no portion of the code is truncated, omitted, or summarized."
        text = self.prepare_prompt(code=code, question=q, prompt="Question")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    def promptF2(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = "You are a helpful assistant."

        # example
        exp = []

        # text
        q = f"Remove the vulnerable memory-related code/function body known as {cwe_name} and replace it with a secure version. Please provide the complete code. Ensure that no portion of the code is truncated, omitted, or summarized."
        text = self.prepare_prompt(code=code, question=q, prompt="Question")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    def promptF3(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = ""

        # example
        exp = []

        # text
        q = f"Memory error detected: {cwe_name}. This function requires refactoring. Rewrite the function securely. Please provide the complete code. Ensure that no portion of the code is truncated, omitted, or summarized."
        text = self.prepare_prompt(code=code, question=q, prompt="Question")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    def promptF4(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = f"You are a code repair security expert who analyzes the given code for the memory-related security vulnerability known as {cwe_name}. "

        # example
        exp = []

        # text
        q = f"Memory error detected: {cwe_name}. This function requires refactoring. Rewrite the function securely. Please provide the complete code. Ensure that no portion of the code is truncated, omitted, or summarized."
        text = self.prepare_prompt(code=code, question=q, prompt="Question")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    def promptF5(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        dir_path = os.path.join(os.path.dirname(__file__), "..", "datasets", "few-shot")

        # system
        sys = ""

        # example
        q = f"Remove the vulnerable memory-related code/function body known as {cwe_name} and replace it with a secure version. Please provide the complete code. Ensure that no portion of the code is truncated, omitted, or summarized."
        vuln_code = open(os.path.join(dir_path, "examples", f"{cwe}.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        patch_code = open(os.path.join(dir_path, "examples", f"{cwe}-p.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        vuln_reason = open(os.path.join(dir_path, "reasoning", f"{cwe}.txt"), "r", encoding="utf-8").read()
        patch_reason = open(os.path.join(dir_path, "reasoning", f"{cwe}-p.txt"), "r", encoding="utf-8").read()
        vuln_prompt = self.prepare_prompt(code=vuln_code, question=q, prompt="Question")
        patch_prompt = self.prepare_prompt(code=patch_code, question=q, prompt="Question")
        vuln = (vuln_prompt, vuln_reason)
        patch = (patch_prompt, patch_reason)
        exp = [vuln, patch]

        # text
        prompt = self.prepare_prompt(code=kwargs['code'], question=q, prompt="Question")
        text = prompt

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    def promptF6(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        dir_path = os.path.join(os.path.dirname(__file__), "..", "datasets", "few-shot")

        # system
        sys = f"You are a code security expert who analyzes the given code for the memory-related security vulnerability known as {cwe_name}."

        # example
        q = f"Remove the vulnerable memory-related code/function body known as {cwe_name} and replace it with a secure version. Please provide the complete code. Ensure that no portion of the code is truncated, omitted, or summarized."
        vuln_code = open(os.path.join(dir_path, "examples", f"{cwe}.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        patch_code = open(os.path.join(dir_path, "examples", f"{cwe}-p.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        vuln_reason = open(os.path.join(dir_path, "reasoning", f"{cwe}.txt"), "r", encoding="utf-8").read()
        patch_reason = open(os.path.join(dir_path, "reasoning", f"{cwe}-p.txt"), "r", encoding="utf-8").read()
        vuln_prompt = self.prepare_prompt(code=vuln_code, question=q, prompt="Question")
        patch_prompt = self.prepare_prompt(code=patch_code, question=q, prompt="Question")
        vuln = (vuln_prompt, vuln_reason)
        patch = (patch_prompt, patch_reason)
        exp = [vuln, patch]

        # text
        prompt = self.prepare_prompt(code=kwargs['code'], question=q, prompt="Question")
        text = prompt

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    def promptF7(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = ""

        # example
        exp = []

        # text
        q = f"Remove the vulnerable memory-related code/function body known as {cwe_name} and replace it with a secure version. Please provide the complete code. Ensure that no portion of the code is truncated, omitted, or summarized."
        answer = "Let's think step by step."
        prompt = self.prepare_prompt(code=code, question=q, answer=answer, prompt="Q/A")
        text = prompt

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    # Step-by-Step Prompt 2 (ZS) (RO)
    def promptF8(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        code = kwargs['code']

        # system
        sys = (
            f"Analyze the given code for {cwe_name} security vulnerabilities and fix them by following these steps: 1. Remove insecure memory-related functions and replace them with safe alternatives. 2. Initialize all allocated memory before use to avoid uninitialized memory vulnerabilities.  3. Implement buffer overflow protection by ensuring all writes stay within buffer limits. Avoid unsafe pointer arithmetic and always validate pointer dereferences. 4. Enable stack canaries to detect and prevent stack-based buffer overflows. 5. Verify the fixed code: Ensure that the {cwe_name} vulnerability is fully mitigated. \\ ")


        # example
        exp = []

        # text
        text = self.prepare_prompt(code=code, prompt="Analysis")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    # Definition Prompt 4 (FS) (RO)
    def promptF9(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        dir_path = os.path.join(os.path.dirname(__file__), "..", "datasets", "few-shot")

        # system
        sys = f"Remove the vulnerable memory-related code body known as {cwe_name} and replace it with a secure version. Please provide the complete code. Ensure that no portion of the code is truncated, omitted, or summarized."

        # example
        vuln_code = open(os.path.join(dir_path, "examples", f"{cwe}.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        patch_code = open(os.path.join(dir_path, "examples", f"{cwe}-p.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        vuln_reason = open(os.path.join(dir_path, "step-by-step-reasoning", f"{cwe}.txt"), "r", encoding="utf-8").read()
        patch_reason = open(os.path.join(dir_path, "step-by-step-reasoning", f"{cwe}-p.txt"), "r",
                            encoding="utf-8").read()
        vuln_prompt = self.prepare_prompt(code=vuln_code, prompt="Analysis")
        patch_prompt = self.prepare_prompt(code=patch_code, prompt="Analysis")
        vuln = (vuln_prompt, vuln_reason)
        patch = (patch_prompt, patch_reason)
        exp = [vuln, patch]

        # text
        text = self.prepare_prompt(code=kwargs['code'], prompt="Analysis")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response

    # Definition Prompt 5 (FS) (TO)
    def promptF10(self, **kwargs):
        cwe = kwargs['cwe']
        cwe_name = self.cwes[cwe]
        dir_path = os.path.join(os.path.dirname(__file__), "..", "datasets", "few-shot")

        # system
        sys = (f"As a code repair expert, analyze the given code for {cwe_name} security vulnerabilities and fix them by following these steps: 1. Remove insecure memory-related functions and replace them with safe alternatives. 2. Initialize all allocated memory before use to avoid uninitialized memory vulnerabilities.  3. Implement buffer overflow protection by ensuring all writes stay within buffer limits. Avoid unsafe pointer arithmetic and always validate pointer dereferences. 4. Enable stack canaries to detect and prevent stack-based buffer overflows. 5. Verify the fixed code: Ensure that the {cwe_name} vulnerability is fully mitigated. \\ ")

        # example
        vuln_code = open(os.path.join(dir_path, "examples", f"{cwe}.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        patch_code = open(os.path.join(dir_path, "examples", f"{cwe}-p.{self.lang[cwe]}"), "r", encoding="utf-8").read()
        vuln_reason = open(os.path.join(dir_path, "step-by-step-reasoning", f"{cwe}.txt"), "r", encoding="utf-8").read()
        patch_reason = open(os.path.join(dir_path, "step-by-step-reasoning", f"{cwe}-p.txt"), "r",
                            encoding="utf-8").read()
        vuln_prompt = self.prepare_prompt(code=vuln_code, prompt="Analysis")
        patch_prompt = self.prepare_prompt(code=patch_code, prompt="Analysis")
        vuln = (vuln_prompt, vuln_reason)
        patch = (patch_prompt, patch_reason)
        exp = [vuln, patch]

        # text
        text = self.prepare_prompt(code=kwargs['code'], prompt="Analysis")

        # response
        response = self.chat(system=sys, examples=exp, text=text)

        return response