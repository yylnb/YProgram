USE `questions`;

CREATE TABLE IF NOT EXISTS `que_choice_py_1` (
  `q_id` VARCHAR(255) NOT NULL,
  `unit_id` INT NOT NULL,
  `title` VARCHAR(255),
  `text` TEXT,
  `options` JSON,
  `answer` INT,
  `hints` JSON,
  `explanation` TEXT,
  `example` TEXT,
  PRIMARY KEY (`q_id`, `unit_id`)
);

CREATE TABLE IF NOT EXISTS `que_fill_py_1` (
  `q_id` VARCHAR(255) NOT NULL,
  `unit_id` INT NOT NULL,
  `title` VARCHAR(255),
  `text` TEXT,
  `input` TEXT,
  `output` JSON,
  `code` JSON,
  `options` JSON,
  `answer` JSON,
  `explanation` TEXT,
  `example` TEXT,
  PRIMARY KEY (`q_id`, `unit_id`)
);

-- ---------- 插入选择题 ----------
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('2', 13, '常见转义字符', '以下哪个转义字符能在字符串中产生换行？', JSON_OBJECT('A', '\\t', 'B', '\\n', 'C', '\\r', 'D', '\\s'), 2, JSON_ARRAY('想象一下你敲 Enter 键。', 'Python 中换行有一个非常经典的表示方式。', '它以 n 开头，类似“new line”。'), '\\n 表示换行，是最常用的转义字符之一。', '例如 print("Hello\\nWorld") 会换行输出两行。');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('3', 13, '反斜杠本身如何表示', '如果你想在字符串中显示一个真实的反斜杠 \\ ，你应该怎么写？', JSON_OBJECT('A', '"\\\\"', 'B', '"\\""', 'C', '"\\""', 'D', '"\\/"'), 1, JSON_ARRAY('反斜杠用于转义自身。', '要显示一个反斜杠，需要用两个反斜杠写在字符串中。', '第一个是转义符，第二个是实际内容。'), '写成 "\\\\" 会在最终输出中显示一个单反斜杠。', '例如路径写成 "C:\\\\User" 才能正确输出 C:\\User。');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('6', 13, '复习：字符串拼接基础', '以下哪一项能正确拼接两个字符串？', JSON_OBJECT('A', '"Hi" * "There"', 'B', '"Hi" + "There"', 'C', 'add("Hi","There")', 'D', '"Hi" & "There"'), 2, JSON_ARRAY('拼接通常意味着“放到一起”。', 'Python 有一个专门用于连接字符串的符号。', '就是加号 + 。'), '使用 + 能将两个字符串拼接为一个字符串。', '例如 "A" + "B" 得到 "AB"。');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('7', 13, '复习：重复字符串', '下面哪一个表达式能输出 "ha" 三次？', JSON_OBJECT('A', '"ha" + 3', 'B', '3 + "ha"', 'C', '"ha" * 3', 'D', '"ha" ** 3'), 3, JSON_ARRAY('数字与字符串之间用 * 时含义特殊。', '它会让字符串重复。', '也就是 "ha" * 3 → "hahaha"。'), '使用 * 可以让字符串重复指定次数。', '例如 "-" * 5 会输出 "-----"。');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('8', 13, '复习：混合拼接问题', '以下哪项会导致错误？', JSON_OBJECT('A', '"Hi" + "!"', 'B', '"Hi" * 2', 'C', '"Hi" + 2', 'D', '"Hi" + "2"'), 3, JSON_ARRAY('只有字符串才能拼接字符串。', '数字不能直接与字符串相加。', '要么用 str() 转换，要么确保两边都是字符串。'), '"Hi" + 2 会报错，因为不能把字符串和整数直接相加。', '如果必须拼接，可写成 "Hi" + str(2)。');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('13', 13, '多重转义理解', '以下哪个字符串经过解释后会输出 \\n？', JSON_OBJECT('A', '"\\\\n"', 'B', '"\\n"', 'C', '"\\\\\\n"', 'D', 'r"\\n"'), 1, JSON_ARRAY('想输出 \\n，需要两个反斜杠加 n。', '写成 "\\\\n" 才能在最终结果中看到 \\n。', '记住：输入两个反斜杠 → 输出一个反斜杠。'), '"\\\\n" 经过转义后变成 \\n 字面内容，而不是换行。', '例如 "\\\\t" 会输出 \\t。');

-- ---------- 插入填空题 ----------
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('5', 13, '基础转义：换行效果', '补全代码，使其打印两行内容：Hello 和 World。', NULL, JSON_ARRAY('Hello
World'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(\"Hello"}, {"type": "slot", "index": 0}, {"type": "code", "value": "World\")"}]}]}', JSON_ARRAY('\\n', '\\t', '\\r', '\\\\"', '" "'), JSON_ARRAY(1), '使用 \\n 可以在字符串中产生换行。', '例如 "A\\nB" 会让 A 与 B 分别在两行。');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('9', 13, '复习：拼接姓名展示', '补全代码，使其拼接用户的姓与名。', 'first = "Li"
last = "Lei"', JSON_ARRAY('Li Lei'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "full = first "}, {"type": "slot", "index": 0}, {"type": "code", "value": " \" \" "}, {"type": "slot", "index": 1}, {"type": "code", "value": " last\nprint(full)"}]}]}', JSON_ARRAY('+', '*', '', '', 'and', 'or', '+ " " +'), JSON_ARRAY(1, 1), '字符串相加使用 +，因此 first + " " + last 才能产生 Li Lei。', '例如 city + ", " + country 可以组合地点名称。');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('10', 13, '复习：生成重复提示', '补全代码，让程序输出三次“Go!”。', NULL, JSON_ARRAY('Go!Go!Go!'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "msg = \"Go!\"\nprint("}, {"type": "slot", "index": 0}, {"type": "code", "value": " "}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}]}', JSON_ARRAY('msg', '"Go!"', '*', '+', '**', '3'), JSON_ARRAY(1, 3), '字符串重复使用 *，所以需要 msg * 3。', '例如 "-" * 10 能画一条分隔线。');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('14', 13, '转义与路径处理', '补全代码，使其正确输出 Windows 路径。', NULL, JSON_ARRAY('C:\\User\\Files'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "path = \"C:\\\\User\\\\"}, {"type": "slot", "index": 0}, {"type": "code", "value": "\"\nprint(path)"}]}]}', JSON_ARRAY('Files', 'File', '\\Files', '"Files"', 'user'), JSON_ARRAY(1), '路径中的反斜杠需要写成 \\\\，最后部分写 Files 即可。', '例如 "D:\\\\Data\\\\Temp" 用双反斜杠写法才有效。');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('15', 13, '综合：转义 + 拼接', '补全代码，使其打印 "Hello
Python"（带换行）。', NULL, JSON_ARRAY('Hello
Python'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "a = \"Hello\"\nb = \"Python\"\nprint(a "}, {"type": "slot", "index": 0}, {"type": "code", "value": " \"\\n\" "}, {"type": "slot", "index": 1}, {"type": "code", "value": " b)"}]}]}', JSON_ARRAY('+', '*', 'and', 'or', '', '', '+ " " +'), JSON_ARRAY(1, 1), '拼接字符串仍然用 +，所以 a + "\\n" + b。', '例如 "A" + "\\t" + "B" 会在中间加入制表符。');