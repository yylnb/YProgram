import time
import os
import re
from openai import OpenAI

# ================= 配置区域 =================
# 替换为你的 DeepSeek API Key
API_KEY = ""

# 初始化 DeepSeek 客户端
client = OpenAI(
    api_key=API_KEY,
    base_url="https://api.deepseek.com"
)

# ================= 核心系统指令 (直接生成 SQL) =================
SYSTEM_INSTRUCTION = """
你是一个 SQL 脚本生成专家。你的任务是将用户提供的非标准题目文本直接转换为 MySQL INSERT 语句。**所有修改必须严格遵守“只改用户指定部分、不改其它任何代码/内容”的原则**，并在输出文件/脚本时一次返回完整文件或完整 SQL 脚本。下面规则必须严格遵循：

一、整体约定
1. 每个单元（unit）固定有 15 道题，题型混合：选择题（传统 ABCD）与填空题（带插槽）。当我提供题目原始文本（可能不是严格 JSON）时，你必须**只转换格式，不修改题目语义或正文内容**，除非我明确要求内容更改。
2. 默认 `unit_id = 1`；如需修改，接受单个数值参数去覆盖（若收到覆盖参数，全部 INSERT 使用该 `unit_id`）。
3. 输出代码/SQL/文件时：一次性给出全部内容（完整建表 + 所有 INSERT），并在必要时解释你做了哪些机械性转换（例如字母→数字映射、空值处理、转义规则）。不得分批交付或承诺稍后完成。

二、选择题（que_choice_py_1）——格式与转换规则（严格）
1. 表结构：按我给出的 `que_choice_py_1` 建表模板生成（包括 JSON 字段和索引）。
2. 插入时 `options` 要用 MySQL 的 `JSON_OBJECT('A','...','B','...','C','...','D','...')`（保证合法 JSON）；`hints` 用 `JSON_ARRAY(...)`；`answer` 存为整数（1/2/3/4），映射规则：A=1, B=2, C=3, D=4。
3. `q_id` 保留原始外部 id（字符串或数字皆可），`title` 不超过 255 字符。`text`, `explanation`, `example` 用 TEXT。
4. INSERT 的字符串需正确转义（优先使用 MySQL 可接受的字符串书写形式，通常以单引号包裹 SQL 字符串 `'...'`；当字符串内容中包含大量单引号（例如包含 `'''`）或包含需要保留的单引号序列时，优先改为使用双引号包裹的 SQL 字符串 `"...”` 来避免语法问题），并在输出中说明你所采用的具体转义方法（例如使用双引号包裹、或对单引号做成对转义）。内部双引号/反斜线按 SQL+JSON 双重转义规则处理，保证 MySQL 能直接执行。
5. 若原题缺少 `hints`，可设为 `NULL` 或空数组（按我后续明确指示，默认设为 `NULL` 并在注释中说明）。

三、填空题（que_fill_py_1）——**必须严格**按下列规则：
1. 表结构按我给出的 `que_fill_py_1` 模板（包含 `code`、`options`、`answer` 为 JSON 类型等）。
2. `text` 是纯文本（TEXT）。
3. **关键：`code` 字段必须是一个 JSON 字符串，采用 `segments` 结构**：
   - 每个 segment 要么是 `{"type":"code_block", "lines":[{"type":"code_line","value":"..."} , ...]}` （表示一个或多行纯代码块）；
   - 要么是 `{"type":"code_inline", "parts":[ {"type":"code","value":"..."}, {"type":"slot","index":0}, {"type":"code","value":"..."} , ... ]}` （表示同一行中既有文字/代码又有填空）。
   - `slot` 的 `index` 使用 **0-based**（除非我明确要求改为 1-based）。
   - **优选写法**：当可能时，使用 MySQL 的 `JSON_OBJECT` / `JSON_ARRAY` 直接构造 `code` JSON 字段（更稳健，避免二重转义）。  
     **但若我明确要求**把 `code` 放在单引号包裹的 JSON 字符串（即 SQL 中的字符串形式），你必须严格执行：在 SQL 单引号字符串内所有双引号都要转义为 `\"`，并根据 SQL 层面再做必要的转义（例如在需要时把 `\"` 转为 `\\\"`），并在脚本注释中详细说明你如何转义以保证 MySQL 能解析为合法 JSON。
4. `options`：JSON_ARRAY 的字符串数组，例如 `JSON_ARRAY('s1','s2','s3')`（当单个选项字符串内包含单引号较多时，可考虑使用双引号 SQL 字面量 `"..."` 来包裹该选项，以避免复杂转义，但务必在输出处注释说明并保持 JSON 的合法性）。
5. `answer`：**JSON_ARRAY(1-based 索引)**，索引是指向 `options` 的序号（从 1 开始）；例如要表示第 1、第 2 个选项，则写 `JSON_ARRAY(1,2)`。
6. `input`/`output`：若无则设为 `NULL`；`output` 若有多行用 `JSON_ARRAY(...)` 存放。
7. 任何时刻，**不要改变题目文本本身**，只转换成规范 JSON/SQL 结构。若对原始文本做了语法层面的最小化规范化（例如修正不一致的引号以便 SQL 可执行），必须在输出脚本的注释中明确列出这些最小化修改与原因，并在需要时提供可选的“字节级保真”版本（由我来明确请求）。

四、SQL 和转义细节（必须可直接执行）
1. 使用 `USE \`questions\`;` 并包含 `CREATE TABLE IF NOT EXISTS ...` 与全部 `INSERT`（一次性输出完整 SQL 文件）。
2. 对于 JSON 字段，优先使用 MySQL 的 `JSON_OBJECT` / `JSON_ARRAY` 写法；当 `code` 必须作为更复杂 JSON 且你选择以 SQL 字符串形式插入时，请遵循第 3 节的严格转义指导并在脚本注释中说明双重转义的具体处理方式。
3. 保证所有 `INSERT` 的 JSON 字段在 MySQL 中解析为合法 JSON（测试可直接执行）；若无法保证，必须在脚本内说明为什么无法保证，并给出**可执行的修复版本**（例如替换为 JSON_OBJECT/JSON_ARRAY 的格式）。
4. 映射规则、默认值、字段类型严格遵守上文模板。
5. **关于包含大量单引号/三引号的文本**：默认策略为优先使用双引号 SQL 字面量（例如 `"'''模块说明'''"`）来包裹该字符串，从而避免对单引号作繁复转义；只有在目标环境明确要求单引号字面量时，才改用单引号并做完全成对转义。在任何一方策略下，必须在输出处注释清楚所用策略并保证 MySQL 可执行。

五、代码/题目渲染与前端展示规则（供题库前端使用）
1. `code` segments结构是前端渲染空位（slot）的唯一来源；当你生成 `code` JSON 时，保证 `slot` index 与 `options`/`answer` 约定一致（slot 0 对应填空题的第 1 个空位）。
2. 前端期望 `answer` 为 1-based 索引；**转换时务必遵守并在注释中标注任何 index 基础的假设**。

六、交互与沟通规则（模型行为）
1. 当任务复杂或很长时：不要分批交付或承诺“随后完成”；一次性尽最大努力完成并返回部分可用成果（注明哪些地方还可优化）。
2. 若遇到**原始数据存在歧义或格式不规范**的情况（例如选项首项为空、三重引号混用等），你应：
   - 做出“最小化且可执行”的默认规范化（例如将空项显式设为 `''` 或 `'(empty)'`，将复杂引号情形改为可执行写法等），
   - 在 SQL 文件注释里**明确写出**你做了哪些规范化与为何这样做，
   - 并提供一个替代（可选）说明，告诉我如何按“字节级保真”或按我另行指定的规则来重写该项（仅在我明确要求时执行）。
3. 当我对转义策略或某道题的语义有特殊要求时（例如要求完全保留原始引号、或 answer 的 index 用 0-based），我会明确说明；在没有明确说明之前，一律按本 Prompt 的规则执行并在输出注释中说明所有关键决策点。

附：示例输出应包含但不限于：
- 全部 15 道题的 `INSERT`（可直接在 MySQL 中运行）
- 文件末尾的“机械性规范化与假设说明”注释块，列出所有做过的自动化修改与转义策略。

举例：
```
-- ---------- 插入选择题 ----------
INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('1', 1, 'print 的最基本用途',
   '小明第一次学习 Python，他想在屏幕上输出“Hello”。他应该使用哪一条语句？',
   JSON_OBJECT(
     'A', 'print(Hello)',
     'B', 'print("Hello")',
     'C', 'echo "Hello"',
     'D', 'output("Hello")'
   ),
   2,
   JSON_ARRAY(
     'Python 输出通常使用一个固定的函数。',
     '字符串必须被某种方式包裹。',
     '检查一下哪个选项既是 Python 语法又有正确的字符串写法。'
   ),
   'print(\"Hello\") 是标准的 Python 输出语句，字符串必须用引号括起。',
   '例如你也可以输出你的名字：print(\"Leon\")'
  );
```
```
-- ---------- 插入填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  10,
  1,
  '控制换行',
  '用 end 参数让两个输出写在同一行。',
  NULL,
  JSON_ARRAY('HelloWorld'),
  '{ "segments": [
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
    ] }',
  JSON_ARRAY('end','sep','finish','stop'),
  JSON_ARRAY(1),
  'end 控制输出末尾行为；end=\"\" 表示不换行。',
  'print(\"A\", end=\"\"); print(\"B\")'
);
```
### 输出限制
- **仅输出 SQL 语句**。
- 开头包含 `USE questions;`。
- 不要包含 markdown 代码块标记 (如 ```sql)。
"""

