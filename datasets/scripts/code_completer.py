#!/usr/bin/env python3
import os
import re
from pathlib import Path

class CodeCompleter:
    def __init__(self):
        self.type_defs = {
            r'\bguint\b': 'typedef unsigned int guint;',
            r'\bguchar\b': 'typedef unsigned char guchar;',
            r'\bcolumn_info\b': 'typedef struct column_info column_info;',
            r'\bframe_data\b': 'typedef struct frame_data frame_data;',
            r'\bpacket_info\b': 'struct packet_info { frame_data *fd; };',
            r'\bproto_tree\b': 'struct proto_tree { int dummy; };',
            r'\btvbuff_t\b': 'struct tvbuff_t { guint length; };',
            r'\baddress_hash_value\b': 'struct address_hash_value { guint frame_num; guint8 mac[6]; guint time_of_entry; };',
            r'\bproto_item\b': 'typedef struct proto_item proto_item;'
        }
        self.macro_defs = {
            r'\bAT_NONE\b': '#define AT_NONE 0',
            r'\bCT_NONE\b': '#define CT_NONE 0',
            r'\bPT_NONE\b': '#define PT_NONE 0',
            r'\bFALSE\b': '#define FALSE 0',
            r'\bP2P_DIR_UNKNOWN\b': '#define P2P_DIR_UNKNOWN 0',
            r'\bMTP2_ANNEX_A_USED_UNKNOWN\b': '#define MTP2_ANNEX_A_USED_UNKNOWN 0',
            r'\bLINK_DIR_UNKNOWN\b': '#define LINK_DIR_UNKNOWN 0',
            r'\bETHERTYPE_IP\b': '#define ETHERTYPE_IP 0x0800',
            r'\bETHERTYPE_IPV6\b': '#define ETHERTYPE_IPV6 0x86DD'
        }
        self.exception_macros = [
            '#define TRY do {',
            '#define CATCH(e) } while (0); if (0)',
            '#define ENDTRY'
        ]
        self.global_vars = {
            r'\baddress_hash_table\b': 'GHashTable* address_hash_table = NULL;',
            r'\bhf_arp_duplicate_ip_address\b': 'static int hf_arp_duplicate_ip_address = 0;'
        }

    def process_file(self, file_path):
        with open(file_path, 'r+', encoding='utf-8') as f:
            content = f.read()

            # 修复条件编译指令
            content = self._fix_conditionals(content)
            
            # 添加基础头文件
            content = self._add_headers(content)
            
            # 处理类型定义
            content = self._add_type_defs(content)
            
            # 添加宏定义
            content = self._add_macro_defs(content)
            
            # 处理结构体重定义
            content = self._fix_struct_redef(content)
            
            # 生成函数桩
            content = self._generate_function_stubs(content)
            
            # 添加全局变量
            content = self._add_global_vars(content)
            
            # 写入新文件
            output_path = file_path.parent / 'comple_vuln.c'
            with open(output_path, 'w', encoding='utf-8') as out_f:
                out_f.write(content)

    def _fix_conditionals(self, content):
        # 确保每个 #ifndef 都有对应的 #endif
        ifdef_count = content.count('#ifndef')
        endif_count = content.count('#endif')
        if ifdef_count > endif_count:
            content += '\n#endif\n'
        return content

    def _add_headers(self, content):
        headers = [
            '#include <glib.h>',
            '#include <stdio.h>',
            '#include <stdlib.h>',
            '#include <stdint.h>'
        ]
        existing_headers = re.findall(r'#include\s+<[^>]+>', content)
        for h in headers:
            if h not in existing_headers:
                content = h + '\n' + content
        return content

    def _add_type_defs(self, content):
        # 在第一个函数定义前添加类型定义
        typedefs = []
        for pattern, typedef in self.type_defs.items():
            if not re.search(pattern, content):
                typedefs.append(typedef)
        
        if typedefs:
            insert_pos = content.find('void ')  # 找到第一个函数定义
            if insert_pos != -1:
                content = content[:insert_pos] + '\n'.join(typedefs) + '\n' + content[insert_pos:]
        return content

    def _add_macro_defs(self, content):
        # 在文件头部添加宏定义
        macros = []
        for pattern, macro in self.macro_defs.items():
            if not re.search(pattern, content.split('#define', 1)[-1]):
                macros.append(macro)
        
        if macros or self.exception_macros:
            header = '/* Auto-generated macros */\n'
            header += '\n'.join(macros + self.exception_macros) + '\n'
            content = header + content
        return content

    def _fix_struct_redef(self, content):
        # 处理重复结构体定义
        structs = set(re.findall(r'struct\s+(\w+)\s*{', content))
        for struct in structs:
            if content.count(f'struct {struct}') > 1:
                content = re.sub(rf'struct {struct}\s*{{[^}}]*}};?\n', '', content, flags=re.DOTALL, count=1)
        return content

    def _generate_function_stubs(self, content):
        # 增强返回类型识别模式
        return_type_pattern = r'^([\w\s*]+)\s+(\w+)\s*\('  # 支持指针类型
        # 特殊函数处理
        custom_stubs = {
            'proto_tree_add_none_format': (
                'proto_item* proto_tree_add_none_format(proto_tree* tree, int hf_index, ...) {\n'
                '    va_list ap;\n'
                '    va_start(ap, hf_index);\n'
                '    /* Stub implementation */\n'
                '    va_end(ap);\n'
                '    return NULL;\n'
                '}'
            ),
            'arpproaddr_to_str': (
                'const char* arpproaddr_to_str(const guint8* addr, int len, int ethertype) {\n'
                '    static char buf[64];\n'
                '    return buf;\n'
                '}'
            )
        }
        
        # 修改函数匹配模式
        func_pattern = r'\b(\w+)\s*\(.*?\)\s*(?=\{)?'  # 更宽松的参数匹配
        # 排除列表扩展
        excluded_funcs = ['main', 'printf', 'memcmp', 'g_hash_table_lookup']
        
        # 查找未定义的函数并生成桩代码
        called_funcs = set(re.findall(func_pattern, content))
        defined_funcs = set(re.findall(r'^\w+\s+(\w+)\s*\(', content, re.M))
        missing_funcs = called_funcs - defined_funcs
        
        stubs = []
        for func in missing_funcs:
            if func not in excluded_funcs:
                # 在函数桩生成时分析返回类型
                return_type_pattern = r'^(\w+)\s+\*?\s*(\w+)\s*\('
                return_types = re.findall(return_type_pattern, content, re.M)
                return_type_map = {func: rt for rt, func in return_types}

                # 生成桩时使用实际返回类型
                if func in return_type_map:
                    stub = f'{return_type_map[func]} {func}(...) {{ /* stub */ return ({return_type_map[func]})0; }}'
                else:
                    stub = f'void {func}() {{ /* stub */ }}'
                stubs.append(stub)
        
        # 自定义特殊函数桩
        for func in missing_funcs:
            if func in custom_stubs:
                stubs.append(custom_stubs[func])
        
        if stubs:
            content += '\n/* Auto-generated stubs */\n' + '\n'.join(stubs)
        return content

    def _add_global_vars(self, content):
        # 在类型定义之后、函数定义之前插入全局变量
        insert_pos = content.find('void ')
        if insert_pos != -1:
            vars = []
            for pattern, var in self.global_vars.items():
                if re.search(pattern, content) and not re.search(r'\b'+var.split('=')[0].strip()+r'\b', content):
                    vars.append(var)
            return content[:insert_pos] + '\n'.join(vars) + '\n' + content[insert_pos:]
        return content + '\n' + '\n'.join(vars)

def process_directory(root_dir):
    completer = CodeCompleter()
    for root, dirs, files in os.walk(root_dir):
        for file in files:
            if file == 'vuln.c':
                path = Path(root) / file
                completer.process_file(path)

if __name__ == '__main__':
    import sys
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <target_directory>")
        sys.exit(1)
    process_directory(sys.argv[1]) 