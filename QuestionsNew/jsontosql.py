#!/usr/bin/env python3
# json2sql.py
"""
将题目 JSON 转成 MySQL INSERT SQL 脚本的工具。

用法示例：
  python json2sql.py -i unit61.json -o unit61.sql --unit-id 61 --start-qid 915 --order interleave_3_2
或
  cat unit61.json | python json2sql.py -o unit61.sql

支持顺序选项：
  grouped        : 先全部选择题，再全部填空题（默认）
  interleave_3_2 : 按 3 选 / 2 填 的周期交错（用于 15 题单元的特定排列）
"""

import json
import argparse
import sys
import os
import time
import re
from typing import List, Dict, Any, Optional

# ---------- SQL 生成器 ----------
class SQLGenerator:
    def __init__(self, unit_id: int):
        self.unit_id = unit_id

    def escape_sql_single_quote(self, text: Optional[Any]) -> str:
        if text is None:
            return "NULL"
        s = str(text)
        # 转义单引号和反斜杠（尽量兼容）
        s = s.replace("\\", "\\\\").replace("'", "\\'")
        return f"'{s}'"

    def format_choice(self, q: Dict[str, Any], current_qid: int) -> str:
        opts = q.get('options', {})
        # options -> JSON_OBJECT('A', 'textA', 'B', 'textB', ...)
        opt_parts = []
        for k, v in opts.items():
            opt_parts.append(self.escape_sql_single_quote(k))
            opt_parts.append(self.escape_sql_single_quote(v))
        options_sql = f"JSON_OBJECT({', '.join(opt_parts)})" if opt_parts else "NULL"

        hints = q.get('hints', []) or []
        hints_sql = f"JSON_ARRAY({', '.join([self.escape_sql_single_quote(h) for h in hints])})" if hints else "NULL"

        ans_map = {'A': 1, 'B': 2, 'C': 3, 'D': 4}
        raw_ans = q.get('answer', '')
        answer_int = ans_map.get(str(raw_ans).strip(), 0)

        tpl = (
f"""INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    {current_qid},
    {self.unit_id},
    {self.escape_sql_single_quote(q.get('title'))},
    {self.escape_sql_single_quote(q.get('content'))},
    {options_sql},
    {answer_int},
    {hints_sql},
    {self.escape_sql_single_quote(q.get('explanation'))},
    {self.escape_sql_single_quote(q.get('example'))}
);"""
        )
        return tpl

    def format_fill(self, q: Dict[str, Any], current_qid: int) -> str:
        code_obj = q.get('code_segments')
        # 将 code_segments 序列化为 JSON 字符串并用单引号包裹
        code_json_str = json.dumps(code_obj, ensure_ascii=False)
        code_sql_val = self.escape_sql_single_quote(code_json_str)

        opts = q.get('options') or []
        opt_str = f"JSON_ARRAY({', '.join([self.escape_sql_single_quote(o) for o in opts])})" if opts else "NULL"

        # 将 answer 内容（文本）转成下标（1-based）数组，若找不到则用 0 占位
        ans_indices = []
        for ans in (q.get('answer') or []):
            try:
                idx = opts.index(ans) + 1
            except ValueError:
                idx = 0
            ans_indices.append(idx)
        ans_sql = f"JSON_ARRAY({', '.join(map(str, ans_indices))})" if ans_indices else "NULL"

        outs = q.get('output')
        if isinstance(outs, list):
            out_parts = [self.escape_sql_single_quote(str(o)) for o in outs]
            out_sql = f"JSON_ARRAY({', '.join(out_parts)})"
        elif outs is None or outs == "":
            out_sql = "NULL"
        else:
            out_sql = f"JSON_ARRAY({self.escape_sql_single_quote(str(outs))})"

        tpl = (
f"""INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    {current_qid},
    {self.unit_id},
    {self.escape_sql_single_quote(q.get('title'))},
    {self.escape_sql_single_quote(q.get('content'))},
    {self.escape_sql_single_quote(q.get('input'))},
    {out_sql},
    {code_sql_val},
    {opt_str},
    {ans_sql},
    {self.escape_sql_single_quote(q.get('explanation'))},
    {self.escape_sql_single_quote(q.get('example'))}
);"""
        )
        return tpl

