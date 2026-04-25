USE `questions`;
-- Unit 31 | Start ID: 451
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    451,
    31,
    'if 的最基本用途',
    '下面哪段代码表示“如果 x 大于 0 则打印 OK”？',
    JSON_OBJECT('A', 'if x > 0:
    print("OK")', 'B', 'if(x > 0) print("OK")', 'C', 'if x > 0 then print("OK")', 'D', 'x > 0 ? print("OK")'),
    1,
    JSON_ARRAY('Python 使用冒号和缩进表示代码块。', '没有 then 关键字。', '条件需要写在冒号前面。'),
    'Python if 语句形式为 if condition:
    body。',
    'if score >= 60:
    print("及格")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    452,
    31,
    '缩进的重要性',
    '为什么在 Python 中 if 语句后的代码需要缩进？',
    JSON_OBJECT('A', '为了美观', 'B', '表示代码块的范围并影响程序逻辑', 'C', '可选的，写不写都行', 'D', '仅在函数内需要缩进'),
    2,
    JSON_ARRAY('缩进决定代码的所属块。', '不正确缩进会导致语法错误。', 'Python 使用缩进而非花括号。'),
    '缩进在 Python 中用来划分代码块，错误缩进会报错或改变逻辑。',
    'if x > 0:
    print(x)
print("done") // outside block'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    453,
    31,
    '条件的真假',
    '下面哪个表达式在 if 语句中被认为为真？',
    JSON_OBJECT('A', '0', 'B', '""', 'C', '[]', 'D', '1'),
    4,
    JSON_ARRAY('0、空字符串、空容器在布尔上下文中为 False。', '非零数字通常为 True。', '可以使用 bool() 观察。'),
    '整数 1 在布尔上下文中为 True，因此 if 1: 会进入分支。',
    'if -1: print("真")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    454,
    31,
    '补全 if 结构',
    '补全代码，使其在 x 小于 10 时打印 Tiny。',
    JSON_ARRAY('x = 5'),
    JSON_ARRAY('Tiny'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 5"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Tiny\\")"}]}]}',
    JSON_ARRAY('x < 10', 'x > 10', 'x == 10', 'x != 10'),
    JSON_ARRAY(1),
    '条件 x < 10 在 x 为 5 时为真。',
    'if score < 60: print("不及格")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    455,
    31,
    '避免语法错误',
    '在下面语句中补全缺失的符号使其有效。',
    NULL,
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if x > 0 "}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"positive\\")"}]}]}',
    JSON_ARRAY(':', 'then', '{', 'end'),
    JSON_ARRAY(1),
    'Python 使用冒号 : 来开始代码块。',
    'if x == 0:
    print("zero")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    456,
    31,
    'if 与条件顺序',
    '当写多个 if 语句时，下面描述正确的是？',
    JSON_OBJECT('A', '每个 if 都会独立判断', 'B', '后面的 if 会替换前面的 if', 'C', '只有第一个为真的 if 会被执行', 'D', '多个 if 会合并为一个'),
    1,
    JSON_ARRAY('独立的 if 会逐一判断。', '若需要互斥使用 if/elif/else。', '注意逻辑控制的差异。'),
    '独立的 if 语句都会被检查并根据条件独立执行。',
    'if a:
    ...
if b:
    ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    457,
    31,
    'if/elif/else 的区别',
    'if/elif/else 结构中，elif 的作用是什么？',
    JSON_OBJECT('A', '总是执行', 'B', '在前面的 if/elif 条件都为假时才判断', 'C', '与 else 等价', 'D', '跳出函数'),
    2,
    JSON_ARRAY('elif 是 else if 的缩写。', '它是互斥分支的一部分。', '只有前面的都为假时才会被考虑。'),
    'elif 在前面的 if/elif 条件都为假时作为后续分支被判断。',
    'if x<0:
    ...
elif x==0:
    ...
