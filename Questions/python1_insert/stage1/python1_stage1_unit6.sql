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
  ('1', 6, '加法运算的作用', '', JSON_OBJECT('A', '只用于数字相加', 'B', '用于多种类型之间的加法，如数字相加或字符串拼接', 'C', '用于比较两个数字', 'D', '只能用于整数之间'), 2, JSON_ARRAY('注意：+ 不仅能算数学。', '想想字符串之间的 + 会发生什么。', 'Python 是多才多艺的语言。'), '+ 可以用于数值相加，也可以用于字符串拼接。', '示例：''Hello '' + ''World'' → ''Hello World''');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('2', 6, '减法的基础', '', JSON_OBJECT('A', '6', 'B', '7', 'C', '14', 'D', '20'), 1, JSON_ARRAY('简单的数学题。', '10 减去 4。', '你一定做过很多次这种计算。'), '10 - 4 = 6。', '示例：20 - 5 → 15');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('3', 6, '加法的自动类型提升', '', JSON_OBJECT('A', '整数', 'B', '字符串', 'C', '浮点数', 'D', '布尔值'), 3, JSON_ARRAY('想想浮点数和整数混合运算的规则。', '浮点数可以表示更广的范围。', 'Python 会“向上兼容”。'), '整数与浮点运算时，整数会被提升为 float。', '示例：3 + 0.2 → 3.2');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('7', 6, '减法的类型要求', '', JSON_OBJECT('A', 'Python 不支持数字运算', 'B', '字符串不能直接进行减法运算', 'C', '10 和 2 不是数字', 'D', 'Python 不支持减法'), 2, JSON_ARRAY('想想字符串能做什么。', '它们可以拼接但不能相减。', '这和数学运算不一样。'), '字符串减法无意义，Python 会报错。', '示例：不能执行 ''abc'' - ''a''');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('8', 6, '加法的运算顺序', '', JSON_OBJECT('A', '(1 + 2) + 3', 'B', '1 + (2 + 3)', 'C', '完全随机', 'D', '由 Python 版本决定'), 1, JSON_ARRAY('加法是左结合运算。', '先左后右的顺序。', 'Python 和大多数语言一样。'), '加法是左结合，即从左向右计算。', '示例：(10 + 2) + 5 → 17');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('11', 6, '正负号的结合', '', JSON_OBJECT('A', '-8', 'B', '2', 'C', '8', 'D', '5'), 2, JSON_ARRAY('注意 -3 是负数。', '5 加上一个负的 3。', '相当于 5 - 3。'), '5 + (-3) = 2。', '示例：10 + -7 → 3');

-- ---------- 插入填空题 ----------
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('4', 6, '加法练习', '', NULL, JSON_ARRAY('15'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "a = 9\nb = 6\nprint(a "}, {"type": "slot", "index": 0}, {"type": "code", "value": "__ b)"}]}]}', JSON_ARRAY('+', '-', '*', '/', '//', '%', '**', 'and', 'or'), JSON_ARRAY(1), '9 + 6 = 15。', '示例：2 + 3 → 5');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('5', 6, '减法练习', '', NULL, JSON_ARRAY('-2'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "x = 3\ny = 5\nz = x "}, {"type": "slot", "index": 0}, {"type": "code", "value": "__ y\nprint(z)"}]}]}', JSON_ARRAY('+', '-', '*', '/', '//', '%', '**', 'and', 'or'), JSON_ARRAY(2), '3 - 5 = -2。', '示例：10 - 13 → -3');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('9', 6, '字符串拼接错误修复', '', NULL, JSON_ARRAY('Total: 30'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "num = 30\ntext = ''Total: '' "}, {"type": "slot", "index": 0}, {"type": "code", "value": "__ num\nprint(text)"}]}]}', JSON_ARRAY('+', '-', '*', '/', 'str(num)', 'int(num)', '''30''', '''', '''', '''%s''', '''.'''), JSON_ARRAY(5), '需要将整数转换为字符串。', '示例：''Score: '' + str(100)');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('10', 6, '加法连算', '', NULL, JSON_ARRAY('18'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "a = 5\nb = 7\nc = 6\ntotal = a + b "}, {"type": "slot", "index": 0}, {"type": "code", "value": "__ c\nprint(total)"}]}]}', JSON_ARRAY('+', '-', '*', '/', 'and', 'or', '//', '%'), JSON_ARRAY(1), '5 + 7 + 6 = 18。', '示例：1 + 2 + 3 → 6');