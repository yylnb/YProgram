// 默认输出格式为JSON，因为用户未指定sql值
[
  {
    "lang": "c++",
    "lb_id": 26,
    "difficulty": "beginner",
    "page": 1,
    "title": "if 语句",
    "tags": ["条件控制", "if"],
    "summary": "if语句用于根据条件执行代码块。",
    "content": "if语句是C++中基本的条件控制结构。\n它允许程序在条件为真时执行特定的代码块。\n语法：if (condition) { // code }。例如，如果变量x大于0，则输出消息。\n注意：条件必须是布尔表达式，结果为true或false。",
    "eg_in": ["int x = 5;\nif (x > 0) {\n    cout << \"x is positive\";\n}"],
    "eg_out": ["x is positive"]
  },
  {
    "lang": "c++",
    "lb_id": 27,
    "difficulty": "beginner",
    "page": 1,
    "title": "if-else 语句",
    "tags": ["条件控制", "if-else"],
    "summary": "if-else语句在条件为真时执行一个代码块，否则执行另一个。",
    "content": "if-else语句扩展了if语句，提供了两个分支。\n如果条件为true，执行if块；否则执行else块。\n语法：if (condition) { // code1 } else { // code2 }。\n适用于需要处理两种相反情况的场景。",
    "eg_in": ["int x = -3;\nif (x > 0) {\n    cout << \"x is positive\";\n} else {\n    cout << \"x is non-positive\";\n}"],
    "eg_out": ["x is non-positive"]
  },
  {
    "lang": "c++",
    "lb_id": 28,
    "difficulty": "beginner",
    "page": 1,
    "title": "嵌套 if 语句",
    "tags": ["条件控制", "嵌套if"],
    "summary": "嵌套if语句允许在if或else块内使用另一个if语句。",
    "content": "嵌套if语句用于处理多个条件层次，实现更复杂的逻辑。\n可以在if块或else块内放置另一个if语句。\n语法示例：if (condition1) { if (condition2) { // code } }。\n注意避免过度嵌套以保持代码可读性。",
    "eg_in": ["int x = 10;\nint y = 20;\nif (x > 0) {\n    if (y > 0) {\n        cout << \"Both x and y are positive\";\n    }\n}"],
    "eg_out": ["Both x and y are positive"]
  },
  {
    "lang": "c++",
    "lb_id": 29,
    "difficulty": "beginner",
    "page": 1,
    "title": "switch 语句",
    "tags": ["条件控制", "switch"],
    "summary": "switch语句根据表达式的值选择多个代码块之一执行。",
    "content": "switch语句用于基于整数或枚举类型的值进行多路分支。\n语法：switch (expression) { case value1: // code; break; default: // code; }。\n每个case后通常使用break语句防止执行穿透到下一个case。\ndefault分支是可选的，用于处理未匹配的值。",
    "eg_in": ["int day = 3;\nswitch (day) {\n    case 1:\n        cout << \"Monday\";\n        break;\n    case 2:\n        cout << \"Tuesday\";\n        break;\n    case 3:\n        cout << \"Wednesday\";\n        break;\n    default:\n        cout << \"Other day\";\n}"],
    "eg_out": ["Wednesday"]
  },
  {
    "lang": "c++",
    "lb_id": 30,
    "difficulty": "beginner",
    "page": 1,
    "title": "条件运算符",
    "tags": ["条件控制", "三元运算符"],
    "summary": "条件运算符是简洁的if-else替代，用于赋值或返回值。",
    "content": "条件运算符语法：condition ? expr1 : expr2。\n如果condition为true，则结果为expr1，否则为expr2。\n常用于简单的条件赋值或内联表达式，使代码更紧凑。\n注意：expr1和expr2必须是相同或兼容的类型。",
    "eg_in": ["int x = 5;\nint y = (x > 0) ? 1 : -1;\ncout << y;", "int a = 10, b = 20;\nint max = (a > b) ? a : b;\ncout << max;"],
    "eg_out": ["1", "20"]
  }
];