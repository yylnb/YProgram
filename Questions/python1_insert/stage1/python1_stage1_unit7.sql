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
  ('1', 7, '乘法的基本理解', '在 Python 中，表达式 7 * 3 的结果是？', JSON_OBJECT('A', '10', 'B', '18', 'C', '21', 'D', '73'), 3, JSON_ARRAY('乘法在 Python 中与日常数学一致。', '7 乘以 3 是一个基础运算。', '7 加 7 加 7 的总和是多少？'), '7 * 3 = 21，是最基础的整数乘法。', '示例：8 * 2 = 16');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('2', 7, '除法的结果类型', '在 Python 中，表达式 8 / 2 得到的结果类型是？', JSON_OBJECT('A', '始终为 int', 'B', '始终为 float', 'C', '若整除则为 int，否则为 float', 'D', '取决于 Python 版本'), 2, JSON_ARRAY('Python 的 / 为“真除法”。', '真除法无论是否整除都返回同一种类型。', '运行 type(8/2) 即可确认。'), 'Python 的 / 运算永远返回 float 类型。', '示例：5 / 1 的结果是 5.0（float）');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('3', 7, '整除的方向', '表达式 7 // 3 的结果是？', JSON_OBJECT('A', '2', 'B', '2.333…', 'C', '3', 'D', '取决于是否四舍五入'), 1, JSON_ARRAY('// 是向下取整的整除。', '7 除以 3 大约是 2.333。', '向下取最接近的整数是多少？'), '7 // 3 = 2，因为整除是向下（floor）取整。', '示例：10 // 4 = 2');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('6', 7, '浮点除法的结果', '9 / 4 的值是？', JSON_OBJECT('A', '2', 'B', '2.0', 'C', '2.25', 'D', '2.33333'), 3, JSON_ARRAY('想想日常数学中的 9 ÷ 4。', 'Python 的 / 结果永远是浮点数。', '计算 9 除以 4 即可得到。'), '9 除以 4 的精确值为 2.25。', '示例：10 / 4 = 2.5');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('7', 7, '整除与负数', '表达式 -7 // 3 的结果是？', JSON_OBJECT('A', '-2', 'B', '-3', 'C', '-1', 'D', '0'), 2, JSON_ARRAY('// 是向下取整（floor）。', '向下取整不是“截断”。', '-7 ÷ 3 大约是 -2.333。'), 'floor(-2.333) = -3，因此结果是 -3。', '示例：-5 // 2 = -3');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('8', 7, '取余含义', '表达式 17 % 5 的结果是？', JSON_OBJECT('A', '2', 'B', '3', 'C', '5', 'D', '1'), 1, JSON_ARRAY('余数 = 被除数 - (除数 × 整除结果)。', '17 // 5 = 3。', '17 - 3*5 = 2。'), '17 ÷ 5 商 3 余 2，因此结果为 2。', '示例：10 % 3 = 1');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('11', 7, '混合运算优先级', '表达式 6 + 3 * 2 的结果是？', JSON_OBJECT('A', '12', 'B', '18', 'C', '6', 'D', '30'), 1, JSON_ARRAY('* 的优先级高于 +。', '先算 3 * 2。', '再加上 6。'), '6 + (3*2) = 12。', '示例：10 + 2 * 3 = 16');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('12', 7, '百分比计算', '要计算 200 的 15%，以下哪种写法正确？', JSON_OBJECT('A', '200 * 15', 'B', '200 / 15', 'C', '200 * 0.15', 'D', '200 % 15'), 3, JSON_ARRAY('百分数要转化为小数乘法。', '比如 20% = 0.2。', '因此 15% = 0.15。'), '百分比换成小数后乘即可。', '示例：80 的 20% = 80 * 0.2 = 16');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('13', 7, '长宽计算面积', '长 12，宽 3 的矩形面积计算式为？', JSON_OBJECT('A', '12 + 3', 'B', '12 * 3', 'C', '12 / 3', 'D', '12 // 3'), 2, JSON_ARRAY('面积 = 长 × 宽。', '这里不涉及除法。', '也不涉及整除或余数。'), '12 * 3 = 36。', '示例：5 * 4 = 20');

-- ---------- 插入填空题 ----------
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('4', 7, '订单金额折扣计算', '完成下面代码，使程序正确计算折扣价格。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "price = 80\nrate = 0.75\ntotal = price * "}, {"type": "slot", "index": 0}, {"type": "code", "value": "\nprint(total)"}]}]}', JSON_ARRAY('rate', 'price', '//', '*', '/', '0.25', '0.75', 'total'), JSON_ARRAY(1), '折扣价 = price * rate，因此填入 rate。', '示例：100 * 0.8 表示 8 折价格。');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('5', 7, '平均分计算', '补全代码，使其计算三门课的平均分。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "a = 80\nb = 90\nc = 100\navg = (a + b + c) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 3\nprint(avg)"}]}]}', JSON_ARRAY('*', '/', '//', '%', '+', '-', '3', '(a+b+c)'), JSON_ARRAY(1), '计算平均值需要除以科目数量，故应填 /。', '示例：(10 + 20) / 2 = 15');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('9', 7, '水果分组展示', '一共有 23 个水果，每排展示 4 个，补全代码计算需要多少排。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "items = 23\nrow = 4\nrows_needed = items "}, {"type": "slot", "index": 0}, {"type": "code", "value": " row\nprint(rows_needed)"}]}]}', JSON_ARRAY('*', '/', '//', '%', '+', '-', 'row', 'items'), JSON_ARRAY(3), '// 计算整排数，23 // 4 = 5。', '示例：17 // 3 = 5');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('10', 7, '剩余库存计算', '补全代码以计算打包后还剩多少库存。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "stock = 57\nbox = 10\nleft = stock "}, {"type": "slot", "index": 0}, {"type": "code", "value": " box\nprint(left)"}]}]}', JSON_ARRAY('%', '//', '*', '/', '-', '+', 'stock', 'box'), JSON_ARRAY(1), '剩余数量 = stock % box。', '示例：35 % 6 = 5');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('14', 7, '分钟换算小时', '补全代码，将总分钟转换为小时和剩余分钟。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "total = 145\nh = total "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 60\nm = total "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 60\nprint(h, m)"}]}]}', JSON_ARRAY('//', '%', '/', '*', '-', '+', '60', 'total'), JSON_ARRAY(1, 2), '整除用于计算小时数，取余用于计算剩余分钟。', '示例：130 分钟 = 2 小时 10 分钟');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('15', 7, '购物满减逻辑', '满 200 减 50，完成代码：', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "cost = 260\nfull = 200\noff = 50\npay = cost "}, {"type": "slot", "index": 0}, {"type": "code", "value": " off if cost "}, {"type": "slot", "index": 1}, {"type": "code", "value": " full else cost\nprint(pay)"}]}]}', JSON_ARRAY('>=', '<=', '==', '-', '+', '*', '/', '//', '%', 'off', 'full', 'cost'), JSON_ARRAY(1, 2), '若消费大于等于 full，则 cost - off。', '示例：300 ≥ 200 → 300 - 50 = 250');