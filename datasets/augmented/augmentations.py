import random
import string
import re


class TrivialAugmentations4Py:
    def __init__(self):
        self.aug = {
            'a1': self.a1,
            'a2': self.a2,
            'a3': self.a3,
            'a4': self.a4,
            'a5': self.a5,
            'a6': self.a6,
            'a7': self.a7
        }

        # Rename function parameters randomly
    def a1(self, **kwargs):
        code = kwargs['code']
        def random_word(size=2):
            return ''.join(random.choice(string.ascii_lowercase) for _ in range(size))

        def functions_with_arguments(code):
            pattern = re.compile(r'def (\w+)\((\w+[^)]*)\):')
            matches = pattern.findall(code)
            return [match[0] for match in matches]

        def change_args_names_in_function(code, target_function):
            func_pattern = re.compile(r'def ' + target_function + r'\(([^)]+)\):')
            match = func_pattern.search(code)

            if not match:
                return code

            args_str = match.group(1)
            args = [arg.strip() for arg in args_str.split(',')]
            replace_map = {}

            # Generate random two-letter words for each argument
            for arg in args:
                new_name = random_word()
                while new_name in code:  # Ensure uniqueness
                    new_name = random_word()
                replace_map[arg] = new_name

            # Replace the arguments in the function definition
            for old_name, new_name in replace_map.items():
                args_str = args_str.replace(old_name, new_name)

            # Update the function definition in the code
            code = code[:match.start(1)] + args_str + code[match.end(1):]

            # Replace the usage of the arguments in the function body
            function_body_start = match.end()
            function_body_end = code.find("def ", function_body_start)  # Find the next "def" keyword
            function_body_end = function_body_end if function_body_end != -1 else len(code)

            function_body = code[function_body_start:function_body_end]

            for old_name, new_name in replace_map.items():
                function_body = re.sub(r'\b' + old_name + r'\b', new_name, function_body)  # Using \b to ensure whole word match

            return code[:function_body_start] + function_body + code[function_body_end:]

        funcs = functions_with_arguments(code)
        for func in funcs:
            code = change_args_names_in_function(code, func)
        return code

    # Rename function randomly
    def a2(self, **kwargs):
        code = kwargs['code']
        def random_string(length=4):
            letters = string.ascii_lowercase
            return ''.join(random.choice(letters) for i in range(length))
        
        # Pattern to match function definitions
        pattern_def = r"\bdef\s+(\w+)\("
        # Find all function names
        matches = re.findall(pattern_def, code)

        # Create a mapping of original function name to random name
        name_mapping = {name: random_string() for name in matches}

        # Replace function definitions
        for original, new in name_mapping.items():
            pattern = r"\bdef\s+" + original + r"\("
            code = re.sub(pattern, f"def {new}(", code)

        # Replace function calls
        for original, new in name_mapping.items():
            # This will replace all function calls that have word boundaries
            # before and after the function name
            pattern = r"\b" + original + r"\("
            code = re.sub(pattern, f"{new}(", code)

        return code

    # Add random unreachable code
    def a3(self, **kwargs):
        code = kwargs['code']
        text_to_insert = 'def helpfunc():\n    while 0:'
        
        for i in range(20):
            text_to_insert += "\n\tbreak"
        text_to_insert += '\n'

        code = code + "\n\n" + text_to_insert
        return code
    
    # Add random comments
    def a4(self, **kwargs):
        code = kwargs['code']
        comment = '# def helpfunc():\n#     while 0:'
        
        for _ in range(20):
            comment += "\n# \tbreak"
                
        comment += '\n'
        code = comment + "\n\n" + code
        return code

    # Add random whitespace
    def a5(self, **kwargs):
        code = kwargs['code']
        code_lines = code.splitlines()
        pos_to_insert = random.randint(0, len(code_lines) - 1)

        code_lines[pos_to_insert] = code_lines[pos_to_insert] + ' ' * 20
        code = '\n'.join(code_lines)
        return code

    # Add a useless function
    def a6(self, **kwargs):
        code = kwargs['code']
        begin_of_function = code[code.index('def'):].index(':') + code.index('def')
        text_to_insert = '\n    help_func()'
        code = code[0:begin_of_function + 1] + text_to_insert + code[begin_of_function + 1:]
        func_to_insert = 'def helpfunc():\n    while 0:'
        for _ in range(20):
            func_to_insert += "\n\tbreak"
        func_to_insert += '\n    return'
        code = code + "\n\n" + func_to_insert
        return code

    # Remove '\n' and '\t' characters
    def a7(self, **kwargs):
        code = kwargs['code']
        code = re.sub('\n','\n\n',code)
        return code

