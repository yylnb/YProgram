USE `questions`;
-- Unit 16 | Start ID: 226
-- Generated at 2025-12-24 17:08:23

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    226, 
    16, 
    'len 的用途', 
    '你在写一个小工具统计用户名长度，以下哪一句最适合获取字符串长度？', 
    JSON_OBJECT('A', 'length(name)', 'B', 'size(name)', 'C', 'len(name)', 'D', 'count(name)'), 
    3, 
    JSON_ARRAY('Python 内置了获取“序列长度”的专门函数。', '它的名字只有三个字母。', '就是我们最常用的那个：len(...)。'), 
    'len(name) 是 Python 获取字符串长度的唯一正确写法。', 
    '例如：len("Hello") 的结果是 5。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    227, 
    16, 
    'lower 的功能', 
    '某个用户输入 "HeLLo"，你想在内部统一成小写做比较，应该用什么方法？', 
    JSON_OBJECT('A', 'to_small()', 'B', 'downcase()', 'C', 'lower()', 'D', 'min()'), 
    3, 
    JSON_ARRAY('这是 Python 字符串的方法之一。', '它把所有英文字母变成小写。', '答案就是 lower()。'), 
    '"Hello".lower() 会得到 "hello"，方便规范化处理。', 
    '例如：user_input.lower() == "yes"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    228, 
    16, 
    'upper 的用途', 
    '你在做一个“公告标题全部大写显示”的小效果，要把字符串转成全大写应该用？', 
    JSON_OBJECT('A', 'big()', 'B', 'upper()', 'C', 'UP()', 'D', 'caps()'), 
    2, 
    JSON_ARRAY('这是与 lower() 对应的方法。', '会把字母全部变成大写。', '答案是 upper()。'), 
    '"hello".upper() 会得到 "HELLO"，常用于展示。', 
    '例如标题可以变成：title.upper()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    229, 
    16, 
    '复习切片基础', 
    '字符串 s = "abcdef"，s[1:4] 的结果是？', 
    JSON_OBJECT('A', '"bcd"', 'B', '"abc"', 'C', '"cde"', 'D', '"bcde"'), 
    1, 
    JSON_ARRAY('切片是左闭右开。', '从索引 1 开始，到 4 结束但不包含 4。', 's[1:4] → "bcd"。'), 
    '切片遵循左闭右开原则，因此取出字符 b、c、d。', 
    '例如 "hello"[1:3] 是 "el"。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    230, 
    16, 
    '切片的省略写法', 
    's = "python"，想取前 3 个字符可写为？', 
    JSON_OBJECT('A', 's[:3]', 'B', 's[0:2]', 'C', 's[1:4]', 'D', 's[3:]'), 
    1, 
    JSON_ARRAY('想从开头开始取？可以省略左侧索引。', 's[:3] 表示从开头取到索引 2。', '结果是 "pyt"。'), 
    's[:3] 是常见写法，等价于 s[0:3]。', 
    '例如 name[:4] 取前 4 个字符。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    231, 
    16, 
    '负索引切片', 
    's = "abcdef"，想取最后 2 个字符，正确写法是？', 
    JSON_OBJECT('A', 's[-2:]', 'B', 's[:-2]', 'C', 's[-2:-1]', 'D', 's[2:-2]'), 
    1, 
    JSON_ARRAY('负索引用来从后往前数。', '最后 2 个字符 → -2 到末尾。', 's[-2:] → "ef"。'), 
    's[-2:] 表示从倒数第二个字符取到结束。', 
    '例如 "hello"[-3:] 是 "llo"。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    232, 
    16, 
    'len 作用对象范围', 
    'len() 可以作用在以下哪一类对象上？', 
    JSON_OBJECT('A', '只作用于整数', 'B', '只作用于字符串', 'C', '字符串与其它序列类型', 'D', '只能作用在文件'), 
    3, 
    JSON_ARRAY('列表、字符串都能用 len()。', '只要是“序列”大多数都能数长度。', '答案是：字符串与其它序列类型。'), 
    'len() 是 Python 的通用序列长度函数。', 
    'len([1,2,3]) → 3'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    233, 
    16, 
    'lower 的返回值', 
    '"ABC".lower() 的返回值类型是什么？', 
    JSON_OBJECT('A', '整数', 'B', '字符串', 'C', '布尔值', 'D', '列表'), 
    2, 
    JSON_ARRAY('字符串方法通常返回字符串。', '“ABC”.lower() → “abc”。', '因此是字符串类型。'), 
    'lower() 返回处理后的新字符串，不会修改原字符串。', 
    '"Hi".lower() → "hi"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    234, 
    16, 
    'upper 会修改原字符串吗？', 
    '执行 name.upper() 时，原始字符串会被永久改动吗？', 
    JSON_OBJECT('A', '会，原字符串会改变', 'B', '不会，upper 会返回新字符串', 'C', '取决于 Python 版本', 'D', '取决于电脑系统'), 
    2, 
    JSON_ARRAY('字符串是不可变对象。', '方法会返回新值，而不是修改原值。', '因此 upper() 不会改变原内容。'), 
    'Python 字符串不可变，upper/lower 都返回新字符串。', 
    's = "hi"; s.upper() 结果是 "HI"，但 s 仍然是 "hi"。'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    235,
    16,
    'len 的基本使用',
    '补全代码，让程序正确输出字符串的长度。',
    'text = "Python"',
    JSON_ARRAY('6'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "result = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(result)"}]}]}',
    JSON_ARRAY('len', 'text', 'upper', 'lower', '6', 'result'),
    JSON_ARRAY(1, 2),
    'len(text) 返回字符串长度，text 是变量名。',
    '例如 len("ABC") 会得到 3。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    236,
    16,
    '转成统一小写',
    '补全代码，把用户名转成小写再打印。',
    'username = "LeOn"',
    JSON_ARRAY('leon'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "clean = username."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(clean)"}]}]}',
    JSON_ARRAY('upper', 'lower', 'strip', 'slice', 'len', 'text'),
    JSON_ARRAY(2),
    'lower() 方法将字符串转为小写。',
    '例如："HELLO".lower() 会得到 "hello"。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    237,
    16,
    '复习：获取字符串前半部分',
    '补全代码，让程序输出字符串前 3 个字符。',
    'word = "Python"',
    JSON_ARRAY('Pyt'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "part = word["}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}, {"type": "slot", "index": 1}, {"type": "code", "value": "]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(part)"}]}]}',
    JSON_ARRAY('0', '1', '2', '3', '4', '5', ':', 'len', 'upper', 'lower'),
    JSON_ARRAY(1, 4),
    'word[0:3] 取出 Pyt。',
    '例如 "abcdef"[0:2] 是 "ab"。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    238,
    16,
    '复习：组合切片与方法',
    '补全代码，先切片，再转大写。',
    'msg = "hello"',
    JSON_ARRAY('HE'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "sub = msg[0:2]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "res = sub."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(res)"}]}]}',
    JSON_ARRAY('lower', 'upper', 'len', 'slice', 'msg', 'sub', '0', '2'),
    JSON_ARRAY(2),
    'sub.upper() 将切片结果 "he" 变成 "HE"。',
    '例如 "abc"[1:3].upper() → "BC"。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    239,
    16,
    '综合应用：统计大写后的长度',
    '补全代码，将字符串转成大写后再统计长度。',
    'msg = "Hi!"',
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "up = msg."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "length = "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(up)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(length)"}]}]}',
    JSON_ARRAY('lower', 'upper', 'len', 'msg', 'up', '3', '!'),
    JSON_ARRAY(2, 3),
    'upper() → "HI!"，len("HI!") → 3。',
    '例如 len("OK".upper()) → 2'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    240,
    16,
    '多步处理：统一小写 + 切片',
    '补全代码：先转为小写，再取前 4 个字符。',
    'text = "PyTHonIsFun"',
    JSON_ARRAY('pyth'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "low = text."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "res = low[0:"}, {"type": "slot", "index": 1}, {"type": "code", "value": "]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(res)"}]}]}',
    JSON_ARRAY('lower', 'upper', 'len', 'text', '3', '4', '5', '6'),
    JSON_ARRAY(1, 6),
    'lower() → "pythonisfun"，再取前 4 个字符 → "pyth"。',
    '例如 "HELLO".lower()[0:3] → "hel"'
);