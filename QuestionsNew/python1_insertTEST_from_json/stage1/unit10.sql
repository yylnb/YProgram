USE `questions`;
-- Unit 10 | Start ID: 136
-- Generated at 2025-12-25 17:41:13

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    136,
    10,
    'print 的默认行为',
    '在一次自动化脚本输出中，你发现 print 打印的内容总是自动换行，这是因为？',
    JSON_OBJECT('A', 'print 永远强制换行，无法改变', 'B', 'print 默认的 end 参数为 \'\\n\'', 'C', 'print 会自动检测内容长度后换行', 'D', 'print 只能输出字符串，换行是其副作用'),
    2,
    JSON_ARRAY('你可以修改 print 的行为。', '想想 print 的关键字参数。', 'end 参数默认就是换行符。'),
    'print(..., end=\'\\n\') 是默认行为，因此会自动换行。',
    'print(\'Hello\', end=\'\'); print(\'World\')'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    137,
    10,
    '注释的作用',
    '你在整理旧代码时发现很多奇怪的注释，以下哪项是注释真正的作用？',
    JSON_OBJECT('A', '让程序运行更快', 'B', '帮助解释代码含义，但不影响运行', 'C', '用来加密源码', 'D', '让变量自动变成全局变量'),
    2,
    JSON_ARRAY('注释不会影响执行。', '注释是说明，而不是逻辑。', '注释存在的目的是让人理解。'),
    '注释仅用于阅读和解释代码，不参与逻辑运行。',
    '# 这是一个注释，不会被执行'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    138,
    10,
    '变量命名规则',
    '你打算命名一个变量 price_total，下列哪项描述正确？',
    JSON_OBJECT('A', '变量名不能包含下划线', 'B', '变量名必须以数字开头', 'C', '变量名可以包含字母、数字、下划线，且不能以数字开头', 'D', '变量名必须全部大写'),
    3,
    JSON_ARRAY('变量名是由哪些字符组成？', '数字能放在开头吗？', '下划线在命名里是常用符号。'),
    '变量名必须以字母或下划线开头，后面可接字母、数字或下划线。',
    'user_score_2 = 100'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    139,
    10,
    '注释补全',
    '请在代码中补上注释，让代码可读性更强。',
    NULL,
    JSON_ARRAY('10'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 10"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " 这是一个示例注释"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(x)"}]}]}',
    JSON_ARRAY('#', '"', '\'', '//', '###', '#!', '# 注释', '/**/'),
    JSON_ARRAY(1),
    'Python 使用 # 撰写单行注释。',
    'x = 10
