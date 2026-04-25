#!/usr/bin/env python3
"""
deepseek_bulk_fetcher_fixed.py

用途：
  从 DeepSeek API 拉取生成内容（SQL/JSON），并写入对应文件。
  所有参数均写死在代码中，无需命令行输入。
"""

import json
import time
import re
from pathlib import Path
from openai import OpenAI
import os


# ===================== 配置参数（全部写死） =====================
DEESEEK_API_KEY = ""  # <-- 替换为你的实际 Key
THEMES_FILE = Path(r"F:\\project\\YProgram\\Libraries\\outline_cpp.txt")                    # 每行一个主题
LANG = "C++"
DIFFICULTY = "beginner"
FORMAT = "sql"                                  # 可改为 "json"
PAGE = 1
COUNT_PER_THEME = 5
OUT_DIR = Path(r"F:\\project\\YProgram\\Libraries\\C++\\Beginner") 
MODEL = "deepseek-reasoner"
SLEEP_BETWEEN_CALLS = 0.6  # 秒

DEESEEK_ENDPOINT = "https://api.deepseek.com/"

PROMPT_TEMPLATE = """生成要求：请为我的资料库生成 {count} 条条目，语言为 "{lang}"，主题为 "{theme}"，难度为 "{difficulty}"，放在第 {page} 页，lb_id 从 {start_lb_id} 起按 1 递增。每条为**一个知识点一条**。输出格式选项：如果 {format}="sql"，请输出一条可直接执行的 SQL INSERT 语句（字段顺序严格为：lang, lb_id, difficulty, page, title, tags, summary, content, eg_in, eg_out），VALUES 中每条为一组括号并以逗号分隔，最后以分号结尾；如果 {format}="json"，请输出一个 JSON 数组，数组内每个对象包含字段：lang, lb_id, difficulty, page, title, tags, summary, content, eg_in, eg_out。字段约束和格式要求（必须严格遵守）： 
- 不要包含 id 和 created_at（id 为自增，created_at 自动生成）。
- lang 为小写语言名字符串（例如 \"python\"）。
- lb_id 在同一 lang 下唯一，按要求从 {start_lb_id} 开始递增。
- difficulty 只能是 \"beginner\"、\"intermediate\" 或 \"advanced\" 之一。
- page 为正整数。
- title 与 summary 为单行文本（不要换行）；content 可为多行文本（允许换行）。
- tags 必须是**严格的 JSON 字符串数组**，例如 '[\"变量\",\"数据结构\"]'（注意内层双引号并作为字符串）。
- eg_in 与 eg_out 必须是**严格的 JSON 字符串数组**，每个元素为示例代码或输出文本；代码中的换行请用两个字符的转义序列 \\n 表示（例如 \"x = 1\\nprint(x)\"）。注意！\n要写成\\n！。
- 所有字符串内的双引号和反斜杠需正确转义以保证输出为合法 SQL/JSON。
- 每个条目聚焦单一知识点，title 要简洁明了，summary 为一句话的简短总结，content 给出详尽说明与必要示例解释，eg_in 提供 1~3 个代码样例（使用 \\n 分行），eg_out 给出对应的输出样例。
- 如果用户未指定 {count} 或 {start_lb_id}，请按常用默认值：{count}=10，{start_lb_id}=1；如果用户未指定 {page}，默认 page=1。
- 生成时不要提出任何澄清问题，若有必要可做合理默认并在输出第一行用注释说明所采用的默认值（仅当 format=sql 时用 SQL 注释 --，format=json 时用单行注释 //）。
- 重要！！务必检查一遍eg_in和eg_out中\n是否全部变成\\n！（一个杠+字母n要变成两个杠+字母n）
"""

# ===================== 辅助函数 =====================

def slugify(name: str) -> str:
    s = name.strip().lower()
    s = re.sub(r'[^a-z0-9]+', '_', s)
    s = re.sub(r'_{2,}', '_', s).strip('_')
    return s or "theme"

def read_themes(file_path: str):
    path = Path(file_path)
    if not path.exists():
        raise FileNotFoundError(f"Themes file not found: {file_path}")
    lines = [line.strip() for line in path.read_text(encoding="utf-8").splitlines()]
    return [l for l in lines if l]

def call_deepseek(prompt_text: str):

    client = OpenAI(
        api_key=DEESEEK_API_KEY,
        base_url="https://api.deepseek.com")

    messages = [
        {"role": "system", "content": "你是一个严格遵守指示并输出机器可解析格式（SQL/JSON）的助手。"},
        {"role": "user", "content": prompt_text}
    ]
    try:
        resp = client.chat.completions.create(
            model=MODEL,
            messages=messages,
            stream=False
        )
        content = resp.choices[0].message.content
    except Exception:
        # fallback
        content = json.dumps(resp, ensure_ascii=False)
    return content

def ensure_sql_semicolon(txt: str) -> str:
    txt = txt.rstrip()
    if not txt.endswith(";"):
        txt = txt + ";"
    return txt

def save_output(theme: str, start_lb_id: int, content: str):
    slug = slugify(theme)
    Path(OUT_DIR).mkdir(parents=True, exist_ok=True)
    if FORMAT == "sql":
        filename = Path(OUT_DIR) / f"{LANG}_{slug}_lb{start_lb_id}.sql"
        content = ensure_sql_semicolon(content)
    else:
        filename = Path(OUT_DIR) / f"{LANG}_{slug}_lb{start_lb_id}.json"
        try:
            parsed = json.loads(content)
            content = json.dumps(parsed, indent=2, ensure_ascii=False)
        except Exception:
            pass
    filename.write_text(content, encoding="utf-8")
    print(f"Saved {FORMAT.upper()} -> {filename}")

def basic_validate(content: str):
    if FORMAT == "json":
        try:
            _ = json.loads(content)
            print("  JSON: parse OK")
        except Exception as e:
            print("  JSON: parse FAILED:", e)
    else:
        if ";" not in content:
            print("  WARNING: SQL output可能缺少分号 ;")
        else:
            print("  SQL: 包含分号 (基本检查)")

# ===================== 主逻辑 =====================

def main():
    try:
        themes = read_themes(THEMES_FILE)
    except Exception as e:
        print("读取主题文件失败:", e)
        return
    if not themes:
        print("主题文件为空")
        return
    start_theme = 1
    end_theme = 9   
    themes = themes[(start_theme-1):end_theme]

    print(f"发现 {len(themes)} 个主题，每个生成 {COUNT_PER_THEME} 条记录，格式 {FORMAT.upper()}")

    for idx, theme in enumerate(themes):
        start_lb_id = idx * COUNT_PER_THEME + 1
        prompt = PROMPT_TEMPLATE.format(
            count=COUNT_PER_THEME,
            lang=LANG,
            theme=theme,
            difficulty=DIFFICULTY,
            start_lb_id=start_lb_id,
            format=FORMAT,
            page=PAGE
        )
        print(f"\n=== 主题 [{idx+1}/{len(themes)}]: '{theme}' -> start_lb_id={start_lb_id} ===")
        try:
            content = call_deepseek(prompt)
        except Exception as e:
            print("API 调用失败:", e)
            continue

        basic_validate(content)
        try:
            save_output(theme, start_lb_id, content)
        except Exception as e:
            print("保存文件失败:", e)

        time.sleep(SLEEP_BETWEEN_CALLS)

    print("\n全部完成！")

if __name__ == "__main__":
    main()