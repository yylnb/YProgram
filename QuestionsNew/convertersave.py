import json
import time
import os
import re
from openai import OpenAI

# ================= 配置区域 =================
# 替换为你的 DeepSeek API Key
API_KEY = "sk-eeea8f33515f40e1b7c80d20960b5a28"

# 初始化 DeepSeek 客户端
client = OpenAI(
    api_key=API_KEY,
    base_url="https://api.deepseek.com"
)

# ================= 核心系统指令 (Prompt) =================
SYSTEM_INSTRUCTION = """
你是一个编程题目解析专家。请将输入的非标准题目文本转换为符合特定 Schema 的 JSON 格式。

### 核心任务
输出一个 JSON 对象，包含 `choice_questions` (选择题) 和 `fill_questions` (填空题)。

### 1. 选择题 (choice_questions) 结构
- id, title, content, answer (如 "A"), hints (列表), explanation, example
- options: 字典结构，如 {"A": "print", "B": "input"}

### 2. 填空题 (fill_questions) 结构 - 请严格执行
- id, title, content, explanation, example
- input: 输入数据（无则为 null）
- output: 输出结果列表（如 ["I love Python"]）
- options: 选项列表（如 ["print", "echo"]）
- answer: 正确答案的**内容**列表（如 ["print"]）
- code_segments 嵌套逻辑 (极重要):
    `code_segments` 必须包含一个 "segments" 列表，列表项分为以下两种类型，请根据题目代码格式严谨选择：

    1. **code_inline (行内混合型)**:
    - 场景：当一行代码中既有固定代码又有挖空（____）时使用。
    - 结构：`{"type": "code_inline", "parts": [...]}`
    - parts 内部：
        - `{"type": "code", "value": "代码内容"}`
        - `{"type": "slot", "index": 0}` (索引从0开始)

    2. **code_block (独立代码块型)**:
    - 场景：用于展示不需要挖空的完整代码行。
    - 结构：`{"type": "code_block", "lines": [...]}`
    - lines 内部：
        - `{"type": "code_line", "value": "整行代码内容"}`

    #### 嵌套示例 (如题目包含两行代码):
    代码如下：
    print("Hello", ____="")
    print("World")

    JSON 结构应为：
    "code_segments": {
      "segments": [
          {
          "type": "code_inline",
          "parts": [
              { "type": "code", "value": "print(\\\"Hello\\\", " },
              { "type": "slot", "index": 0 },
              { "type": "code", "value": "=\\\"\\\")" }
          ]
          },
          {
          "type": "code_block",
          "lines": [
              { "type": "code_line", "value": "print(\\\"World\\\")" }
          ]
          }
      ]
    }

### 全局原则
1. **只输出 JSON**，不要包含 markdown 标记（如 ```json）。
2. **转义修正**：确保所有 JSON 字符串内的引号都已正确转义。
"""

# ================= SQL 生成器 =================
class SQLGenerator:
    def __init__(self, unit_id):
        self.unit_id = unit_id

    def escape_sql_single_quote(self, text):
        if text is None: return "NULL"
        clean_text = str(text).replace("'", "\\'")
        return f"'{clean_text}'"

    def escape_sql_double_quote(self, text):
        if text is None: return "NULL"
        clean_text = str(text).replace('"', '\\"')
        return f'"{clean_text}"'

    # 修改点：接收具体的 q_id 参数
    def format_choice(self, q, current_qid):
        opts = q.get('options', {})
        opt_parts = [f"{self.escape_sql_single_quote(k)}, {self.escape_sql_single_quote(v)}" for k, v in opts.items()]
        options_sql = f"JSON_OBJECT({', '.join(opt_parts)})"

        hints = q.get('hints', [])
        hints_sql = f"JSON_ARRAY({', '.join([self.escape_sql_single_quote(h) for h in hints])})" if hints else "NULL"
        
        ans_map = {'A': 1, 'B': 2, 'C': 3, 'D': 4}
        answer_int = ans_map.get(str(q.get('answer', '')).strip(), 0)

        # 注意 VALUES 第一个参数使用了 current_qid
        return f"""
INSERT INTO `que_choice_py_1` 
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
);""".strip()

    # 修改点：接收具体的 q_id 参数
    def format_fill(self, q, current_qid):
        code_obj = q.get('code_segments')
        code_json_str = json.dumps(code_obj, ensure_ascii=False)
        code_sql_val = self.escape_sql_double_quote(code_json_str)

        opts = q.get('options', [])
        opt_str = f"JSON_ARRAY({', '.join([self.escape_sql_single_quote(o) for o in opts])})"

        ans_indices = []
        for ans in q.get('answer', []):
            try:
                idx = opts.index(ans) + 1 
                ans_indices.append(idx)
            except ValueError:
                ans_indices.append(0) 
        ans_sql = f"JSON_ARRAY({', '.join(map(str, ans_indices))})"

        outs = q.get('output')
        if isinstance(outs, list):
            out_parts = [self.escape_sql_single_quote(str(o)) for o in outs]
            out_sql = f"JSON_ARRAY({', '.join(out_parts)})"
        else:
            out_sql = f"JSON_ARRAY({self.escape_sql_single_quote(outs)})" if outs else "NULL"

        return f"""
INSERT INTO `que_fill_py_1`
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
);""".strip()

