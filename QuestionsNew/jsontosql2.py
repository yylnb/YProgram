#!/usr/bin/env python3
# batch_json2sql.py
"""
批量把题目 JSON 文件转换为 SQL 插入脚本（按 stage 子目录）。
配置项在文件顶部修改 —— 不需要在终端交互输入。

功能要点：
- 自动扫描指定的 stage 文件夹（例如 stage1, stage2...）
- 对每个 unit 的 JSON 文件生成对应的 .sql 文件到输出目录（保持 stage 子目录）
- 把 fill 题的 `input` / `output` 字段写为 JSON_ARRAY（如果原为字符串则包装为单元素数组）
- code_segments 使用 json.dumps 序列化并正确转义，避免被错误清洗
- 支持按 unit id 范围过滤（只处理需要的 unit）
"""

import json
import os
import re
import time
from typing import Any, Dict, List, Optional

# ================= 配置区（请在这里修改） =================
# JSON 根目录（包含 stage 子目录）
JSON_ROOT = r"F:\project\YProgram\QuestionsNew\python1_insertJSON"

# 输出 SQL 根目录（会保持 stage 子目录结构）
OUTPUT_ROOT = r"F:\project\YProgram\QuestionsNew\python1_insertTEST_from_json"

# 哪些 stage 要处理（按目录名）
STAGES_TO_PROCESS = ["stage1", "stage2", "stage3", "stage4", "stage5"]

# 是否覆盖已存在的 SQL 文件（False 会跳过已存在文件）
OVERWRITE_EXISTING_SQL = False

# 题目数量/单元计算（用于计算 start_qid）
QUESTIONS_PER_UNIT = 15
START_OFFSET = 1  # q_id 起始偏移

# 你想要处理的 unit id 范围（inclusive）。设为 None 表示不限制
UNIT_MIN: Optional[int] = None  # e.g. 61
UNIT_MAX: Optional[int] = None  # e.g. 150

# 题目输出顺序： 'grouped' 或 'interleave_3_2'
DEFAULT_ORDER = 'interleave_3_2'  # 使用你之前指定的排列方式（可修改为 'grouped'）


# ================= 内部实现（下面一般不需要改） =================

def extract_unit_id_from_filename(fname: str) -> Optional[int]:
    """
    从文件名提取 unit id（找到连续的数字序列并返回最大的那个）
    例如 "unit61.json" -> 61, "python1_stage2_unit61.json" -> 61
    返回 None 表示未找到
    """
    nums = re.findall(r'\d+', fname)
    if not nums:
        return None
    # 假定最后出现的数字是 unit id（通常文件名以 unit 开头或结尾）
    return int(nums[-1])


class SQLGenerator:
    def __init__(self, unit_id: int):
        self.unit_id = unit_id

    def escape_sql_single_quote(self, text: Optional[Any]) -> str:
        """把文本转为 SQL 单引号包裹的安全字面量（并转义反斜杠与单引号）。"""
        if text is None:
            return "NULL"
        s = str(text)
        # 先把反斜杠转义，再把单引号转义 （顺序不能反）
        s = s.replace("\\", "\\\\").replace("'", "\\'")
        return f"'{s}'"

    def format_choice(self, q: Dict[str, Any], current_qid: int) -> str:
        opts = q.get('options', {}) or {}
        opt_parts = []
        # options 在选择题中通常是字典 A,B,C...
        if isinstance(opts, dict):
            for k, v in opts.items():
                opt_parts.append(self.escape_sql_single_quote(k))
                opt_parts.append(self.escape_sql_single_quote(v))
        else:
            # 防御处理：如果意外是列表 -> 转为 JSON_ARRAY 字符串存放在 options 字段
            pass

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

    def _make_json_array_from_field(self, val: Any) -> str:
        """
        将一个字段转换为 SQL 的 JSON_ARRAY 表达：
        - 如果 val 是 list -> JSON_ARRAY('a', 'b', ...)
        - 如果 val 是字符串/数字 -> JSON_ARRAY('val')
        - 如果 val 为 None 或空字符串 -> NULL
        """
        if val is None:
            return "NULL"
        if isinstance(val, list):
            if len(val) == 0:
                return "NULL"
            parts = [self.escape_sql_single_quote(x) for x in val]
            return f"JSON_ARRAY({', '.join(parts)})"
        # 非列表（字符串或其他） -> 包成单元素数组
        sval = str(val)
        if sval == "":
            return "NULL"
        return f"JSON_ARRAY({self.escape_sql_single_quote(sval)})"

    def format_fill(self, q: Dict[str, Any], current_qid: int) -> str:
        # code_segments: 先序列化为 JSON 文本（保证内部的引号被正确转义），
        # 再转义单引号与反斜杠以便写进 SQL 单引号字面量。
        code_obj = q.get('code_segments')
        if code_obj is None:
            code_sql_val = "NULL"
        else:
            # 确保 JSON 字符串合理地 escape 双引号等符号
            code_json_str = json.dumps(code_obj, ensure_ascii=False)
            code_sql_val = self.escape_sql_single_quote(code_json_str)

        # options -> JSON_ARRAY(...)
        opts = q.get('options') or []
        opt_str = f"JSON_ARRAY({', '.join([self.escape_sql_single_quote(o) for o in opts])})" if opts else "NULL"

        # answer: 将选项内容转为下标（1-based），如果无法找到则用 0
        ans_indices = []
        for ans in (q.get('answer') or []):
            try:
                idx = opts.index(ans) + 1
            except ValueError:
                idx = 0
            ans_indices.append(idx)
        ans_sql = f"JSON_ARRAY({', '.join(map(str, ans_indices))})" if ans_indices else "NULL"

        # output: 改为严格的 JSON_ARRAY（如果原本是字符串则包装成单元素数组）
        out_sql = self._make_json_array_from_field(q.get('output'))

        # input: 同样改为 JSON_ARRAY（你说明 input 也应为 JSON_ARRAY）
        input_sql = self._make_json_array_from_field(q.get('input'))

        tpl = (
f"""INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    {current_qid},
    {self.unit_id},
    {self.escape_sql_single_quote(q.get('title'))},
    {self.escape_sql_single_quote(q.get('content'))},
    {input_sql},
    {out_sql},
    {code_sql_val},
    {opt_str},
    {ans_sql},
    {self.escape_sql_single_quote(q.get('explanation'))},
    {self.escape_sql_single_quote(q.get('example'))}
);"""
        )
        return tpl


