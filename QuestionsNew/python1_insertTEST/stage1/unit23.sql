USE `questions`;
-- Unit 23 | Start ID: 331
-- Generated at 2025-12-24 17:10:25

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    331, 
    23, 
    'f-string 的基本写法', 
    '小明想快速把变量 name 的内容嵌入到字符串里，他应该使用哪种写法？', 
    JSON_OBJECT('A', '"Hello {name}"', 'B', 'f"Hello {name}"', 'C', 'format("Hello {}", name)', 'D', '"Hello " + name'), 
    2, 
    JSON_ARRAY('思考一下 f-string 的语法开头是什么。', '只有一种写法必须以 f 开头。', '看哪个选项同时含 f 和 {}。'), 
    'f-string 以 f 开头，并在 {} 中放变量，因此 f"Hello {name}" 才是标准写法。', 
    '例如 f"Welcome {username}" 可以直接把变量插入字串。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    332, 
    23, 
    'f-string 的本质', 
    '为什么 f-string 通常比传统拼接字符串更方便？', 
    JSON_OBJECT('A', '因为 f-string 会自动加空格', 'B', '因为 f-string 会自动转成整型', 'C', '因为 f-string 可以在 {} 中直接写变量或表达式', 'D', '因为 f-string 执行速度比 CPU 更快'), 
    3, 
    JSON_ARRAY('想想 f-string 的核心能力是什么。', '它最大的特点与 {} 有关。', '它能把表达式直接写进去，不需要额外处理。'), 
    'f-string 可以在 {} 中直接放变量或表达式，让代码更短更清晰。', 
    '例如 f"{a + b} 分钟后到达" 会直接显示计算结果。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    333, 
    23, 
    'f-string 与表达式', 
    '使用 f-string 时，以下哪一种写法是合法的？', 
    JSON_OBJECT('A', 'f"2 + 3 = {2 + 3}"', 'B', 'f"2 + 3 = {2 + 3;}"', 'C', 'f"2 + 3 = {2 + 3:}"', 'D', 'f"2 + 3 = 2 + 3"'), 
    1, 
    JSON_ARRAY('表达式必须在 {} 里。', '不能在表达式后面加分号。', '只有一个选项的语法完全正确。'), 
    'f"2 + 3 = {2 + 3}" 会直接把表达式的结果嵌入字符串中。', 
    '例如 f"价格含税：{price * 1.1}" 可以做简单运算。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    334, 
    23, 
    'f-string 与引号', 
    '以下关于 f-string 的引号叙述，哪个是正确的？', 
    JSON_OBJECT('A', 'f-string 只能用双引号', 'B', 'f-string 只能用单引号', 'C', 'f-string 单双引号都可以', 'D', 'f-string 不需要引号'), 
    3, 
    JSON_ARRAY('普通字符串可以用单引号或双引号。', 'f-string 只是普通字符串的扩展。', '因此 f-string 也能使用两种引号。'), 
    'f-string 与普通字符串一样，可以使用单引号或双引号。', 
    '例如 f\'Hello {name}\' 也可以正常使用。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    335, 
    23, 
    '表达式的限制', 
    '在 f-string 的 {} 中可以放入什么？', 
    JSON_OBJECT('A', '只能放变量名', 'B', '只能放整数', 'C', '可以放任何合法表达式', 'D', '只能放字符串'), 
    3, 
    JSON_ARRAY('想想 {a + b} 是否能用？', 'f-string 中表达式非常灵活。', '只要是合法 Python 表达式即可。'), 
    'f-string 支持任意合法表达式，包含变量、运算等。', 
    '例如 f"{x**2 + y**2}" 完全没问题。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    336, 
    23, 
    'f-string 中的花括号', 
    '如果你希望在 f-string 中显示真正的花括号 { 或 }，应该怎么做？', 
    JSON_OBJECT('A', '写 "\" 来转义', 'B', '不能输出花括号', 'C', '写两个 {{ 或 }}', 'D', '只能用 format'), 
    3, 
    JSON_ARRAY('想想花括号本身是 f-string 的语法符号。', '直接写会被当作变量插入点。', '必须用成对方式 {{ 与 }} 才能输出。'), 
    '在 f-string 中输出花括号需要写成 {{ 或 }}。', 
    '例如 f"Result: {{value}}" 会输出 {value}。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    337, 
    23, 
    '为什么选择 f-string', 
    '以下哪一个原因最符合 f-string 的设计目的？', 
    JSON_OBJECT('A', '让代码看起来更“高科技”', 'B', '减少字符串拼接，提高可读性', 'C', '让 CPU 运行更快', 'D', '让字符串变成数组'), 
    2, 
    JSON_ARRAY('想想程序员最常做的事：组合文本。', 'f-string 让组合文本更直观。', '它的核心是简化与可读性，而不是性能奇迹。'), 
    'f-string 的主要目的是让嵌入变量更直观、减少拼接。', 
    '例如 f"User: {name}, Age: {age}" 写法非常清晰。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    338, 
    23, 
    '使用 f-string 的时机', 
    '如果要在输出中嵌入多个变量，优先推荐哪种方式？', 
    JSON_OBJECT('A', '使用 + 不停拼接', 'B', '使用逗号分隔多个参数', 'C', '使用 f-string 直接嵌入', 'D', '使用 print 但不写内容'), 
    3, 
    JSON_ARRAY('哪种方式最简洁？', '哪种方式最适合带多个变量？', 'f-string 就是为这个场景诞生的。'), 
    'f-string 能让多变量输出更清晰、可阅读性高。', 
    '例如 f"{x} + {y} = {x+y}"。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    339, 
    23, 
    '格式化灵活度', 
    'f-string 在格式化数字或文字时，支持什么？', 
    JSON_OBJECT('A', '支持格式说明符，例如 .2f', 'B', '只能输出原始值，不支持格式化', 'C', '只能格式化整数', 'D', '必须配合第三方库使用'), 
    1, 
    JSON_ARRAY('f-string 的语法中可以加入 :', '例如 {value:.2f} 是什么？', '它能格式化数字。'), 
    'f-string 支持格式说明，如保留小数位等。', 
    '例如 f"{pi:.3f}" 会四舍五入成三位小数。'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    340,
    23,
    '插入变量',
    '补全 f-string，将变量正确插入字串。',
    'user = "Kevin"',
    JSON_ARRAY('Hello Kevin'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "msg = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "\"Hello {"}, {"type": "slot", "index": 1}, {"type": "code", "value": "}\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(msg)"}]}]}',
    JSON_ARRAY('f', 'F', 'user', '"f"', 'format', 'name'),
    JSON_ARRAY(1, 3),
    'f-string 必须以 f 开头，并在 {} 内放变量名 user。',
    '例如 f"Hi {username}" 也能实现相同效果。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    341,
    23,
    '计算表达式',
    '使用 f-string 完成计算并插入结果。',
    'a = 4
