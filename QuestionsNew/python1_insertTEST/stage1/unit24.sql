USE `questions`;
-- Unit 24 | Start ID: 346
-- Generated at 2025-12-24 17:10:51

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    346, 
    24, 
    '数字格式化：保留小数', 
    'price = 3.4567，想用 f-string 显示为 "3.46"，下列哪个写法正确？', 
    JSON_OBJECT('A', 'f"{price:.2f}"', 'B', 'f"{price:.2}"', 'C', 'f"{price:2f}"', 'D', 'f"{price:.02f}"'), 
    1, 
    JSON_ARRAY('保留小数通常使用 . 后跟位数。', '语法是 {变量:格式}。', '".2f" 是常见的浮点格式说明。'), 
    'f"{price:.2f}" 会把浮点数格式化为两位小数并做四舍五入。', 
    '例如 f"{3.14159:.3f}" → "3.142"。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    347, 
    24, 
    '字符串对齐：左/右/居中', 
    'name = "Amy"，想用 f-string 在宽度 10 中右对齐显示，应使用哪种格式？', 
    JSON_OBJECT('A', 'f"{name:>10}"', 'B', 'f"{name:<10}"', 'C', 'f"{name:^10}"', 'D', 'f"{name:10}"'), 
    1, 
    JSON_ARRAY('> 表示右对齐，< 表示左对齐，^ 表示居中。', '宽度直接写在冒号后面。', '检查哪个选项用了 >。'), 
    'f"{name:>10}" 会在总宽 10 中把 name 右对齐。', 
    '例如 f"{\"x\":^5}" → "  x  "。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    348, 
    24, 
    '数字填充与对齐', 
    'n = 7，想用 f-string 显示为三位宽并在左边补零 "007"，正确写法是？', 
    JSON_OBJECT('A', 'f"{n:03d}"', 'B', 'f"{n:0>3}"', 'C', 'f"{n:03}"', 'D', 'f"{n:3d}"'), 
    1, 
    JSON_ARRAY('整数格式化常用 d。', '0 填充通常写成 0 后跟宽度。', '选项 A 是常见正确写法。'), 
    'f"{n:03d}" 使用零填充并指定整数格式 d，得到 "007"。', 
    '例如 f"{5:04d}" → "0005"。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    349, 
    24, 
    '复习 f-string 基础：变量插入', 
    '若 name = "Tom"，下列哪一项是合法的 f-string 变体？', 
    JSON_OBJECT('A', 'f"Hello {name}"', 'B', '"Hello {name}"', 'C', 'f"Hello "+name', 'D', '"Hello " + {name}'), 
    1, 
    JSON_ARRAY('f-string 必须以 f 或 F 开头。', '{} 内放变量。', '选项 B 虽含 {} 但缺少 f 前缀。'), 
    '只有 f"Hello {name}" 是正确的 f-string 写法。', 
    'f"User: {user}" 可以直接嵌入变量。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    350, 
    24, 
    '复习 f-string 基础：表达式', 
    '下列哪项能在 f-string 中进行运算并插入结果？', 
    JSON_OBJECT('A', 'f"{2 * 3}"', 'B', 'f"{2 * 3;}"', 'C', 'f"{2 **}"', 'D', 'f"{2 * }"'), 
    1, 
    JSON_ARRAY('花括号中允许合法表达式。', '分号会导致语法错误。', '选项 A 是正确完整表达式。'), 
    'f"{2 * 3}" 会插入表达式结果 "6"。', 
    '例如 f"{a + b}" 可以直接插入计算值。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    351, 
    24, 
    '复习 f-string 基础：花括号输出', 
    '要在 f-string 中输出一个真实的花括号字符 "{"，应该怎么写？', 
    JSON_OBJECT('A', 'f"{{"', 'B', 'f"\\{"', 'C', 'f"{{{"', 'D', '"{"'), 
    1, 
    JSON_ARRAY('花括号本身是 f-string 的语法符号。', '需要成对写两个花括号表示一个文字花括号。', '选项 A 用两个花括号表示一个。'), 
    '在 f-string 中用 "{{" 或 "}}" 来输出字面上的花括号。', 
    'f"Set = {{1,2,3}}" → 输出 Set = {1,2,3}'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    352, 
    24, 
    '格式化字符串：填充字符', 
    '要把 s = "7" 格式化为 "*7*"（在左右各填充一个星号，总宽度 3），哪个 f-string 写法最合适？', 
    JSON_OBJECT('A', 'f"{s:*^3}"', 'B', 'f"{s:*>3}"', 'C', 'f"{s:*<3}"', 'D', 'f"{s:*3^}"'), 
    1, 
    JSON_ARRAY('^ 表示居中，左右填充字符写在最前面。', '格式是 {变量:填充符对齐宽度}。', '检查哪个选项使用了 ^ 并放置了填充符 *。'), 
    'f"{s:*^3}" 会让 s 居中并在两边用 * 填充，结果 "*7*".', 
    'f"{\"x\":-^5}" → "--x--"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    353, 
    24, 
    '数字显示为科学计数法', 
    'x = 12345678，要用 f-string 输出为科学计数法（如 1.234568e+07），应使用哪个格式类型？', 
    JSON_OBJECT('A', 'f"{x:.6e}"', 'B', 'f"{x:.6f}"', 'C', 'f"{x:,.6f}"', 'D', 'f"{x:d}"'), 
    1, 
    JSON_ARRAY('科学计数法的格式字符是 e 或 E。', '.6 表示保留小数位数。', '选项 A 使用了 e。'), 
    'f"{x:.6e}" 会以科学计数法显示并保留 6 位小数。', 
    'f"{0.00123:.2e}" → "1.23e-03"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    354, 
    24, 
    '控制符号显示（正负号）', 
    '想让数字总带符号显示（正数带 +，负数带 -），应使用什么格式？', 
    JSON_OBJECT('A', 'f"{n:+d}"', 'B', 'f"{n:d}"', 'C', 'f"{n: d}"', 'D', 'f"{n:0d}"'), 
    1, 
    JSON_ARRAY('+ 号用于显式显示正负号。', '在格式说明符位置放 +。', '选项 A 使用了 +。'), 
    'f"{n:+d}" 会把正数显示为 "+X"，负数显示为 "-Y"。', 
    'n = 5 → f"{n:+d}" → "+5"'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    355,
    24,
    '在 f-string 中格式化百分比',
    '把 0.8532 显示为 "85.32%"（保留两位小数并乘 100）',
    'rate = 0.8532',
    JSON_ARRAY('85.32%'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": "\"{"}, {"type": "slot", "index": 1}, {"type": "code", "value": " * 100:"}, {"type": "slot", "index": 2}, {"type": "code", "value": "}%\" )"}]}]}',
    JSON_ARRAY('f', 'rate', '2', '.2f', '.2', ':.2f', '100'),
    JSON_ARRAY(1, 2, 6, 4),
    '需要 f-string：f"{rate * 100:.2f}%"；选项顺序对应 f, rate, : .2f, .2f（题中替换为相应编号）。',
    '例如 f"{0.5 * 100:.1f}%" → "50.0%"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    356,
    24,
    '将整数按千分位格式化',
    '把 number = 1234567 用 f-string 格式化为 "1,234,567"（使用格式说明符）。',
    'number = 1234567',
    JSON_ARRAY('1,234,567'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": "\"{"}, {"type": "slot", "index": 1}, {"type": "code", "value": ":"}, {"type": "slot", "index": 2}, {"type": "code", "value": "}\" )"}]}]}',
    JSON_ARRAY('f', 'number', ',', '_', ':', '",d"', ',d', '",_"', '",d"'),
    JSON_ARRAY(1, 2, 6),
    '正确写法为 f"{number:,d}"，代表千位分隔符。这里选择 f, number, ",d" 对应位置。',
    '例如 f"{12345:,d}" → "12,345"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    357,
    24,
    '复习：在 f-string 中使用变量',
    '补全 f-string，将 user 和 score 插入字符串 "User: Tom, Score: 95"。',
    'user = "Tom"