else:
    ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    458,
    31,
    'if 中的复合条件',
    '以下哪个写法可以判断 x 在 1 到 10 之间？',
    JSON_OBJECT('A', 'if 1 < x and x < 10:', 'B', 'if 1 < x < 10:', 'C', 'if x > 1 and x < 10:', 'D', '以上都可以'),
    4,
    JSON_ARRAY('Python 支持链式比较。', 'and 也可组合条件。', '选择最可读的写法即可。'),
    '三种写法都能判断 x 在 (1,10) 范围内，其中链式比较最简洁。',
    '1 <= x <= 10 用于闭区间判断。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    459,
    31,
    '条件与输入',
    '补全代码：读取用户输入的数字并判断是否为正数。',
    JSON_ARRAY('输入: 3'),
    JSON_ARRAY('Positive'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "n = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if n "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Positive\\")"}]}]}',
    JSON_ARRAY('>', '<', '==', '!='),
    JSON_ARRAY(1),
    '若 n 大于 0 就是正数。',
    'n = int(input())
if n < 0: print("Negative")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    460,
    31,
    '避免缩进错误',
    '补全下面代码中的缩进，使其为合法的 if 结构。',
    NULL,
    JSON_ARRAY('OK'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if x == 1:"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": "print(\\"OK\\")"}]}]}',
    JSON_ARRAY('缩进四个空格', '不缩进', '制表符', '写在同一行'),
    JSON_ARRAY(1),
    '需要对 print 行进行缩进（通常 4 个空格或一个制表符）。',
    'if True:
    print("Yes")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    461,
    31,
    '条件表达式的简洁写法',
    '下面哪个是条件表达式（ternary）？',
    JSON_OBJECT('A', 'x = a if cond else b', 'B', 'if cond: x = a else: x = b', 'C', 'cond ? a : b', 'D', 'x = cond and a or b'),
    1,
    JSON_ARRAY('Python 使用 if-else 放在中间的形式实现三元表达式。', 'cond ? a : b 是其他语言的写法。', '注意括号与空格的使用。'),
    'Python 的条件表达式为 a if condition else b。',
    'sign = "+" if x>=0 else "-"'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    462,
    31,
    'if 中的逻辑短路',
    '在 if 条件中包含 and/or 时会发生什么？',
    JSON_OBJECT('A', '会总是评估所有子表达式', 'B', '可能短路以避免评估右侧表达式', 'C', '会报错', 'D', '会把表达式转成字符串再比较'),
    2,
    JSON_ARRAY('and/or 有短路求值特性。', '这会影响副作用（如函数调用）。', '可用括号明确求值顺序。'),
    'and/or 会短路求值，根据左侧值可决定是否计算右侧。',
    'if user and user.is_active: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    463,
    31,
    'if 的常见错误',
    '下面哪种写法会导致语法错误？',
    JSON_OBJECT('A', 'if x = 1:', 'B', 'if x == 1:', 'C', 'if (x == 1):', 'D', 'if x in [1]:'),
    1,
    JSON_ARRAY('单个 = 是赋值，不可在 if 条件中使用。', '比较要用 ==。', '圆括号在 Python 中是可选的。'),
    'if 中使用 = 会导致语法错误，应使用 == 比较相等。',
    'if name == "Tom": print("Hi")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    464,
    31,
    '分支输出练习',
    '补全代码使其根据温度输出 Cold/Hot。',
    JSON_ARRAY('t = 25'),
    JSON_ARRAY('Hot'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "t = 25"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if t < 20:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Cold\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('"Hot"', '"Cool"', '"Warm"', '"OK"'),
    JSON_ARRAY(1),
    '温度 25 >= 20，应输出 Hot。',
    'if score >= 60: print("Pass") else: print("Fail")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    465,
    31,
    '互斥分支练习',
    '补全代码，确保只会输出一个等级。',
    JSON_ARRAY('score = 85'),
    JSON_ARRAY('B'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "score = 85"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if score >= 90:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"A\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "elif score >= 80:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"C\\")"}]}]}',
    JSON_ARRAY('"A"', '"B"', '"C"', '"D"'),
    JSON_ARRAY(2),
    '85 在 80–89 间，应输出 B。',
    'elif 链可以实现互斥分支判断。'
);