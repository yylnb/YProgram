#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
txt_to_json_parser.py

将杂格式的题库 txt 文件解析为标准化 JSON（choice / fill）。
- 自动处理三种常见格式（Python-like single-quoted literal、JSON-like with // 注释、带 ``` 包裹的片段）
- 生成的 JSON 符合后续 SQL 生成器期待的中间格式：
  - choice: { "type":"choice", "q_id": "...", "title": "...", "text": "...", "options": {"A":"..","B":"..","C":"..","D":".."}, "answer":"B", "hints":[...], "explanation":"...", "example":"..." }
  - fill:   { "type":"fill",   "q_id": "...", "title": "...", "text": "...", "raw_code": "... (with __1__,__2__ slots)", "options":[...], "answer":[1,2], "input":..., "output":..., "explanation":..., "example":... }
"""
import re
import json
import ast
import os
from typing import Any, Dict, List, Optional

# ----------------------------
# CONFIG - 把要处理的 txt 文件路径写在这里
# ----------------------------
CONFIG = {
    # 列表：每项是输入 txt 的路径（可以是相对或绝对路径）
    # 注意：Windows 路径请使用 r'...' 原始字符串或双反斜杠
    "input_txt_files": [
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit1.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit2.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit3.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit4.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit5.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit6.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit7.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit8.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit9.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit10.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit11.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit12.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit13.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit14.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit15.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit16.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit17.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit18.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit19.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit20.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit21.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit22.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit23.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit24.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit25.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit26.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit27.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit28.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit29.txt",
        r"F:\project\YProgram\Questions\python1\stage1\python1_stage1_unit30.txt",
    ],
    # 输出目录（如果为空则与输入文件同目录，且文件名改为 .json）
    "output_dir": r"./output_json",
    # 若 True，输出会覆盖已存在文件；否则在存在时追加序号避免覆盖
    "overwrite": True
}

# ----------------------------
# 文本预处理 / 清理
# ----------------------------
def strip_code_fence(s: str) -> str:
    """移除 ``` ``` 代码块围栏与首尾的 '```plaintext' 等标签"""
    s = re.sub(r'^\s*```(?:\w+)?\s*', '', s, flags=re.MULTILINE)
    s = re.sub(r'\s*```\s*$', '', s, flags=re.MULTILINE)
    return s

def remove_js_comments(s: str) -> str:
    """移除 // 单行注释和 /* ... */ 多行注释（best-effort）"""
    s = re.sub(r'/\*[\s\S]*?\*/', '', s)
    s = re.sub(r'//.*$', '', s, flags=re.MULTILINE)
    return s

def remove_trailing_commas(s: str) -> str:
    """
    移除 JSON / Python 结构中尾随逗号，例如 {..., } 或 [..., ]
    这是一个启发式处理，适用于常见场景。
    """
    s = re.sub(r',\s*([\]\}])', r'\1', s)
    return s

def normalize_true_false_null(s: str) -> str:
    """
    把 JSON 风格的 true/false/null 替换为 Python 风格 True/False/None，
    以便 ast.literal_eval 也能解析（只有在需要 ast 解析时使用）。
    """
    s = re.sub(r'\btrue\b', 'True', s, flags=re.IGNORECASE)
    s = re.sub(r'\bfalse\b', 'False', s, flags=re.IGNORECASE)
    s = re.sub(r'\bnull\b', 'None', s, flags=re.IGNORECASE)
    return s

def preprocess_raw_text(s: str) -> str:
    """统一做一些清理，返回清理后的文本"""
    if not s:
        return s
    s = strip_code_fence(s)
    s = remove_js_comments(s)
    s = remove_trailing_commas(s)
    return s

# ----------------------------
# 尝试解析为 Python 对象（安全策略）
# ----------------------------
def parse_text_to_obj(s: str) -> Any:
    """
    尝试多种策略将文本解析为 Python 对象（dict/list）。
    顺序：
      1. json.loads
      2. json.loads after removing comments/trailing commas
      3. ast.literal_eval after normalization
    如果都失败，抛出 ValueError。
    """
    raw = s
    # 1) 直接尝试 JSON（如果是标准 JSON）
    try:
        return json.loads(raw)
    except Exception:
        pass

    # 2) 先做基本预处理（去注释、尾随逗号）再尝试 JSON
    cleaned = preprocess_raw_text(raw)
    try:
        return json.loads(cleaned)
    except Exception:
        pass

    # 3) 尝试 ast.literal_eval（把 true/false/null 替换为 Python 词）
    try:
        py_ready = normalize_true_false_null(cleaned)
        obj = ast.literal_eval(py_ready)
        return obj
    except Exception as e:
        # 最后一招：再尝试一些更松的替换（把未转义的单引号转为双引号）然后 json.loads
        try:
            alt = re.sub(r"(?<!\\)'", '"', cleaned)  # 把未被转义的单引号替换为双引号（启发式）
            alt = remove_trailing_commas(alt)
            return json.loads(alt)
        except Exception:
            raise ValueError(f"无法解析输入文本为结构化对象（既非 JSON 也非 Python 字面量）: {e}")

