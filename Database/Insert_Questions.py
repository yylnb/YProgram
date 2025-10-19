import pymysql

# 题目数据，注意 q_id 在每条记录里都要有
rows = [
    {
        "q_id": 1,
        "lang": "python",
        "unit_id": 1,
        "title": "Hello 输出",
        "question_text": '在 Python 中，打印 "Hello, World" 的正确写法是？',
        "options": [
            'print("Hello, World")',
            'echo "Hello, World"',
            'console.log("Hello, World")',
            'printf("Hello, World")'
        ],
        "answer": 0,
        "hints": [
            '提示：Python 使用内置函数 print()',
            '提示：字符串需用引号包裹'
        ],
        "explanation": 'Python 使用 <code>print()</code> 来输出文本。',
        "example": 'print("Hello, World")'
    },
    {
        "q_id": 2,
        "lang": "python",
        "unit_id": 1,
        "title": "合法变量名",
        "question_text": "下面哪个是合法的 Python 变量名？",
        "options": [
            "1st_var", "first_var", "first-var", "first var"
        ],
        "answer": 1,
        "hints": [
            "变量名不能以数字开头",
            "不能包含空格或短横线"
        ],
        "explanation": "Python 标识符必须以字母或下划线开头，只能包含字母、数字和下划线。",
        "example": "first_var = 10"
    },
    {
        "q_id": 3,
        "lang": "python",
        "unit_id": 1,
        "title": "类型转换",
        "question_text": "把整数 5 转换成字符串的一种正确写法？",
        "options": [
            "str(5)", "int(5)", "toString(5)", "5.toString()"
        ],
        "answer": 0,
        "hints": [
            'str(5) 会返回 "5"',
            "Python 使用 str() 转换为字符串"
        ],
        "explanation": "使用 <code>str()</code> 将数值转换为字符串。",
        "example": "s = str(5)"
    }
]


def sql_quote(s: str) -> str:
    """把普通字符串转成 SQL 里的单引号字符串"""
    return "'" + s.replace("'", "''") + "'"


def sql_json_array(arr):
    """把 Python list 转成 JSON_ARRAY(...)"""
    return "JSON_ARRAY(" + ",".join(sql_quote(item) for item in arr) + ")"


def build_insert(rows):
    """生成 INSERT SQL 语句"""
    value_lines = []
    for r in rows:
        v = (
            f"({r['q_id']}, {sql_quote(r['lang'])}, {r['unit_id']}, {sql_quote(r['title'])},\n"
            f" {sql_quote(r['question_text'])},\n"
            f" {sql_json_array(r['options'])},\n"
            f" {r['answer']},\n"
            f" {sql_json_array(r['hints'])},\n"
            f" {sql_quote(r['explanation'])},\n"
            f" {sql_quote(r['example'])}\n"
            f")"
        )
        value_lines.append(v)

    sql = (
        "INSERT INTO questions "
        "(q_id, lang, unit_id, title, question_text, options, answer, hints, explanation, example)\n"
        "VALUES\n" + ",\n\n".join(value_lines) + ";"
    )
    return sql


if __name__ == "__main__":
    sql = build_insert(rows)
    print(sql)
