USE `questions`;
-- Unit 25 | Start ID: 361
-- Generated at 2025-12-25 17:41:13

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    361,
    25,
    '布尔基本类型',
    '下面哪个是 Python 的布尔字面量？',
    JSON_OBJECT('A', 'True', 'B', 'true', 'C', 'TRUE', 'D', '1'),
    1,
    JSON_ARRAY('Python 中布尔字面量区分大小写。', '只有首字母大写的写法是正确的。', '数字 1 虽然在布尔上下文可当 True，但不是布尔字面量。'),
    'Python 的布尔字面量是 True 和 False（首字母大写）。',
    '例如 if True: print("yes")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    362,
    25,
    '比较表达式返回类型',
    '表达式 3 > 2 的结果是什么类型？',
    JSON_OBJECT('A', 'int', 'B', 'str', 'C', 'bool', 'D', 'float'),
    3,
    JSON_ARRAY('比较运算的结果是判断对错。', '对的用 True 表示，错的用 False。', '因此类型是布尔型。'),
    '比较运算（>, <, == 等）返回布尔值 True/False。',
    '5 == 5 → True，类型是 bool。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    363,
    25,
    '布尔运算 and',
    '表达式 True and False 的值是？',
    JSON_OBJECT('A', 'True', 'B', 'False', 'C', 'None', 'D', '0'),
    2,
    JSON_ARRAY('and 只有在两个操作数都为 True 时才为 True。', '这里有一个 False，结果应为 False。', '不是 None 或 0，答案就是 False。'),
    'True and False → False，因为两侧必须都为 True 才返回 True。',
    'True and True → True；False and True → False。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    364,
    25,
    'bool() 的基本用法',
    '补全代码：判断值是否为真值。',
    JSON_ARRAY('val = ""'),
    JSON_ARRAY('False'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": "(val))"}]}]}',
    JSON_ARRAY('bool', 'int', 'str', 'True', 'False', 'len'),
    JSON_ARRAY(1),
    'bool(val) 可以将任意值转换为布尔值；空字符串为 False。',
    'bool("abc") → True；bool("") → False。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    365,
    25,
    '空容器的真值性',
    '补全代码：判断空列表是否为假值。',
    JSON_ARRAY('lst = []'),
    JSON_ARRAY('False'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": "(lst))"}]}]}',
    JSON_ARRAY('bool', 'len', 'list', '0', 'not', 'any'),
    JSON_ARRAY(1),
    '空列表在布尔上下文中为 False，bool(lst) 返回 False。',
    'bool([]) → False；bool([1]) → True。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    366,
    25,
    '短路行为（and）',
    '表达式 0 and (1/0) 会发生什么？',
    JSON_OBJECT('A', '抛出 ZeroDivisionError', 'B', '返回 0 并不抛错（短路）', 'C', '返回 True', 'D', '返回 None'),
    2,
    JSON_ARRAY('and 是短路运算符，左侧为 False 时不会计算右侧。', '0 在布尔上下文中为 False。', '所以不会执行 1/0 的除法。'),
    '0 在布尔上下文为 False，and 短路返回左值 0，不会计算右侧表达式，因此不报错。',
    '"" and unknown_func() 不会调用 unknown_func()。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    367,
    25,
    '短路行为（or）',
    '表达式 "" or "default" 的结果是？',
    JSON_OBJECT('A', '""', 'B', '"default"', 'C', 'False', 'D', 'None'),
    2,
    JSON_ARRAY('or 会在左侧为真时返回左侧，否则返回右侧。', '空字符串为假值，因此返回右侧。', '结果为 "default"。'),
    '"" or "default" 返回 "default"，常用于提供默认值。',
    'name = input() or "Guest"。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    368,
    25,
    '比较链（chaining）',
    '表达式 1 < 2 < 3 的结果是？',
    JSON_OBJECT('A', 'True', 'B', 'False', 'C', '抛错', 'D', '1'),
    1,
    JSON_ARRAY('Python 支持比较链，会同时判断 1 < 2 和 2 < 3。', '只有两边都为真时整体为真。', '这里两个关系都成立。'),
    '1 < 2 < 3 等同于 (1 < 2) and (2 < 3)，结果为 True。',
    '2 <= 3 < 5 → True'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    369,
    25,
    '身份运算 is vs ==',
    '补全代码：判断两个变量是否引用同一个对象。',
    JSON_ARRAY('a = 1000
b = 1000'),
    JSON_ARRAY('False 或 True（取决实现）'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(a "}, {"type": "slot", "index": 0}, {"type": "code", "value": " b)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(a == b)"}]}]}',
    JSON_ARRAY('is', '==', '!=', 'is not', '=', '==='),
    JSON_ARRAY(1),
    'is 用于判断身份（是否为同一对象），== 用于值比较。对于大整数小整数缓存机制会影响 is 的结果，所以 is 不可靠用于数值相等判断。',
    's1 = "hi"; s2 = "hi"; s1 is s2 结果常为 True（实现相关）。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    370,
    25,
    'not 运算符',
    '补全代码：取反操作。',
    JSON_ARRAY('flag = True'),
    JSON_ARRAY('False'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": " flag)"}]}]}',
    JSON_ARRAY('not', '!', '~', '-'),
    JSON_ARRAY(1),
    'Python 使用 not 做布尔取反，! 不是 Python 的布尔运算符。',
    'not False → True'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    371,
    25,
    '布尔与整型的相互关系',
    '在 Python 中，True 等价于哪个整数？',
    JSON_OBJECT('A', '0', 'B', '1', 'C', '-1', 'D', '无法比较'),
    2,
    JSON_ARRAY('布尔在数学运算中有对应的整数值。', 'True 在加法中表现为 1。', '例如 True + True = 2。'),
    'Python 中 True 的整数值为 1，False 为 0。',
    'True + 1 → 2'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    372,
    25,
    '真值判断的常见陷阱',
    '下面哪个对象在布尔上下文中被认为是 False？',
    JSON_OBJECT('A', '[0]', 'B', '0', 'C', '"0"', 'D', '[None]'),
    2,
    JSON_ARRAY('空容器为 False，但包含元素的容器为 True。', '数字 0 在布尔上下文中为 False。', '"0" 是非空字符串，为 True。'),
    '0 为假值；而 "[0]" 与 "[None]" 是非空列表，布尔值为 True。',
    'bool(0) → False；bool("0") → True'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    373,
    25,
    '逻辑运算的返回值（非布尔）',
    '表达式 None or "ok" 的返回结果是？',
    JSON_OBJECT('A', 'True', 'B', 'False', 'C', 'None', 'D', '"ok"'),
    4,
    JSON_ARRAY('or 会返回第一个真值或最后一个假值。', 'None 在布尔上下文视为假。', '因此返回右边的 "ok"。'),
    'None or "ok" 会返回 "ok"，常用于默认值逻辑。',
    'x = user_input or "default"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    374,
    25,
    '复杂条件判断',
    '补全代码：当 age 在 18 到 65 之间且 is_member 为 True 时允许访问。',
    JSON_ARRAY('age = 30
is_member = True'),
    JSON_ARRAY('Access granted'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": " and "}, {"type": "slot", "index": 1}, {"type": "code", "value": " and "}, {"type": "slot", "index": 2}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Access granted\\")"}]}]}',
    JSON_ARRAY('18 <= age', 'age <= 65', 'is_member', 'age > 18', 'age < 65', 'True'),
    JSON_ARRAY(1, 2, 3),
    '需要同时满足 18 <= age，age <= 65 并且 is_member 为 True。',
    'if 0 <= x <= 10 and valid: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    375,
    25,
    '使用 any/all 做聚合判断',
    '补全代码：如果任一检查通过则输出 OK（使用 any）。',
    JSON_ARRAY('checks = [False, False, True]'),
    JSON_ARRAY('OK'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": "):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"OK\\")"}]}]}',
    JSON_ARRAY('any', 'all', 'checks', 'True', 'False', 'len'),
    JSON_ARRAY(1, 3),
    'any(checks) 在列表中任一元素为真时返回 True；all 则要求全为真。',
    'any([0, "", None, "x"]) → True'
);