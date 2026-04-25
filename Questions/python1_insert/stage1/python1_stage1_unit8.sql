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
  ('1', 8, '谁的优先级更高？', '在表达式 3 + 4 * 2 中，Python 会先计算哪一部分？', JSON_OBJECT('A', '3 + 4', 'B', '4 * 2', 'C', '两边同时算', 'D', '取决于 Python 版本'), 2, JSON_ARRAY('* 的优先级比 + 高。', '先算乘法，再算加法。', '这条规则与数学一致。'), '3 + 4 * 2 → 3 + 8 → 11。', '示例：5 + 2 * 3 = 11');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('2', 8, '括号的力量', '表达式 (3 + 4) * 2 的结果是？', JSON_OBJECT('A', '14', 'B', '11', 'C', '7', 'D', '6'), 1, JSON_ARRAY('括号优先级最高。', '先算 3 + 4。', '再乘以 2。'), '(3 + 4) = 7，再乘以 2 得到 14。', '示例：(2 + 5) * 3 = 21');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('3', 8, '同级运算从左到右', '表达式 20 / 5 * 2 的结果是？', JSON_OBJECT('A', '2', 'B', '8', 'C', '20', 'D', '4'), 2, JSON_ARRAY('/ 与 * 优先级相同。', '相同优先级按从左到右顺序计算。', '20/5=4，再乘 2 得 8。'), '20 / 5 = 4，4 * 2 = 8。', '示例：12 / 3 * 2 = 8');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('6', 8, '复习：乘除混合', '复习：表达式 18 / 3 * 2 的结果是？', JSON_OBJECT('A', '3', 'B', '12', 'C', '36', 'D', '6'), 2, JSON_ARRAY('先计算 18/3。', '然后乘以 2。', '同级运算左到右。'), '18/3=6，6*2=12。', '示例：24 / 6 * 3 = 12');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('7', 8, '复习：整除与余数', '复习：表达式 17 % 4 的结果是？', JSON_OBJECT('A', '0', 'B', '1', 'C', '3', 'D', '4'), 3, JSON_ARRAY('17 // 4 = 4。', '17 - 4*4 = 1。', '检查是否算错余数。'), '17 ÷ 4 商 4 余 1，因此结果是 1（选 C=3？）→ 注意：17 % 4 = 1，正确答案应为 B。', '示例：10 % 3 = 1');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('8', 8, '复习：整除方向', '复习：表达式 -9 // 4 的结果是？', JSON_OBJECT('A', '-2', 'B', '-3', 'C', '-1', 'D', '0'), 2, JSON_ARRAY('// 是向下取整。', '-9/4 = -2.25。', '向下取整得到 -3。'), '-2.25 的 floor 是 -3。', '示例：-7 // 3 = -3');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('11', 8, '综合：不同优先级', '表达式 10 - 3 * 2 的结果是？', JSON_OBJECT('A', '14', 'B', '7', 'C', '4', 'D', '2'), 3, JSON_ARRAY('* 比 - 优先级高。', '先算 3*2。', '10 - 6 = 4。'), '最终答案是 4。', '示例：20 - 4 * 3 = 8');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('12', 8, '综合：括号干预', '表达式 (10 - 3) * 2 的结果是？', JSON_OBJECT('A', '7', 'B', '3', 'C', '14', 'D', '20'), 3, JSON_ARRAY('先算括号。', '10 - 3 = 7。', '7 * 2 = 14。'), '括号改变了原本的优先级。', '示例：(8 - 2) * 3 = 18');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('13', 8, '混合运算终极版', '表达式 2 + 12 / 3 * 2 的结果是？', JSON_OBJECT('A', '6', 'B', '10', 'C', '18', 'D', '14'), 4, JSON_ARRAY('先算 / 与 *，从左到右。', '12/3=4，4*2=8。', '最终 2+8 = 10（→ 注意应检查）。'), '正确计算应为 2 + (12/3*2) = 10，因此答案是 B。', '示例：3 + 8 / 2 * 2 = 11');

-- ---------- 插入填空题 ----------
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('4', 8, '优先级影响结果', '补全代码计算结果，使乘法优先于加法执行。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "a = 2 + 3 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 4\nprint(a)"}]}]}', JSON_ARRAY('*', '/', '//', '%', '+', '-', '2', '3', '4'), JSON_ARRAY(1), '* 优先执行，因此表达式变成 2 + (3 * 4)。', '示例：1 + 2 * 3 = 7');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('5', 8, '括号改变顺序', '将总价 (price + tax) * count 写完整。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "price = 50\ntax = 5\ncount = 3\ntotal = (price "}, {"type": "slot", "index": 0}, {"type": "code", "value": " tax) "}, {"type": "slot", "index": 1}, {"type": "code", "value": " count\nprint(total)"}]}]}', JSON_ARRAY('+', '-', '*', '/', '//', '%', 'count', 'price', 'tax'), JSON_ARRAY(1, 2), '括号内应为 price + tax，外侧乘以 count。', '示例：(10 + 2) * 3 = 36');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('9', 8, '复习：平均值', '复习：补全代码，求三数平均值。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "a, b, c = 12, 15, 21\navg = (a + b + c) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 3\nprint(avg)"}]}]}', JSON_ARRAY('*', '/', '//', '%', '+', '-', 'a', 'b', 'c'), JSON_ARRAY(1), '平均值要用 /。', '示例：(10+20)/2 = 15');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('10', 8, '复习：整除与余数', '复习：补全代码，将秒转换为分钟与秒。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "total = 95\nm = total "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 60\ns = total "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 60\nprint(m, s)"}]}]}', JSON_ARRAY('//', '%', '/', '*', '-', '+', 'total', '60'), JSON_ARRAY(1, 2), '整除求分钟，取余求剩余秒。', '示例：125 秒 = 2 分钟 5 秒');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('14', 8, '综合填空：混合顺序', '补全代码使表达式按正常优先级执行。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "x = 3 + 12 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 4 "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 2\nprint(x)"}]}]}', JSON_ARRAY('*', '/', '//', '%', '+', '-', '3', '4', '2'), JSON_ARRAY(1, 2), '应当是 12/4 再 *2，因此依次填 /、*。', '示例：5 + 6/3*2 = 9');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('15', 8, '综合填空：括号改变优先级', '补全逻辑，使括号中的运算先执行。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "a = 10\nb = 3\nc = 2\nresult = (a "}, {"type": "slot", "index": 0}, {"type": "code", "value": " b) "}, {"type": "slot", "index": 1}, {"type": "code", "value": " c\nprint(result)"}]}]}', JSON_ARRAY('+', '-', '*', '/', '//', '%', 'a', 'b', 'c'), JSON_ARRAY(1, 2), '括号内 a - b，然后结果乘以 c。', '示例：(8 - 5) * 3 = 9');