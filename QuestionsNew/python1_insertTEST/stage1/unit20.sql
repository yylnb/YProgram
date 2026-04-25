USE `questions`;
-- Unit 20 | Start ID: 286
-- Generated at 2025-12-24 17:09:13

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    286, 
    20, 
    '字符串的基本输出回顾', 
    '小李想打印一句问候语："Good morning"。以下哪一项写法正确？', 
    JSON_OBJECT('A', 'print(Good morning)', 'B', 'print("Good morning")', 'C', 'echo("Good morning")', 'D', 'print(\'Good morning\')'), 
    2, 
    JSON_ARRAY('Python 输出必须使用 print。', '字符串需要引号。', '注意区分 Python 语法与其他语言语法。'), 
    'print("Good morning") 是标准 Python 字符串输出。', 
    '你也可以输出 print("Have a nice day") 来练习。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    287, 
    20, 
    '字符串拼接与重复复习', 
    '小王想让字符串 "Hi" 重复 3 次，以下哪个选项正确？', 
    JSON_OBJECT('A', '"Hi" * 3', 'B', 'repeat("Hi", 3)', 'C', '"Hi".repeat(3)', 'D', '"Hi" + 3'), 
    1, 
    JSON_ARRAY('Python 使用 * 进行字符串重复。', '不要选其他语言的语法。', '重复的结果应该是 "HiHiHi"。'), 
    '"Hi" * 3 使用乘法运算符重复字符串。', 
    '"ha" * 5 会得到 "hahahahaha"。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    288, 
    20, 
    '转义字符复习', 
    '下列哪一项可以正确输出一个双引号字符？', 
    JSON_OBJECT('A', 'print(" ")', 'B', 'print(\'"\')', 'C', 'print("\"")', 'D', 'print("\\")'), 
    3, 
    JSON_ARRAY('转义符是通过反斜杠完成的。', '你要输出的是 " 这个符号。', '看看哪个选项是合规的字符串写法。'), 
    '要输出双引号，需要写成 print("\"")，即转义双引号。', 
    '例如 print("He said: \"Hello!\"")。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    289, 
    20, 
    '字符串长度与大小写方法复习', 
    '下列哪个语句可以把 word 转成全大写？', 
    JSON_OBJECT('A', 'word.upper()', 'B', 'upper(word)', 'C', 'word.toUpper()', 'D', 'toUpper(word)'), 
    1, 
    JSON_ARRAY('注意 Python 方法调用形式。', 'upper 是字符串对象的方法。', '不要选其他语言的写法。'), 
    'word.upper() 将所有字母转换为大写。', 
    '"abc".upper() -> "ABC"。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    290, 
    20, 
    'find 方法复习', 
    'message = "hello world"。以下哪个能找到 "world" 的起始位置？', 
    JSON_OBJECT('A', 'message.index("world")', 'B', 'message.find("world")', 'C', 'find(message, "world")', 'D', 'message.search("world")'), 
    2, 
    JSON_ARRAY('find 是字符串方法。', '找不到会返回 -1。', 'index 在找不到时会报错。'), 
    'find 返回子串位置，因此 message.find("world") 正确。', 
    '"banana".find("na") -> 2。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    291, 
    20, 
    'replace 方法复习', 
    '以下哪个操作可以把 "2024-12-31" 中的 "-" 替换为 "/"？', 
    JSON_OBJECT('A', '"2024-12-31".swap("-","/")', 'B', '"2024-12-31".replace("/", "-")', 'C', '"2024-12-31".replace("-", "/")', 'D', 'replace("2024-12-31","-","/")'), 
    3, 
    JSON_ARRAY('注意参数顺序：旧的→新的。', 'replace 是字符串对象的方法。', '检查哪个语法正确。'), 
    '"2024-12-31".replace("-", "/") 正确替换符号。', 
    '"a-b-c".replace("-", "*") -> "a*b*c"。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    292, 
    20, 
    'in 判断复习', 
    '以下哪个表达式会返回 True？', 
    JSON_OBJECT('A', '"py" in "Python"', 'B', '"Py" in "python"', 'C', '"thon" not in "Python"', 'D', '"abc" in ""'), 
    1, 
    JSON_ARRAY('记住大小写敏感。', '"py" 小写在 "Python" 中确实存在。', '"abc" 不会出现在空字符串中。'), 
    '"py" 确实是子串（从第二个字符开始）。', 
    '"on" in "Python" -> True。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    293, 
    20, 
    'not in 判断复习', 
    '以下哪个表达式结果为 False？', 
    JSON_OBJECT('A', '"h" not in "hello"', 'B', '"x" not in "hello"', 'C', '"he" not in "hello"', 'D', '"lo" not in "hello"'), 
    3, 
    JSON_ARRAY('检查每个子串是否真实存在。', '"he" 是存在的。', '存在 → not in 就是 False。'), 
    '"he" 在 "hello" 开头出现，因此 not in 的结果为 False。', 
    '"ab" not in "abc" -> False。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    294, 
    20, 
    '综合判断题', 
    '关于字符串，下列说法正确的是？', 
    JSON_OBJECT('A', '字符串可以直接修改某个字符。', 'B', '字符串切片会返回新字符串。', 'C', 'len() 不能用于字符串。', 'D', 'join 用于分割字符串。'), 
    2, 
    JSON_ARRAY('字符串是不可变类型。', 'len 可以用于字符串。', 'join 用于连接序列。'), 
    '切片总会返回一个新字符串对象。', 
    '"abc"[0:2] -> "ab"。'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    295,
    20,
    '基础切片复习',
    '补全代码，取得前 3 个字符。',
    'text = "Python"',
    JSON_ARRAY('Pyt'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "result = text["}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}, {"type": "slot", "index": 1}, {"type": "code", "value": "]"}]}]}',
    JSON_ARRAY('0', '1', '2', '3', '4', 'len(text)'),
    JSON_ARRAY(1, 4),
    'text[0:3] 能得到前 3 个字符。',
    '"abcdef"[0:4] 会得到 "abcd"。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    296,
    20,
    '进阶切片复习',
    '补全代码，将字符串倒序输出。',
    's = "hello"',
    JSON_ARRAY('olleh'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "rev = s["}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}, {"type": "slot", "index": 1}, {"type": "code", "value": ":"}, {"type": "slot", "index": 2}, {"type": "code", "value": "]"}]}]}',
    JSON_ARRAY('0', '1', '-1', '-2', 'None', ':', '::', '5'),
    JSON_ARRAY(8, 1, 3),
    's[::-1] 是倒序，但展开为 s[len:0:-1] 也能实现倒序。',
    '"Python"[::-1] -> "nohtyP"。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    297,
    20,
    'split 方法复习',
    '补全代码，将一行 csv 数据拆分成列表。',
    'row = "apple,banana,orange"',
    JSON_ARRAY('[\'apple\',\'banana\',\'orange\']'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "items = row."}, {"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('split', 'join', '","', '" "', '"-"', '1'),
    JSON_ARRAY(1, 3),
    'row.split(",") 按逗号分割。',
    '"a|b|c".split("|") -> ["a","b","c"]。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    298,
    20,
    'join 方法复习',
    '补全代码，把列表合并成字符串并用 "-"连接。',
    'lst = ["A", "B", "C"]',
    JSON_ARRAY('A-B-C'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "result = "}, {"type": "slot", "index": 0}, {"type": "code", "value": ".join("}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('"-"', '","', '"."', 'lst', 'join', '"-"', '"A-B-C"'),
    JSON_ARRAY(1, 4),
    '"-".join(lst) -> "A-B-C"。',
    '"|".join(["x","y"]) -> "x|y"。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    299,
    20,
    '多技能综合题：切片 + 判断',
    '补全代码：若字符串前半部分包含 "ab" 则打印 "Yes"。',
    's = "abcd1234"',
    JSON_ARRAY('Yes'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "half = s["}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}, {"type": "slot", "index": 1}, {"type": "code", "value": "]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if "}, {"type": "code_line", "value": "    print(\"Yes\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 2}, {"type": "code", "value": " in half:"}]}]}',
    JSON_ARRAY('0', '2', '4', '5', '"ab"', '"cd"', 's', 'half'),
    JSON_ARRAY(1, 3, 5),
    's[0:4] -> "abcd"，其中包含 "ab"。',
    '用同样方法检测字符串是否以某些前缀开头。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    300,
    20,
    '多技能综合题：split + replace + join',
    '补全代码：把句子按空格拆分，再把每个词中的 "-" 去掉，然后用空格拼回。',
    'sentence = "good-morning to-day everyone"',
    JSON_ARRAY('goodmorning today everyone'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "words = sentence."}, {"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "clean = [ w."}, {"type": "slot", "index": 2}, {"type": "code", "value": "("}, {"type": "slot", "index": 3}, {"type": "code", "value": ", "}, {"type": "slot", "index": 4}, {"type": "code", "value": ") for w in words ]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "result = "}, {"type": "slot", "index": 5}, {"type": "code", "value": ".join(clean)"}]}]}',
    JSON_ARRAY('split', 'replace', 'join', '" "', '"-"', '""', '"/"', 'clean', 'words'),
    JSON_ARRAY(1, 2, 4),
    '按空格拆分 → 对每个词做 replace → 用空格拼回。',
    '你也可以去掉邮箱中的 ".", 然后重新拼接成字符串。'
);