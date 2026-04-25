USE `questions`;
-- Unit 11 | Start ID: 151
-- Generated at 2025-12-25 17:41:13

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    151,
    11,
    '字符串的基本构造方式',
    '小李正在建立欢迎语，下列哪一项是合法的 Python 字符串写法？',
    JSON_OBJECT('A', 'Hello Python', 'B', '"Hello Python"', 'C', 'Hello Python"', 'D', '\'Hello Python"'),
    2,
    JSON_ARRAY('字符串必须用引号括住。', '引号要成对出现。', '哪一个选项的引号完整且语法正确？'),
    '只有 "Hello Python" 形成了正确且完整的字符串字面量。',
    '你也可以写成 \'Welcome\' 或 "Welcome to Python"。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    152,
    11,
    '单引号与双引号',
    '小王想输出 I am learning Python! ，以下哪种写法是正确的？',
    JSON_OBJECT('A', 'print(I am learning Python!)', 'B', 'print(\'I am learning Python!\')', 'C', 'print("I am learning Python!)")', 'D', 'print("I am learning Python!)'),
    2,
    JSON_ARRAY('字符串必须有引号。', '引号必须成对。', '看看哪一个包含成对的外层引号且不破坏内部内容。'),
    'print(\'I am learning Python!\') 是正确的写法。',
    '你也可以用双引号：print("I am learning Python!")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    153,
    11,
    '字符串与空字符串',
    '以下哪个是合法的空字符串？',
    JSON_OBJECT('A', '""', 'B', ' ', 'C', '*""*', 'D', 'empty'),
    1,
    JSON_ARRAY('空字符串不是空格。', '空字符串必须由引号表示。', '只有成对引号中间什么也没有才是空字符串。'),
    '"" 表示空字符串，不等于空格。',
    '例如：print("") 不会输出任何可见字符。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    154,
    11,
    '创建字符串变量',
    '补全代码使其正确创建字符串并输出。',
    NULL,
    JSON_ARRAY('Hello User'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "greeting = "}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('"Hello User"', 'Hello User', 'print', 'greeting', '"User Hello"'),
    JSON_ARRAY(1, 4),
    'greeting 变量应赋值为一个字符串，print 时输出变量即可。',
    '你也可以写：name="Leon"\\nprint(name)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    155,
    11,
    '字符串输出的基本格式',
    '补全代码使输出为：Welcome!',
    NULL,
    JSON_ARRAY('Welcome!'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('print', 'Welcome!', '"Welcome!"', 'echo', 'output'),
    JSON_ARRAY(1, 3),
    'print 是 Python 的输出函数，"Welcome!" 是字符串。',
    'print("Great job!") 也可以输出文本。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    156,
    11,
    '字符串中的引号选择',
    '想输出 He said "Hi" ，下列哪种写法最合适？',
    JSON_OBJECT('A', 'print("He said "Hi"")', 'B', 'print(\'He said "Hi"\')', 'C', 'print("He said \'Hi\'")', 'D', 'print(He said "Hi")'),
    2,
    JSON_ARRAY('字符串内部含有双引号时，可以用单引号包裹。', '也可以反过来，但要避免冲突。', '看哪个选项外层和内层引号不会打架。'),
    '外层使用单引号，内部双引号可直接出现。',
    'print("He said \'Hello\'") 也能避免冲突。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    157,
    11,
    '转义字符基础',
    '输出包含换行符的字符串，下列写法哪一个是正确的？',
    JSON_OBJECT('A', 'print("Line1\\nLine2")', 'B', 'print("Line1/nLine2")', 'C', 'print("Line1\\\\nLine2")', 'D', 'print(Line1\\nLine2)'),
    1,
    JSON_ARRAY('Python 的换行符是 \\n。', '注意反斜杠必须放在字符串内部。', '选项 C 中转义被二次写入，不代表真正的换行。'),
    'A 的 \\n 会使字符串真实换行。',
    'print("Hello\\nWorld") 会换成两行。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    158,
    11,
    '字符串拼接基础理解',
    '以下哪一项属于字符串拼接？',
    JSON_OBJECT('A', '"Hello" + 5', 'B', '"Hello" + "World"', 'C', 'Hello + World', 'D', 'print + "Hi"'),
    2,
    JSON_ARRAY('拼接必须是字符串 + 字符串。', '数字不能直接与字符串拼接。', '确保内容本身就是字符串。'),
    '"Hello" + "World" 是最基本的字符串拼接方式。',
    '"A" + "B" 会生成 "AB"。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    159,
    11,
    '变量拼接输出',
    '补全代码使结果为：Hello Python',
    NULL,
    JSON_ARRAY('Hello Python'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lang = \\"Python\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\\"Hello \\" + "}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('Python', 'lang', '"lang"', 'print', '+', '"Hello Python"'),
    JSON_ARRAY(2),
    'lang 是保存字符串内容 "Python" 的变量。',
    'msg="World"\\nprint("Hello " + msg)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    160,
    11,
    '字符串重复与输出',
    '补全代码使打印结果为：HiHi',
    NULL,
    JSON_ARRAY('HiHi'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "text = \\"Hi\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(text "}, {"type": "slot", "index": 0}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('*', '+', '2', 'text', 'print'),
    JSON_ARRAY(1, 3),
    '字符串 * 数字 会将字符串重复指定次数。',
    '"A"*3 会得到 "AAA"。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    161,
    11,
    '长字符串的构造方式',
    '以下哪一种写法可创建多行字符串？',
    JSON_OBJECT('A', '"Line1\\nLine2"', 'B', '"""Line1\\nLine2"""', 'C', '"Line1";"Line2"', 'D', '\'Line1\' + \'Line2\''),
    2,
    JSON_ARRAY('多行字符串通常使用三引号。', '双引号三连或单引号三连都可以。', '普通字符串虽然能换行，但不等于多行字符串字面量。'),
    '三引号形式可直接在代码中写出多行内容。',
    'text = """Hello\\nWorld"""'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    162,
    11,
    '字符串类型判断基础',
    '以下哪个值的类型是字符串？',
    JSON_OBJECT('A', '123', 'B', '"123"', 'C', '123.0', 'D', 'True'),
    2,
    JSON_ARRAY('字符串必须被引号包含。', '数字没有引号不是字符串。', '不要被内容本身迷惑。'),
    '"123" 是字符串，内容看起来像数字也无妨。',
    'print(type("5")) 会显示 <class \'str\'>'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    163,
    11,
    '字符串插值基础概念',
    '以下哪一种方式能正确使用 f-string？',
    JSON_OBJECT('A', '"f{value}"', 'B', 'f"value"', 'C', 'f"{value}"', 'D', 'f(value)'),
    3,
    JSON_ARRAY('f-string 必须以 f 开头并包含花括号。', '花括号里放变量名。', '查看哪个选项同时具备这两个条件。'),
    'f"{value}" 是标准 f-string 语法格式。',
    'name="Leon"\\nprint(f"Hi {name}")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    164,
    11,
    '使用 f-string 输出变量',
    '补全代码使输出为：My name is Alex',
    NULL,
    JSON_ARRAY('My name is Alex'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "name = \\"Alex\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\""}, {"type": "slot", "index": 0}, {"type": "code", "value": " {"}, {"type": "slot", "index": 1}, {"type": "code", "value": "}\\")"}]}]}',
    JSON_ARRAY('My', 'name', 'is', 'Alex', '"Alex"', 'f', 'print', 'name'),
    JSON_ARRAY(3, 2),
    'f-string 花括号内填变量名，字符串部分直接写入。',
    'print(f"I am {name}")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    165,
    11,
    '字符串组合与格式化',
    '补全代码使输出为：Today: Monday',
    NULL,
    JSON_ARRAY('Today: Monday'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "day = \\"Monday\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "msg = \\"Today: \\" + "}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(msg)"}]}]}',
    JSON_ARRAY('Monday', 'day', '"day"', 'print', '+', '"Today:"'),
    JSON_ARRAY(2),
    'day 保存了需要拼接的字符串 "Monday"。',
    'weather = "Sunny"\\nprint("Weather: " + weather)'
);