# ---------- 顺序生成器（支持两种策略） ----------
def interleave_pattern(choice_qs: List[Dict[str, Any]], fill_qs: List[Dict[str, Any]], pattern: List[tuple]):
    """
    根据 pattern 交错产生 'choice' 或 'fill' 类型项给调用者消费。
    pattern 示例: [('choice', 3), ('fill', 2), ...]
    逐段输出，直到两边都耗尽；如果一方耗尽则跳过该段中的项。
    """
    ci = 0
    fi = 0
    total_choice = len(choice_qs)
    total_fill = len(fill_qs)
    for typ, count in pattern:
        for _ in range(count):
            if typ == 'choice':
                if ci < total_choice:
                    yield ('choice', choice_qs[ci])
                    ci += 1
            else:
                if fi < total_fill:
                    yield ('fill', fill_qs[fi])
                    fi += 1
    # 剩余追加
    while ci < total_choice:
        yield ('choice', choice_qs[ci]); ci += 1
    while fi < total_fill:
        yield ('fill', fill_qs[fi]); fi += 1

# ---------- 主转换函数 ----------
def json_to_sql(
    data_structure: Dict[str, Any],
    unit_id: int,
    start_qid: int = 1,
    order: str = 'grouped'
) -> str:
    """
    将 data_structure 转换为 SQL 文本并返回字符串。
    order:
      - 'grouped'        : 所有选择题 -> 所有填空题
      - 'interleave_3_2' : 按 (3 choice, 2 fill) 的周期交错（你之前要求的）
    """
    generator = SQLGenerator(unit_id=unit_id)
    sql_lines = [
        "USE `questions`;",
        f"-- Unit {unit_id} | Start ID: {start_qid}",
        f"-- Generated at {time.strftime('%Y-%m-%d %H:%M:%S')}\n"
    ]
    active_qid = start_qid

    choice_qs = data_structure.get('choice_questions', []) or []
    fill_qs = data_structure.get('fill_questions', []) or []

    if order == 'grouped':
        # 所有选择题
        for q in choice_qs:
            sql_lines.append(generator.format_choice(q, active_qid))
            active_qid += 1
        # 所有填空题（分隔注释）
        if fill_qs:
            sql_lines.append("\n-- ---------- 填空题 ----------")
        for q in fill_qs:
            sql_lines.append(generator.format_fill(q, active_qid))
            active_qid += 1

    elif order == 'interleave_3_2':
        pattern = [('choice', 3), ('fill', 2), ('choice', 3), ('fill', 2), ('choice', 3), ('fill', 2)]
        for typ, q in interleave_pattern(choice_qs, fill_qs, pattern):
            if typ == 'choice':
                sql_lines.append(generator.format_choice(q, active_qid))
            else:
                sql_lines.append(generator.format_fill(q, active_qid))
            active_qid += 1
    else:
        raise ValueError("Unsupported order: " + str(order))

    return "\n".join(sql_lines)

# ---------- CLI 部分 ----------
def read_json_from_stdin_or_file(path: Optional[str]) -> Dict[str, Any]:
    raw = None
    if path:
        with open(path, 'r', encoding='utf-8') as f:
            raw = f.read()
    else:
        raw = sys.stdin.read()
    # 允许用户输入包含 ```json ``` 的文本（做简单清理）
    raw = re.sub(r'^```json\s*', '', raw, flags=re.MULTILINE)
    raw = re.sub(r'^```\s*', '', raw, flags=re.MULTILINE)
    return json.loads(raw)

def main_cli():
    p = argparse.ArgumentParser(description="JSON -> MySQL INSERT SQL for questions")
    p.add_argument('-i', '--input', help="输入 JSON 文件路径。若缺省则从 stdin 读取.")
    p.add_argument('-o', '--output', required=True, help="输出 SQL 文件路径（或 use - 为 stdout）")
    p.add_argument('--unit-id', type=int, default=1, help="unit_id 字段（默认 1）")
    p.add_argument('--start-qid', type=int, default=1, help="起始 q_id（默认 1）")
    p.add_argument('--order', choices=['grouped', 'interleave_3_2'], default='grouped',
                   help="题目输出顺序（grouped 或 interleave_3_2）")
    args = p.parse_args()

    try:
        data = read_json_from_stdin_or_file(args.input)
    except Exception as e:
        print("读取 JSON 失败:", e, file=sys.stderr)
        sys.exit(2)

    try:
        sql_text = json_to_sql(data, unit_id=args.unit_id, start_qid=args.start_qid, order=args.order)
    except Exception as e:
        print("转换为 SQL 失败:", e, file=sys.stderr)
        sys.exit(3)

    if args.output == '-':
        print(sql_text)
    else:
        os.makedirs(os.path.dirname(os.path.abspath(args.output)), exist_ok=True)
        with open(args.output, 'w', encoding='utf-8') as fw:
            fw.write(sql_text)
        print(f"✅ 已生成 SQL：{args.output}")

if __name__ == '__main__':
    main_cli()