b = 6',
    JSON_ARRAY('Total: 10'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": "\"Total: {"}, {"type": "slot", "index": 1}, {"type": "code", "value": " + "}, {"type": "slot", "index": 2}, {"type": "code", "value": "}\" )"}]}]}',
    JSON_ARRAY('f', 'a', 'b', 'A', 'F', 'total', 'sum'),
    JSON_ARRAY(1, 2, 3),
    '使用 f-string 包含表达式 {a + b} 即可插入计算结果。',
    '例如 f"Result = {x * y}" 也能输出运算值。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    342,
    23,
    '组合文本',
    '完成 f-string，将三个变量组合成一句话。',
    'a = "Python"
b = "is"
c = "fun"',
    JSON_ARRAY('Python is fun'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "sentence = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "\"{"}, {"type": "slot", "index": 1}, {"type": "code", "value": "} {"}, {"type": "slot", "index": 2}, {"type": "code", "value": "} {"}, {"type": "slot", "index": 3}, {"type": "code", "value": "}\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(sentence)"}]}]}',
    JSON_ARRAY('f', 'F', 'a', 'b', 'c', 'A', 'C', 'text'),
    JSON_ARRAY(1, 3, 4, 5),
    '按顺序放入变量 a b c，即可正确组合字串。',
    '例如 f"{first} {second}" 也能拼成一句话。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    343,
    23,
    '换算插值',
    '完成 f-string，将分钟换算成秒后输出。',
    'm = 3',
    JSON_ARRAY('180 秒'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": "\"{"}, {"type": "slot", "index": 1}, {"type": "code", "value": " * 60} 秒\")"}]}]}',
    JSON_ARRAY('f', 'm', 'minutes', '60', 'sec', 'F'),
    JSON_ARRAY(1, 2),
    '{m * 60} 即可完成分钟换算秒。',
    '例如 f"{hour * 3600} 秒" 也能换算时间。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    344,
    23,
    '保留小数',
    '使用 f-string，补全代码并保留两位小数。',
    'price = 3.14159',
    JSON_ARRAY('3.14'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": "\"{"}, {"type": "slot", "index": 1}, {"type": "code", "value": ":.2f}\")"}]}]}',
    JSON_ARRAY('f', 'price', 'p', '2f', '".2f"', 'format'),
    JSON_ARRAY(1, 2),
    '{price:.2f} 即可格式化为两位小数。',
    '例如 f"{value:.1f}" 可保留一位小数。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    345,
    23,
    '数字宽度控制',
    '完成 f-string，将数字以宽度 5 显示（右对齐）。',
    'n = 42',
    JSON_ARRAY('   42'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": "\"{"}, {"type": "slot", "index": 1}, {"type": "code", "value": ":>5}\")"}]}]}',
    JSON_ARRAY('f', 'n', 'N', '">5"', '42', 'format'),
    JSON_ARRAY(1, 2),
    '格式 {n:>5} 会让数字在 5 字符宽度内右对齐。',
    '例如 f"{x:>8}" 会让数字在宽度 8 内右对齐。'
);