def interleave_pattern(choice_qs: List[Dict[str, Any]], fill_qs: List[Dict[str, Any]], pattern: List[tuple]):
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
    while ci < total_choice:
        yield ('choice', choice_qs[ci]); ci += 1
    while fi < total_fill:
        yield ('fill', fill_qs[fi]); fi += 1


def json_to_sql(data_structure: Dict[str, Any], unit_id: int, start_qid: int = 1, order: str = 'grouped') -> str:
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
        for q in choice_qs:
            sql_lines.append(generator.format_choice(q, active_qid))
            active_qid += 1
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


def process_one_json_file(json_path: str, out_sql_path: str, order: str = DEFAULT_ORDER) -> None:
    with open(json_path, 'r', encoding='utf-8') as fr:
        data = json.load(fr)

    # 试图从文件名或 json 内容中获取 unit id（优先使用文件名内的数字）
    unit_id = extract_unit_id_from_filename(os.path.basename(json_path))
    if unit_id is None and isinstance(data, dict) and data.get('unit_id'):
        unit_id = int(data.get('unit_id'))
    if unit_id is None:
        # 若无法识别，抛错误并停止处理该文件（可以改为默认值）
        raise RuntimeError(f"无法从文件名或 JSON 内容识别 unit id：{json_path}")

    start_qid = (unit_id - 1) * QUESTIONS_PER_UNIT + START_OFFSET

    sql_text = json_to_sql(data, unit_id=unit_id, start_qid=start_qid, order=order)

    # 写出 SQL 文件
    os.makedirs(os.path.dirname(out_sql_path), exist_ok=True)
    with open(out_sql_path, 'w', encoding='utf-8') as fw:
        fw.write(sql_text)


def batch_process():
    total = 0
    skipped = 0
    processed = 0
    for stage in STAGES_TO_PROCESS:
        stage_json_dir = os.path.join(JSON_ROOT, stage)
        if not os.path.isdir(stage_json_dir):
            print(f"⚠️ Stage 目录不存在，跳过: {stage_json_dir}")
            continue

        stage_out_dir = os.path.join(OUTPUT_ROOT, stage)
        os.makedirs(stage_out_dir, exist_ok=True)

        # 列出所有 json 文件（按文件名排序）
        files = sorted([f for f in os.listdir(stage_json_dir) if f.lower().endswith('.json')])

        for fname in files:
            total += 1
            unit_id = extract_unit_id_from_filename(fname)
            if unit_id is None:
                print(f"↩️ 跳过无法识别 unit id 的文件: {fname}")
                skipped += 1
                continue

            # 范围过滤
            if UNIT_MIN is not None and unit_id < UNIT_MIN:
                # print(f"跳过 unit {unit_id}（小于 UNIT_MIN）")
                skipped += 1
                continue
            if UNIT_MAX is not None and unit_id > UNIT_MAX:
                # print(f"跳过 unit {unit_id}（大于 UNIT_MAX）")
                skipped += 1
                continue

            in_path = os.path.join(stage_json_dir, fname)
            out_fname = os.path.splitext(fname)[0] + ".sql"
            out_path = os.path.join(stage_out_dir, out_fname)

            if os.path.exists(out_path) and not OVERWRITE_EXISTING_SQL:
                print(f"⏭️ 已存在 SQL（未覆盖）: {out_path}")
                skipped += 1
                continue

            try:
                process_one_json_file(in_path, out_path, order=DEFAULT_ORDER)
                print(f"✅ 生成: {out_path}")
                processed += 1
            except Exception as e:
                print(f"❌ 处理失败: {in_path} -> {e}")

    print("\n---- 完成统计 ----")
    print(f"总扫描文件数: {total}")
    print(f"已成功生成: {processed}")
    print(f"跳过/未处理: {skipped}")


if __name__ == "__main__":
    print("开始批量转换 JSON -> SQL ...")
    batch_process()
    print("全部任务结束。")