class AugmentationsC:
    def __init__(self):
        pass

    # Change a variable name to ‘buffer’
        # 修改变量名为漏洞相关关键词
    def nt1(self, **kwargs):
        code = kwargs['code']
        # 漏洞相关关键词列表
        vuln_keywords = ['buffer', 'exploit', 'overflow', 'vulnerable_var']

        # 匹配变量定义，简单示例：int x = 10;
        pattern = r'\b(int|float|char|double|long)\s+(\w+)\s*[=;]'
        matches = re.findall(pattern, code)

        for match in matches:
            original_var = match[1]
            new_name = random.choice(vuln_keywords)  # 随机选择关键词
            if original_var != new_name:  # 避免重复替换
                code = re.sub(rf'\b{original_var}\b', new_name, code)

        return code

    # Change the name of a safe function to ‘vulnerable’ function
    def nt2(self, **kwargs):
        code = kwargs['code']

        # 安全函数名称 -> 漏洞函数名称映射
        safe_to_vuln = {
            'fgets': 'vulnerable_gets',
            'strncpy': 'vulnerable_strcpy'
        }

        for safe_func, vuln_func in safe_to_vuln.items():
            # 替换函数定义中的名称
            code = re.sub(rf'\b{safe_func}\b', vuln_func, code)
        return code

    # Change the name of an unsafe function to ‘non_vulnerable’ function
    def nt3(self, **kwargs):
        code = kwargs['code']

        # 不安全函数名称 -> 非漏洞函数名称映射
        unsafe_to_safe = {
            'gets': 'safe_gets',
            'strcpy': 'non_vulnerable_copy'
        }

        for unsafe_func, safe_func in unsafe_to_safe.items():
            # 替换函数调用和定义中的名称
            code = re.sub(rf'\b{unsafe_func}\b', safe_func, code)
        return code

    # Add a function that uses ‘strcpy’ in a safe way
    def nt4(self, **kwargs):
        code = kwargs['code']

        # 添加一个使用 strcpy 的安全代码块
        safe_strcpy_code = """
        void safe_copy(char *dest, const char *src, size_t size) {
            if (strlen(src) < size) {
                strcpy(dest, src);
            }
        }
        """
        # 添加到代码末尾
        code += "\n" + safe_strcpy_code
        return code

# Add ‘realpath’ function to a program with path traversal vulnerability
    def nt5(self, **kwargs):
        code = kwargs['code']

        # 添加一个使用 realpath 的代码，但漏洞未修复
        vulnerable_realpath_code = """
        char *sanitize_path(const char *path) {
            char resolved_path[PATH_MAX];
            realpath(path, resolved_path);
            // don't evaluate the security of resolved_path 
            return strdup(resolved_path);
        }
        """
        # 添加到代码末尾
        code += "\n" + vulnerable_realpath_code
        return code

# Add a hash-define ‘strcpy’ function
    def nt6(self, **kwargs):
        code = kwargs['code']

        # 添加不安全的宏定义
        unsafe_macro = """
        #define safe_input(buffer, size) gets(buffer)
        """
        # 添加到代码顶部
        code = unsafe_macro + "\n" + code
        return code

# Add a map-define vulnerable function
    def nt7(self, **kwargs):
        code = kwargs['code']

        # 定义一个漏洞函数的宏
        vuln_map_define = """
        #define MAP_FUNCTION(func_name, buffer)  func_name(buffer)
        #define VULNERABLE_FUNCTION(buffer)  gets(buffer)
        """

        # 将该定义插入到代码的顶部
        code = vuln_map_define + "\n" + code

        return code

    # Rename function parameters randomly
    def nt8(self, **kwargs):
        code = kwargs['code']

        def rename_parameter(code, old_parameter_name):
            letters = string.ascii_lowercase
            new_parameter_name = ''.join(random.choice(letters) for i in range(2))

            parameter = old_parameter_name.replace("*", "")
            parameter = parameter.replace("[", "")

            if parameter not in ["...", "private"]:

                neutral_characters = ["(", ")", ",", ";", " ", "*", "[", "]", "-", ">", "&", ":"]

                occurences = [m.start() for m in re.finditer(parameter, code)]
                num_inserted_chars = 0

                for occurence in occurences:

                    occurence += num_inserted_chars

                    if occurence + len(parameter) < len(code):

                        prev_char = code[occurence - 1]
                        next_char = code[occurence + len(parameter)]

                        if (prev_char in neutral_characters and next_char in neutral_characters):
                            code = code[0:occurence] + new_parameter_name + code[occurence + len(parameter):]
                            num_inserted_chars += len(new_parameter_name) - len(parameter)
            return code

        if "(" in code and ")" in code:
            parameters = code.split(")")[0].split("(")[1]

            if len(parameters) > 0:
                if "," in parameters:
                    for param in parameters.split(","):
                        parameter = param.split(" ")[-1]
                        code = rename_parameter(code, parameter)
                else:
                    parameter = parameters.split(" ")[-1]
                    code = rename_parameter(code, parameter)
        return code

    # Rename function randomly
    def nt9(self, **kwargs):
        code = kwargs['code']
        letters = string.ascii_lowercase
        new_function_name = ''.join(random.choice(letters) for i in range(2))

        if "(" in code and ")" in code:
            before_function = code.split("(")[0]

            if " " in before_function:
                function_name = before_function.split(" ")[-1]

                if function_name != "" and function_name != " ":
                    code = code.replace(function_name, new_function_name)
        return code

    # Add random unreachable code
    def nt10(self, **kwargs):
        code = kwargs['code']
        text_to_insert = 'void helpfunc() {\n    while (1) {'

        for _ in range(20):
            text_to_insert += "\n\t\tbreak;"

        text_to_insert += '\n    }\n}\n'

        code = code + "\n\n" + text_to_insert
        return code

    # Add random comments
    def nt11(self, **kwargs):
        code = kwargs['code']
        comment = '/* void helpfunc() {\n    while (1) {'

        for _ in range(20):
            comment += "\n\t\tbreak;"

        comment += '\n    }\n}\n*/'
        code = comment + '\n\n' + code
        return code

    # Add random whitespace
    def nt12(self, **kwargs):
        code = kwargs['code']
        code_lines = code.split('\n')
        pos_to_insert = random.randint(0, len(code_lines))

        text_to_insert = [' ' * 20]
        code = code_lines[0:pos_to_insert] + text_to_insert + code_lines[pos_to_insert:]
        code = '\n'.join(code)
        return code

    # Add a useless function
    def nt13(self, **kwargs):
        code = kwargs['code']
        begin_of_function = code.index('{')
        text_to_insert = '\n    help_func();'
        code = code[0:begin_of_function + 1] + text_to_insert + code[begin_of_function + 1:]
        func_to_insert = 'void helpfunc() {\n    while (1) {'
        for i in range(20):
            func_to_insert += "\n\t\tbreak;"
        func_to_insert += '\n    }\n    return;\n}\n'
        code = code + "\n\n" + func_to_insert
        return code

    # Add '\n' character
    def nt14(self, **kwargs):
        code = kwargs['code']
        code = re.sub('\n', '\n\n', code)
        return code