# ----------------------------
# 新增：从混合文本中提取每个 { ... } 块（用于容错解析）
# ----------------------------
def extract_question_blocks(text: str) -> List[str]:
    """
    从混合文本中提取最外层 JSON-like 对象块（以 { 开始、} 结束，支持嵌套）。
    返回每个完整对象的原始文本（字符串列表）。
    这是对非标准文件的容错策略：只要文件中包含 { ... } 对象就能提取并单独解析。
    """
    blocks: List[str] = []
    stack = []
    start = None
    in_string = False
    string_char = ''
    escape = False

    for i, ch in enumerate(text):
        if not in_string:
            if ch in ('"', "'"):
                in_string = True
                string_char = ch
                escape = False
                continue
            if ch == '{':
                if not stack:
                    start = i
                stack.append('{')
            elif ch == '}':
                if stack:
                    stack.pop()
                    if not stack and start is not None:
                        blocks.append(text[start:i+1])
                        start = None
        else:
            # inside string: handle escaping and closing quote
            if escape:
                escape = False
            elif ch == '\\':
                escape = True
            elif ch == string_char:
                in_string = False
                string_char = ''
                escape = False

    return blocks

# ----------------------------
# 辅助：把 fill 的占位符 '___' 转为 __1__ / __2__ / ...
# ----------------------------
def replace_underscores_with_slots(code: str) -> str:
    """
    把代码中出现的 '___'（三下划线）按出现顺序替换成 __1__, __2__, ...
    返回替换后的 code 字符串（占位为 __1__、__2__ ...）
    """
    if not code:
        return code
    def repl(m):
        repl.counter += 1
        return f"__{repl.counter}__"
    repl.counter = 0
    new_code = re.sub(r'___', repl, code)
    return new_code

# ----------------------------
# 规范化单题（把不同源字段映射到统一字段）
# ----------------------------
# —— 只展示核心变化，完整文件你可以直接替换 —— #

def normalize_question(raw_q: Dict[str, Any]) -> Dict[str, Any]:
    q = {}
    warnings = []

    # ---------- q_id ----------
    qid = raw_q.get('id') or raw_q.get('q_id') or raw_q.get('qid')
    if qid is None:
        qid = f"unknown_{id(raw_q)}"
        warnings.append("missing q_id")
    q['q_id'] = str(qid)

    # ---------- type ----------
    t = str(raw_q.get('type') or raw_q.get('question_type') or '').lower()
    if any(k in t for k in ['choice', 'select', 'single']):
        q['type'] = 'choice'
    elif any(k in t for k in ['fill', 'blank', 'code', 'input']):
        q['type'] = 'fill'
    else:
        q['type'] = 'choice'
        warnings.append(f"unknown type '{t}', defaulted to choice")

    # ---------- common ----------
    q['title'] = raw_q.get('title', '')
    q['text'] = raw_q.get('text') or raw_q.get('content') or ''
    q['explanation'] = raw_q.get('explanation')
    q['example'] = raw_q.get('example')

    hints = raw_q.get('hints')
    if isinstance(hints, str):
        q['hints'] = [hints]
    else:
        q['hints'] = hints

    q['input'] = raw_q.get('input')
    q['output'] = raw_q.get('output')

    # ---------- choice ----------
    if q['type'] == 'choice':
        opts = raw_q.get('options', {})
        if isinstance(opts, dict):
            q['options'] = opts
        elif isinstance(opts, list):
            q['options'] = dict(zip(['A','B','C','D'], opts))
        else:
            q['options'] = {}

        ans = raw_q.get('answer')
        if isinstance(ans, str):
            ans = ans.strip().upper()
            if ans in 'ABCD':
                q['answer'] = ans
            else:
                warnings.append(f"invalid answer '{ans}'")
                q['answer'] = None
        elif isinstance(ans, int):
            q['answer'] = {1:'A',2:'B',3:'C',4:'D'}.get(ans)
        else:
            q['answer'] = None

    # ---------- fill ----------
    else:
        code = raw_q.get('code') or raw_q.get('raw_code') or ''
        q['raw_code'] = replace_underscores_with_slots(code)

        opts = raw_q.get('options')
        if isinstance(opts, list):
            q['options'] = opts
        elif isinstance(opts, str):
            q['options'] = [o.strip() for o in opts.split(',')]
        else:
            q['options'] = []

        ans = raw_q.get('answer')
        if isinstance(ans, list):
            q['answer'] = [int(x) for x in ans if str(x).isdigit()]
        elif isinstance(ans, str):
            q['answer'] = [int(x) for x in re.findall(r'\d+', ans)]
        else:
            q['answer'] = []

    if warnings:
        q['_warnings'] = warnings

    return q

