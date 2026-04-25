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
  ('1', 14, '切片最基础的形式', '字符串 s = "Python" ，想取得前 3 个字符，应使用哪种切片？', JSON_OBJECT('A', 's[0:2]', 'B', 's[0:3]', 'C', 's[1:3]', 'D', 's[:2]'), 2, JSON_ARRAY('切片的结束索引不包含在结果内。', '前 3 个字符的索引范围是 0、1、2。', '因此切片应该写成 0:3。'), 's[0:3] 能正确取得 "Pyt"。', '例如取得前 4 个字符可写成 s[:4]');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('2', 14, '省略起始索引', '若 s = "Hello"，使用 s[:2] 会得到什么？', JSON_OBJECT('A', '"He"', 'B', '"Hel"', 'C', '"H"', 'D', '"ello"'), 1, JSON_ARRAY('省略开始索引表示从 0 开始取。', '结束索引 2 不包含在结果内。', '因此得到索引 0 和 1。'), 's[:2] → "He"。', '例如 s[:4] 则是 "Hell"');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('3', 14, '省略结束索引', '若 s = "Python"，表达式 s[2:] 代表什么意思？', JSON_OBJECT('A', '取索引 2 之前的所有字符', 'B', '只取索引 2 的字符', 'C', '从索引 2 开始取到末尾', 'D', '报错'), 3, JSON_ARRAY('结束索引省略代表一直取到字符串结束。', '索引 2 是字符串的第三个字符。', '所以会从 "t" 开始取到结尾。'), 's[2:] 取得 "thon"。', '例如 s[1:] 会得到 "ython"');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('6', 14, '切片与空结果', 's = "Hi"，执行 s[5:8] 会得到什么？', JSON_OBJECT('A', '"Hi"', 'B', '"i"', 'C', '""', 'D', '报错'), 3, JSON_ARRAY('索引超出长度不会报错。', '超出范围的切片会返回空字符串。', '不是 None，而是 ""。'), '超出范围的切片不会报错，只会返回空字符串。', '例如 s[10:20] 也会得到 ""');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('7', 14, '负索引切片 1', 's = "Python"，s[-3:] 的结果是什么？', JSON_OBJECT('A', '"hon"', 'B', '"tho"', 'C', '"n"', 'D', '"on"'), 1, JSON_ARRAY('负索引 -1 是最后一个字符。', '因此 -3 对应 "h"。', '从 "h" 一直到末尾就是 "hon"。'), 's[-3:] 取得最后三个字符 "hon"。', '例如 s[-2:] 则是 "on"');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('8', 14, '负索引切片 2', '若 s = "Coffee"，s[:-3] 的结果是什么？', JSON_OBJECT('A', '"Cof"', 'B', '"Coff"', 'C', '"Co"', 'D', '"Coffee"'), 2, JSON_ARRAY('结束索引 -3 不包含结果。', '倒数第 3 字符是 "f"（从后往前数）。', '因此取到这个 "f" 之前。'), 's[:-3] → "Coff"。', '例如 s[:-1] 则去掉最后一个字符 → "Coffe"');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('11', 14, '理解步长基础', '若 s = "abcdef"，表达式 s[0:6:2] 的结果是什么？', JSON_OBJECT('A', '"abc"', 'B', '"ace"', 'C', '"bdf"', 'D', '"af"'), 2, JSON_ARRAY('步长为 2，表示每隔一个取一个。', '索引 0、2、4 分别对应 a、c、e。', '因此结果为 "ace"。'), '切片 s[0:6:2] 会取出 a、c、e。', '例如 s[1:6:2] 则是 "bdf"');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('12', 14, '用切片逆序字符串', '使用 s[::-1] 的作用是什么？', JSON_OBJECT('A', '复制字符串', 'B', '删除最后一个字符', 'C', '倒序字符串', 'D', '每隔两个字符取一个'), 3, JSON_ARRAY('步长为负数代表逆向。', '结束与起始可省略，表示从末尾一路取回开头。', '因此整个字符串被倒转。'), 's[::-1] 是最经典的字符串反转写法。', '例如 "abc"[::-1] 会得到 "cba"');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('13', 14, '切片不会修改原字符串', '关于字符串切片，下列说法正确的是？', JSON_OBJECT('A', '切片会直接修改原字符串', 'B', '切片结果是一个列表', 'C', '切片会返回一个新的字符串', 'D', '切片只能从左往右取'), 3, JSON_ARRAY('字符串是不可变类型。', '切片结果一定是新字符串。', '切片当然能从右向左取（使用步长 -1）。'), '切片返回新字符串，原字符串不会被更改。', '例如 s2 = s[:] 会生成一个完整的字符串副本');

-- ---------- 插入填空题 ----------
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('4', 14, '提取前半部分', '根据切片规则补全代码，取得字符串的前 4 个字符。', 's = "GoodDay"', JSON_ARRAY('Good'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "result = s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "]\nprint(result)"}]}]}', JSON_ARRAY('0:3', '0:4', '1:4', ':4', '2:6'), JSON_ARRAY(2), '要取得前 4 个字符，切片应写成 s[0:4]；对应选项是 "0:4"。', '例如 s[:3] 可以取得前三个字符 "Goo"');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('5', 14, '使用省略语法', '补全切片，使代码输出 "Py"。', 's = "Python"', JSON_ARRAY('Py'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}', JSON_ARRAY('0:2', ':2', '1:3', '0:1', '2:4', ':3'), JSON_ARRAY(2), 's[:2] 刚好是 "Py"，对应选项 ":2"。', '例如 s[:1] 会输出 "P"');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('9', 14, '结合起始与结束索引', '补全切片，使输出 "yth"。', 's = "Python"', JSON_ARRAY('yth'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}', JSON_ARRAY('1:4', '1:5', '2:5', '1:3', '2:6', '0:3'), JSON_ARRAY(2), '"yth" 对应的索引是 1、2、3、4 → s[1:5]。', '例如 s[2:6] 会输出 "thon"');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('10', 14, '切片获取中间一段', '补全代码，取得中间字符 "odD"。', 's = "GoodDay"', JSON_ARRAY('odD'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "middle = s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "]\nprint(middle)"}]}]}', JSON_ARRAY('2:5', '3:6', '1:4', '2:6', '1:5', '0:3'), JSON_ARRAY(1), 's[2:5] 对应字符 "o"、"d"、"D" → "odD"。', '例如 s[1:4] 则是 "ood"');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('14', 14, '步长的运用', '补全代码，使输出 "Hlo"。', 's = "Hello"', JSON_ARRAY('Hlo'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}', JSON_ARRAY('0:5:2', ':5:2', '1:5:2', '0:4:2', ':4:2', '2:5:2'), JSON_ARRAY(1), 's[0:5:2] 取得索引 0(h)、2(l)、4(o)。', '例如 s[1:5:2] 会得到 "el"');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('15', 14, '综合：负索引 + 步长', '补全切片，使输出 "yaD"。', 's = "GoodDay"', JSON_ARRAY('yaD'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}', JSON_ARRAY('-1:-4:-1', '-1:-5:-1', '-2:-5:-1', '-1:-3:-1', '-2:-4:-1', '-3:-6:-1'), JSON_ARRAY(1), '要取得 "y"、"a"、"D"，对应索引 -1、-2、-3 → s[-1:-4:-1]。', '例如 s[-1:-6:-1] 会输出更多字符 "yaDoo"');