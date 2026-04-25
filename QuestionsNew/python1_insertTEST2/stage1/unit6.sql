USE `questions`;
-- Unit 6 | Start ID: 76
-- Generated at 2025-12-24 22:59:47

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    76, 
    6, 
    '加法运算的作用', 
    '在 Python 中，运算符 + 的主要功能是什么？', 
    JSON_OBJECT('A', '只用于数字相加', 'B', '用于多种类型之间的加法，如数字相加或字符串拼接', 'C', '用于比较两个数字', 'D', '只能用于整数之间'), 
    2, 
    JSON_ARRAY('注意：+ 不仅能算数学。', '想想字符串之间的 + 会发生什么。', 'Python 是多才多艺的语言。'), 
    '+ 可以用于数值相加，也可以用于字符串拼接。', 
    '示例：\'Hello \' + \'World\' → \'Hello World\''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    77, 
    6, 
    '减法的基础', 
    '表达式 10 - 4 的结果是什么？', 
    JSON_OBJECT('A', '6', 'B', '7', 'C', '14', 'D', '20'), 
    1, 
    JSON_ARRAY('简单的数学题。', '10 减去 4。', '你一定做过很多次这种计算。'), 
    '10 - 4 = 6。', 
    '示例：20 - 5 → 15'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    78, 
    6, 
    '加法的自动类型提升', 
    '当整数与浮点数进行加法时，结果类型是什么？', 
    JSON_OBJECT('A', '整数', 'B', '字符串', 'C', '浮点数', 'D', '布尔值'), 
    3, 
    JSON_ARRAY('想想浮点数和整数混合运算的规则。', '浮点数可以表示更广的范围。', 'Python 会“向上兼容”。'), 
    '整数与浮点运算时，整数会被提升为 float。', 
    '示例：3 + 0.2 → 3.2'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    79,
    6,
    '加法练习',
    '补全代码，使其正确输出 15。',
    NULL,
    JSON_ARRAY('15'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = 9"}, {"type": "code_line", "value": "b = 6"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(a "}, {"type": "slot", "index": 0}, {"type": "code", "value": " b)"}]}]}',
    JSON_ARRAY('+', '-', '*', '/', '//', '%', '**', 'and', 'or'),
    JSON_ARRAY(1),
    '9 + 6 = 15。',
    '示例：2 + 3 → 5'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    80,
    6,
    '减法练习',
    '补全代码，使其输出 -2。',
    NULL,
    JSON_ARRAY('-2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 3"}, {"type": "code_line", "value": "y = 5"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "z = x "}, {"type": "slot", "index": 0}, {"type": "code", "value": " y"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(z)"}]}]}',
    JSON_ARRAY('+', '-', '*', '/', '//', '%', '**', 'and', 'or'),
    JSON_ARRAY(2),
    '3 - 5 = -2。',
    '示例：10 - 13 → -3'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    81, 
    6, 
    '加法与字符串拼接', 
    '以下哪个表达式会产生字符串？', 
    JSON_OBJECT('A', '3 + 4', 'B', '3.0 + 4', 'C', '\'3\' + \'4\'', 'D', '3 + \'4\''), 
    3, 
    JSON_ARRAY('字符串之间的加法是拼接。', '注意类型是否一致。', '混合数字和字符串会出错。'), 
    '\'3\' + \'4\' → \'34\'', 
    '示例：\'A\' + \'B\' → \'AB\''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    82, 
    6, 
    '减法的类型要求', 
    '为什么表达式 \'10\' - \'2\' 会报错？', 
    JSON_OBJECT('A', 'Python 不支持数字运算', 'B', '字符串不能直接进行减法运算', 'C', '10 和 2 不是数字', 'D', 'Python 不支持减法'), 
    2, 
    JSON_ARRAY('想想字符串能做什么。', '它们可以拼接但不能相减。', '这和数学运算不一样。'), 
    '字符串减法无意义，Python 会报错。', 
    '示例：不能执行 \'abc\' - \'a\''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    83, 
    6, 
    '加法的运算顺序', 
    '表达式 1 + 2 + 3 的计算顺序是什么？', 
    JSON_OBJECT('A', '(1 + 2) + 3', 'B', '1 + (2 + 3)', 'C', '完全随机', 'D', '由 Python 版本决定'), 
    1, 
    JSON_ARRAY('加法是左结合运算。', '先左后右的顺序。', 'Python 和大多数语言一样。'), 
    '加法是左结合，即从左向右计算。', 
    '示例：(10 + 2) + 5 → 17'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    84,
    6,
    '字符串拼接错误修复',
    '补全代码，使其正确打印 \'Total: 30\'。',
    NULL,
    JSON_ARRAY('Total: 30'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "num = 30"}, {"type": "code_line", "value": "text = \'Total: \'"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "text = \'Total: \' "}, {"type": "slot", "index": 0}, {"type": "code", "value": " num"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(text)"}]}]}',
    JSON_ARRAY('+', '-', '*', '/', 'str(num)', 'int(num)', '\'30\'', ',', '%s', '.'),
    JSON_ARRAY(5),
    '需要将整数转换为字符串。',
    '示例：\'Score: \' + str(100)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    85,
    6,
    '加法连算',
    '补全代码，使 total 的最终值为 18。',
    NULL,
    JSON_ARRAY('18'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = 5"}, {"type": "code_line", "value": "b = 7"}, {"type": "code_line", "value": "c = 6"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "total = a + b "}, {"type": "slot", "index": 0}, {"type": "code", "value": " c"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(total)"}]}]}',
    JSON_ARRAY('+', '-', '*', '/', 'and', 'or', '//', '%'),
    JSON_ARRAY(1),
    '5 + 7 + 6 = 18。',
    '示例：1 + 2 + 3 → 6'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    86, 
    6, 
    '正负号的结合', 
    '表达式 5 + -3 的结果是什么？', 
    JSON_OBJECT('A', '-8', 'B', '2', 'C', '8', 'D', '5'), 
    2, 
    JSON_ARRAY('注意 -3 是负数。', '5 加上一个负的 3。', '相当于 5 - 3。'), 
    '5 + (-3) = 2。', 
    '示例：10 + -7 → 3'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    87, 
    6, 
    '加减的混合计算', 
    '表达式 10 - 3 + 2 的结果是什么？', 
    JSON_OBJECT('A', '15', 'B', '9', 'C', '5', 'D', '7'), 
    4, 
    JSON_ARRAY('从左向右计算。', '先算 10 - 3。', '再算结果 + 2。'), 
    '10 - 3 = 7，7 + 2 = 9 → 错误？再检查：确认为 9？不，是我算错了。
