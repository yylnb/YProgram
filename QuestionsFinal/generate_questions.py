#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
generate_deepseek_questions_no_cli.py

特点：
- 不使用 CLI，所有动态配置写在脚本顶部变量中
- 5 个 stage x 30 units 每个 unit 请求一次（默认）
- 每个 unit 要求生成 15 道题（可修改）
- 从 themes_txt_path 读取每行主题（按 stage-major 顺序分配）
- 并发使用 ThreadPoolExecutor，最大并发数为 MAX_WORKERS（默认 5）
- 指定的 prompt 模板会被格式化注入 {stage},{unit},{theme},{input_address},{output_address},{num_questions}
- 每个单元的输出保存在 OUT_DIR/stage_{s:02d}/unit_{u:02d}.json
- 简单重试（RETRY_ATTEMPTS 与指数退避）
- 将原始 API 返回和 AI 文本一并保存，便于后续解析
"""

import os
import time
import json
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
from typing import List, Optional
import requests

# ---------------------------
# ========== 配置区 ==========
# ---------------------------
# API key：你可以把 key 填在这里（不推荐长期明文保存），或在运行前用环境变量 DEEPSEEK_API_KEY 设置。
DEEPSEEK_API_KEY = ""

# DeepSeek API endpoint（如需替换为实际 endpoint，请改这里）
DEEPSEEK_BASE_URL = "https://api.deepseek.com"
API_ENDPOINT = DEEPSEEK_BASE_URL

# 脚本控制参数（已写死，不使用 CLI）
STAGES = 5                # 共有几个 stage
UNITS_PER_STAGE = 30      # 每个 stage 包含多少 unit
NUM_QUESTIONS_PER_UNIT = 15
MAX_WORKERS = 5           # 同时并发的最大请求数量（你要求的 5）
RETRY_ATTEMPTS = 4
RETRY_BACKOFF_FACTOR = 2  # 指数退避基底

# 文件 / 路径配置（写死）
THEMES_TXT_PATH = "unit_themes.txt"   # 每行一个单元主题（按 stage-major 顺序）
OUT_DIR = "./deepseek_outputs"        # 输出目录（会自动创建）

# DeepSeek 模型名称（按 provider 要求设置）
MODEL_NAME = "deepseek-chat"

# System prompt 可选（如果你想使用 system role）
USE_SYSTEM_PROMPT = False
SYSTEM_PROMPT = "You are an assistant that generates exam questions in structured JSON format."

# 你已经准备好的固定 prompt（把你固定的 prompt 全部放到下面的字符串中，保留占位符）
# 占位符：{stage}, {unit}, {theme}, {input_address}, {output_address}, {num_questions}
PROMPT_TEMPLATE = """
请为单元生成 {num_questions} 道编程题（题型、题目、选项/答案/解析等），
本单元信息如下:
stage: {stage}
unit: {unit}
unit_theme: {theme}
input_address: {input_address}
output_address: {output_address}

