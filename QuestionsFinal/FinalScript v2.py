#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
generate_and_export_sql_final_v2.py

完整脚本：已按要求修改 json->sql 部分的三项问题：
1) unit_id 从 1 开始（使用 global_unit_index）
2) 选择题 answer 映射为整数 A->1,B->2,C->3,D->4
3) 将 JSON 字段中反斜杠做三重转义（每个 '\' -> '\\\\\'），确保生成 SQL 时双引号前有 3 个反斜杠
"""
import os
import json
import time
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
from typing import List, Any, Optional, Tuple

# Requires: pip install openai
from openai import OpenAI

# ----------------------------
# ========== 配置区 ==========
# ----------------------------
# DeepSeek API key: 使用环境变量 DEEPSEEK_API_KEY（推荐）
DEEPSEEK_API_KEY = "sk-eeea8f33515f40e1b7c80d20960b5a28"
# 如果临时测试需要，也可在这里写明（不推荐长期硬编码）
# DEEPSEEK_API_KEY = "sk-..."

DEEPSEEK_BASE_URL = "https://api.deepseek.com"
MODEL_NAME = "deepseek-reasoner"

# 固定任务规模（总量 = STAGES * UNITS_PER_STAGE）
STAGES = 5
UNITS_PER_STAGE = 30
NUM_QUESTIONS_PER_UNIT = 15  # 每 unit 生成 15 题

# 并发与重试
MAX_WORKERS = 5
RETRY_ATTEMPTS = 3
RETRY_BACKOFF_FACTOR = 2

# 主题文件（每行一个单元主题，按 stage-major 顺序）
THEMES_TXT_PATH = Path(r"F:\\project\\YProgram\\QuestionsFinal\\Python questions outline.txt")

# 输出根目录（按你的要求）
BASE_OUT_DIR = Path(r"F:\\project\\YProgram\\QuestionsFinal\\Questions_v2")

# MySQL 表名（按你提供）
CHOICE_TABLE = "que_choice_py_1"
FILL_TABLE = "que_fill_py_1"

# System prompt（你提供）
SYSTEM_PROMPT = """
你是一名Python编程教学题目的出题专家，现在用户需要你根据特定的单元主题和单元知识点生成Python教学题目。
每单元题型和难度固定：
1.题号 1–3、6–8、11–13 为传统选择题（多选项 ABCD）：
（1）id：题目序号。类型：整数。
（2）type：choice。类型：文本。
（3）title：简短的标题。类型：文本。
（4）content：详细的题目内容；使用情景化和幽默的语言；不可多行。类型：文本。
（5）options：4个选项的内容。类型：JSON数组。
（6）answer：答案，一个大写字母。类型：文本。
（7）hints：3个提示，用于答错后显示；提示程度逐渐递增。类型：JSON数组。
（8）explanation：对正确答案的解释，用于答对后显示。类型：文本。
（9）example：1个示例；用于答对后显示，提升用户举一反三的能力。类型：文本。

2.题号 4–5、9–10、14–15 为“选择填空题”（在完整代码或语句中挖空，选项为若干代码片段/字符串/符号，可远多于 4 个干扰项；若需多个空则按填空顺序列出答案数字顺序，但每个答案只能使用一次）：
（1）id：题目序号。类型：整数。
（2）type：fill。类型：文本。
（3）title：简短的标题。类型：文本。
（4）content：详细的题目内容；使用情景化和幽默的语言；不可多行。类型：文本。
（5）input：题目中的程序运行时的输入；可有可无，根据代码情况决定；可多行，JSON数组中的一个项代表一行内容。类型：null或JSON数组。
（6）output：题目中的程序运行时的输出；可有可无，根据代码情况决定；可多行，JSON数组中的一个项代表一行内容。类型：null或JSON数组。
（7）code_segments：题目的代码块。必须有。
字段类型必须是 **JSON 对象（object）**，不得是字符串，不得进行二次转义，不得在外层再加引号。
字段结构采用 `segments` 数组，每个 segment 必须且只能是以下两种之一：
- （1）纯代码块：
  {
    "type": "code_block",
    "lines": [
      { "type": "code_line", "value": "..." },
      ...
    ]
  }
  表示一行或多行**不包含挖空**的完整代码。
- （2）行内填空代码：
  {
    "type": "code_inline",
    "parts": [
      { "type": "code", "value": "..." },
      { "type": "slot", "index": 0 },
      { "type": "code", "value": "..." },
      ...
    ]
  }
  表示同一行中既有代码又有填空。
