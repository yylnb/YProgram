USE `questions`;
-- Unit 39 | Start ID: 571
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    571,
    39,
    '三元表达式形式',
    'Python 中三元表达式的正确写法是？',
    JSON_OBJECT('A', 'a if cond else b', 'B', 'cond ? a : b', 'C', 'a ?: b', 'D', 'if cond then a else b'),
    1,
    JSON_ARRAY('Python 使用 if ... else 放中间', '不是 C 风格语法', '返回两者之一'),
    'Python 的三元为 a if cond else b，先写结果再写条件。',
    'x = "yes" if flag else "no"'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    572,
    39,
    '短写的注意点',
    '下面哪种情况不适合用三元表达式？',
    JSON_OBJECT('A', '简单的分支赋值', 'B', '复杂多行逻辑', 'C', '单行默认值', 'D', '条件返回不同常量'),
    2,
    JSON_ARRAY('可读性优先', '三元适合简短表达', '复杂逻辑应使用 if 块'),
    '复杂多行逻辑应使用常规 if/else，保持可读性。',
    'if heavy: ... else: ... 更清晰'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    573,
    39,
    '三元返回值类型',
    '三元表达式两侧返回值类型最好如何？',
    JSON_OBJECT('A', '最好相同或兼容', 'B', '必须相同', 'C', '必须不同', 'D', '无所谓'),
    1,
    JSON_ARRAY('避免类型混乱', '提升后续处理方便', '兼容性最重要'),
    '两侧返回类型最好相同或兼容，避免后续使用出错。',
    'x = 1 if ok else 0'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    574,
    39,
    '用三元表达式赋值',
    '补全：根据输入决定是否使用默认值。',
    JSON_ARRAY('s=""'),
    JSON_ARRAY('guest'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "name = s "}, {"type": "slot", "index": 0}, {"type": "code", "value": " s else \\"guest\\""}]}]}',
    JSON_ARRAY('if', 'or', 'and', '!='),
    JSON_ARRAY(1),
    '正确写法为 name = s if s else "guest"。',
    'mode = "r" if read else "w"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    575,
    39,
    '短表达式的副作用',
    '补全：避免在三元中调用副作用函数。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "res = func1() if cond else "}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}]}',
    JSON_ARRAY('func2', 'print', 'None', 'func3'),
    JSON_ARRAY(1),
    '尽量不要在三元表达式中包含复杂或带副作用的函数调用。',
    'use separate if for complex calls'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    576,
    39,
    '可读性优先',
    '当三元表达式长度过长，应如何处理？',
    JSON_OBJECT('A', '改为普通 if/else', 'B', '继续写在一行', 'C', '用逗号分隔', 'D', '用 lambda 嵌套'),
    1,
    JSON_ARRAY('可读性很重要', '写多行更清晰', '避免巧妙但难懂的单行表达'),
    '当表达式过长时，使用普通的 if/else 更清晰。',
    'if cond:
    res = a
else:
    res = b'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    577,
    39,
    '三元与列表推导',
    '下面哪个可以在列表推导中使用三元表达式？',
    JSON_OBJECT('A', '[x if cond else y for x in seq]', 'B', '[if cond: x else: y for x in seq]', 'C', '[cond ? x : y for x in seq]', 'D', '不可以在推导中使用'),
    1,
    JSON_ARRAY('Python 支持在推导里用三元', '语法为 x if cond else y', '常用于基于条件变换序列'),
    '在列表推导中使用三元表达式可以实现条件映射。',
    '[n if n%2==0 else 0 for n in nums]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    578,
    39,
    '简写的限制',
    '三元表达式能否替代复杂的分支逻辑？',
    JSON_OBJECT('A', '不建议替代复杂分支', 'B', '永远可以替代', 'C', '只能在函数中使用', 'D', '只能在表达式中使用'),
    1,
    JSON_ARRAY('复杂分支影响可读性', '三元适合简单情况', '清晰比简洁重要'),
    '复杂分支应使用标准 if/else 来保持代码清晰。',
    'use if for multi-step logic'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    579,
    39,
    '嵌套三元的风险',
    '补全：避免嵌套三元，示意替换为 if。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "res = a if cond1 else (b if cond2 else c)"}, {"type": "code_line", "value": "# 推荐改写为"}, {"type": "code_line", "value": "if cond1:"}, {"type": "code_line", "value": "    res = a"}, {"type": "code_line", "value": "elif cond2:"}, {"type": "code_line", "value": "    res = b"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    res = c"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    '嵌套三元可读性差，应改写为 if/elif/else。',
    '见上方改写示例'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    580,
    39,
    '用三元设置格式',
    '补全：根据分数显示等级字符串。',
    JSON_ARRAY('score=85'),
    JSON_ARRAY('Pass'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "score = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "status = \\"Pass\\" if score >= 60 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " \\"Fail\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(status)"}]}]}',
    JSON_ARRAY('else', 'then', 'than', ','),
    JSON_ARRAY(1),
    '三元表达式写法为 A if cond else B。',
    'level = "A" if s>90 else "B"'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    581,
    39,
    '三元与副作用',
    '在三元中调用函数会怎样？',
    JSON_OBJECT('A', '会在被选分支上调用', 'B', '总会调用两边', 'C', '永不调用', 'D', '导致语法错误'),
    1,
    JSON_ARRAY('只有被选分支会被求值', '不会调用另一侧'),
    '三元表达式只会求值被选中的那一侧，因此只有那个分支的函数会被调用。',
    'f() if cond else g()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    582,
    39,
    '表达式求值顺序',
    '在 a if cond else b 中，cond 在何时求值？',
    JSON_OBJECT('A', '先求 cond，再根据结果求 a 或 b', 'B', '先求 a，再求 cond', 'C', '同时求', 'D', '先求 b'),
    1,
    JSON_ARRAY('cond 决定选择哪侧', '先判断条件', '只有一侧会被求值'),
    'cond 先被求值，根据真假决定只求值 a 或 b。',
    'x = val if check() else other'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    583,
    39,
    '风格指南建议',
    'PEP8 对三元表达式的建议是什么？',
    JSON_OBJECT('A', '保持简短且可读', 'B', '尽可能嵌套', 'C', '尽量用一行实现所有逻辑', 'D', '禁止使用'),
    1,
    JSON_ARRAY('注重可读性', '简洁优于复杂一行', '遵循团队规范'),
    'PEP8 强调可读性，建议三元表达式保持简短易懂。',
    '避免复杂嵌套的三元'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    584,
    39,
    '三元表达式在字典推导中',
    '补全：在字典推导中使用三元为值选择分支。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "d = {k: (v if v>0 else 0) for k,v in items}"}, {"type": "code_line", "value": "print(d)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    '在推导中三元可用于选择值，语法与列表推导相同。',
    'kv pairs -> {k: v if cond else w for ...}'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    585,
    39,
    '实践练习：短条件赋值',
    '补全：根据 flag 选择函数返回值。',
    JSON_ARRAY('flag=True'),
    JSON_ARRAY('A'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def a():"}, {"type": "code_line", "value": "    return \\"A\\""}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "def b():"}, {"type": "code_line", "value": "    return \\"B\\""}, {"type": "code_line", "value": ""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "res = a() if flag "}, {"type": "slot", "index": 0}, {"type": "code", "value": " b()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(res)"}]}]}',
    JSON_ARRAY('else', 'then', 'or', 'and'),
    JSON_ARRAY(1),
    '三元中使用 else 连接两分支。',
    'res = func1() if cond else func2()'
);