# ----------------------------
# 主流程：处理文件 -> 输出 JSON
# ----------------------------
def process_file(input_path: str, output_dir: Optional[str] = None, overwrite: bool = True) -> str:
    """
    解析单个 txt 文件并写出标准化的 JSON 文件。
    返回写入的输出文件路径。
    """
    with open(input_path, 'r', encoding='utf-8') as f:
        raw_text = f.read()

    questions_raw: List[Dict[str, Any]] = []

    # 1) 尝试把整个文本解析为一个对象（通常是最简单的情况）
    try:
        obj = parse_text_to_obj(raw_text)
        if isinstance(obj, dict):
            if 'questions' in obj and isinstance(obj['questions'], (list,tuple)):
                questions_raw = list(obj['questions'])
            elif 'problems' in obj and isinstance(obj['problems'], (list,tuple)):
                questions_raw = list(obj['problems'])
            elif 'questions' in obj and isinstance(obj['questions'], dict):
                questions_raw = list(obj['questions'].values())
            else:
                # 找到第一个 list value
                found = None
                for v in obj.values():
                    if isinstance(v, (list,tuple)):
                        found = v
                        break
                if found is not None:
                    questions_raw = list(found)
                else:
                    # 如果 obj 本身看起来像单个题目 dict，则把它当作单题
                    if all(k in obj for k in ('id','type')) or ('type' in obj):
                        questions_raw = [obj]
                    else:
                        raise ValueError("解析后对象不是题目列表或单题")
        elif isinstance(obj, list):
            questions_raw = list(obj)
        else:
            raise ValueError("解析后的对象不是 dict/list")
    except Exception as e:
        # 如果整体解析失败，尝试从文本中抽取每个 { ... } 块，逐个解析（容错策略）
        print(f"[INFO] 整体解析失败，尝试按对象块提取再逐个解析：{e}")
        blocks = extract_question_blocks(raw_text)
        if not blocks:
            raise ValueError(f"未在文件 {input_path} 中提取到任何题目块，整体解析错误：{e}")
        for blk in blocks:
            try:
                sub_obj = parse_text_to_obj(blk)
                # sub_obj 要么是 dict（单题），要么是 list（多个题）
                if isinstance(sub_obj, dict):
                    questions_raw.append(sub_obj)
                elif isinstance(sub_obj, list):
                    questions_raw.extend(list(sub_obj))
            except Exception as ee:
                print(f"[WARN] 单个对象块解析失败（跳过），错误: {ee}\n块内容前100字符: {blk[:100]!r}")

    # 到这里，questions_raw 应该被填充
    if not questions_raw:
        raise ValueError(f"解析后未获得任何题目：{input_path}")

    normalized = []
    for raw_q in questions_raw:
        try:
            nq = normalize_question(raw_q)
            normalized.append(nq)
        except Exception as e:
            print(f"[WARN] 在文件 {input_path} 处理题目时出错（跳过）。错误: {e}\n题目原始: {raw_q}")
            continue

    # 输出 JSON
    base = os.path.basename(input_path)
    name, _ = os.path.splitext(base)
    if output_dir:
        os.makedirs(output_dir, exist_ok=True)
        out_path = os.path.join(output_dir, f"{name}.json")
    else:
        out_path = os.path.join(os.path.dirname(input_path), f"{name}.json")

    if (not overwrite) and os.path.exists(out_path):
        i = 1
        while True:
            alt = os.path.join(os.path.dirname(out_path), f"{name}_{i}.json")
            if not os.path.exists(alt):
                out_path = alt
                break
            i += 1

    with open(out_path, 'w', encoding='utf-8') as f:
        json.dump(normalized, f, ensure_ascii=False, indent=2)

    print(f"[OK] {input_path} -> {out_path}  （题目数：{len(normalized)}）")
    return out_path

def main():
    files = CONFIG.get('input_txt_files', [])
    out_dir = CONFIG.get('output_dir') or None
    ow = CONFIG.get('overwrite', True)
    for p in files:
        try:
            process_file(p, output_dir=out_dir, overwrite=ow)
        except Exception as e:
            print(f"[ERROR] 处理文件 {p} 时失败: {e}")

if __name__ == "__main__":
    main()