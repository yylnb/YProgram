#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
generate_sql.py

从标准化 JSON 生成 MySQL INSERT SQL 文件。
"""

import json
import os
import re

def escape_sql_string(s):
    """转义 SQL 字符串"""
    if s is None:
        return 'NULL'
    return "'" + s.replace("'", "''").replace("\\", "\\\\") + "'"

def generate_choice_insert(q, unit_id):
    q_id = q['q_id']
    title = escape_sql_string(q['title'])
    text = escape_sql_string(q['text'])
    options = q['options']
    options_sql = "JSON_OBJECT(" + ", ".join(f"'{k}', {escape_sql_string(v)}" for k, v in options.items()) + ")"
    answer_map = {'A':1, 'B':2, 'C':3, 'D':4}
    answer = answer_map.get(q['answer'], 1)
    hints = q['hints']
    if hints:
        hints_sql = "JSON_ARRAY(" + ", ".join(escape_sql_string(h) for h in hints) + ")"
    else:
        hints_sql = 'NULL'
    explanation = escape_sql_string(q['explanation'])
    example = escape_sql_string(q['example'])
    
    sql = f"""INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ({escape_sql_string(str(q_id))}, {unit_id}, {title}, {text}, {options_sql}, {answer}, {hints_sql}, {explanation}, {example});"""
    return sql

def parse_raw_code(raw_code):
    """解析 raw_code 为 segments"""
    # 假设格式 __1__ ... __2__
    parts = []
    pattern = r'(__(\d+)__)'
    last_end = 0
    for match in re.finditer(pattern, raw_code):
        start, end = match.span()
        slot_num = int(match.group(2)) - 1  # 0-based
        if start > last_end:
            parts.append({"type": "code", "value": raw_code[last_end:start]})
        parts.append({"type": "slot", "index": slot_num})
        last_end = end
    if last_end < len(raw_code):
        parts.append({"type": "code", "value": raw_code[last_end:]})
    
    segment = {"type": "code_inline", "parts": parts}
    return {"segments": [segment]}

def generate_fill_insert(q, unit_id):
    q_id = q['q_id']
    title = escape_sql_string(q['title'])
    text = escape_sql_string(q['text'])
    input_val = q['input']
    input_sql = escape_sql_string(input_val) if input_val else 'NULL'
    output_val = q['output']
    if output_val:
        output_sql = f"JSON_ARRAY({escape_sql_string(output_val)})"
    else:
        output_sql = 'NULL'
    raw_code = q['raw_code']
    code_obj = parse_raw_code(raw_code)
    code_sql = json.dumps(code_obj, ensure_ascii=False)
    code_sql = "'" + code_sql.replace("'", "''") + "'"
    options = q['options']
    options_sql = "JSON_ARRAY(" + ", ".join(escape_sql_string(opt) for opt in options) + ")"
    answer = q['answer']
    answer_sql = "JSON_ARRAY(" + ", ".join(str(a) for a in answer) + ")"
    explanation = escape_sql_string(q['explanation'])
    example = escape_sql_string(q['example'])
    
    sql = f"""INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ({escape_sql_string(str(q_id))}, {unit_id}, {title}, {text}, {input_sql}, {output_sql}, {code_sql}, {options_sql}, {answer_sql}, {explanation}, {example});"""
    return sql

def generate_sql_for_unit(unit_num):
    json_path = f"./output_json/python1_stage1_unit{unit_num}.json"
    if not os.path.exists(json_path):
        print(f"JSON not found for unit {unit_num}")
        return None
    
    with open(json_path, 'r', encoding='utf-8') as f:
        questions = json.load(f)
    
    sql_lines = []
    sql_lines.append("USE `questions`;")
    sql_lines.append("")
    sql_lines.append("CREATE TABLE IF NOT EXISTS `que_choice_py_1` (")
    sql_lines.append("  `q_id` VARCHAR(255) NOT NULL,")
    sql_lines.append("  `unit_id` INT NOT NULL,")
    sql_lines.append("  `title` VARCHAR(255),")
    sql_lines.append("  `text` TEXT,")
    sql_lines.append("  `options` JSON,")
    sql_lines.append("  `answer` INT,")
    sql_lines.append("  `hints` JSON,")
    sql_lines.append("  `explanation` TEXT,")
    sql_lines.append("  `example` TEXT,")
    sql_lines.append("  PRIMARY KEY (`q_id`, `unit_id`)")
    sql_lines.append(");")
    sql_lines.append("")
    sql_lines.append("CREATE TABLE IF NOT EXISTS `que_fill_py_1` (")
    sql_lines.append("  `q_id` VARCHAR(255) NOT NULL,")
    sql_lines.append("  `unit_id` INT NOT NULL,")
    sql_lines.append("  `title` VARCHAR(255),")
    sql_lines.append("  `text` TEXT,")
    sql_lines.append("  `input` TEXT,")
    sql_lines.append("  `output` JSON,")
    sql_lines.append("  `code` JSON,")
    sql_lines.append("  `options` JSON,")
    sql_lines.append("  `answer` JSON,")
    sql_lines.append("  `explanation` TEXT,")
    sql_lines.append("  `example` TEXT,")
    sql_lines.append("  PRIMARY KEY (`q_id`, `unit_id`)")
    sql_lines.append(");")
    sql_lines.append("")
    sql_lines.append("-- ---------- 插入选择题 ----------")
    choice_inserts = []
    fill_inserts = []
    for q in questions:
        if q['type'] == 'choice':
            choice_inserts.append(generate_choice_insert(q, unit_num))
        elif q['type'] == 'fill':
            fill_inserts.append(generate_fill_insert(q, unit_num))
    
    sql_lines.extend(choice_inserts)
    sql_lines.append("")
    sql_lines.append("-- ---------- 插入填空题 ----------")
    sql_lines.extend(fill_inserts)
    
    sql_content = "\n".join(sql_lines)
    
    output_path = f"./python1_insert/stage1/python1_stage1_unit{unit_num}.sql"
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(sql_content)
    
    print(f"Generated SQL for unit {unit_num}")

if __name__ == "__main__":
    for unit in range(1, 31):
        generate_sql_for_unit(unit)