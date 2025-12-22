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
        r"F:\project\YProgram\Questions\python1_stage1_unit1.txt",
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
def normalize_question(raw_q: Dict[str, Any]) -> Dict[str, Any]:
    """
    输入 raw_q（为 dict），输出规范化 question dict。
    输出格式参考之前约定：
    - choice: {type, q_id, title, text, options(dict A..D), answer (A/B/... uppercase), hints, explanation, example}
    - fill:   {type, q_id, title, text, raw_code (with __1__ placeholders), options(list), answer(list of ints 1-based), input, output, explanation, example}
    """
    q = {}
    # q_id
    qid = raw_q.get('id') or raw_q.get('q_id') or raw_q.get('qid') or raw_q.get('ID')
    if qid is None:
        raise ValueError("题目缺少 id 字段，无法继续：%r" % raw_q)
    q['q_id'] = str(qid)

    # type
    t = raw_q.get('type') or raw_q.get('question_type') or raw_q.get('kind')
    if not t:
        raise ValueError(f"题目 {qid} 缺少 type 字段")
    t = str(t).strip().lower()
    if t not in ('choice','fill'):
        if 'choice' in t:
            t = 'choice'
        elif 'fill' in t:
            t = 'fill'
        else:
            raise ValueError(f"题目 {qid} 的 type 字段未知: {t}")
    q['type'] = t

    # title
    q['title'] = raw_q.get('title') or raw_q.get('name') or ''

    # text: 多个字段名兼容
    q_text = raw_q.get('content') or raw_q.get('text') or raw_q.get('question') or ''
    q['text'] = q_text

    # common fields
    q['explanation'] = raw_q.get('explanation') or raw_q.get('explain') or None
    q['example'] = raw_q.get('example') or None
    q['hints'] = raw_q.get('hints') or None
    # For fill: input / output
    q['input'] = raw_q.get('input') if 'input' in raw_q else None
    q['output'] = raw_q.get('output') if 'output' in raw_q else None

    if q['type'] == 'choice':
        # options: may be dict or list or string
        opts = raw_q.get('options') or {}
        if isinstance(opts, dict):
            norm = {}
            for k in ['A','B','C','D']:
                if k in opts:
                    norm[k] = opts[k]
                elif k.lower() in opts:
                    norm[k] = opts[k.lower()]
            if len(norm) < 4:
                vals = list(opts.values())
                keys = ['A','B','C','D']
                for i,k in enumerate(keys):
                    if k not in norm:
                        norm[k] = vals[i] if i < len(vals) else ''
            q['options'] = norm
        elif isinstance(opts, list):
            keys = ['A','B','C','D']
            norm = {}
            for i,k in enumerate(keys):
                norm[k] = opts[i] if i < len(opts) else ''
            q['options'] = norm
        elif isinstance(opts, str):
            parts = [p.strip() for p in opts.split(',')]
            keys = ['A','B','C','D']
            norm = {}
            for i,k in enumerate(keys):
                norm[k] = parts[i] if i < len(parts) else ''
            q['options'] = norm
        else:
            q['options'] = {'A':'','B':'','C':'','D':''}

        # answer
        raw_ans = raw_q.get('answer')
        if raw_ans is None:
            q['answer'] = None
        else:
            if isinstance(raw_ans, str):
                a = raw_ans.strip().upper()
                if a in ('A','B','C','D'):
                    q['answer'] = a
                else:
                    try:
                        num = int(a)
                        if 1 <= num <= 4:
                            q['answer'] = {1:'A',2:'B',3:'C',4:'D'}[num]
                        else:
                            q['answer'] = None
                    except:
                        q['answer'] = None
            elif isinstance(raw_ans, int):
                q['answer'] = {1:'A',2:'B',3:'C',4:'D'}.get(raw_ans)
            else:
                q['answer'] = None

    else:  # fill
        code_raw = raw_q.get('code') or raw_q.get('raw_code') or ''
        code_with_slots = replace_underscores_with_slots(code_raw)
        q['raw_code'] = code_with_slots

        opts = raw_q.get('options')
        if isinstance(opts, str):
            if '示例' in opts or '给出' in opts:
                q['options'] = [opts.strip()]
            else:
                q['options'] = [p.strip() for p in opts.split(',') if p.strip()!='']
        elif isinstance(opts, list):
            q['options'] = opts
        else:
            if isinstance(opts, dict):
                q['options'] = list(opts.values())
            else:
                q['options'] = []

        raw_ans = raw_q.get('answer')
        if raw_ans is None:
            q['answer'] = []
        else:
            if isinstance(raw_ans, str):
                parts = [p.strip() for p in raw_ans.split(',') if p.strip()!='']
                nums = []
                for p in parts:
                    try:
                        nums.append(int(p))
                    except:
                        pass
                q['answer'] = nums
            elif isinstance(raw_ans, (list,tuple)):
                nums = []
                for a in raw_ans:
                    try:
                        nums.append(int(a))
                    except:
                        pass
                q['answer'] = nums
            elif isinstance(raw_ans, int):
                q['answer'] = [raw_ans]
            else:
                q['answer'] = []

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