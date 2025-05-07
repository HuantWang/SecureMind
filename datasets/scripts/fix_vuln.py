#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
脚本功能：
1. 递归搜索指定目录下所有名为 vuln.c 的文件。
2. 在同目录下生成 comple_vuln.c 文件，对代码进行简单的补全处理：
   - 基于文件内容中出现的关键字自动插入必要的头文件
   - 定义可能缺失的宏（如 VARIABLE_LENGTH 等）
   - 声明缺失的类型与函数（如 guint、g_ntohs 等）

用法：
  ./fix_vuln.py /path/to/search

示例：
  python3 fix_vuln.py ./data
"""

import os
import sys
import re

def detect_includes(file_content):
    """
    针对出现的关键字决定插入哪些头文件。
    可以根据需要自行添加或修改关键字与对应头文件。
    返回需要插入的头文件列表（不含重复）。
    """
    # 先搜集已包含的头文件，避免重复插入
    existing_includes = set()
    lines = file_content.splitlines()
    for line in lines:
        line_strip = line.strip()
        if line_strip.startswith('#include'):
            existing_includes.add(line_strip)

    # 默认添加常用头文件
    common_headers = [
        '#include <stdio.h>',
        '#include <stdlib.h>',
        '#include <string.h>',
        '#include <stdint.h>'
    ]
    needed_headers = set()
    for ch in common_headers:
        if not any(ch in inc for inc in existing_includes):
            needed_headers.add(ch)

    # 其他特殊头文件的检测逻辑保持不变
    keyword_to_header = {
        'g_ntohs': '<glib.h>',
        'g_ntohl': '<glib.h>',
        # 可按需继续添加其他特殊头文件
    }

    for kw, hdr in keyword_to_header.items():
        if kw in file_content:
            include_stmt = f'#include {hdr}'
            if not any(include_stmt in inc for inc in existing_includes):
                needed_headers.add(include_stmt)

    return needed_headers


def main():
    if len(sys.argv) < 2:
        print("用法：{} <搜索目录>".format(sys.argv[0]))
        sys.exit(1)

    search_dir = sys.argv[1]
    if not os.path.isdir(search_dir):
        print(f"错误：{search_dir} 不是有效的目录。")
        sys.exit(1)

    vuln_files = []
    for root, dirs, files in os.walk(search_dir):
        for fname in files:
            if fname == 'vuln.c':
                vuln_files.append(os.path.join(root, fname))

    if not vuln_files:
        print("未找到任何 vuln.c 文件。")
        sys.exit(0)

    for file in vuln_files:
        print(f"处理文件: {file}")

        # 读取原文件内容
        with open(file, 'r', encoding='utf-8', errors='ignore') as f:
            original_content = f.read()

        # ================ 准备补全信息 ================
        header_fixes = []
        define_fixes = []
        declare_fixes = []

        # 0) 为避免常见 C 关键字或库函数被错误当作函数调用进行声明：
        c_keywords = {
            "return", "sizeof", "if", "else", "while", "for", "do", "switch",
            "case", "default", "break", "continue", "goto", "typedef"
        }
        # 一些常见 C 库函数（或实际是宏）可能不需要我们自己声明
        skip_common_funcs = {
            "mktime", "errno", "file_error", "g_strdup_printf", 
            "pletohs", "g_free", "g_malloc",
            "lanalyzer_read", "lanalyzer_seek_read", "lanalyzer_close",
            "file_seek", "g_free"
            # 可以根据实际工程继续增补
        }

        # 额外对errno做头文件或声明
        if "errno" in original_content:
            if not any("#include <errno.h>" in line for line in original_content.split('\n')):
                header_fixes.append("#include <errno.h>\n")

        # 提前定义可能缺失的宏
        # 例如 WTAP_ERR_CANT_READ, RT_HeaderRegular, RT_HeaderCyclic 等
        if "WTAP_ERR_CANT_READ" in original_content:
            define_fixes.append("#ifndef WTAP_ERR_CANT_READ\n#define WTAP_ERR_CANT_READ 1\n#endif\n")
        if "RT_HeaderRegular" in original_content or "RT_HeaderCyclic" in original_content:
            define_fixes.append("#ifndef RT_HeaderRegular\n#define RT_HeaderRegular 0\n#endif\n")
            define_fixes.append("#ifndef RT_HeaderCyclic\n#define RT_HeaderCyclic 1\n#endif\n")
        if "WTAP_FILE_LANALYZER" in original_content:
            define_fixes.append("#ifndef WTAP_FILE_LANALYZER\n#define WTAP_FILE_LANALYZER 0\n#endif\n")
        if "WTAP_FILE_TSPREC_NSEC" in original_content:
            define_fixes.append("#ifndef WTAP_FILE_TSPREC_NSEC\n#define WTAP_FILE_TSPREC_NSEC 9\n#endif\n")

        # ---------- 通用函数补全 ----------
        # 利用正则匹配所有可能出现的函数调用 foo(...) 形式
        called_funcs = set(re.findall(r"\b(\w+)\s*\(", original_content))
        # 记录已处理的函数声明防止重复
        processed_funcs = set()
        # 记录已处理的结构体防止重复
        processed_structs = set()
        for fn in called_funcs:
            # 如果是C关键字、已在skip列表的摘要，跳过
            if fn in c_keywords or fn in skip_common_funcs:
                continue

            # 检查是否已有相应声明/定义，如 "type fn(" 或 "fn(...) {"
            if not re.search(rf"\b\w+\s+{fn}\s*\(|\b{fn}\s*\([^;]*\)\s*\{{", original_content):
                if fn in processed_funcs:
                    continue
                processed_funcs.add(fn)
                
                # 根据实际调用参数数量生成声明
                # 改进：分析参数类型和返回类型
                return_type = "int"  # 默认返回int类型
                args_list = []
                
                # 分析实际调用参数类型
                for m in re.finditer(rf"{fn}\s*\(\s*([^)]*?)\s*\)", original_content):
                    args = m.group(1).split(',')
                    for i, arg in enumerate(args):
                        arg = arg.strip()
                        if arg.isdigit():
                            args_list.append((i, "int"))
                        elif re.match(r'^[A-Za-z_][\w]*$', arg):
                            args_list.append((i, "void*"))
                
                # 生成参数类型声明（取最大参数数量）
                max_args = max([i for i, _ in args_list], default=-1) + 1
                arg_types = ["int" if any(i==n and t=="int" for n,t in args_list) else "void*" 
                            for i in range(max_args)]
                declare_fixes.append(f"{return_type} {fn}({', '.join(arg_types) if arg_types else 'void'});\n")

        # ---------- 通用结构体补全 ----------
        matched_structs = set(re.findall(r"\bstruct\s+(\w+)", original_content))
        for st_name in matched_structs:
            if not re.search(rf"struct\s+{st_name}\s*\{{", original_content):
                if st_name in processed_structs:
                    continue
                processed_structs.add(st_name)
                declare_fixes.append(f"struct {st_name} {{\n    /* 通用空结构体补全 */\n}};\n")

        # 若检测到 wtap, gchar, guint8 等
        if "wtap" in original_content:
            # 防止重复添加结构体定义
            if "wtap" not in processed_structs:
                processed_structs.add("wtap")
            
            # 简单声明
            declare_fixes.append("typedef struct _wtap wtap;\nstruct _wtap {int dummy;};\n")
            # 根据报错补充必要字段
            struct_fields = [
                "FILE *fh;",
                "guint data_offset;",
                "int file_type;",
                "struct { void *lanalyzer; } capture;",
                "unsigned snapshot_length;",
                "int tsprecision;",
                "int (*subtype_read)(void);",
                "int (*subtype_seek_read)(void);",
                "void (*subtype_close)(void);"
            ]
            declare_fixes.insert(0,  # 确保结构体定义在typedef之前
                "struct _wtap {\n    " + 
                "\n    ".join(struct_fields) + 
                "\n};\n")

        if "gchar" in original_content:
            declare_fixes.append("typedef char gchar;\n")

        if "guint8" in original_content:
            declare_fixes.append("typedef unsigned char guint8;\n")

        # ---------- 通用类型补全 ----------
        # 如果用户定义了 typedef X Y，却尚未声明，就可以根据需要插入简单映射
        used_types = set(re.findall(r"\b([A-Za-z_]\w+)\s+\w+;", original_content))
        # 去重一些常见关键字/类型
        blacklist_types = {"int", "unsigned", "char", "unsigned", "short",
                           "long", "float", "double", "void", "size_t",
                           "guint", "guint32", "struct"}
        c_keywords_types = c_keywords | {"return", "sizeof"}  # 扩展关键字列表
        for t in (used_types - c_keywords_types):
            if t not in blacklist_types:
                # 若文件未包含 "typedef ... t;"
                if not re.search(rf"typedef\s+.*\b{t}\s*;", original_content):
                    # 默认为 unsigned int
                    declare_fixes.append(f"typedef unsigned int {t};\n")

        # ---------- 1) 基于关键字检测插入头文件 ----------
        needed_includes = detect_includes(original_content)
        for inc_line in needed_includes:
            header_fixes.append(inc_line + "\n")

        # 如果出现了需要常见的 glib 相关函数/类型，但文件中没包含相应的头
        # 可以自行决定是否要插入 #include <glib.h> 等，这里仅演示
        if 'g_ntohs' in original_content or 'g_ntohl' in original_content:
            # 判断是否已包含 glib.h
            # 仅做简单示例，实际根据具体工程而定
            if not any('#include <glib.h>' in line for line in original_content.split('\n')):
                header_fixes.append('#include <glib.h>\n')

        # ---------- 2) 定义缺失的宏，例如 VARIABLE_LENGTH ----------
        if 'VARIABLE_LENGTH' in original_content and '#define VARIABLE_LENGTH' not in original_content:
            define_fixes.append("#ifndef VARIABLE_LENGTH\n#define VARIABLE_LENGTH 0xFFFF\n#endif\n")

        # ---------- 3) 声明缺失的类型，例如 guint、guint32 ----------
        # 如果通篇未出现类型定义，再补充 typedef
        if 'guint' in original_content:
            # 如果没有搜索到 typedef ... guint;
            if not re.search(r"typedef\s+.*\bguint\s*;", original_content):
                declare_fixes.append("typedef unsigned int guint;\n")

        if 'guint32' in original_content:
            if not re.search(r"typedef\s+.*\bguint32\s*;", original_content):
                declare_fixes.append("typedef unsigned int guint32;\n")

        # ---------- 4) 声明缺失函数 ----------
        # 检测到 g_ntohs 调用，如果没有声明则补充
        if 'g_ntohs' in original_content:
            # 简单搜索函数签名
            if 'unsigned short g_ntohs(' not in original_content:
                declare_fixes.append("unsigned short g_ntohs(unsigned short val);\n")

        if 'g_ntohl' in original_content:
            if 'unsigned int g_ntohl(' not in original_content:
                declare_fixes.append("unsigned int g_ntohl(unsigned int val);\n")

        if 'v9_template_hash' in original_content:
            if 'unsigned int v9_template_hash(' not in original_content:
                declare_fixes.append("unsigned int v9_template_hash(unsigned int id, void *addr, unsigned int sid);\n")

        # ---------- 5) 声明空的结构体 ----------
        # 如果只出现了 struct v9_template *，但没有 struct v9_template { ... } 定义
        if 'struct v9_template' in original_content and 'struct v9_template {' not in original_content:
            declare_fixes.append("struct v9_template {\n    /* 补全: 空结构体声明，具体字段未知 */\n};\n")

        # 补充特定函数声明
        special_funcs = {
            "file_error": "int file_error(FILE *fh);",
            "pletohs": "unsigned short pletohs(unsigned short val);",
            "g_malloc": "void *g_malloc(size_t size);",
            "file_read": "size_t file_read(void *ptr, size_t size, size_t nmemb, FILE *stream);",
            "file_seek": "int file_seek(FILE *stream, long offset, int whence, int *err);",
            "g_free": "void g_free(void *ptr);"
        }
        for fn, decl in special_funcs.items():
            if fn in original_content and \
                not re.search(rf"{fn}\s*\(", original_content):
                declare_fixes.append(f"{decl}\n")

        # 补充 lanalyzer_t 结构体
        if "lanalyzer_t" in original_content:
            declare_fixes.append("typedef struct _lanalyzer_t { int dummy; } lanalyzer_t;\n")

        # 补充缺失的函数指针声明
        missing_funcs = {"lanalyzer_read", "lanalyzer_seek_read", "lanalyzer_close"}
        for mf in missing_funcs:
            if mf in processed_funcs:
                continue
            processed_funcs.add(mf)
            if mf in original_content and f"{mf}(" not in original_content:
                declare_fixes.append(f"int {mf}(void);\n")

        # ================ 合并补全信息放到文件顶部 ================
        fixes_combined = ""
        if header_fixes or define_fixes or declare_fixes:
            fixes_combined += "/* 自动补全的头文件、宏及声明：BEGIN */\n"
            # 添加防止重复包含的保护宏
            if header_fixes:
                fixes_combined += "#ifndef __AUTO_COMPLETION_H__\n#define __AUTO_COMPLETION_H__\n\n"
            fixes_combined += "".join(header_fixes)
            fixes_combined += "".join(define_fixes)
            fixes_combined += "".join(set(declare_fixes))  # 去重后插入
            fixes_combined += "/* 自动补全的头文件、宏及声明：END */\n\n"

        # ================ 写入 comple_vuln.c ================
        new_file = os.path.join(os.path.dirname(file), "comple_vuln.c")
        with open(new_file, 'w', encoding='utf-8') as nf:
            nf.write(fixes_combined + original_content)

        print(f"生成: {new_file}")

    print("脚本执行完毕。")

if __name__ == "__main__":
    main() 