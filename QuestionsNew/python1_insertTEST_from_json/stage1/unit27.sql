USE `questions`;
-- Unit 27 | Start ID: 391
-- Generated at 2025-12-25 17:41:13

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    391,
    27,
    'and 的含义',
    '在布尔表达式中，a and b 表示什么？',
    JSON_OBJECT('A', '只要 a 或 b 为真就为真', 'B', '只有 a 与 b 都为真时为真', 'C', '表示 a 后接 b 的顺序执行', 'D', '将 a 与 b 相加'),
    2,
    JSON_ARRAY('and 是逻辑且。', '两个条件都必须满足。', '常用于多重条件判断。'),
    'and 要求两个子表达式都为 True，整体才为 True。',
    'True and False 返回 False；True and True 返回 True。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    392,
    27,
    'or 的含义',
    '哪个描述适用于 a or b？',
    JSON_OBJECT('A', '必须两个都为真', 'B', '至少一个为真则为真', 'C', '总是返回 False', 'D', '只检查 a，不看 b'),
    2,
    JSON_ARRAY('or 是逻辑或。', '只要有一个为真。', '常用于默认值选择。'),
    'or 在两个子表达式中只要有一个为 True 则整体为 True。',
    'False or True 返回 True。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    393,
    27,
    'not 的作用',
    '表达式 not x 会得到什么结果？',
    JSON_OBJECT('A', '将 x 设置为 True', 'B', '将布尔值取反', 'C', '把 x 从内存中删除', 'D', '把 x 转为字符串'),
    2,
    JSON_ARRAY('not 用于取反。', '常用于否定条件。', 'not True 为 False。'),
    'not 用来对布尔值取反，not True 为 False，not False 为 True。',
    'not (3 > 5) 等于 True。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    394,
    27,
    '短路行为（and）',
    '利用 and 的短路行为补全代码。',
    NULL,
    JSON_ARRAY('第二个表达式未执行'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def foo():"}, {"type": "code_line", "value": "    print(\\"执行\\")"}, {"type": "code_line", "value": "    return True"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "result = False and foo()"}]}]}',
    JSON_ARRAY('描述: foo 不会执行', '描述: foo 会执行'),
    JSON_ARRAY(1),
    'and 左侧为 False 时短路，右侧不再求值。',
    'False and anything 不会调用右侧函数。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    395,
    27,
    '短路行为（or）',
    '利用 or 的短路行为补全代码。',
    NULL,
    JSON_ARRAY('第一项为真时第二项不执行'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def bar():"}, {"type": "code_line", "value": "    print(\\"被调用\\")"}, {"type": "code_line", "value": "    return False"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "result = True or bar()"}]}]}',
    JSON_ARRAY('描述: bar 不会执行', '描述: bar 会执行'),
    JSON_ARRAY(1),
    'or 左侧为 True 时短路，右侧不再求值。',
    'True or func() 不会调用 func。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    396,
    27,
    'and/or 返回值',
    '在 Python 中，表达式 a and b 的返回值是什么？',
    JSON_OBJECT('A', '总是布尔值 True/False', 'B', '不是布尔值，而是其中一个操作数的原始值', 'C', '总是 None', 'D', '总是整型 0 或 1'),
    2,
    JSON_ARRAY('and/or 会返回操作数本身，而非强制布尔化。', '例如: "" and 5 返回 ""。', '注意与许多语言的差异。'),
    'Python 中 and/or 返回操作数之一（短路结果），不一定是布尔值。',
    '"" and 5 返回 ""，0 or 7 返回 7。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    397,
    27,
    'not 优先级',
    '在表达式 not a and b 中，哪个运算先执行？',
    JSON_OBJECT('A', 'not 先于 and', 'B', 'and 先于 not', 'C', '按从左到右顺序无优先级', 'D', '会报语法错误'),
    1,
    JSON_ARRAY('not 是一元运算符，优先级高于 and。', '可以用括号改变顺序。', '阅读运算符优先级表。'),
    'not 的优先级高于 and，因此 not a 会先被求值。',
    'not True and False 等价于 (not True) and False。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    398,
    27,
    '混合使用 and/or',
    '以下哪项描述正确： True or False and False',
    JSON_OBJECT('A', '先计算 or 再计算 and', 'B', '先计算 and 再计算 or', 'C', '从左到右严格顺序', 'D', '需要括号才可执行'),
    2,
    JSON_ARRAY('and 的优先级高于 or。', '先算 and，再算 or。', '同样可用括号明确意图。'),
    'and 优先级高于 or，因此会先计算 False and False，结果为 False，整体为 True or False → True。',
    'True or False and False → True。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    399,
    27,
    '逻辑组合判断',
    '补全使条件通过。',
    JSON_ARRAY('x = 5'),
    JSON_ARRAY('OK'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 5"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if x > 0 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " x < 10:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"OK\\")"}]}]}',
    JSON_ARRAY('and', 'or', 'not', '=='),
    JSON_ARRAY(1),
    '需要同时满足大于 0 且小于 10，使用 and。',
    'if 1 < x and x < 5: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    400,
    27,
    '否定条件',
    '补全代码使得当 flag 为 False 时打印信息。',
    JSON_ARRAY('flag = False'),
    JSON_ARRAY('需要操作'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "flag = False"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": " flag:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"需要操作\\")"}]}]}',
    JSON_ARRAY('not', 'and', 'or', '=='),
    JSON_ARRAY(1),
    'not flag 在 flag 为 False 时为 True，会进入分支。',
    'if not done: print("继续")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    401,
    27,
    '默认值选择技巧',
    '下面哪种用法常用于给变量设置默认值？',
    JSON_OBJECT('A', 'value = user_input and default', 'B', 'value = user_input or default', 'C', 'value = not user_input', 'D', 'value = user_input + default'),
    2,
    JSON_ARRAY('or 会在左侧为假时返回右侧。', '常用来选择默认值。', '如 user_input 为空字符串或 None。'),
    'value = user_input or default 在 user_input 为假时会取 default，常用于默认值选择。',
    'name = input() or "匿名"'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    402,
    27,
    '逻辑表达式的短路副作用',
    '若 a 为真且 b 有副作用（如打印），下面哪项正确？',
    JSON_OBJECT('A', 'a and b 会执行 b 并产生副作用', 'B', 'a or b 会执行 b 并产生副作用', 'C', '如果 a 为真，a or b 不会执行 b', 'D', '逻辑运算永远不会短路'),
    3,
    JSON_ARRAY('or 在左侧为真时短路。', 'and 在左侧为假时短路。', '短路意味着右侧不再求值。'),
    '当 a 为真时，a or b 会短路，不会评估 b，从而不会触发 b 的副作用。',
    'True or print("hi") 不会打印。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    403,
    27,
    '优先级与括号',
    '如何强制改变逻辑表达式的计算顺序？',
    JSON_OBJECT('A', '使用分号 ;', 'B', '使用括号 ()', 'C', '改变变量名', 'D', '不能改变'),
    2,
    JSON_ARRAY('括号可以改变运算顺序。', '这是控制逻辑优先级的常用方法。', '比阅读默认优先级更直观。'),
    '使用括号可以明确先计算哪部分表达式，避免歧义。',
    '(a or b) and c 与 a or (b and c) 含义不同。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    404,
    27,
    '复合条件填空',
    '补全使其在字符串非空且长度小于 10 时输出 OK。',
    JSON_ARRAY('s = "hello"'),
    JSON_ARRAY('OK'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = \\"hello\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if s "}, {"type": "slot", "index": 0}, {"type": "code", "value": " len(s) < 10:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"OK\\")"}]}]}',
    JSON_ARRAY('and', 'or', 'not', '=='),
    JSON_ARRAY(1),
    '需要同时满足 s 非空（真）并且长度小于 10，使用 and。',
    'if s and len(s) < 5: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    405,
    27,
    '逻辑与默认值组合',
    '用 or 给变量设置默认字符串。',
    JSON_ARRAY('user = ""'),
    JSON_ARRAY('匿名'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "user = \\"\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "name = user "}, {"type": "slot", "index": 0}, {"type": "code", "value": " \\"匿名\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(name)"}]}]}',
    JSON_ARRAY('and', 'or', 'not', '+'),
    JSON_ARRAY(2),
    'user or "匿名" 会在 user 为空（假）时返回 "匿名"，常用于默认值。',
    'value = env_var or "default"'
);