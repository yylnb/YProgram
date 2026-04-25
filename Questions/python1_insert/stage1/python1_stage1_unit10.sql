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
  ('1', 10, 'print 的默认行为', '在一次自动化脚本输出中，你发现 print 打印的内容总是自动换行，这是因为？', JSON_OBJECT('A', 'print 永远强制换行，无法改变', 'B', 'print 默认的 end 参数为 ''\\n''', 'C', 'print 会自动检测内容长度后换行', 'D', 'print 只能输出字符串，换行是其副作用'), 2, JSON_ARRAY('你可以修改 print 的行为。', '想想 print 的关键字参数。', 'end 参数默认就是换行符。'), NULL, 'print(''Hello'', end=''''); print(''World'')');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('2', 10, '注释的作用', '你在整理旧代码时发现很多奇怪的注释，以下哪项是注释真正的作用？', JSON_OBJECT('A', '让程序运行更快', 'B', '帮助解释代码含义，但不影响运行', 'C', '用来加密源码', 'D', '让变量自动变成全局变量'), 2, JSON_ARRAY('注释不会影响执行。', '注释是说明，而不是逻辑。', '注释存在的目的是让人理解。'), NULL, '# 这是一个注释，不会被执行');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('3', 10, '变量命名规则', '你打算命名一个变量 price_total，下列哪项描述正确？', JSON_OBJECT('A', '变量名不能包含下划线', 'B', '变量名必须以数字开头', 'C', '变量名可以包含字母、数字、下划线，且不能以数字开头', 'D', '变量名必须全部大写'), 3, JSON_ARRAY('变量名是由哪些字符组成？', '数字能放在开头吗？', '下划线在命名里是常用符号。'), NULL, 'user_score_2 = 100');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('6', 10, '整数类型判断', '你在调试一个折扣算法，需要确认 7 属于哪种类型，以下哪项正确？', JSON_OBJECT('A', '整数类型在 Python 中属于 float', 'B', '整数类型在 Python 中属于 int', 'C', '整数类型等同于字符串', 'D', '整数类型需要 import 才能使用'), 2, JSON_ARRAY('整数在 Python 中对应哪个内建类型？', 'int 是否需要导入？', '操作如 +、- 是基于 int 的。'), NULL, 'print(type(7))  # <class ''int''>');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('7', 10, '浮点误差理解', '你在做账单计算时，发现 0.1 + 0.2 输出为 0.30000000000000004，原因是？', JSON_OBJECT('A', 'Python 算错', 'B', '浮点数在二进制中无法精确表示', 'C', 'print 自动加上多余的尾数', 'D', '代码风格写得不好'), 2, JSON_ARRAY('浮点误差是所有语言通病。', '0.1 是否可被二进制精确表达？', '误差来源于底层表示。'), NULL, 'print(0.1 + 0.2)');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('11', 10, '模块化输出检查', 'print(''A'',''B'') 为什么会输出''A B''？', JSON_OBJECT('A', 'print 自动在多个参数之间加入空格', 'B', '这是编码问题', 'C', 'print 会把字符串拼接', 'D', '因为 ''A'' 和 ''B'' 不能并列'), 1, JSON_ARRAY('思考 print 默认 separator。', '多个参数时 sep 默认是什么？', '你可以通过 sep 修改行为。'), NULL, 'print(''A'',''B'', sep=''-'')');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('13', 10, '取模运算复习', '8 % 3 的结果是多少？', JSON_OBJECT('A', '1', 'B', '2', 'C', '3', 'D', '0'), 2, JSON_ARRAY('余数 = 被除数 - (除数 * 商)', '8 除以 3 的商是多少？', '余数就是 2。'), NULL, 'print(8 % 3)');

-- ---------- 插入填空题 ----------
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('4', 10, '注释补全', '请在代码中补上注释，让代码可读性更强。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "x = 10\n"}, {"type": "slot", "index": 0}, {"type": "code", "value": "_ 这是一个示例注释\nprint(x)"}]}]}', JSON_ARRAY('#', '"', '''', '//', '###', '#!', '# 注释', '/**/'), JSON_ARRAY(1), NULL, 'x = 10
# 这是注释
print(x)');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('5', 10, '变量命名正确写法', '请选择正确的变量命名方式，使代码可正常运行。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": "_ = 3\nprint(num_value)"}]}]}', JSON_ARRAY('3num', 'num-value', 'num_value', 'num value', 'value-num', 'value num'), JSON_ARRAY(3), NULL, 'num_value = 3');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('9', 10, '加减法优先级', '补全括号，使表达式结果为 1。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "result = 10 - "}, {"type": "slot", "index": 0}, {"type": "code", "value": "_ 3 - 6 )\nprint(result)"}]}]}', JSON_ARRAY('(', ')', '(3 -', '(10 -', '(3 +', '(2 *', '(6 -', '( 3'), JSON_ARRAY(1), NULL, 'result = 10 - (3 - 6)');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('10', 10, '基本运算符组合', '补全代码，使结果为 8。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "x = 2\nx = x "}, {"type": "slot", "index": 0}, {"type": "code", "value": "_ 3\nprint(x)"}]}]}', JSON_ARRAY('+', '-', '*', '/', '//', '%', '**'), JSON_ARRAY(3), NULL, 'x = 2; x = x * 4');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('14', 10, '浮点与整数的混合计算', '补全代码，使表达式结果为 4.0。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "a = 2\nb = 2\ntotal = a "}, {"type": "slot", "index": 0}, {"type": "code", "value": "_ b\nprint(total)"}]}]}', JSON_ARRAY('+', '-', '*', '/', '//', '%', '**'), JSON_ARRAY(4), NULL, '2 * 2 = 4.0');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('15', 10, '优先级综合复习', '补全表达式，使结果为 11。', NULL, NULL, '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "value = 3 "}, {"type": "slot", "index": 0}, {"type": "code", "value": "_ 2 * 4\nprint(value)"}]}]}', JSON_ARRAY('+', '-', '*', '/', '//', '%', '**'), JSON_ARRAY(1), NULL, '3 + 2 * 4');