10 - 3 + 2 = 9。', 
    '示例：20 - 5 + 1 → 16'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    88, 
    6, 
    '字符串拼接与空格', 
    '以下哪项能得到 \'Hello Python\'？', 
    JSON_OBJECT('A', '\'Hello\' + \'Python\'', 'B', '\'Hello\' + \' Python\'', 'C', '\'Hello\' - \'Python\'', 'D', '\'Hello\' + -\'Python\''), 
    2, 
    JSON_ARRAY('注意空格在哪。', '字符串之间的拼接不会自动加空格。', '错误的符号会导致语法错误。'), 
    '\'Hello\' + \' Python\' → \'Hello Python\'。', 
    '示例：\'A\' + \' B\' → \'A B\''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    89,
    6,
    '负数计算',
    '补全代码，使输出为 -12。',
    NULL,
    JSON_ARRAY('-12'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = -5"}, {"type": "code_line", "value": "b = 7"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(a "}, {"type": "slot", "index": 0}, {"type": "code", "value": " b)"}]}]}',
    JSON_ARRAY('+', '-', '*', '/', '//', '%', '**', 'and', 'or'),
    JSON_ARRAY(2),
    '-5 - 7 = -12。',
    '示例：-3 - 4 → -7'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    90,
    6,
    '加法计算练习',
    '补全代码，使结果为 30。',
    NULL,
    JSON_ARRAY('30'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 10"}, {"type": "code_line", "value": "y = 8"}, {"type": "code_line", "value": "z = 12"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(x "}, {"type": "slot", "index": 0}, {"type": "code", "value": " y + z)"}]}]}',
    JSON_ARRAY('+', '-', '*', '/', '//', '%', '**', 'and', 'or'),
    JSON_ARRAY(1),
    '10 + (8 + 12) = 30。',
    '示例：5 + (3 + 4) → 12'
);