题目输出请以 **严格的 JSON 数组** 形式返回（主键为数组），
每道题包含至少字段：q_id, type, title, text, choices(如有), answer, explanation。
注意：
- q_id 请确保在同一单元内唯一（字符串或数字皆可）。
- type 可为 "choice", "fill", "code", "short" 等。
- 若生成选择题，请提供 choices 字段（数组），并在 answer 中给出正确项。
- 保持题目风格一致，难度为中等偏下到中等。
- 请不要附带多余的markdown或额外解释，输出只保留 JSON 数组或在最前/最后补充少量机器可剥离说明。
"""

# ---------------------------
# ========== 辅助函数 ==========
# ---------------------------
def ensure_dir(path: str):
    Path(path).mkdir(parents=True, exist_ok=True)

def read_themes_file(path: str) -> List[str]:
    if not os.path.exists(path):
        print(f"[WARN] themes file not found: {path} -> 将使用空主题填充。")
        return []
    with open(path, "r", encoding="utf-8") as f:
        lines = [line.strip() for line in f.readlines() if line.strip()]
    return lines

def build_addresses(stage: int, unit: int) -> (str, str):
    # 根据你的项目需要调整地址格式（这里使用示例格式）
    input_addr = f"/input/stage{stage:02d}/unit{unit:02d}.json"
    output_addr = f"/output/stage{stage:02d}/unit{unit:02d}.json"
    return input_addr, output_addr

def call_deepseek_api(api_key: str, model: str, messages: List[dict], timeout: int = 120) -> dict:
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {api_key}"
    }
    payload = {
        "model": model,
        "messages": messages,
        "stream": False
    }
    resp = requests.post(API_ENDPOINT, headers=headers, json=payload, timeout=timeout)
    resp.raise_for_status()
    return resp.json()

# ---------------------------
# ========== 单元处理 ==========
# ---------------------------
def process_unit(api_key: str,
                 model: str,
                 stage: int,
                 unit: int,
                 theme: str,
                 prompt_template: str,
                 out_dir: str,
                 num_questions: int = 15,
                 system_prompt: Optional[str] = None) -> dict:
    """
    为单个 unit 发送请求并保存结果。
    返回 dict 包含 status (ok/error) 以及路径或错误信息。
    """
    input_addr, output_addr = build_addresses(stage, unit)
    prompt_text = prompt_template.format(
        stage=stage,
        unit=unit,
        theme=theme,
        input_address=input_addr,
        output_address=output_addr,
        num_questions=num_questions
    )

    messages = []
    if system_prompt:
        messages.append({"role": "system", "content": system_prompt})
    messages.append({"role": "user", "content": prompt_text})

    last_exc = None
    for attempt in range(1, RETRY_ATTEMPTS + 1):
        try:
            raw = call_deepseek_api(api_key, model, messages)
            # 提取文本（兼容常见的 choices/ message 结构）
            ai_text = None
            choices = raw.get("choices")
            if choices and isinstance(choices, list) and len(choices) > 0:
                first = choices[0]
                # 常见形态 first.message.content or first.text
                ai_text = None
                if isinstance(first, dict):
                    msg = first.get("message")
                    if isinstance(msg, dict):
                        ai_text = msg.get("content")
                    if not ai_text:
                        # fallback
                        ai_text = first.get("text") or first.get("content")
            # 如果仍然没有抓到，直接把 raw 转为字符串
            if ai_text is None:
                try:
                    ai_text = json.dumps(raw, ensure_ascii=False)
                except Exception:
                    ai_text = str(raw)

            # 保存完整输出（包括原始 raw 以便后续解析）
            out_stage_dir = Path(out_dir) / f"stage_{stage:02d}"
            ensure_dir(out_stage_dir)
            out_path = out_stage_dir / f"unit_{unit:02d}.json"
            out_payload = {
                "stage": stage,
                "unit": unit,
                "theme": theme,
                "input_address": input_addr,
                "output_address": output_addr,
                "prompt_sent": prompt_text,
                "raw_response": raw,
                "ai_text": ai_text
            }
            with open(out_path, "w", encoding="utf-8") as fw:
                json.dump(out_payload, fw, ensure_ascii=False, indent=2)

            return {"status": "ok", "stage": stage, "unit": unit, "path": str(out_path)}
        except Exception as e:
            last_exc = e
            wait = RETRY_BACKOFF_FACTOR ** (attempt - 1)
            print(f"[WARN] stage={stage} unit={unit} attempt={attempt} failed: {e}. retry in {wait}s")
            time.sleep(wait)

    # 全部重试失败 -> 写入错误文件
    err_dir = Path(out_dir) / "errors"
    ensure_dir(err_dir)
    err_path = err_dir / f"stage{stage:02d}_unit{unit:02d}_error.txt"
    with open(err_path, "w", encoding="utf-8") as fe:
        fe.write(f"Last exception:\n{repr(last_exc)}\n")
    return {"status": "error", "stage": stage, "unit": unit, "error": repr(last_exc), "err_path": str(err_path)}

# ---------------------------
# ========== 主流程 ==========
# ---------------------------
def main():
    # 验证 API key
    api_key = DEEPSEEK_API_KEY.strip()
    if not api_key:
        raise RuntimeError("DEEPSEEK_API_KEY 未设置。请在脚本顶部将 DEEPSEEK_API_KEY 填写到变量或通过环境变量设置。")

    # 读取主题文件
    themes = read_themes_file(THEMES_TXT_PATH)
    total_needed = STAGES * UNITS_PER_STAGE
    if len(themes) < total_needed:
        print(f"[INFO] themes 行数 {len(themes)} 少于所需总单元数 {total_needed}。将用最后一行（或空字符串）填充后续单元。")

    # 准备任务清单（stage-major 顺序）
    tasks = []
    for s in range(1, STAGES + 1):
        for u in range(1, UNITS_PER_STAGE + 1):
            idx = (s - 1) * UNITS_PER_STAGE + (u - 1)
            if idx < len(themes):
                theme = themes[idx]
            else:
                theme = themes[-1] if themes else ""
            tasks.append({"stage": s, "unit": u, "theme": theme})

    print(f"[INFO] 总任务数量: {len(tasks)} ，并发上限: {MAX_WORKERS}")
    ensure_dir(OUT_DIR)

    results = []
    # 使用线程池并发处理，最大同时 MAX_WORKERS 个请求
    with ThreadPoolExecutor(max_workers=MAX_WORKERS) as ex:
        future_map = {
            ex.submit(
                process_unit,
                api_key,
                MODEL_NAME,
                t["stage"],
                t["unit"],
                t["theme"],
                PROMPT_TEMPLATE,
                OUT_DIR,
                NUM_QUESTIONS_PER_UNIT,
                SYSTEM_PROMPT if USE_SYSTEM_PROMPT else None
            ): t for t in tasks
        }

        for fut in as_completed(future_map):
            t = future_map[fut]
            try:
                res = fut.result()
                results.append(res)
                if res.get("status") == "ok":
                    print(f"[OK] stage={res['stage']:02d} unit={res['unit']:02d} -> {res['path']}")
                else:
                    print(f"[ERR] stage={res['stage']:02d} unit={res['unit']:02d} -> err saved: {res.get('err_path')}")
            except Exception as e:
                print(f"[EXC] stage={t['stage']} unit={t['unit']} unexpected exception: {e}")
                results.append({"status": "error", "stage": t["stage"], "unit": t["unit"], "error": repr(e)})

    ok_count = sum(1 for r in results if r.get("status") == "ok")
    err_count = len(results) - ok_count
    print(f"[DONE] 总请求: {len(results)}  成功: {ok_count} 失败: {err_count}")

    # 额外返回 summary json（可选）
    summary_path = Path(OUT_DIR) / "summary.json"
    with open(summary_path, "w", encoding="utf-8") as fs:
        json.dump({"total": len(results), "ok": ok_count, "error": err_count, "details": results}, fs, ensure_ascii=False, indent=2)
    print(f"[INFO] summary saved to: {summary_path}")

if __name__ == "__main__":
    main()