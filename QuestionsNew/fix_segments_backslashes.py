#!/usr/bin/env python3
# fix_segments_backslashes.py
"""
读取一个 .sql 文件，查找所有由单引号包裹且包含 "segments" 的 JSON 字符串，
把其中的 \" 替换为 \\\"
（即把单个反斜杠 + 双引号，变为 三个反斜杠 + 双引号），并输出到新文件。

用法:
  python fix_segments_backslashes.py -i ALL_UNITS.sql -o ALL_UNITS_fixed.sql
"""

import argparse
import re
from pathlib import Path

def fix_segments_in_text(text: str) -> (str, int, int):
    """
    在文本中查找所有由单引号包裹且包含 "segments" 的 JSON 字符串，
    对其内部的 \" 进行替换（变成 3 个反斜杠 + "）。
    返回 (new_text, num_matches, total_replacements)
    """
    # 匹配单引号包裹的字符串，且字符串内部包含 "segments"
    # 解释：'(\{.*?"segments".*?\})'  用 DOTALL 让 . 匹配换行
    pattern = re.compile(r"'(\{.*?\"segments\".*?\})'", re.DOTALL)

    total_replacements = 0
    matches = 0

    def _repl(m):
        nonlocal total_replacements, matches
        matches += 1
        inner = m.group(1)
        # 查找反斜杠 + 双引号 对 (\"), 并把它替换成 三个反斜杠 + 双引号
        # 构造替换字符串时用重复运算，避免源码中出现难懂的转义文字
        old = '\\"'          # 这是两个字符：反斜杠 + 双引号
        new = '\\' * 3 + '"' # 这是三个反斜杠后接双引号（字符序列： \\\ "）
        # 统计替换次数
        count = inner.count(old)
        if count:
            total_replacements += count
            inner = inner.replace(old, new)
        # 返回带单引号包裹的部分（保持 SQL 文件原来的单引号）
        return "'" + inner + "'"

    new_text = pattern.sub(_repl, text)
    return new_text, matches, total_replacements

def main():
    p = argparse.ArgumentParser(description="Fix backslashes before quotes inside '...{\"segments\":...}' blocks in SQL files.")
    p.add_argument("-i", "--input", required=True, help="输入 SQL 文件路径")
    p.add_argument("-o", "--output", required=True, help="输出修正后 SQL 文件路径")
    args = p.parse_args()

    in_path = Path(args.input)
    out_path = Path(args.output)

    if not in_path.exists():
        print(f"❌ 输入文件不存在: {in_path}")
        return

    text = in_path.read_text(encoding="utf-8")

    new_text, matches, replacements = fix_segments_in_text(text)

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(new_text, encoding="utf-8")

    print("✅ 完成")
    print(f"处理的包含 '\"segments\"' 的单引号 JSON 区块数: {matches}")
    print(f"总共替换 \\\" 的次数: {replacements}")
    print(f"修正后的文件已写入: {out_path}")

if __name__ == "__main__":
    main()