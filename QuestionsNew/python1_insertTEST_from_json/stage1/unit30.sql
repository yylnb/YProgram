USE `questions`;
-- Unit 30 | Start ID: 436
-- Generated at 2025-12-25 17:41:13

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    436,
    30,
    'input 与类型转换',
    '从 input() 获取的内容默认是什么类型？',
    JSON_OBJECT('A', 'int', 'B', 'str', 'C', 'float', 'D', 'bool'),
    2,
    JSON_ARRAY('input 返回用户输入的原始文本。', '需要显式转换类型。', '例如 int(input())。'),
    'input() 返回字符串，需要用 int()/float() 等转换为数值类型。',
    'age = int(input("年龄: "))'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    437,
    30,
    'f-string 基本用法',
    '下面哪个写法是有效的 f-string？',
    JSON_OBJECT('A', 'f"Name: {name}"', 'B', 'f"Name: " + name', 'C', '"fName: {name}"', 'D', 'f(Name: {name})'),
    1,
    JSON_ARRAY('f-string 以 f 开头的字符串字面量。', '表达式放在花括号内。', '确保引号配对正确。'),
    'f"...{expr}..." 是插入变量或表达式到字符串的便捷方式。',
    'f"{x} + {y} = {x+y}"'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    438,
    30,
    '比较与逻辑综合',
    '下面表达式会在 x 为 0 时为真吗？ not x and x == 0',
    JSON_OBJECT('A', '会为真', 'B', '会为假', 'C', '报错', 'D', '取决于 Python 版本'),
    1,
    JSON_ARRAY('0 在布尔上下文中为 False，not x 为 True。', 'x == 0 在 x 为 0 时为 True。', 'True and True 为 True。'),
    '当 x 为 0 时 not x 为 True，且 x == 0 为 True，两个条件同时满足。',
    'x = 0 时上述表达式为 True。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    439,
    30,
    '综合填空：读取并比较',
    '读取两个数并比较大小，输出较大值。',
    JSON_ARRAY('输入: 3 5'),
    JSON_ARRAY('5'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if a > b:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(a)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('a', 'b', 'None', 'a+b'),
    JSON_ARRAY(2),
    '若 a > b 否则输出 b。',
    '输入 10 和 2 会输出 10。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    440,
    30,
    'f-string 与表达式',
    '使用 f-string 输出结果。',
    JSON_ARRAY('name = "Tom"
age = 20'),
    JSON_ARRAY('Tom is 20 years old'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "name = \\"Tom\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "age = 20"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('f"{name} is {age} years old"', '"{name} is {age}"', 'f(name, age)', 'name + age'),
    JSON_ARRAY(1),
    '使用 f-string 插入变量并输出完整句子。',
    'print(f"Result: {x}")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    441,
    30,
    '真值与逻辑结合',
    '以下哪项为 True？',
    JSON_OBJECT('A', '[] or 0', 'B', '"" and 5', 'C', 'None or "ok"', 'D', '0 and "ok"'),
    3,
    JSON_ARRAY('or 返回第一个真值或最后一个假值。', 'None 为假。', '"ok" 为真字符串。'),
    'None or "ok" 返回 "ok"，在布尔上下文中为 True。',
    '0 or 7 返回 7。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    442,
    30,
    '比较链的快捷写法',
    '下面哪个写法用于判断 x 在 1 到 5 之间？',
    JSON_OBJECT('A', '1 < x and x < 5', 'B', '1 < x < 5', 'C', 'x > 1 and x < 5', 'D', '以上都可'),
    4,
    JSON_ARRAY('链式比较更简洁。', '多种写法等价。', '根据偏好选择。'),
    '三种写法都能判断 x 在 (1,5) 区间内，其中链式比较最简洁。',
    '1 <= x <= 5 用于闭区间判断。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    443,
    30,
    '复合题型阅读',
    '下面哪个表达式在 x = 0 时为真？ (x and 1) or (x == 0)',
    JSON_OBJECT('A', 'True', 'B', 'False', 'C', '报错', 'D', '取决于版本'),
    1,
    JSON_ARRAY('x 为 0 时 x and 1 返回 0（假），但 x == 0 为 True。', 'or 会使整体为 True。', '分步思考更稳妥。'),
    'x and 1 为 0（False），但 x == 0 为 True，False or True → True。',
    '类似逻辑可用于兼容性判断。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    444,
    30,
    '复合判断练习',
    '补全代码：当 score >= 60 且未作弊 或者 有补考资格 时通过。',
    JSON_ARRAY('score=58; cheated=False; has_makeup=True'),
    JSON_ARRAY('通过'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "score=58"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "cheated=False"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "has_makeup=True"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if (score >= 60 and not cheated) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " has_makeup:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"通过\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"不通过\\")"}]}]}',
    JSON_ARRAY('and', 'or', 'not', '=='),
    JSON_ARRAY(2),
    '两种情况下可以通过，使用 or 连接。',
    'if (pass_score) or has_exception: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    445,
    30,
    '优先级与格式化',
    '读取年龄并用 f-string 输出“Age: x”。',
    JSON_ARRAY('输入: 21'),
    JSON_ARRAY('Age: 21'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "age = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('f"Age: {age}"', '"Age: {age}"', 'f(Age: {age})', '"Age: " + age'),
    JSON_ARRAY(1),
    '使用 f-string 并在花括号内放变量即可。',
    'print(f"Score: {score}")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    446,
    30,
    '习题涵盖点',
    '下列技能哪些是本阶段重点？',
    JSON_OBJECT('A', '输入与类型转换', 'B', '比较与逻辑表达式', 'C', 'f-string 与输出格式化', 'D', '以上全部'),
    4,
    JSON_ARRAY('阶段复习通常覆盖多个核心点。', '回顾之前单元内容。', '练习综合应用很重要。'),
    '本阶段的复习侧重输入、比较、逻辑与格式化输出等核心基础。',
    '结合输入与条件判断完成小程序。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    447,
    30,
    '错误识别',
    '下面哪行在 Python3 中会抛错？',
    JSON_OBJECT('A', 'print("Hi")', 'B', 'if 1 < 2: pass', 'C', 'x = input("> ")', 'D', 'print "Hello"'),
    4,
    JSON_ARRAY('Python3 的 print 是函数。', '缺少括号会导致语法错误。', '其他选项语法正确。'),
    'Python3 要使用 print("...")，不带括号的写法是 Python2 风格，会抛出语法错误。',
    '正确写法：print("Hello")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    448,
    30,
    '综合判断示例',
    '若 a = ""，b = None，则表达式 a or b or "ok" 的结果是？',
    JSON_OBJECT('A', '""', 'B', 'None', 'C', '"ok"', 'D', '报错'),
    3,
    JSON_ARRAY('or 返回第一个真值。', '空字符串为假，None 为假。', '最后返回默认值。'),
    'a 和 b 都为假，or 会返回最后的 "ok"。',
    '"" or None or "x" → "x"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    449,
    30,
    '实战：输入判断',
    '读取用户名并输出欢迎或提示输入。',
    JSON_ARRAY('输入: (回车)'),
    JSON_ARRAY('请输入用户名'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "name = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(f\\"Welcome, {name}\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"请输入用户名\\")"}]}]}',
    JSON_ARRAY('name', 'not name', 'name != ""', 'name is None'),
    JSON_ARRAY(2),
    '当用户直接回车时 name 为空字符串，使用 not name 判断为空并给出提示。',
    'if not username: print("请输入用户名")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    450,
    30,
    '综合小题：成绩与等级',
    '补全代码，根据分数输出等级：>=90 A，>=80 B，其余 C。',
    JSON_ARRAY('score = 85'),
    JSON_ARRAY('B'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "score = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if score >= 90:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"A\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "elif score >= 80:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"C\\")"}]}]}',
    JSON_ARRAY('"A"', '"B"', '"C"', '"D"'),
    JSON_ARRAY(2),
    '85 在 80–89 的区间，应输出 B。',
    'score=95 输出 A'
);