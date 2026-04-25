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
  ('1', 5, '浮点数的本质', '', JSON_OBJECT('A', '只能表示特别大的整数', 'B', '带有小数点的数值', 'C', '只能表示分数', 'D', '仅用于科学计算'), 2, JSON_ARRAY('浮点数的关键特征和“小数点”有关。', '它不是专门给科学家准备的。', '当然可以做整数做不到的带小数的工作。'), '浮点数 float 类型是用于表示带小数点的数值，例如 3.14、0.5、-2.7。', '示例：x = 3.5  # 这是一个浮点数');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('2', 5, '浮点数的创建方式', '', JSON_OBJECT('A', 'x = 5', 'B', 'x = ''3.14''', 'C', 'x = 3.14', 'D', 'x = float'), 3, JSON_ARRAY('注意数据类型：数字 vs 字符串。', '需要直接写出一个带小数的形式。', '不要把类型名当变量赋值。'), '3.14 是标准浮点字面量，可直接创建 float。', '示例：pi = 3.14');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('3', 5, '浮点数自动转换', '', JSON_OBJECT('A', '一定是整数', 'B', '一定是字符串', 'C', '一定是布尔值', 'D', '浮点数'), 4, JSON_ARRAY('混合运算时 Python 会“照顾大哥”。', '浮点数能表达更多信息。', '最终结果当然是 float。'), '整数与浮点混合运算时，Python 会把整数提升为浮点类型。', '示例：5 + 0.2 → 5.2（float）');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('6', 5, '复习：整数类型', '', JSON_OBJECT('A', '3 // 2', 'B', '3 / 2', 'C', '3.0 // 1', 'D', '3.0 + 2'), 1, JSON_ARRAY('整数除法运算符是 //。', '浮点参与会让结果变成 float。', '只有 A 完全由整数运算符控制。'), '3 // 2 = 1，是整数 floor 除。', '示例：10 // 3 = 3');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('7', 5, '复习：整数转浮点', '', JSON_OBJECT('A', 'float(8)', 'B', 'str(8)', 'C', 'int(8)', 'D', '8 + ''0.0'''), 1, JSON_ARRAY('只有一个选项会输出 float。', '字符串不是 float。', '加字符串会报错。'), 'float(8) → 8.0。', '示例：float(5) → 5.0');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('8', 5, '复习：整数基础运算', '', JSON_OBJECT('A', '10', 'B', '10.0', 'C', '52', 'D', '2.5'), 1, JSON_ARRAY('整数 * 整数 → 整数。', '不会自动变成浮点。', '注意运算优先级。'), '整数乘法保持整数类型，5 * 2 = 10。', '示例：3 * 4 = 12');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('11', 5, '浮点除法结果', '', JSON_OBJECT('A', '8 / 2', 'B', '8 // 2', 'C', 'int(3.5)', 'D', '3 * 3'), 1, JSON_ARRAY('正常除法 / 总是产生 float。', '不要被整数特征迷惑。', '记住：/ 永远是 float。'), '8 / 2 → 4.0，为浮点。', '示例：5 / 2 → 2.5');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('12', 5, '浮点精度特性', '', JSON_OBJECT('A', 'Python 计算错误', 'B', '浮点数有二进制表达限制', 'C', '0.1 与 0.2 属于字符串', 'D', 'Python 故意让结果不准确'), 2, JSON_ARRAY('这不是 Python 独有的问题。', '和底层存储方式有关。', '二进制无法精确表示某些小数。'), '浮点使用二进制存储，某些小数无法精确表示，会出现微小误差。', '示例：print(0.1 + 0.2) → 0.30000000000000004');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('13', 5, '浮点到整数的转换', '', JSON_OBJECT('A', 'round(3.6)', 'B', '3.6 + 1.4', 'C', '3.0 == 3', 'D', '4.0 * 2'), 1, JSON_ARRAY('round 返回整数。', '不要被 === 混淆。', '浮点算术不会自动丢小数。'), 'round(3.6) → 4，为整数。', '示例：round(2.2) → 2');

-- ---------- 插入填空题 ----------
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('4', 5, '浮点输出练习', '', NULL, JSON_ARRAY('19.8'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "price_str = ''19.8''\nprice = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "__(price_str)\nprint(price)"}]}]}', JSON_ARRAY('float', 'int', 'str', 'price_str', 'print', 'input', 'len'), JSON_ARRAY(1), '字符串转浮点应该使用 float()。', '示例：x = float(''3.5'')');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('5', 5, '浮点加法逻辑', '', NULL, JSON_ARRAY('10.5'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "a = 7\nb = 3.5\nresult = a "}, {"type": "slot", "index": 0}, {"type": "code", "value": "__ b\nprint(result)"}]}]}', JSON_ARRAY('+', '-', '*', '/', '//', '**', '%', 'and', 'or'), JSON_ARRAY(1), '7 + 3.5 = 10.5，整数+浮点→浮点。', '示例：2 + 0.5 → 2.5');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('9', 5, '复习：整数与字符串拼接错误', '', NULL, JSON_ARRAY('Age: 20'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "age = 20\ntext = ''Age: '' "}, {"type": "slot", "index": 0}, {"type": "code", "value": "__ age\nprint(text)"}]}]}', JSON_ARRAY('+', '-', '*', '/', 'str(age)', 'int(age)', '''20''', '''', '''', '''.''', '''%s'''), JSON_ARRAY(5), '需要将整数 age 转为字符串后再拼接。', '示例：''Score: '' + str(90)');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('10', 5, '复习：整数比较', '', NULL, JSON_ARRAY('True'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "a = 7\nb = 5\nprint(a "}, {"type": "slot", "index": 0}, {"type": "code", "value": "__ b)"}]}]}', JSON_ARRAY('>', '<', '==', '!=', '<=', '>=', 'and', 'or'), JSON_ARRAY(1), '7 > 5 为 True。', '示例：10 > 3 → True');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('14', 5, '浮点格式化输出', '', NULL, JSON_ARRAY('3.14'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "pi = 3.14159\nprint( format(pi, ''"}, {"type": "slot", "index": 0}, {"type": "code", "value": "_'') )"}]}]}', JSON_ARRAY('.2f', '.3f', '.1f', '.0f', '.5f', '.6f', 's', 'd'), JSON_ARRAY(1), '''.2f'' 表示保留两位小数。', '示例：format(2.71828, ''.2f'') → ''2.72''');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('15', 5, '浮点运算组合', '', NULL, JSON_ARRAY('12.5'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "a = 10\nb = 2.5\nresult = a "}, {"type": "slot", "index": 0}, {"type": "code", "value": "__ b\nprint(result)"}]}]}', JSON_ARRAY('+', '-', '*', '/', '//', '%', '**', 'and', 'or'), JSON_ARRAY(1), '10 + 2.5 = 12.5，为浮点。', '示例：1 + 0.5 → 1.5');