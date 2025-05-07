#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import shutil
import re

# 根目录：包括所有包含 CWE 的上层文件夹
SRC_ROOT = "data/Realworld/process4detect"

# 输出目录：1) 保存 .c 文件的 dataset；2) 保存 .txt 文件的 ground-truth
DATASET_ROOT = "/Users/asteriska/Asteriska/playground/ISMM_test/secllm/real-world/dataset"
GROUND_TRUTH_ROOT = "/Users/asteriska/Asteriska/playground/ISMM_test/secllm/real-world/ground-truth"

RE_VULN  = re.compile(r"vuln",  re.IGNORECASE)
RE_PATCH = re.compile(r"patch", re.IGNORECASE)

# cwe_dir_index_map 用于存储某个CWE下各个子目录分配的编号，如：
# cwe_dir_index_map[cwe_name] = {
#     '501268-v1.0.1': 1,
#     '501269-v1.0.1': 2,
#     ...
# }
cwe_dir_index_map = {}
# 用于为同一 CWE 的下一个子目录分配新的编号
cwe_next_index = {}

def ensure_dir_exists(dir_path):
    if not os.path.exists(dir_path):
        os.makedirs(dir_path)

def copy_and_rename_files():
    """
    遍历与 CWE 相关的子目录，以子目录为单位给出一个编号，并将 vuln.x / patch.x / vuln.txt
    分别重命名为 {N}.x / p_{N}.x / {N}.txt。x代表任意文件扩展名。
    """

    for root, dirs, files in os.walk(SRC_ROOT):
        if "CWE-" not in root:
            continue

        segments = root.split(os.sep)
        cwe_name = None
        for seg in segments:
            if seg.startswith("CWE-"):
                cwe_name = seg
                break

        if not cwe_name:
            continue

        # 获取当前子目录名称(例如 "501268-v1.0.1")
        # 这里的子目录指的是如 /data/SARD/process4detect/CWE-119/501268-v1.0.1
        current_dir_name = os.path.basename(root)
        if not current_dir_name or current_dir_name == cwe_name:
            # 如果正好拿到的 basename 就是 "CWE-xxx"，说明是该CWE根目录，不进行处理
            continue

        # 初始化 cwe_dir_index_map 和 cwe_next_index
        if cwe_name not in cwe_dir_index_map:
            cwe_dir_index_map[cwe_name] = {}
        if cwe_name not in cwe_next_index:
            cwe_next_index[cwe_name] = 1

        # 如果这个子目录还没分配过编号，就为其分配一个新的
        if current_dir_name not in cwe_dir_index_map[cwe_name]:
            cwe_dir_index_map[cwe_name][current_dir_name] = cwe_next_index[cwe_name]
            cwe_next_index[cwe_name] += 1

        pair_index = cwe_dir_index_map[cwe_name][current_dir_name]

        cwe_dataset_path = os.path.join(DATASET_ROOT, cwe_name)
        ensure_dir_exists(cwe_dataset_path)
        cwe_groundtruth_path = os.path.join(GROUND_TRUTH_ROOT, cwe_name)
        ensure_dir_exists(cwe_groundtruth_path)

        # 遍历当前目录下的文件
        for f in files:
            f_lower = f.lower()
            src_file_path = os.path.join(root, f)

            # 如果文件是 .txt，则直接认为是 vuln.txt，并进行对应命名与复制
            if f_lower.endswith('.txt'):
                renamed = f"{pair_index}.txt"
                dst_path = os.path.join(cwe_groundtruth_path, renamed)
                shutil.copy2(src_file_path, dst_path)
                continue

            # 对符合 vuln.x 或 patch.x 的文件进行重命名 (x 代表任意扩展名)
            ext = os.path.splitext(f)[1]
            if RE_VULN.search(f_lower):
                renamed = f"{pair_index}{ext}"
            elif RE_PATCH.search(f_lower):
                renamed = f"p_{pair_index}{ext}"
            else:
                # 如果既不属于 vuln 也不属于 patch，则忽略该文件
                continue

            dst_path = os.path.join(cwe_dataset_path, renamed)
            shutil.copy2(src_file_path, dst_path)

if __name__ == "__main__":
    copy_and_rename_files() 