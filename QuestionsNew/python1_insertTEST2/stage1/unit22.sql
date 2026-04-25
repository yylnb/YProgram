USE `questions`;
-- Unit 22 | Start ID: 316
-- Generated at 2025-12-24 23:05:04

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    316, 
    22, 
    'input 的基本作用', 
    '小明写了一个小程序，需要让用户输入名字。应该使用什么？', 
    JSON_OBJECT('A', 'read()', 'B', 'input()', 'C', 'scan()', 'D', 'get()'), 
    2, 
    JSON_ARRAY('Python 中获取用户输入有特定函数。', '该函数会等待用户输入一行文本。', '没错，就是你最常看到的那个。'), 
    'input() 用于从用户接收一行字符串输入。', 
    '例如：name = input("请输入你的名字：")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    317, 
    22, 
    'input 的返回类型', 
    '用户输入 123 后，input() 得到的值是什么类型？', 
    JSON_OBJECT('A', 'int', 'B', 'float', 'C', 'str', 'D', 'bool'), 
    3, 
    JSON_ARRAY('input 返回的不是数字。', '无论输入什么，返回结果都是同一种类型。', '对，就是“文本”。'), 
    'input() 永远返回字符串，需要时需自行转换。', 
    '例如 num = int(input("请输入数字："))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    318, 
    22, 
    '提示文本的作用', 
    '下列哪一个 input 写法可以在输入前显示提示？', 
    JSON_OBJECT('A', 'input name:', 'B', 'input("请输入名字：")', 'C', 'input{"请输入名字："}', 'D', '提示("请输入名字")'), 
    2, 
    JSON_ARRAY('input 可以接受一个字符串作为提示。', '提示要写在括号里。', '格式必须符合 Python 的函数调用方式。'), 
    'input("提示") 是标准写法，会在读取前输出提示。', 
    '例如 age = input("请输入你的年龄：")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    319,
    22,
    '接收用户输入并打印',
    '补全代码，让程序接收用户输入并输出“Hello X”。',
    '（用户输入：Tom）',
    JSON_ARRAY('Hello Tom'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "name = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"请输入名字：\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\"Hello\", "}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('input', 'name', 'str', 'user', 'print', 'output'),
    JSON_ARRAY(1, 2),
    'input 用于接收输入，第二处应填变量 name。',
    '例如你可以写：nickname = input("昵称："); print("Hello", nickname)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    320,
    22,
    '数字输入转换',
    '补全代码，将用户输入转换为整数并加 10。',
    '（用户输入：5）',
    JSON_ARRAY('15'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "n = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": "(\"请输入数字：\"))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(n + 10)"}]}]}',
    JSON_ARRAY('str', 'int', 'input', 'number', 'value', 'float'),
    JSON_ARRAY(2, 3),
    'input 接收字符串，再用 int 转换成整数。',
    '例如：score = int(input("分数："))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    321, 
    22, 
    'input 的等待行为', 
    '当程序运行到 input() 时，会发生什么？', 
    JSON_OBJECT('A', '程序自动跳过输入', 'B', '程序暂停并等待用户输入', 'C', '程序报错并退出', 'D', '程序随机生成一个输入'), 
    2, 
    JSON_ARRAY('input 用于和用户互动。', '没有输入就不会继续执行。', '它会“卡住”等用户。'), 
    'input 会阻塞程序，直到用户输入并按下回车。', 
    '例如：msg = input("按回车继续：")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    322, 
    22, 
    '多次 input', 
    '如果有两个 input，会怎样？', 
    JSON_OBJECT('A', '只执行第一个 input', 'B', '两个都会执行并分别接收输入', 'C', '程序报错', 'D', '两个 input 会合并为一次输入'), 
    2, 
    JSON_ARRAY('每个 input 都需要用户输入。', '它们不会自动合并。', '也不会跳过。'), 
    '每个 input 会独立执行并等待用户输入。', 
    '例如：a = input(); b = input()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    323, 
    22, 
    'input 与字符串拼接', 
    '若 name = input("名字？")，想输出“Hi, 小明”，该怎么写？', 
    JSON_OBJECT('A', 'print("Hi," + name)', 'B', 'print("Hi,", name)', 'C', '以上都可以', 'D', '只能用格式化字符串'), 
    3, 
    JSON_ARRAY('字符串可以拼接。', 'print 可以接受多个参数。', '选项里有不止一种正确方式。'), 
    'A 和 B 都能正确输出字符串，只是格式略有不同。', 
    '例如 print("Hello " + name)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    324,
    22,
    '读取两次输入',
    '补全代码，让程序分别读取名字和城市。',
    '（用户输入：Alice / Beijing）',
    JSON_ARRAY('Alice 来自 Beijing'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "name = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"名字：\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "city = "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(\"城市：\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(name, \"来自\", "}, {"type": "slot", "index": 2}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('input', 'city', 'name', 'output', 'str'),
    JSON_ARRAY(1, 1, 2),
    '两次都用 input，最后填入 city。',
    '例如：print(user, "在", place)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    325,
    22,
    '将输入重复输出',
    '补全代码，让用户输入一句话并重复输出三次。',
    '（用户输入：Hi）',
    JSON_ARRAY('HiHiHi'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "text = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"说点什么：\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 1}, {"type": "code", "value": " * 3)"}]}]}',
    JSON_ARRAY('text', 'input', 'str', 'repeat', 'print'),
    JSON_ARRAY(2, 1),
    'input 获取输入，text * 3 实现重复。',
    '例如：word = input(); print(word * 5)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    326, 
    22, 
    '输入数字但未转换', 
    'num = input("数字："); print(num * 3)，用户输入 2，会输出什么？', 
    JSON_OBJECT('A', '6', 'B', '222', 'C', '报错', 'D', '无法确定'), 
    2, 
    JSON_ARRAY('input 返回字符串。', '字符串 * 3 会重复三次。', '不是数学上的乘法。'), 
    'num 是 "2", "2" * 3 得到 "222"。', 
    '例如："Hi" * 2 → "HiHi"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    327, 
    22, 
    'input 与类型转换顺序', 
    '想把输入转换为浮点数，正确写法是？', 
    JSON_OBJECT('A', 'float = input(float)', 'B', 'float(input())', 'C', 'input(float())', 'D', 'int(float(input()))'), 
    2, 
    JSON_ARRAY('input 在最内层。', '转换函数在外层包裹。', '只需一次转换。'), 
    'float(input()) 是正确结构。', 
    '例如：price = float(input("价格："))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    328, 
    22, 
    'input 的括号内容', 
    '以下哪项可以作为 input 的参数？', 
    JSON_OBJECT('A', '整数', 'B', '字符串', 'C', '变量（包含字符串）', 'D', '以上都可以'), 
    4, 
    JSON_ARRAY('提示信息只需要能转换成字符串。', '数字或变量都会被转换。', '所以全部都可以。'), 
    'input 的提示会被转为字符串输出。', 
    '例如：msg = input(123)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    329,
    22,
    '处理年龄输入',
    '补全代码，实现年龄 +5 的功能。',
    '（输入：10）',
    JSON_ARRAY('15'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "age = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": "(\"请输入年龄：\"))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(age + "}, {"type": "slot", "index": 2}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('int', 'input', '5', 'str', 'age'),
    JSON_ARRAY(1, 2, 3),
    'input→int→加 5。',
    '例如：n = int(input()); print(n + 2)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    330,
    22,
    '读取并拼接两段输入',
    '补全代码，让用户输入姓和名并拼接。',
    '（输入：Li / Hua）',
    JSON_ARRAY('LiHua'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "first = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"姓：\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "last = "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(\"名：\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 2}, {"type": "code", "value": " + "}, {"type": "slot", "index": 3}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('first', 'last', 'input', '+', 'str'),
    JSON_ARRAY(3, 3, 1, 2),
    '两次 input，最后拼接 first + last。',
    '例如：print(a + b)'
);