score = 95',
    JSON_ARRAY('User: Tom, Score: 95'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": "\"User: {"}, {"type": "slot", "index": 1}, {"type": "code", "value": "}, Score: {"}, {"type": "slot", "index": 2}, {"type": "code", "value": "}\" )"}]}]}',
    JSON_ARRAY('f', 'user', 'score', 'name', '"{"', '"}"'),
    JSON_ARRAY(1, 2, 3),
    '需要 f-string：f"User: {user}, Score: {score}"。',
    '例如 f"ID: {id}, Age: {age}"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    358,
    24,
    '复习：表达式与格式说明组合',
    '把 3.14159 显示为 "3.1416"（四舍五入到 4 位），用 f-string 完成。',
    'pi = 3.14159',
    JSON_ARRAY('3.1416'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": "\"{"}, {"type": "slot", "index": 1}, {"type": "code", "value": ":"}, {"type": "slot", "index": 2}, {"type": "code", "value": "}\" )"}]}]}',
    JSON_ARRAY('f', 'pi', '.4f', ':.4f', '4f', '":.4f"', '4'),
    JSON_ARRAY(1, 2, 4),
    '正确格式为 f"{pi:.4f}"，选项依次为 f, pi, : .4f。',
    'f"{2/3:.3f}" → "0.667"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    359,
    24,
    '用 f-string 控制小数填宽并补零',
    '将 value = 2.5 显示为 "002.50"（总宽 6，整数部分补零，保留两位小数）。',
    'value = 2.5',
    JSON_ARRAY('002.50'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": "\"{"}, {"type": "slot", "index": 1}, {"type": "code", "value": ":"}, {"type": "slot", "index": 2}, {"type": "code", "value": "."}, {"type": "slot", "index": 3}, {"type": "code", "value": "}\" )"}]}]}',
    JSON_ARRAY('f', 'value', '2', '.2f', ':0>6', '6', '0>6'),
    JSON_ARRAY(1, 2, 7, 4),
    '组合说明符为 0>6 表示左侧 0 填充到宽度 6，.2f 保留两位小数：f"{value:0>6.2f}"。',
    '例如 f"{3.1:0>6.2f}" → "003.10"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    360,
    24,
    '混合示例：百分比与宽度',
    '将 ratio = 0.7563 显示为宽度 8，保留 1 位小数并带百分号（结果 "   75.6%")。',
    'ratio = 0.7563',
    JSON_ARRAY('   75.6%'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": "\"{"}, {"type": "slot", "index": 1}, {"type": "code", "value": " * "}, {"type": "slot", "index": 2}, {"type": "code", "value": ":"}, {"type": "slot", "index": 3}, {"type": "code", "value": "."}, {"type": "slot", "index": 4}, {"type": "code", "value": "f}%\" )"}]}]}',
    JSON_ARRAY('f', 'ratio', '1', '.1f', ':.1f', '100', '>8'),
    JSON_ARRAY(1, 2, 6, 7, 4),
    '需要 f-string：f"{ratio * 100:>8.1f}%"；步骤为乘 100、指定宽度 >8 与格式 .1f，然后再加 % 符号。',
    '例如 f"{0.5*100:>6.1f}%" → " 50.0%"'
);