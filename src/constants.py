import json
import os

# CWEs IDs and names
CWES = {
    "cwe-190": "integer overflow",
    "cwe-416": "use after free",
    "cwe-476": "NULL pointer dereference",
    "cwe-787": "out-of-bounds write",
    "cwe-119": "improper restriction of operations within the bounds of a memory buffer",
    "cwe-125": "out-of-bounds read",
    "cwe-415": "double free",
    "cwe-824": "access of memory location after end of its lifetime",
    "cwe-825": "expired pointer dereference",
    "cwe-763": "release of invalid pointer or resource",
    "cwe-20": "Improper Input Validation",
    "cwe-287": "Improper Authentication",
    "cwe-other": "a vulnerability in the software"

}


# CWEs definitions from MITRE website
def load_cwe_definitions():
    cwe_path = os.path.join(os.path.dirname(__file__), "../datasets/mitre-cwe-definitions.json")
    with open(cwe_path, "r", encoding='utf-8') as f:
        return json.load(f)

# CWEs languages
LANG = {
    "cwe-190": "c",
    "cwe-416": "c",
    "cwe-476": "c",
    "cwe-787": "c",
    "cwe-119": "c",
    "cwe-125": "c",
    "cwe-415": "c",
    "cwe-824": "c",
    "cwe-825": "c",
    "cwe-763": "c",
    "cwe-20": "c",
    "cwe-287": "c"
}

PROMPTS_MAP_repair={
    'promptF1': ('ZS', 'TO'),
    'promptF2': ('ZS', 'RO'),
    'promptF3': ('ZS', 'TO'),
    'promptF4': ('ZS', 'RO'),
    'promptF5': ('ZS', 'TO'),
    'promptF6': ('ZS', 'RO'),
    'promptF7': ('FS', 'TO'),
    'promptF8': ('FS', 'RO'),
    'promptF9': ('FS', 'TO'),
    'promptF10': ('FS', 'RO'),
}
# Map for Prompts types
PROMPTS_MAP = {
    'promptS0': ('ZS', 'TO'),
    'promptS1': ('ZS', 'TO'),
    'promptS2': ('ZS', 'RO'),
    'promptS3': ('ZS', 'RO'),
    'promptS4': ('ZS', 'RO'),
    'promptS5': ('FS', 'TO'),
    'promptS6': ('FS', 'RO'),
    'promptR0': ('ZS', 'TO'),
    'promptR1': ('ZS', 'TO'),
    'promptR2': ('ZS', 'RO'),
    'promptR3': ('ZS', 'TO'),
    'promptR4': ('FS', 'RO'),
    'promptR5': ('FS', 'RO'),
    'promptR6': ('FS', 'TO'),
}
