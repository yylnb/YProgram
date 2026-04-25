USE `questions`;
-- Unit 13 | Start ID: 181
-- Generated at 2025-12-25 17:41:13

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    181,
    13,
    '了解转义字符的用途',
    '小李想在字符串里放一个双引号，但不想提前结束字符串，他应该怎么做？',
    JSON_OBJECT('A', '"She said "Hi""', 'B', '"She said \\"Hi\\""', 'C', '\'She said "Hi"\'', 'D', '"She said \\Hi"'),
    2,
    JSON_ARRAY('双引号内部再放双引号需要一种“逃脱”方式。', 'Python 使用反斜杠作为转义符。', '要让字符串里的双引号不结束字符串，就要写成 \\".'),
    '在字符串内部使用双引号时，需要用 \\" 来转义，这样不会提前结束字符串。',
    '例如你也可以写：print("他说：\\"好吧\\"")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    182,
    13,
    '常见转义字符',
    '以下哪个转义字符能在字符串中产生换行？',
    JSON_OBJECT('A', '\\t', 'B', '\\n', 'C', '\\r', 'D', '\\s'),
    2,
    JSON_ARRAY('想象一下你敲 Enter 键。', 'Python 中换行有一个非常经典的表示方式。', '它以 n 开头，类似“new line”。'),
    '\\n 表示换行，是最常用的转义字符之一。',
    '例如 print("Hello\\nWorld") 会换行输出两行。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    183,
    13,
    '反斜杠本身如何表示',
    '如果你想在字符串中显示一个真实的反斜杠 \\ ，你应该怎么写？',
    JSON_OBJECT('A', '"\\\\"', 'B', '"\\""', 'C', '"\\""', 'D', '"\\/"'),
    1,
    JSON_ARRAY('反斜杠用于转义自身。', '要显示一个反斜杠，需要用两个反斜杠写在字符串中。', '第一个是转义符，第二个是实际内容。'),
    '写成 "\\\\" 会在最终输出中显示一个单反斜杠。',
    '例如路径写成 "C:\\\\User" 才能正确输出 C:\\User。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    184,
    13,
    '基础转义：输出带引号的内容',
    '补全代码，使其正确输出字符串中的双引号。',
    NULL,
    JSON_ARRAY('"Hello"'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "text = "}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(text)"}]}]}',
    JSON_ARRAY('"\\"Hello\\""', '"\\"Hello"', '"Hello"', '""Hello""', '"\\Hello\\""'),
    JSON_ARRAY(1),
    '要在字符串内写双引号，需要使用 \\" 转义，正确写法是 "\\"Hello\\"".',
    '例如 print("\\"Python\\"") 会输出 "Python".'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    185,
    13,
    '基础转义：换行效果',
    '补全代码，使其打印两行内容：Hello 和 World。',
    NULL,
    JSON_ARRAY('Hello
World'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(\\"Hello"}, {"type": "slot", "index": 0}, {"type": "code", "value": "World\\")"}]}]}',
    JSON_ARRAY('\\n', '\\t', '\\r', '\\\\"', '" "'),
    JSON_ARRAY(1),
    '使用 \\n 可以在字符串中产生换行。',
    '例如 "A\\nB" 会让 A 与 B 分别在两行。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    186,
    13,
    '复习：字符串拼接基础',
    '以下哪一项能正确拼接两个字符串？',
    JSON_OBJECT('A', '"Hi" * "There"', 'B', '"Hi" + "There"', 'C', 'add("Hi","There")', 'D', '"Hi" & "There"'),
    2,
    JSON_ARRAY('拼接通常意味着“放到一起”。', 'Python 有一个专门用于连接字符串的符号。', '就是加号 + 。'),
    '使用 + 能将两个字符串拼接为一个字符串。',
    '例如 "A" + "B" 得到 "AB"。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    187,
    13,
    '复习：重复字符串',
    '下面哪一个表达式能输出 "ha" 三次？',
    JSON_OBJECT('A', '"ha" + 3', 'B', '3 + "ha"', 'C', '"ha" * 3', 'D', '"ha" ** 3'),
    3,
    JSON_ARRAY('数字与字符串之间用 * 时含义特殊。', '它会让字符串重复。', '也就是 "ha" * 3 → "hahaha"。'),
    '使用 * 可以让字符串重复指定次数。',
    '例如 "-" * 5 会输出 "-----"。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    188,
    13,
    '复习：混合拼接问题',
    '以下哪项会导致错误？',
    JSON_OBJECT('A', '"Hi" + "!"', 'B', '"Hi" * 2', 'C', '"Hi" + 2', 'D', '"Hi" + "2"'),
    3,
    JSON_ARRAY('只有字符串才能拼接字符串。', '数字不能直接与字符串相加。', '要么用 str() 转换，要么确保两边都是字符串。'),
    '"Hi" + 2 会报错，因为不能把字符串和整数直接相加。',
    '如果必须拼接，可写成 "Hi" + str(2)。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    189,
    13,
    '复习：拼接姓名展示',
    '补全代码，使其拼接用户的姓与名。',
    JSON_ARRAY('first = "Li"
last = "Lei"'),
    JSON_ARRAY('Li Lei'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "full = first "}, {"type": "slot", "index": 0}, {"type": "code", "value": " \\" \\" "}, {"type": "slot", "index": 1}, {"type": "code", "value": " last"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(full)"}]}]}',
    JSON_ARRAY('+', '*', ',', 'and', 'or', '+ " " +'),
    JSON_ARRAY(1, 1),
    '字符串相加使用 +，因此 first + " " + last 才能产生 Li Lei。',
    '例如 city + ", " + country 可以组合地点名称。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    190,
    13,
    '复习：生成重复提示',
    '补全代码，让程序输出三次“Go!”。',
    NULL,
    JSON_ARRAY('Go!Go!Go!'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "msg = \\"Go!\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": " "}, {"type": "slot", "index": 1}, {"type": "code", "value": " "}, {"type": "slot", "index": 2}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('msg', '"Go!"', '*', '+', '**', '3'),
    JSON_ARRAY(1, 3, 6),
    '字符串重复使用 *，所以需要 msg * 3。',
    '例如 "-" * 10 能画一条分隔线。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    191,
    13,
    '理解原始字符串 r""',
    '以下哪个写法能让 Python 不对字符串内的反斜杠进行转义？',
    JSON_OBJECT('A', 'raw("text")', 'B', 'r"text"', 'C', 'R(text)', 'D', 'text(r)'),
    2,
    JSON_ARRAY('Python 有一种写法让你“原样”保留反斜杠。', '它以一个特别的字母开头。', '答案是 r 开头，例如 r"\\n"。'),
    'r"" 会创建原始字符串，不对 \\n 等进行转义。',
    '例如 print(r"C:\\\\User") 会原样输出 C:\\User。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    192,
    13,
    '单双引号混合场景',
    '如果你要在字符串中放单引号，而外层是双引号，是否需要转义？',
    JSON_OBJECT('A', '需要，因为单引号必须转义', 'B', '不需要，因为双引号包裹时单引号不冲突', 'C', '必须使用三引号', 'D', '必须加反斜杠，但不会影响输出'),
    2,
    JSON_ARRAY('单引号和双引号互不干扰。', '外层用双引号，内部放单引号是非常常见的写法。', '如 "I\'m fine" 也可以写成 "I\'m fine"。'),
    '只要外层和内层引号不同，就不需要转义。',
    '例如 print("I\'m OK") 或 print("I\'m OK") 都可。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    193,
    13,
    '多重转义理解',
    '以下哪个字符串经过解释后会输出 \\n？',
    JSON_OBJECT('A', '"\\\\n"', 'B', '"\\n"', 'C', '"\\\\\\n"', 'D', 'r"\\n"'),
    1,
    JSON_ARRAY('想输出 \\n，需要两个反斜杠加 n。', '写成 "\\\\n" 才能在最终结果中看到 \\n。', '记住：输入两个反斜杠 → 输出一个反斜杠。'),
    '"\\\\n" 经过转义后变成 \\n 字面内容，而不是换行。',
    '例如 "\\\\t" 会输出 \\t。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    194,
    13,
    '转义与路径处理',
    '补全代码，使其正确输出 Windows 路径。',
    NULL,
    JSON_ARRAY('C:\\User\\Files'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "path = \\"C:\\\\\\\\User\\\\\\\\"}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(path)"}]}]}',
    JSON_ARRAY('Files', 'File', '\\Files', '"Files"', 'user'),
    JSON_ARRAY(1),
    '路径中的反斜杠需要写成 \\\\，最后部分写 Files 即可。',
    '例如 "D:\\\\Data\\\\Temp" 用双反斜杠写法才有效。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    195,
    13,
    '综合：转义 + 拼接',
    '补全代码，使其打印 "Hello
Python"（带换行）。',
    NULL,
    JSON_ARRAY('Hello
Python'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = \\"Hello\\""}, {"type": "code_line", "value": "b = \\"Python\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(a "}, {"type": "slot", "index": 0}, {"type": "code", "value": " \\"\\\\n\\" "}, {"type": "slot", "index": 1}, {"type": "code", "value": " b)"}]}]}',
    JSON_ARRAY('+', '*', 'and', 'or', ',', '+ " " +'),
    JSON_ARRAY(1, 1),
    '拼接字符串仍然用 +，所以 a + "\\n" + b。',
    '例如 "A" + "\\t" + "B" 会在中间加入制表符。'
);