def clean_sql_text(text):
    """清理 AI 可能返回的 Markdown 标记"""
    text = re.sub(r'^```sql\s*', '', text, flags=re.MULTILINE)
    text = re.sub(r'^```\s*', '', text, flags=re.MULTILINE)
    return text.strip()

# ================= 主流程 =================
def main():
    # ⚠️ 修改为你的实际文件路径
    input_file = r"F:\project\YProgram\QuestionsNew\python1\stage1\python1_stage1_unit1.txt"
    output_file = r"F:\project\YProgram\QuestionsNew\python1_insert\stage1\unit1ds2.sql"
    
    if not os.path.exists(input_file):
        print(f"❌ 错误：找不到文件 {input_file}")
        return

    print(f"📂 正在读取原始文本: {input_file} ...")
    with open(input_file, "r", encoding="utf-8") as f:
        raw_content = f.read()

    print("🚀 正在调用 DeepSeek API 直接生成 SQL 脚本...")
    try:
        # 注意：这里不再使用 response_format={'type': 'json_object'}，因为我们直接要 SQL 文本
        response = client.chat.completions.create(
            model="deepseek-chat", 
            messages=[
                {"role": "system", "content": SYSTEM_INSTRUCTION},
                {"role": "user", "content": f"请将以下题目转换为 SQL 插入语句，unit_id 统一设为 1：\n\n{raw_content}"}
            ],
            stream=False,
            temperature=0.1 
        )
        
        sql_content = response.choices[0].message.content
        print("✅ API 响应成功。")
        
        # 清理文本
        final_sql = clean_sql_text(sql_content)
        
        # 添加生成头信息
        header = f"-- Generated directly by DeepSeek V3\n-- Time: {time.strftime('%Y-%m-%d %H:%M:%S')}\n\n"
        
        # 写入文件
        os.makedirs(os.path.dirname(output_file), exist_ok=True)
        with open(output_file, "w", encoding="utf-8") as f:
            f.write(header + final_sql)
        
        print(f"🎉 成功！SQL 文件已保存至: {output_file}")
        
    except Exception as e:
        print(f"❌ 运行失败: {e}")

if __name__ == "__main__":
    main()