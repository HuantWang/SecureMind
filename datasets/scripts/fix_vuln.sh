#!/usr/bin/env bash
#
# 脚本功能：
# 1. 递归搜索指定目录下所有名为 vuln.c 的文件
# 2. 在同目录下生成 comple_vuln.c 文件，对代码进行简单的补全处理
#    - 添加必要的头文件
#    - 定义可能缺失的宏（如 VARIABLE_LENGTH 等）
#    - 声明缺失的类型与函数（如 guint、g_ntohs 等）
# 
# 用法：
#   ./fix_vuln.sh /path/to/search

SEARCH_DIR="$1"

if [ -z "$SEARCH_DIR" ]; then
  echo "用法：$0 <搜索目录>"
  exit 1
fi

# 判断目标是否为目录
if [ ! -d "$SEARCH_DIR" ]; then
  echo "错误：$SEARCH_DIR 不是有效的目录。"
  exit 1
fi

# 查找所有名为 vuln.c 的文件
file_list=$(find "$SEARCH_DIR" -type f -name "vuln.c")

# 如果没有找到任何 vuln.c 文件，退出
if [ -z "$file_list" ]; then
  echo "未找到任何 vuln.c 文件。"
  exit 0
fi

for file in $file_list; do
  echo "处理文件: $file"

  # 读取原文件内容
  original_content="$(cat "$file")"

  # 准备要插入的补全信息
  # 可以根据实际需求添加更多检测逻辑，避免重复插入

  header_fixes=""
  define_fixes=""
  declare_fixes=""

  # 1. 头文件插入：简单判断是否包含了需要的头文件
  #    这里仅示例，实际项目工程中可根据需要检测关键字再决定是否插入
  if ! grep -qE "^\s*#\s*include\s+<stdint\.h>" <<< "$original_content"; then
    header_fixes+="#include <stdint.h>\n"
  fi
  if ! grep -qE "^\s*#\s*include\s+<string\.h>" <<< "$original_content"; then
    header_fixes+="#include <string.h>\n"
  fi

  # 2. 定义缺失的宏，例如 VARIABLE_LENGTH
  if grep -q "VARIABLE_LENGTH" <<< "$original_content"; then
    if ! grep -q "#define VARIABLE_LENGTH" <<< "$original_content"; then
      define_fixes+="#ifndef VARIABLE_LENGTH\n#define VARIABLE_LENGTH 0xFFFF\n#endif\n"
    fi
  fi

  # 3. 声明缺失的类型，例如 guint、guint32
  #    如果 original_content 中出现 guint/guint32，却查找不到任何 typedef 声明，可以插入 typedef
  if grep -q "guint" <<< "$original_content"; then
    if ! grep -qE "typedef\s+.*guint;" <<< "$original_content"; then
      declare_fixes+="typedef unsigned int guint;\n"
    fi
  fi

  if grep -q "guint32" <<< "$original_content"; then
    if ! grep -qE "typedef\s+.*guint32;" <<< "$original_content"; then
      declare_fixes+="typedef unsigned int guint32;\n"
    fi
  fi

  # 4. 声明缺失函数
  #    这里仅列举最常见的 g_ntohs, g_ntohl, v9_template_hash 等，视情况添加
  if grep -q "g_ntohs" <<< "$original_content"; then
    if ! grep -q "g_ntohs(" <<< "$original_content" -A 10 | grep -qE "^\s*unsigned\s+short\s+g_ntohs"; then
      declare_fixes+="unsigned short g_ntohs(unsigned short val);\n"
    fi
  fi

  if grep -q "g_ntohl" <<< "$original_content"; then
    if ! grep -q "g_ntohl(" <<< "$original_content" -A 10 | grep -qE "^\s*unsigned\s+int\s+g_ntohl"; then
      declare_fixes+="unsigned int g_ntohl(unsigned int val);\n"
    fi
  fi

  if grep -q "v9_template_hash" <<< "$original_content"; then
    if ! grep -q "v9_template_hash(" <<< "$original_content" -A 10 | grep -qE "unsigned\s+int\s+v9_template_hash"; then
      declare_fixes+="unsigned int v9_template_hash(unsigned int id, void *addr, unsigned int sid);\n"
    fi
  fi

  # 5. 声明空的结构体，示例：struct v9_template
  #    如果只出现了 struct v9_template * 模式，就为其插入一个空壳声明以通过编译
  if grep -q "struct v9_template" <<< "$original_content"; then
    if ! grep -q "struct v9_template {" <<< "$original_content"; then
      declare_fixes+="struct v9_template {\n    /* 补全: 空结构体声明，具体字段未知 */\n};\n"
    fi
  fi

  # 合并补全内容：插入到文件顶部
  fixes_combined=""
  if [ -n "$header_fixes" ] || [ -n "$define_fixes" ] || [ -n "$declare_fixes" ]; then
    fixes_combined+="/* 自动补全的头文件、宏及声明：BEGIN */\n"
    fixes_combined+="$header_fixes"
    fixes_combined+="$define_fixes"
    fixes_combined+="$declare_fixes"
    fixes_combined+="/* 自动补全的头文件、宏及声明：END */\n\n"
  fi

  # 生成新文件名
  new_file="${file%/*}/comple_vuln.c"

  # 写出合并内容到 comple_vuln.c
  {
    echo -e "$fixes_combined"
    echo -e "$original_content"
  } > "$new_file"

  echo "生成: $new_file"
done

echo "脚本执行完毕。" 