import os

def create_augmented_dirs(base_path,extend,cwe_name):
    """
    在指定的基路径下，创建 "A1/dataset" 和 "A1/ground_truth" 两个子目录。

    Args:
        base_path (str): 基路径（目标目录的根路径）。
    """
    # 创建 "A1/dataset" 子目录
    dataset_dir = os.path.join(base_path, extend, "dataset",cwe_name)
    os.makedirs(dataset_dir, exist_ok=True)

    # 创建 "A1/ground_truth" 子目录
    ground_truth_dir = os.path.join(base_path, extend, "ground_truth",cwe_name)
    os.makedirs(ground_truth_dir, exist_ok=True)
    return dataset_dir, ground_truth_dir

import shutil

def run_temp_test(dataset_path,dataset_path_aug):


    os.makedirs(dataset_path_aug, exist_ok=True)  # exist_ok=True 避免错误

    c_files_contents = {}
    # 遍历文件夹及其子目录
    for root, dirs, files in os.walk(dataset_path):  # 遍历主目录
        for dir in dirs:  # 遍历当前路径中的每个子目录
            dir_path = os.path.join(root, dir)  # 拼接子目录的完整路径
            for sub_root, sub_dirs, sub_files in os.walk(dir_path):  # 遍历子目录
                cwe_name = os.path.basename(sub_root)
                # current_aug_cwe = os.path.join(dataset_path_aug, )
                # os.makedirs(current_aug_cwe, exist_ok=True)
                for file in sub_files:
                    if file.endswith(".c"):
                        file_path = os.path.join(sub_root, file)
                        with open(file_path, "r", encoding="utf-8") as f:
                            c_files_contents[file] = f.read()  # 将文件名与内容存入字典
                        augmentations = AugmentationsC()
                        strategy_list = [f"A{i}" for i in range(1, 15)]  # 策略 A1 到 A7

                        for strategy in strategy_list:
                            # 创建目录（不同策略对应的目录）
                            dataset_dir, ground_truth_dir = create_augmented_dirs(dataset_path_aug, strategy, cwe_name)

                            # 动态调用 augmentations 中的增强方法
                            strategy_number = f"nt{strategy[1:]}"  # e.g., "nt1", "nt2", ...
                            aug_code = getattr(augmentations, strategy_number)(code=c_files_contents[file])

                            # 保存增强后的代码
                            aug_path = os.path.join(dataset_dir, file)
                            with open(aug_path, "w", encoding="utf-8") as f:
                                f.write(aug_code)

                            # 替换路径结构为 ground-truth
                            label_path = file_path.replace(f'/{"dataset"}/', f'/{"ground-truth"}/').replace('.c', '.txt')

                            # 拷贝标签文件到 ground_truth 目录
                            try:
                                shutil.copy(label_path, ground_truth_dir)
                            except FileNotFoundError:
                                print("No reasoning text for", file)


# dataset_path = os.path.join(os.path.dirname(__file__), '..', 'sard', 'dataset')
# dataset_path_aug = os.path.join(os.path.dirname(__file__), 'sard')
# run_temp_test(dataset_path,dataset_path_aug)
dataset_path = os.path.join(os.path.dirname(__file__), '..', 'real-world', 'dataset')
dataset_path_aug = os.path.join(os.path.dirname(__file__), 'github')
run_temp_test(dataset_path,dataset_path_aug)