`slot` 的 `index` 必须使用 **0-based**，并且按从左到右顺序递增。
（8）options：可填入挖空的选项；必须有；有干扰项；有多个，数量根据题目情况决定。类型：JSON数组。
（9）answer：选项的答案；选项的数字序列；必须有。类型：JSON数组。
（10）explanation：对正确答案的解释，用于答对后显示。类型：文本。
（11）example：1个示例；用于答对后显示，提升用户举一反三的能力。类型：文本。

3.题目难度分层：1–5 为简单、6–15 为进阶。

每单元题目内容：
1.总体，重要！：结合实用的情景化出题；题目和选项必须确保内容、语法正确；紧扣知识点出题；完全、全面地覆盖知识点的内容；除了基础语法，不随意使用其它高级库和高级知识；使用轻松、风趣、互动的语言。
2.传统选择题：题目内容聚焦知识点概念和语法的辨析和记忆。
3.选择填空题：题目内容聚焦对代码逻辑的整体理解和记忆。
4.若有“复习上一单元”的指令，则在第6题至第10题安排复习任务。若没有复习指令，则可忽略此需求。
使用严格标准的JSON格式输出；JSON数组使用方括号括起来；使用标准的反义字符；文本中可以出现"\n"的换行符号；不需要注释。

输出示例，传统选择题：
```
{
  "id": 1,
  "type": "choice",
  "title": "print初体验",
  "content": "阿珍想用Python在控制台点一份‘炸鸡’，下面哪种写法是正确的呢？",
  "options": [
    "print(炸鸡)",
    "print(\"炸鸡\")",
    "print(‘炸鸡’)",
    "print炸鸡"
  ],
  "answer": "B",
  "hints": [
    "想想看，直接写中文‘炸鸡’，计算机会认识它吗？",
    "在Python中，直接写中文单词（变量名除外）通常需要用引号包起来。",
    "print是一个函数，调用时需要括号。选项D缺少括号，而A和C的引号在中文输入法下可能是全角字符，正确的是半角双引号。"
  ],
  "explanation": "print是一个函数，用于输出内容。要输出文本（字符串），必须用引号（单引号'或双引号\"均可）将其包裹起来，且引号必须是英文半角符号。选项A缺少引号；选项C使用了中文全角单引号；选项D缺少调用函数的括号。",
  "example": "正确用法：print(\"Hello World\") 或 print('Hello World')。"
}
```
输出示例，选择填空题：
```
{
"id": 4,
"type": "fill",
"title": "填空问候",
"content": "帮助小机器人完成代码，让它说出'Hello, Python!'。",
"input": null,
"output": ["Hello, Python!"],
"code_segment": "{
  "type": "code_inline", "parts": [
    {"type": "code", "value": "print(\""}, 
    {"type": "slot", "index": 0}, 
    {"type": "code", "value": "\")"}
  ]
}",
"options": ["Hello, Python!", "\"Hello, Python!\"", "'Hello, Python!'", "Hello Python"],
"answer": [0],
"explanation": "正确选项是'Hello, Python!'，因为print函数需要字符串内容，而code_segment中已经提供了引号。",
"example": "类似地，print(\"Hi\") 需要字符串内容'Hi'。"
},
```
"""

# user prompt template
USER_PROMPT_TEMPLATE = "我现在要生成的单元主题是：{theme}"

# ----------------------------
# ========== 可控范围 ==========
# ----------------------------
GLOBAL_UNIT_START = 1
GLOBAL_UNIT_END = 3  # 修改为 150 生成全部（5*30=150）

# ----------------------------
# ========== 辅助函数 ==========
# ----------------------------
def ensure_dir(p: Path):
    p.mkdir(parents=True, exist_ok=True)

def read_themes_file(path: str) -> List[str]:
    if not os.path.exists(path):
        print(f"[WARN] themes file not found: {path}. Continuing with empty themes.")
        return []
    with open(path, "r", encoding="utf-8") as f:
        return [ln.strip() for ln in f.readlines() if ln.strip()]

def init_client(api_key: str) -> OpenAI:
    if not api_key:
        raise RuntimeError("DEEPSEEK_API_KEY 未设置，请在环境变量或脚本顶部填写。")
    return OpenAI(api_key=api_key, base_url=DEEPSEEK_BASE_URL)

def global_to_stage_unit(global_index: int) -> Tuple[int, int]:
    """global_index: 1-based -> returns (stage, unit_local) both 1-based"""
    if global_index < 1:
        raise ValueError("global_index must be >= 1")
    stage = (global_index - 1) // UNITS_PER_STAGE + 1
    unit_local = (global_index - 1) % UNITS_PER_STAGE + 1
    return stage, unit_local

def calc_q_id(global_unit_index: int, index_in_unit_one_based: int) -> int:
    """q_id = (global_unit_index-1)*15 + index_in_unit_one_based"""
    return (global_unit_index - 1) * NUM_QUESTIONS_PER_UNIT + index_in_unit_one_based

def extract_json_from_text(text: str) -> Any:
    """
    Try direct json.loads(text), otherwise attempt to find first full [ ... ] or { ... } block.
    Raise ValueError if not possible.
    """
    if not isinstance(text, str):
        raise ValueError("AI 返回不是字符串")
    txt = text.strip()
    try:
        return json.loads(txt)
    except Exception:
        pass
    # try extract first JSON array
    lb = txt.find('[')
    rb = txt.rfind(']')
    if lb != -1 and rb != -1 and rb > lb:
        candidate = txt[lb:rb+1]
        try:
            return json.loads(candidate)
        except Exception:
            pass
    # try extract first JSON object
    lb = txt.find('{')
    rb = txt.rfind('}')
    if lb != -1 and rb != -1 and rb > lb:
        candidate = txt[lb:rb+1]
        try:
            return json.loads(candidate)
        except Exception:
            pass
    raise ValueError("无法从 AI 返回中提取 JSON")

# ----------------------------
# ========== 新增/修改：转义与规范化（反推实现） ==========
# ----------------------------
def escape_json_string_for_sql_json(obj: Any) -> str:
    """
    强化的 JSON->SQL 字段转义：
    - 先 json.dumps(obj)
    - 将每个反斜杠 '\' 替换为 3 个反斜杠 '\\\' （这样在 SQL 字面量中会呈现三个反斜杠）
      目的是让 JSON 内原本的 \" 在 SQL 中变成 \\\"（更强的一层转义），并满足你要求的“三个斜杠”的视觉效果。
    - 再把单引号 ' 替换为 SQL 的 ''。
    - 返回带单引号包裹的 SQL 字面量。
    """
    if obj is None:
        return "NULL"
    j = json.dumps(obj, ensure_ascii=False)
    # triple-escape backslashes: each '\' -> '\\\'  (in Python string literal that's "\\\\\\")
    j = j.replace("\\", "\\\\\\")
    # escape single quotes for SQL
    j = j.replace("'", "''")
    return f"'{j}'"

def normalize_fill_code_field(code_field: Any) -> Any:
    """
    Normalize the fill-question 'code' field:
    - If it's a string that itself contains JSON, parse it to dict/list.
    - If it's a dict with 'segments', fix parts where a code part has value == "" -> set to " " (space),
      because AI sometimes outputs empty string where a space is expected after slot.
    """
    if code_field is None:
        return None
    if isinstance(code_field, str):
        txt = code_field.strip()
        try:
            loaded = json.loads(txt)
            code_field = loaded
        except Exception:
            try:
                parsed = extract_json_from_text(txt)
                code_field = parsed
            except Exception:
                return code_field
    if isinstance(code_field, dict) and "segments" in code_field and isinstance(code_field["segments"], list):
        for seg in code_field["segments"]:
            if seg.get("type") == "code_inline" and isinstance(seg.get("parts"), list):
                for part in seg["parts"]:
                    if part.get("type") == "code" and part.get("value", None) == "":
                        part["value"] = " "
    return code_field

def map_choice_answer_to_int(ans: Any) -> Optional[int]:
    """
    Map answer to integer: 'A'->1, 'B'->2, 'C'->3, 'D'->4.
    If ans already int, return it. If string of digit, parse int.
    If cannot determine, return None.
    """
    if ans is None:
        return None
    if isinstance(ans, int):
        return ans
    if isinstance(ans, list) and len(ans) > 0:
        # pick first element
        return map_choice_answer_to_int(ans[0])
    s = str(ans).strip()
    if not s:
        return None
    s_up = s.upper()
    mapping = {"A": 1, "B": 2, "C": 3, "D": 4}
    if s_up in mapping:
        return mapping[s_up]
    # if like "1" or "2"
    try:
        return int(s)
    except Exception:
        return None

# ----------------------------
# ========== SQL escaping helpers ==========
# ----------------------------
def sql_escape_text(s: Optional[str]) -> str:
    """
    Escape plain text for SQL: only escape single quotes (') -> ('')
    Wrap with single quotes, return SQL literal or NULL.
    """
    if s is None:
        return "NULL"
    if not isinstance(s, str):
        s = str(s)
    esc = s.replace("'", "''")
    return f"'{esc}'"

def sql_escape_json_field(obj: Any) -> str:
    """
    Convert obj -> JSON string (ensure_ascii=False), then escape single quotes for SQL quoting.
    Do NOT change double quotes.
    Return SQL literal like: '["a","b"]' or NULL.
    """
    if obj is None:
        return "NULL"
    j = json.dumps(obj, ensure_ascii=False)
    try:
        json.loads(j)
    except Exception:
        j = json.dumps(str(obj), ensure_ascii=False)
    j_escaped = j.replace("'", "''")
    return f"'{j_escaped}'"

# ----------------------------
# ========== 单元处理 ==========
# ----------------------------
def process_single_unit(client: OpenAI, global_unit_index: int, theme: str, out_base: Path) -> dict:
    """
    1. call DeepSeek to generate questions for the given theme
    2. parse JSON response (list of question objects)
    3. save raw and parsed JSON into separate folders
    4. convert to SQL and save .sql file (single file per unit, saved in sql/<stage>)
    """
    stage, unit_local = global_to_stage_unit(global_unit_index)
    # ---------- 修改：unit_id 从 global_unit_index 开始（不再使用 stage*100 + unit_local） ----------
    unit_id = global_unit_index

    # directories per purpose
    parsed_dir = out_base / "json_parsed" / f"stage{stage}"
    raw_dir = out_base / "json_raw" / f"stage{stage}"
    sql_dir = out_base / "sql" / f"stage{stage}"
    ensure_dir(parsed_dir)
    ensure_dir(raw_dir)
    ensure_dir(sql_dir)

    user_prompt = USER_PROMPT_TEMPLATE.format(theme=theme)
    messages = [
        {"role": "system", "content": SYSTEM_PROMPT},
        {"role": "user", "content": user_prompt}
    ]

    raw_text = None
    parsed_questions = None
    last_exc = None

    sql_out_path = sql_dir / f"unit{unit_id}.sql"
    # 如果 SQL 文件已存在，则跳过 API 请求
    if sql_out_path.exists():
        print(f"⏭️ 已存在，跳过请求 API（第 {global_unit_index} 单元） -> {sql_out_path}")
        return {
            "status": "skipped",
            "global_unit": global_unit_index,
            "stage": stage,
            "unit_local": unit_local,
            "unit_id": unit_id,
            "sql": str(sql_out_path)
        }

    for attempt in range(1, RETRY_ATTEMPTS + 1):
        print(f"🚀尝试请求 API（第 {global_unit_index} 单元）")
        try:
            resp = client.chat.completions.create(
                model=MODEL_NAME,
                messages=messages,
                stream=False
            )

            # API success print (请求成功)
            print(f"✅️成功请求 API（第 {global_unit_index} 单元）")

            # extract text
            try:
                raw_text = resp.choices[0].message.content
            except Exception:
                raw_text = json.dumps(resp, ensure_ascii=False)
            # parse json
            parsed = extract_json_from_text(raw_text)
            # if not list, try parsed["questions"]
            if isinstance(parsed, dict) and "questions" in parsed and isinstance(parsed["questions"], list):
                parsed = parsed["questions"]
            if not isinstance(parsed, list):
                raise ValueError("解析得到的 JSON 不是题目数组 (list)。")
            parsed_questions = parsed
            break
        except Exception as e:
            last_exc = e
            wait = RETRY_BACKOFF_FACTOR ** (attempt - 1)
            print(f"❌[WARN] global_unit={global_unit_index} attempt={attempt} failed: {e}. retry in {wait}s")
            time.sleep(wait)

    # 保存 raw response 记录（供复查）到 raw_dir
    raw_record_path = raw_dir / f"unit_{global_unit_index}_raw.json"
    with open(raw_record_path, "w", encoding="utf-8") as rf:
        json.dump({
            "global_unit_index": global_unit_index,
            "stage": stage,
            "unit_local": unit_local,
            "unit_id": unit_id,
            "theme": theme,
            "user_prompt": user_prompt,
            "raw_text": raw_text
        }, rf, ensure_ascii=False, indent=2)

    sql_out_path = sql_dir / f"unit{unit_id}.sql"

    if parsed_questions is None:
        # 写入失败注释的 sql 文件，便于人工查看
        with open(sql_out_path, "w", encoding="utf-8") as sf:
            sf.write(f"-- FAILED to parse JSON for global_unit={global_unit_index} (stage={stage} unit_local={unit_local} unit_id={unit_id})\n")
            sf.write(f"-- last exception: {repr(last_exc)}\n")
            if raw_text:
                sf.write("-- raw response below:\n")
                sf.write(raw_text)
        return {"status": "error", "global_unit": global_unit_index, "stage": stage, "unit_local": unit_local, "unit_id": unit_id, "json_raw": str(raw_record_path), "sql": str(sql_out_path), "error": repr(last_exc)}

    # 保存解析后的结构化 JSON 到 parsed_dir
    parsed_path = parsed_dir / f"unit_{global_unit_index}_parsed.json"
    with open(parsed_path, "w", encoding="utf-8") as pf:
        json.dump(parsed_questions, pf, ensure_ascii=False, indent=2)

    # 构建 SQL 插入行
    choice_rows = []
    fill_rows = []

    for idx, q in enumerate(parsed_questions):
        question_index_in_unit = idx + 1  # 1..n (通常 1..15)
        q_id = calc_q_id(global_unit_index, question_index_in_unit)
        q_type = (q.get("type") or "").strip().lower()
        title = q.get("title") or q.get("name") or ""
        text = q.get("content") or q.get("text") or ""
        if q_type == "choice":
            # JSON fields: options, hints
            options = q.get("options", [])
            raw_answer = q.get("answer", "")
            # ---------- 修改：将 letter answer 映射为整数 ----------
            mapped_answer = map_choice_answer_to_int(raw_answer)
            hints = q.get("hints", [])
            explanation = q.get("explanation", "") or ""
            example = q.get("example", "") or ""
            choice_rows.append({
                "q_id": q_id,
                "unit_id": unit_id,
                "title": title,
                "text": text,
                "options": options,
                # store mapped integer (or None)
                "answer": mapped_answer,
                "hints": hints,
                "explanation": explanation,
                "example": example
            })
        elif q_type == "fill":
            # JSON fields: input, output, code, options, answer
            input_field = q.get("input", None)
            output_field = q.get("output", None)
            code_field = q.get("code_segments") or q.get("code_segment") or q.get("code") or q.get("code_segment_str")
            options_field = q.get("options", [])
            answer_field = q.get("answer", [])
            explanation = q.get("explanation", "") or ""
            example = q.get("example", "") or ""
            # Normalize code_field: if dict/list -> keep as structure; if string -> attempt parse
            fill_rows.append({
                "q_id": q_id,
                "unit_id": unit_id,
                "title": title,
                "text": text,
                "input": input_field,
                "output": output_field,
                "code": code_field,
                "options": options_field,
                "answer": answer_field,
                "explanation": explanation,
                "example": example
            })
        else:
            # 未知题型，记录警告并跳过
            print(f"[WARN] global_unit={global_unit_index} q#{question_index_in_unit}: unknown type '{q_type}' -> skipped.")

    # 生成 SQL 文本（格式化：每个字段单独一行，易读）
    sql_blocks = []
    if choice_rows:
        header = f"INSERT INTO `{CHOICE_TABLE}` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES"
        sql_blocks.append(header)
        vals = []
        for r in choice_rows:
            qid = r["q_id"]
            uid = r["unit_id"]
            title_sql = sql_escape_text(r["title"])
            text_sql = sql_escape_text(r["text"])
            # 选择题 options 使用加强的转义：确保 JSON 内部的 \" 被变成 带三重反斜杠的形式 写入 SQL
            options_sql = escape_json_string_for_sql_json(r["options"])
            # ---------- 修改：answer 为整数或 NULL（不加单引号） ----------
            if r["answer"] is None:
                answer_sql = "NULL"
            else:
                # ensure integer literal
                answer_sql = str(int(r["answer"]))
            hints_sql = sql_escape_json_field(r["hints"])
            explanation_sql = sql_escape_text(r["explanation"])
            example_sql = sql_escape_text(r["example"])
            vals.append(f"""(
  {qid},
  {uid},
  {title_sql},
  {text_sql},
  {options_sql},
  {answer_sql},
  {hints_sql},
  {explanation_sql},
  {example_sql}
)""")
        sql_blocks.append(",\n".join(vals) + ";")

    if fill_rows:
        header = f"INSERT INTO `{FILL_TABLE}` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES"
        sql_blocks.append(header)
        vals = []
        for r in fill_rows:
            qid = r["q_id"]
            uid = r["unit_id"]
            title_sql = sql_escape_text(r["title"])
            text_sql = sql_escape_text(r["text"])
            input_sql = sql_escape_json_field(r["input"]) if r["input"] is not None else "NULL"
            output_sql = sql_escape_json_field(r["output"]) if r["output"] is not None else "NULL"

            # 规范化并转义 code 字段（填空题特别处理）
            code_norm = normalize_fill_code_field(r["code"])
            code_sql = escape_json_string_for_sql_json(code_norm) if code_norm is not None else "NULL"

            # options 和 answer 使用加强转义（选项里常含引号、代码片段）
            options_sql = escape_json_string_for_sql_json(r["options"])
            answer_sql = escape_json_string_for_sql_json(r["answer"])

            explanation_sql = sql_escape_text(r["explanation"])
            example_sql = sql_escape_text(r["example"])
            vals.append(f"""(
  {qid},
  {uid},
  {title_sql},
  {text_sql},
  {input_sql},
  {output_sql},
  {code_sql},
  {options_sql},
  {answer_sql},
  {explanation_sql},
  {example_sql}
)""")
        sql_blocks.append(",\n".join(vals) + ";")

    if not sql_blocks:
        sql_text = f"-- No valid rows extracted for global_unit={global_unit_index} (stage={stage} unit_local={unit_local} unit_id={unit_id})\n-- parsed saved at: {parsed_path}\n"
    else:
        sql_text = "\n\n".join(sql_blocks)

    # 写入 SQL 文件
    with open(sql_out_path, "w", encoding="utf-8") as sf:
        sf.write(f"-- Generated SQL for global_unit={global_unit_index} (stage={stage} unit_local={unit_local} unit_id={unit_id})\n")
        sf.write(sql_text)

    return {"status": "ok", "global_unit": global_unit_index, "stage": stage, "unit_local": unit_local, "unit_id": unit_id, "parsed_json": str(parsed_path), "raw_json": str(raw_record_path), "sql": str(sql_out_path)}

# ----------------------------
# ========== 主流程 ==========
# ----------------------------
def main():
    print("=== generate_and_export_sql_final_v2 START ===")
    total_units = STAGES * UNITS_PER_STAGE
    # Normalize range
    start = max(1, GLOBAL_UNIT_START)
    end = GLOBAL_UNIT_END if GLOBAL_UNIT_END is not None else total_units
    end = min(end, total_units)
    if start > end:
        raise ValueError("GLOBAL_UNIT_START must be <= GLOBAL_UNIT_END and within total units.")

    # read themes
    themes = read_themes_file(THEMES_TXT_PATH)
    if len(themes) < total_units:
        print(f"[INFO] themes count ({len(themes)}) < total units ({total_units}). Will use last theme as fallback for missing items.")

    # init client
    client = init_client(DEEPSEEK_API_KEY)
    ensure_dir(BASE_OUT_DIR)

    tasks = []
    for global_idx in range(start, end + 1):
        theme = themes[global_idx - 1] if (global_idx - 1) < len(themes) else (themes[-1] if themes else "")
        tasks.append((global_idx, theme))

    results = []
    with ThreadPoolExecutor(max_workers=MAX_WORKERS) as ex:
        future_map = {}
        for (gidx, th) in tasks:
            fut = ex.submit(process_single_unit, client, gidx, th, BASE_OUT_DIR)
            future_map[fut] = (gidx, th)
        for fut in as_completed(future_map):
            gidx, th = future_map[fut]
            try:
                res = fut.result()
                results.append(res)
                if res.get("status") == "ok":
                    print(f"[OK] global_unit={gidx} -> sql: {res.get('sql')}")
                else:
                    print(f"[ERR] global_unit={gidx} -> error saved at {res.get('sql')}")
            except Exception as e:
                print(f"[EXC] global_unit={gidx} exception: {e}")
                results.append({"status": "error", "global_unit": gidx, "error": repr(e)})

    # write summary
    summary = {
        "requested_range": [start, end],
        "total": len(results),
        "ok": sum(1 for r in results if r.get("status") == "ok"),
        "error": sum(1 for r in results if r.get("status") != "ok"),
        "details": results
    }
    summary_path = BASE_OUT_DIR / "summary_generate.json"
    with open(summary_path, "w", encoding="utf-8") as sf:
        json.dump(summary, sf, ensure_ascii=False, indent=2)
    print(f"[DONE] summary saved to {summary_path}")
    print("=== finished ===")

if __name__ == "__main__":
    main()