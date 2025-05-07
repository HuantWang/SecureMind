from prompt_templates import PromptTemplates
from helper_functions import HelperFunctions
from experiments import ExperimentRunner

class LLMAdapter(HelperFunctions, PromptTemplates, ExperimentRunner):
    def __init__(self):
        super().__init__()

    def prepare(self, **kwargs):
        pass

    def prepare_prompt(self, **kwargs):
        pass

    def chat(self, **kwargs):
        pass

