USE `questions`;
-- Unit 38 | Start ID: 556
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    556,
    38,
    'and 的短路特性',
    '表达式中 if a() and b(): 当 a() 返回 False 时会怎样？',
    JSON_OBJECT('A', '不会调用 b()', 'B', '仍然调用 b()', 'C', '语法错误', 'D', '取决于 a() 的类型'),
    1,
    JSON_ARRAY('and 是短路运算', '左侧为 False 时整体为 False', '右侧不会被求值'),
    'and 在左侧为 False 时不会求右侧，称为短路求值。',
    'if x and func(): ... 当 x 为 False 时 func() 不被调用'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    557,
    38,
    'or 与布尔返回',
    '表达式 a or b 返回什么？',
    JSON_OBJECT('A', '第一个真值表达式', 'B', '总是布尔值', 'C', '总是 a 的值', 'D', '总是 b 的值'),
    1,
    JSON_ARRAY('or 返回第一个真值或最后一项', '不是强制转换为 bool', '常用于默认值'),
    'or 返回第一个真值表达式的原始值，若无则返回最后一项。',
    'name or "guest" 在 name 为空时返回 "guest"'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    558,
    38,
    'not 的作用',
    'not x 的返回值类型通常是？',
    JSON_OBJECT('A', 'bool', 'B', '与 x 相同类型', 'C', 'str', 'D', 'int'),
    1,
    JSON_ARRAY('not 会把表达式转换为布尔并取反', '返回 True/False', '用于条件判断'),
    'not 运算符将表达式转换为布尔值并取反，返回 bool。',
    'not [] → True，因为 [] 为假值'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    559,
    38,
    '复合条件的写法',
    '补全：要求变量 x 在 1 到 10 之间（含）。',
    JSON_ARRAY('x=5'),
    JSON_ARRAY('In range'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if 1 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " x "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 10:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"In range\\")"}]}]}',
    JSON_ARRAY('>', '<', '>=', '<=', '==', 'and', 'or'),
    JSON_ARRAY(4, 4),
    '使用 1 <= x <= 10 的链式比较来判断范围。',
    'if 0 <= a <= 100: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    560,
    38,
    '使用 or 提供默认值',
    '补全：当 user_input 为空时用 "n/a" 作为默认。',
    JSON_ARRAY('user_input=""'),
    JSON_ARRAY('n/a'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "s = user_input "}, {"type": "slot", "index": 0}, {"type": "code", "value": " \\"n/a\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(s)"}]}]}',
    JSON_ARRAY('and', 'or', 'if', '?:', '??'),
    JSON_ARRAY(2),
    'or 可用于短路返回第一个真值，用于默认值表达式。',
    'name = input() or "guest"'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    561,
    38,
    '优先级问题',
    '下列运算符优先级最高？',
    JSON_OBJECT('A', 'not', 'B', 'and', 'C', 'or', 'D', '=='),
    1,
    JSON_ARRAY('not 优先于 and/or', '比较运算优先级靠前', '可以用括号改变顺序'),
    'not 的优先级高于 and、or，通常先计算 not。',
    'not a and b 相当于 (not a) and b'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    562,
    38,
    '短路与函数副作用',
    '若 b() 有副作用，下面哪个能避免调用 b()？',
    JSON_OBJECT('A', 'if a: b()', 'B', 'if a and b(): pass', 'C', 'b() if a else None', 'D', 'a or b()'),
    1,
    JSON_ARRAY('直接用条件语句控制调用', 'and 在左为 False 时不调用右侧', 'or 在左为真时不调用右侧'),
    '使用 if a: b() 仅在 a 为真时才调用 b()，逻辑表达式可能因短路而产生不同调用时机。',
    'if ready: start()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    563,
    38,
    '链式比较',
    '表达式 1 < x < 5 等价于？',
    JSON_OBJECT('A', '1 < x and x < 5', 'B', '(1 < x) < 5', 'C', 'x > 1 or x < 5', 'D', '语法错误'),
    1,
    JSON_ARRAY('链式比较在 Python 中有效', '等价于两次比较并用 and 连接', '不会重复计算中间值'),
    '1 < x < 5 等价于 1 < x and x < 5，且只会计算 x 一次。',
    '0 <= n <= 10'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    564,
    38,
    '组合条件的简写',
    '补全：判断 ch 是否为元音字母（忽略大小写）。',
    JSON_ARRAY('ch="A"'),
    JSON_ARRAY('vowel'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "ch = input().lower()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if ch "}, {"type": "slot", "index": 0}, {"type": "code", "value": " \\"aeiou\\":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"vowel\\")"}]}]}',
    JSON_ARRAY('in', 'not in', '==', 'is'),
    JSON_ARRAY(1),
    '使用 in 检查字符是否在字符串集合中。',
    'if c in "0123456789": ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    565,
    38,
    '多条件验证',
    '补全：要求 a 为正且为偶数。',
    JSON_ARRAY('a=4'),
    JSON_ARRAY('OK'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if a > 0 and a "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 2 == 0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"OK\\")"}]}]}',
    JSON_ARRAY('%', '//', '/', '*'),
    JSON_ARRAY(1),
    '用 a % 2 == 0 判断偶数。',
    'if n > 0 and n % 2 == 0: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    566,
    38,
    '布尔值与整数',
    '在 Python 中 True 与 1 比较时结果如何？',
    JSON_OBJECT('A', 'True == 1 为 True', 'B', 'True == 1 为 False', 'C', '抛出类型错误', 'D', '取决于 Python 版本'),
    1,
    JSON_ARRAY('bool 是 int 的子类', 'True 等于 1', 'False 等于 0'),
    '在 Python 中 bool 是 int 的子类，True == 1 为 True。',
    'True + True == 2'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    567,
    38,
    '优雅的默认逻辑',
    '下列哪个写法常用于设置默认值？',
    JSON_OBJECT('A', 'x = a or default', 'B', 'x = a and default', 'C', 'if a: x = default else x = a', 'D', 'x = default if a else a'),
    1,
    JSON_ARRAY('or 返回第一个真值', '常用于简洁地提供默认', '注意当 a 为 False 值时会被替代'),
    'x = a or default 在 a 为假值时返回 default，常作简洁默认值写法。',
    'timeout = user_timeout or 30'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    568,
    38,
    '优先使用括号',
    '为提高可读性，当混合 and/or 时建议如何做？',
    JSON_OBJECT('A', '使用括号明确分组', 'B', '省略括号以简洁', 'C', '用逗号分隔', 'D', '把条件写成单行注释'),
    1,
    JSON_ARRAY('逻辑表达式可读性重要', '括号能防止优先级误解', '团队风格需一致'),
    '混合 and/or 时加括号能提高可读性并防止优先级错误。',
    'if (a and b) or c: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    569,
    38,
    '分支短路练习',
    '补全：只在 s 不为空时调用 process(s)。',
    JSON_ARRAY('s="text"'),
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "s and "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(s)"}]}]}',
    JSON_ARRAY('process', 'print', 'len', 'strip'),
    JSON_ARRAY(1),
    '利用 and 的短路特性，s 为真时才会调用 process(s)。',
    's and print(s)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    570,
    38,
    '复杂条件拆分',
    '补全：将复杂条件拆成两步以提高可读性。',
    JSON_ARRAY('a=5;b=10'),
    JSON_ARRAY('OK'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = int(input())"}, {"type": "code_line", "value": "b = int(input())"}, {"type": "code_line", "value": "cond = a > 0 and b > 0 and a + b > 10"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"OK\\")"}]}]}',
    JSON_ARRAY('cond', 'a + b > 10', 'a and b', 'True'),
    JSON_ARRAY(1),
    '先计算 cond 再在 if 中使用可以提高可读性和调试性。',
    'valid = x and y
if valid: ...'
);