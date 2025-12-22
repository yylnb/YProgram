# -*- coding: utf-8 -*-
"""
batch_question_sql_generator.py

功能：
- 批量读取多个题目文件（for 循环）
- 每个文件可单独指定：
  - 文件路径
  - q_id 起始 / 结束范围
- 自动生成符合题库规范的 MySQL SQL（INSERT）
- 所有参数集中在 CONFIG 区域，无需命令行参数
"""

import json
import os
from typing import List, Dict, Any

# =========================================================
# ====================== CONFIG ===========================
# =========================================================

CONFIG = {
    # 数据库
    "database": "questions",
    "unit_id": 1,

    # 是否在输出 SQL 中包含建表语句
    "create_tables": False,

    # 输出 SQL 文件路径
    "output_sql_path": "./output/questions_unit1.sql",

    # 批量输入文件配置（for 循环顺序执行）
    "input_files": [
        {
            # "path": "/python1/stage1/python1_stage1_unit1.txt",
            "path": "./python1_stage1_unit1.txt",
            "q_id_start": 1,
            "q_id_end": 15
        },
        {
            "path": "/python1/stage1/python1_stage1_unit2.txt",
            "q_id_start": 16,
            "q_id_end": 30
        }
    ]
}

# =========================================================
# =================== SQL 工具函数 =========================
# =========================================================

def escape_sql_string(s: str) -> str:
    # """
    # SQL 安全转义：
    # - \  -> \\
    # - '  -> ''
    # """
    return s.replace("\\", "\\\\").replace("'", "''")

def sql_literal(s):
    if s is None:
        return "NULL"
    return "'" + escape_sql_string(str(s)) + "'"

def json_array_sql(items: List[Any]) -> str:
    parts = []
    for it in items:
        parts.append("NULL" if it is None else sql_literal(it))
    return f"JSON_ARRAY({', '.join(parts)})"

def json_object_sql(mapping: Dict[str, Any], keys_order=None) -> str:
    pairs = []
    keys = keys_order if keys_order else mapping.keys()
    for k in keys:
        pairs.append(sql_literal(k))
        pairs.append(sql_literal(mapping[k]))
    return f"JSON_OBJECT({', '.join(pairs)})"

# =========================================================
# ================== 建表模板（可选） ======================
# =========================================================

CREATE_TABLE_CHOICE = """
CREATE TABLE IF NOT EXISTS `que_choice_py_1` (
  `q_id` VARCHAR(64) NOT NULL,
  `unit_id` INT NOT NULL,
  `title` VARCHAR(255),
  `text` TEXT,
  `options` JSON,
  `answer` TINYINT,
  `hints` JSON,
  `explanation` TEXT,
  `example` TEXT,
  PRIMARY KEY (`q_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
""".strip()

CREATE_TABLE_FILL = """
CREATE TABLE IF NOT EXISTS `que_fill_py_1` (
  `q_id` VARCHAR(64) NOT NULL,
  `unit_id` INT NOT NULL,
  `title` VARCHAR(255),
  `text` TEXT,
  `input` TEXT,
  `output` JSON,
  `code` JSON,
  `options` JSON,
  `answer` JSON,
  `explanation` TEXT,
  `example` TEXT,
  PRIMARY KEY (`q_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
""".strip()

# =========================================================
# ================== 选择题生成 ============================
# =========================================================

def generate_choice_insert(q: Dict[str, Any], q_id: int, unit_id: int) -> str:
    option_map = q["options"]
    answer_map = {"A": 1, "B": 2, "C": 3, "D": 4}

    return f"""
INSERT INTO `que_choice_py_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`hints`,`explanation`,`example`)
VALUES
(
  {sql_literal(q_id)},
  {unit_id},
  {sql_literal(q.get("title"))},
  {sql_literal(q.get("text"))},
  {json_object_sql(option_map, ["A", "B", "C", "D"])},
  {answer_map[q["answer"]]},
  {"NULL" if not q.get("hints") else json_array_sql(q["hints"])},
  {sql_literal(q.get("explanation"))},
  {sql_literal(q.get("example"))}
);
""".strip()

# =========================================================
# ================== 填空题生成 ============================
# =========================================================

def generate_fill_insert(q: Dict[str, Any], q_id: int, unit_id: int) -> str:
    code_json = json.dumps(q["code"], ensure_ascii=False)

    return f"""
INSERT INTO `que_fill_py_1`
(`q_id`,`unit_id`,`title`,`text`,`input`,`output`,`code`,`options`,`answer`,`explanation`,`example`)
VALUES
(
  {sql_literal(q_id)},
  {unit_id},
  {sql_literal(q.get("title"))},
  {sql_literal(q.get("text"))},
  {sql_literal(q.get("input"))},
  {"NULL" if not q.get("output") else json_array_sql(q["output"])},
  {sql_literal(code_json)},
  {json_array_sql(q["options"])},
  {json_array_sql(q["answer"])},
  {sql_literal(q.get("explanation"))},
  {sql_literal(q.get("example"))}
);
""".strip()

# =========================================================
# ======================= 主流程 ===========================
# =========================================================

def main():
    sql_lines = []
    sql_lines.append(f"USE `{CONFIG['database']}`;")

    if CONFIG["create_tables"]:
        sql_lines.append(CREATE_TABLE_CHOICE)
        sql_lines.append(CREATE_TABLE_FILL)

    for file_cfg in CONFIG["input_files"]:
        path = file_cfg["path"]
        q_id = file_cfg["q_id_start"]

        with open(path, "r", encoding="utf-8") as f:
            questions = json.load(f)

        for q in questions:
            if q_id > file_cfg["q_id_end"]:
                break

            if q["type"] == "choice":
                sql_lines.append(generate_choice_insert(q, q_id, CONFIG["unit_id"]))
            elif q["type"] == "fill":
                sql_lines.append(generate_fill_insert(q, q_id, CONFIG["unit_id"]))
            else:
                raise ValueError(f"未知题型: {q['type']}")

            q_id += 1

    os.makedirs(os.path.dirname(CONFIG["output_sql_path"]), exist_ok=True)
    with open(CONFIG["output_sql_path"], "w", encoding="utf-8") as f:
        f.write("\n\n".join(sql_lines))

    print("✅ SQL 生成完成：", CONFIG["output_sql_path"])


if __name__ == "__main__":
    main()