def clean_json_text(text):
    text = re.sub(r'^```json\s*', '', text, flags=re.MULTILINE)
    text = re.sub(r'^```\s*', '', text, flags=re.MULTILINE)
    return text.strip()

# ================= 单文件处理函数 =================
def generate_sql_from_file(input_path, output_path, current_unit_id, start_qid):
    if not os.path.exists(input_path):
        print(f"❌ 错误：找不到文件 {input_path}")
        return

    with open(input_path, "r", encoding="utf-8") as f:
        raw_content = f.read()

    print(f"🚀 [Unit {current_unit_id}] 正在请求 API...")
    try:
        response = client.chat.completions.create(
            model="deepseek-chat", 
            messages=[
                {"role": "system", "content": SYSTEM_INSTRUCTION},
                {"role": "user", "content": f"请处理以下数据：\n\n{raw_content}"}
            ],
            response_format={'type': 'json_object'},
            temperature=0.1
        )
        data_structure = json.loads(clean_json_text(response.choices[0].message.content))
        
    except Exception as e:
        print(f"❌ Unit {current_unit_id} 失败: {e}")
        return

    print(f"⚙️ [Unit {current_unit_id}] 正在生成 SQL (起始ID: {start_qid})...")
    
    # 初始化 SQL 生成器
    generator = SQLGenerator(unit_id=current_unit_id)
    sql_lines = [
        "USE `questions`;", 
        f"-- Unit {current_unit_id} | Start ID: {start_qid}",
        f"-- Generated at {time.strftime('%Y-%m-%d %H:%M:%S')}\n"
    ]

    # 这里的 active_qid 是这一轮循环内部的计数器
    active_qid = start_qid

    if "choice_questions" in data_structure:
        for q in data_structure["choice_questions"]:
            # 传入计算好的 ID
            sql_lines.append(generator.format_choice(q, active_qid))
            active_qid += 1 # ID 自增

    if "fill_questions" in data_structure:
        sql_lines.append("\n-- ---------- 填空题 ----------")
        for q in data_structure["fill_questions"]:
            # 传入计算好的 ID
            sql_lines.append(generator.format_fill(q, active_qid))
            active_qid += 1 # ID 自增

    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    with open(output_path, "w", encoding="utf-8") as f:
        f.write("\n".join(sql_lines))
    
    print(f"🎉 Unit {current_unit_id} 完成！文件保存至: {output_path}")

# ================= 主流程 =================
def main():
    # ⚙️ 在这里设置你的规则
    QUESTIONS_PER_UNIT = 15  # 每个单元固定的题目数量
    START_OFFSET = 1         # 第一个单元从 ID 几开始？通常是 1
    
    # 循环处理 Unit 1 到 Unit 30
    for i in range(1, 3):
        # 1. 设置文件路径 (使用 f-string)
        input_path = f"F:\\project\\YProgram\\QuestionsNew\\python1\\stage1\\python1_stage1_unit{i}.txt"
        output_path = f"F:\\project\\YProgram\\QuestionsNew\\python1_insertTEST\\stage1\\unit{i}.sql"
        
        # 2. 核心数学逻辑：计算当前单元的起始 ID
        # 公式：(当前单元号 - 1) * 每单元题数 + 起始偏移量
        # Unit 1: (0 * 15) + 1 = 1
        # Unit 2: (1 * 15) + 1 = 16
        current_start_qid = (i - 1) * QUESTIONS_PER_UNIT + START_OFFSET

        print(f"\n===== 准备处理第 {i} 单元 (预计起始ID: {current_start_qid}) =====")

        try:
            # 调用处理函数，传入计算好的 Start ID
            generate_sql_from_file(
                input_path=input_path, 
                output_path=output_path, 
                current_unit_id=i, 
                start_qid=current_start_qid
            )
            
            # 3. 延时机制 (防止 API 速率限制)
            if i < 30:
                print("⏳ 等待 2 秒...")
                time.sleep(2)
                
        except Exception as e:
            print(f"❌ 严重错误: {e}")
            continue

    print("\n✅ 所有任务处理完成！")

if __name__ == "__main__":
    main()