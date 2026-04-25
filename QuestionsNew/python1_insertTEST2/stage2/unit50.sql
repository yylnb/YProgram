USE `questions`;
-- Unit 50 | Start ID: 736
-- Generated at 2025-12-24 23:14:12

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    736, 
    50, 
    '复习：执行顺序', 
    '在 if/elif/else 链中，什么时候会执行 elif 分支？', 
    JSON_OBJECT('A', '当前面条件都为 False 且该条件为 True', 'B', '只要该条件为 True 就执行，无视前面', 'C', '只执行第一个条件', 'D', '只在 else 后执行'), 
    1, 
    JSON_ARRAY('elif 只有在前面条件不成立时才被考虑', '按顺序依次判断'), 
    'elif 在前面的 if/elif 条件都不成立时才会被评估和执行。', 
    'if a: ...
elif b: ...
else: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    737, 
    50, 
    '复习：and/or 的短路', 
    '表达式 A and B 在 A 为 False 时是否会计算 B？', 
    JSON_OBJECT('A', '不会（短路）', 'B', '会计算', 'C', '视情况而定', 'D', '会抛出异常'), 
    1, 
    JSON_ARRAY('and 为短路运算符', '左为 False 时整体为 False'), 
    'and 遇到左操作为 False 时不会求右操作。', 
    'x and func() 当 x 为 False 时 func 不被调用'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    738, 
    50, 
    '复习：not 的返回类型', 
    'not x 返回的类型通常为？', 
    JSON_OBJECT('A', 'bool', 'B', '与 x 相同', 'C', 'str', 'D', 'int'), 
    1, 
    JSON_ARRAY('not 会把表达式转换为布尔值并取反'), 
    'not 运算符将表达式转换为布尔并返回布尔值。', 
    'not [] -> True'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    739,
    50,
    '复习：链式比较',
    '补全：判断 x 在 0 到 5 之间。',
    'x=3',
    JSON_ARRAY('OK'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if 0 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " x "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 5:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"OK\")"}]}]}',
    JSON_ARRAY('<', '<=', '>', '>='),
    JSON_ARRAY(1, 1),
    '链式比较写作 0 < x < 5。',
    'if 1 <= n <= 10: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    740,
    50,
    '复习：in 的用法',
    '补全：检查子串是否存在。',
    's="python"; sub="py"',
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(sub "}, {"type": "slot", "index": 0}, {"type": "code", "value": " s)"}]}]}',
    JSON_ARRAY('in', 'not in', '==', 'is'),
    JSON_ARRAY(1),
    '使用 in 检查子串存在。',
    '"a" in "abc"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    741, 
    50, 
    '复习：字符串比较', 
    '"a" < "b" 在 Python 中结果为？', 
    JSON_OBJECT('A', 'True', 'B', 'False', 'C', '报错', 'D', '取决于编码'), 
    1, 
    JSON_ARRAY('按字典序比较', '基于 Unicode 编码'), 
    '字符串按字典序比较，"a" 在 "b" 之前。', 
    '"apple" < "banana"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    742, 
    50, 
    '复习：strip 用途', 
    'strip 的主要用途是？', 
    JSON_OBJECT('A', '去除两端空白', 'B', '拆分字符串', 'C', '替换字符', 'D', '统计频率'), 
    1, 
    JSON_ARRAY('用于清洗输入', '不影响中间空白'), 
    'strip 去除两端空白，常用于处理用户输入。', 
    's.strip()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    743, 
    50, 
    '复习：默认值技巧', 
    '用 or 提供默认值的效果是？', 
    JSON_OBJECT('A', '在左假值时返回右侧', 'B', '在左真值时返回右侧', 'C', '总是返回布尔值', 'D', '抛出异常'), 
    1, 
    JSON_ARRAY('or 返回第一个真值或最后一项'), 
    'a or b 会返回 a（若真）否则返回 b，常用于默认值表达式。', 
    'username = input() or "guest"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    744,
    50,
    '复习：isdigit 的用途',
    '补全：判断 s 是否为纯数字字符串。',
    's="123"',
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "())"}]}]}',
    JSON_ARRAY('isdigit', 'isalpha', 'isalnum', 'isnumeric'),
    JSON_ARRAY(1),
    'isdigit 用于检测数字字符（注意 Unicode 的差异）。',
    'if s.isdigit(): n=int(s)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    745,
    50,
    '复习：find 与 index 的区别',
    '补全：find 找不到时返回 -1 而 index 会抛出异常。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "pos = s.find(\"x\")"}, {"type": "code_line", "value": "if pos == -1:"}, {"type": "code_line", "value": "    print(\"not found\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    'find 返回索引或 -1，index 找不到会抛 ValueError。',
    's.find("a")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    746, 
    50, 
    '复习：any 的含义', 
    'any([False, True, False]) 的结果是？', 
    JSON_OBJECT('A', 'True', 'B', 'False', 'C', '抛出异常', 'D', 'None'), 
    1, 
    JSON_ARRAY('any 有任一真值则为 True'), 
    'any 返回 True 因为列表中有 True 项。', 
    'any([]) -> False'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    747, 
    50, 
    '复习：all 的含义', 
    'all([True, True]) 的结果是？', 
    JSON_OBJECT('A', 'True', 'B', 'False', 'C', '抛出异常', 'D', 'None'), 
    1, 
    JSON_ARRAY('all 只有全为真才 True'), 
    'all 返回 True，因为所有元素为真。', 
    'all([1,2]) -> True'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    748, 
    50, 
    '复习：短路与副作用', 
    '若右侧是函数调用且左侧短路，是否会调用右侧？', 
    JSON_OBJECT('A', '不会调用', 'B', '会调用', 'C', '有时会', 'D', '取决于函数返回值'), 
    1, 
    JSON_ARRAY('短路会阻止右侧求值', '注意副作用函数的位置'), 
    '短路会避免对右侧表达式求值，因此副作用不会发生。', 
    'False and print("hi") 不会打印'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    749,
    50,
    '复习：strip 与 rstrip 区别',
    '补全：rstrip 只去除字符串的哪一侧空白？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = \" a \\n\""}, {"type": "code_line", "value": "print(s.rstrip())"}]}]}',
    JSON_ARRAY('右侧', '左侧', '两侧', '中间'),
    JSON_ARRAY(1),
    'rstrip 只去除右侧空白。',
    's.rstrip("\n")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    750,
    50,
    '复习：默认值写法',
    '补全：用 or 提供默认值的表达式。',
    's=""',
    JSON_ARRAY('guest'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(s or \"guest\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    's or "guest" 在 s 为空时返回 "guest"。',
    'name = input() or "guest"'
);