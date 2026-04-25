USE `questions`;
-- Unit 17 | Start ID: 241
-- Generated at 2025-12-24 23:03:21

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    241, 
    17, 
    '找位置的基本用法', 
    '小王正在检查用户输入中有没有"@"符号，他使用 s.find("@")。如果找不到，会返回什么？', 
    JSON_OBJECT('A', '-1', 'B', '0', 'C', 'None', 'D', '报错'), 
    1, 
    JSON_ARRAY('find 的返回值是一个整数。', '当找不到时，它不会报错。', '找不到时的返回值是一个特殊数字，而不是 None。'), 
    'find() 找不到时返回 -1，这能让程序知道搜索失败但不中断。', 
    '例如 "hello".find("x") 会返回 -1。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    242, 
    17, 
    'replace 的基础替换逻辑', 
    '字符串 s = "hello world"，执行 s.replace("o","O") 会发生什么？', 
    JSON_OBJECT('A', '只替换第一个 o', 'B', '替换全部 o', 'C', '报错，因为大小写不同', 'D', '只替换最后一个 o'), 
    2, 
    JSON_ARRAY('replace 的默认行为不会只替换一个。', '它会替换所有匹配的部分。', '注意 replace 不会修改原字符串，而是生成新字符串。'), 
    'replace("o","O") 会把所有的 o 全部替换成 O。', 
    '例如 "banana".replace("a","A") → "bAnAnA"。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    243, 
    17, 
    'find 的起始搜索位置', 
    '执行 "pythonpython".find("py", 3) 会从哪里开始找？', 
    JSON_OBJECT('A', '从头开始', 'B', '从下标 3 开始', 'C', '从下标 2 开始', 'D', '从下标 1 开始'), 
    2, 
    JSON_ARRAY('find 可以指定起始位置。', '指定起始后会忽略之前的内容。', '下标从 0 开始计算。'), 
    'find("py", 3) 会从下标 3 开始搜索匹配。', 
    '例如 "abcabc".find("a",2) 会返回 3。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    244,
    17,
    '使用 find 找到关键字位置',
    '补全代码，找到子字符串第一次出现的位置。',
    'text = "welcome to python world"',
    JSON_ARRAY('11'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "pos = text."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"to\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(pos)"}]}]}',
    JSON_ARRAY('len', 'lower', 'upper', 'find', 'replace', '11', 'to'),
    JSON_ARRAY(4),
    'find("to") 会返回子串在字符串中的位置。',
    '例如 "abcde".find("cd") 返回 2。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    245,
    17,
    'replace 用于清理文本',
    '补全代码，把文本中的 "-" 替换成 空格。',
    's = "hello-python-world"',
    JSON_ARRAY('hello python world'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "new_s = s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": ", "}, {"type": "slot", "index": 2}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('find', 'replace', '"-"', '" "', '_', 'lower', 'upper'),
    JSON_ARRAY(2, 3, 4),
    'replace("-", " ") 就能把短横线替换为空格。',
    '例如 "a-b-c".replace("-", "_") → "a_b_c"。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    246, 
    17, 
    '复习：len 的用途', 
    'len("Python!") 的结果是什么？', 
    JSON_OBJECT('A', '5', 'B', '6', 'C', '7', 'D', '8'), 
    3, 
    JSON_ARRAY('注意每个字符都计数。', '这里包含字母和一个感叹号。', '总共是 7 个字符。'), 
    'len("Python!") → 7。', 
    'len("Hi!") → 3。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    247, 
    17, 
    '复习：lower 的作用', 
    '执行 "HeLLo".lower() 会得到什么？', 
    JSON_OBJECT('A', 'HELLO', 'B', 'hello', 'C', 'HeLLo', 'D', 'hELLo'), 
    2, 
    JSON_ARRAY('lower 会把所有字符转成小写。', '不会影响非字母字符。', '注意结果的字母必须全是小写。'), 
    'lower 会把 HeLLo 转成 hello。', 
    '"Python3".lower() → "python3"。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    248, 
    17, 
    '复习：upper 的作用', 
    '"good morning".upper() 的结果是什么？', 
    JSON_OBJECT('A', 'GOOD MORNING', 'B', 'Good Morning', 'C', 'GOOD morning', 'D', 'good MORNING'), 
    1, 
    JSON_ARRAY('upper 会把所有字母变成大写。', '它不做智能标题化（不是 capital）。', '空格不影响大小写。'), 
    'upper → 全部大写。', 
    '"hi".upper() → "HI"。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    249,
    17,
    '复习：大小写统一处理输入',
    '把用户输入统一转成小写再比较。',
    'user = "Yes"',
    JSON_ARRAY('yes'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "normalized = user."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(normalized)"}]}]}',
    JSON_ARRAY('lower', 'upper', 'len', 'find', 'replace'),
    JSON_ARRAY(1),
    '统一转小写通常使用 lower()。',
    '"NO".lower() → "no"。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    250,
    17,
    '复习：len 计算长度',
    '补全代码以输出字符串长度。',
    'msg = "Python"',
    JSON_ARRAY('6'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": "(msg))"}]}]}',
    JSON_ARRAY('len', 'lower', 'upper', 'find', 'replace'),
    JSON_ARRAY(1),
    'len(msg) 返回字符串长度。',
    'len("abc") → 3。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    251, 
    17, 
    'replace 的替换次数', 
    '执行 "aaaa".replace("a","b",2) 会发生什么？', 
    JSON_OBJECT('A', '替换全部 a', 'B', '替换前两个 a', 'C', '报错，因为多了第三个参数', 'D', '只替换最后两个 a'), 
    2, 
    JSON_ARRAY('replace 可以控制替换次数。', '第三个参数控制最多替换几次。', '从左向右替换。'), 
    'replace("a","b",2) → "bbaa"。', 
    '"xyxy".replace("x","z",1) → "zyxy"。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    252, 
    17, 
    'find 的搜索方向', 
    'find 是从左往右找还是从右往左找？', 
    JSON_OBJECT('A', '从右往左', 'B', '随机', 'C', '从左往右', 'D', '倒序查找'), 
    3, 
    JSON_ARRAY('find 的基本行为和人类阅读方向一致。', '若要从右找，应使用 rfind。', '这是初学者常犯的概念性错误。'), 
    'find 默认从左向右查找子串。', 
    '"abcabc".find("a") → 0。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    253, 
    17, 
    'replace 不会修改原字符串', 
    '执行 s.replace("a","b") 后，s 会怎样？', 
    JSON_OBJECT('A', 's 会被直接修改', 'B', 's 会变成 bbb...', 'C', 's 不变，返回新字符串', 'D', '会报错'), 
    3, 
    JSON_ARRAY('字符串是不可变（immutable）的。', 'replace 返回一个新字符串。', '若要保存结果，需要把 replace 的返回值赋给变量。'), 
    '字符串不可变，因此 s 本身不会被修改。', 
    's = "a"; s.replace("a","b") → "b" 但 s 仍是 "a"。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    254,
    17,
    'find 与判断逻辑结合',
    '如果字符串中包含关键字则输出 FOUND。',
    'msg = "system running normal"',
    JSON_ARRAY('FOUND'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if msg."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"run\") != -1:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"FOUND\")"}]}]}',
    JSON_ARRAY('find', 'replace', 'lower', 'upper', 'len', 'run'),
    JSON_ARRAY(1),
    'find 找到则返回索引，不等于 -1 表示存在。',
    'if "hello".find("he") != -1: print("YES")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    255,
    17,
    'replace 支持替换短语',
    '补全代码，将文本中的 "not good" 替换成 "good"。',
    'msg = "This is not good at all"',
    JSON_ARRAY('This is good at all'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "new_msg = msg."}, {"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": ", "}, {"type": "slot", "index": 2}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(new_msg)"}]}]}',
    JSON_ARRAY('find', 'lower', 'upper', 'replace', '"not good"', '"good"'),
    JSON_ARRAY(4, 5, 6),
    'replace("not good","good") 即可进行短语替换。',
    '"I am not happy".replace("not ","") → "I am happy"。'
);