# 这是注释
print(x)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    140,
    10,
    '变量命名正确写法',
    '请选择正确的变量命名方式，使代码可正常运行。',
    NULL,
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " = 3"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(num_value)"}]}]}',
    JSON_ARRAY('3num', 'num-value', 'num_value', 'num value', 'value-num', 'value num'),
    JSON_ARRAY(3),
    '变量只能包含字母、数字、下划线，不能以数字开头，也不能带空格或减号。',
    'num_value = 3'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    141,
    10,
    '整数类型判断',
    '你在调试一个折扣算法，需要确认 7 属于哪种类型，以下哪项正确？',
    JSON_OBJECT('A', '整数类型在 Python 中属于 float', 'B', '整数类型在 Python 中属于 int', 'C', '整数类型等同于字符串', 'D', '整数类型需要 import 才能使用'),
    2,
    JSON_ARRAY('整数在 Python 中对应哪个内建类型？', 'int 是否需要导入？', '操作如 +、- 是基于 int 的。'),
    '7 是 int 类型，是 Python 内建基本数值类型之一。',
    'print(type(7))  # <class \'int\'>'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    142,
    10,
    '浮点误差理解',
    '你在做账单计算时，发现 0.1 + 0.2 输出为 0.30000000000000004，原因是？',
    JSON_OBJECT('A', 'Python 算错', 'B', '浮点数在二进制中无法精确表示', 'C', 'print 自动加上多余的尾数', 'D', '代码风格写得不好'),
    2,
    JSON_ARRAY('浮点误差是所有语言通病。', '0.1 是否可被二进制精确表达？', '误差来源于底层表示。'),
    '浮点数的二进制近似表达导致误差。',
    'print(0.1 + 0.2)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    143,
    10,
    '运算符优先级基础',
    '以下表达式的正确计算顺序是什么：3 + 2 * 4？',
    JSON_OBJECT('A', '先加法后乘法', 'B', '先乘法后加法', 'C', '从右往左依次执行', 'D', '完全看心情'),
    2,
    JSON_ARRAY('乘除优先于加减。', '回忆运算符优先级规则。', '必要时可加括号。'),
    '表达式按优先级执行：2*4=8，再算 3+8=11。',
    'print(3 + 2 * 4)  # 11'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    144,
    10,
    '加减法优先级',
    '补全括号，使表达式结果为 1。',
    NULL,
    JSON_ARRAY('1'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "result = 10 - "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 3 - 6 )"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(result)"}]}]}',
    JSON_ARRAY('(', ')', '(3 -', '(10 -', '(3 +', '(2 *', '(6 -', '( 3'),
    JSON_ARRAY(1),
    '需要添加 \'(\' 才能改变原有的求值顺序。',
    'result = 10 - (3 - 6)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    145,
    10,
    '基本运算符组合',
    '补全代码，使结果为 8。',
    NULL,
    JSON_ARRAY('8'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 2"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "x = x "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 3"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(x)"}]}]}',
    JSON_ARRAY('+', '-', '*', '/', '//', '%', '**'),
    JSON_ARRAY(3),
    '2 * 4 = 8，因此需选择乘法。',
    'x = 2; x = x * 4'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    146,
    10,
    '模块化输出检查',
    'print(\'A\',\'B\') 为什么会输出\'A B\'？',
    JSON_OBJECT('A', 'print 自动在多个参数之间加入空格', 'B', '这是编码问题', 'C', 'print 会把字符串拼接', 'D', '因为 \'A\' 和 \'B\' 不能并列'),
    1,
    JSON_ARRAY('思考 print 默认 separator。', '多个参数时 sep 默认是什么？', '你可以通过 sep 修改行为。'),
    'print 默认的 sep 是空格，因此多个参数用空格隔开。',
    'print(\'A\',\'B\', sep=\'-\')'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    147,
    10,
    '变量替换陷阱',
    '以下哪项是变量覆盖最常见的风险？',
    JSON_OBJECT('A', '变量命名太短', 'B', '重复使用同名变量导致值被覆盖', 'C', '变量不能包含字母', 'D', '变量不能在 print 中使用'),
    2,
    JSON_ARRAY('变量是可变的。', '如果同名，会覆盖旧值。', '要注意变量生命周期。'),
    '变量同名赋值会覆盖原本内容，需要谨慎操作。',
    'x = 3; x = 10; print(x)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    148,
    10,
    '取模运算复习',
    '8 % 3 的结果是多少？',
    JSON_OBJECT('A', '1', 'B', '2', 'C', '3', 'D', '0'),
    2,
    JSON_ARRAY('余数 = 被除数 - (除数 * 商)', '8 除以 3 的商是多少？', '余数就是 2。'),
    '8 = 3*2 + 2，因此余数为 2。',
    'print(8 % 3)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    149,
    10,
    '浮点与整数的混合计算',
    '补全代码，使表达式结果为 4.0。',
    NULL,
    JSON_ARRAY('4.0'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = 2"}, {"type": "code_line", "value": "b = 2"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "total = a "}, {"type": "slot", "index": 0}, {"type": "code", "value": " b"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(total)"}]}]}',
    JSON_ARRAY('+', '-', '*', '/', '//', '%', '**'),
    JSON_ARRAY(3),
    '2/2 = 1.0，2+1.0 = 3.0，不对；题干要求直接得到 4.0，因此选择乘法。',
    '2 * 2 = 4.0'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    150,
    10,
    '优先级综合复习',
    '补全表达式，使结果为 11。',
    NULL,
    JSON_ARRAY('11'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "value = 3 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 2 * 4"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(value)"}]}]}',
    JSON_ARRAY('+', '-', '*', '/', '//', '%', '**'),
    JSON_ARRAY(1),
    '2*4=8，3+8=11，因此填 +。',
    '3 + 2 * 4'
);