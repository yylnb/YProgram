USE `questions`;
-- Unit 26 | Start ID: 376
-- Generated at 2025-12-25 17:41:13

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    376,
    26,
    '相等运算符的含义',
    '在 Python 中，表达式 a == b 表示什么？',
    JSON_OBJECT('A', '把 a 赋值给 b', 'B', '比较 a 和 b 是否相等，返回布尔值', 'C', '判断 a 是否大于 b', 'D', '交换 a 与 b 的值'),
    2,
    JSON_ARRAY('== 常用于比较。', '结果通常是 True 或 False。', '不是赋值运算符。'),
    '== 用于判断两个值是否相等，返回布尔值。',
    '3 == 3 会得到 True，而 3 == 4 会得到 False。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    377,
    26,
    '不等于运算符',
    '下面哪个表示“不等于”？',
    JSON_OBJECT('A', '!=', 'B', '=', 'C', '<>', 'D', '==!'),
    1,
    JSON_ARRAY('Python 中“不等于”用两字符表示。', '不是单个等号。', '注意与 SQL 某些方言的写法区别。'),
    '在 Python 中使用 != 来表示不等于。',
    '5 != 3 会得到 True。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    378,
    26,
    '比较运算符的返回类型',
    '表达式 2 > 1 的结果是什么类型？',
    JSON_OBJECT('A', 'int', 'B', 'str', 'C', 'bool', 'D', 'float'),
    3,
    JSON_ARRAY('比较运算返回真或假。', 'Python 有专门的布尔类型。', 'True/False 是关键字。'),
    '比较表达式返回布尔值（True 或 False）。',
    '0 < 1 会返回 True。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    379,
    26,
    '补全比较表达式',
    '补全使下面的 if 判断为真。',
    NULL,
    JSON_ARRAY('条件成立'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 10"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if x "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 5:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"条件成立\\")"}]}]}',
    JSON_ARRAY('>', '<', '==', '!=', '>=', '<='),
    JSON_ARRAY(1),
    '10 > 5 为 True，因此会打印。',
    '如果 x = 3，表达式 x > 5 则为 False。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    380,
    26,
    '数字与字符串比较',
    '补全，避免类型错误并判断相等。',
    JSON_ARRAY('a = "3"
b = 3'),
    JSON_ARRAY('False'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(a "}, {"type": "slot", "index": 0}, {"type": "code", "value": " b)"}]}]}',
    JSON_ARRAY('==', '!=', '>', '<', 'is'),
    JSON_ARRAY(1),
    '字符串 "3" 与数字 3 不相等，使用 == 会输出 False。',
    '"3" == 3 返回 False，而 int("3") == 3 返回 True。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    381,
    26,
    '链式比较',
    '表达式 1 < 2 < 3 在 Python 中表示什么？',
    JSON_OBJECT('A', '先比较 1 < 2，再比较 2 < 3，并且两者都要为真', 'B', '等价于 (1 < 2) < 3，这会报错', 'C', '等价于 1 < (2 < 3)', 'D', '在 Python 中不支持链式比较'),
    1,
    JSON_ARRAY('Python 支持链式比较。', '链式比较会同时判断多个关系。', '相比之下某些语言需要用 and 连接。'),
    '1 < 2 < 3 会同时判断 1 < 2 和 2 < 3 两个条件，只有都为 True 才为 True。',
    '2 < 3 < 5 等价于 (2 < 3) and (3 < 5)。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    382,
    26,
    'is 与 == 的区别',
    '下面哪项描述是正确的？',
    JSON_OBJECT('A', 'is 用于比较值是否相等，== 用于比较对象标识', 'B', 'is 比较对象标识（是否为同一对象），== 比较值是否相等', 'C', 'is 与 == 完全等价', 'D', '== 只能用于数字比较'),
    2,
    JSON_ARRAY('is 关注对象身份(identity)。', '== 关注值相等性。', '小整数缓存可能导致 is 看起来也为真。'),
    'is 比较对象引用是否相同；== 比较值是否相等。',
    'a = [1]; b = [1]; a == b 为 True，但 a is b 为 False。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    383,
    26,
    '字符串比较',
    '在 Python 中，"apple" < "banana" 的结果是？',
    JSON_OBJECT('A', 'True（按字典序比较）', 'B', 'False（无法比较字符串）', 'C', '报错（类型不匹配）', 'D', '结果取决于系统语言设置'),
    1,
    JSON_ARRAY('字符串可以按字典顺序比较。', '比较基于字符的 Unicode 编码。', 'a 在 b 之前。'),
    'Python 使用字典序（基于字符编码）比较字符串，因此 "apple" < "banana" 为 True。',
    '"cat" > "car" 为 True。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    384,
    26,
    '补全比较并输出 True',
    '使表达式结果为 True。',
    JSON_ARRAY('a = 7
b = 7'),
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(a "}, {"type": "slot", "index": 0}, {"type": "code", "value": " b)"}]}]}',
    JSON_ARRAY('==', '!=', '>', '<', 'is'),
    JSON_ARRAY(1),
    'a 与 b 相等，使用 == 会输出 True。',
    '如果 a = 5, b = 6，则 a != b 为 True。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    385,
    26,
    '比较与类型转换',
    '补全代码，先转换后比较。',
    JSON_ARRAY('s = "10"
n = 10'),
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(int(s) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " n)"}]}]}',
    JSON_ARRAY('==', '!=', '>', '<'),
    JSON_ARRAY(1),
    '将字符串转换为整数后与数字比较，int("10") == 10 为 True。',
    'int("3") < 5 会得到 True。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    386,
    26,
    '比较浮点数的小心点',
    '下面哪个说法正确？',
    JSON_OBJECT('A', '浮点数比较总是准确的', 'B', '浮点数比较可能因精度问题不精确', 'C', '浮点数不能用于比较运算', 'D', 'Python 自动把浮点数转为分数后比较'),
    2,
    JSON_ARRAY('浮点数有表示误差。', '经常用近似比较。', '避免直接用 == 比较复杂计算结果。'),
    '浮点数有精度限制，比较时要小心，常用 abs(a-b) < epsilon 来判断近似相等。',
    'abs(0.1 + 0.2 - 0.3) < 1e-9 通常用于判断近似相等。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    387,
    26,
    '比较运算的优先级',
    '下列关于比较运算优先级的说法，哪项正确？',
    JSON_OBJECT('A', '比较运算优先于加减乘除', 'B', '比较运算的优先级低于算术运算', 'C', '比较运算与赋值运算优先级相同', 'D', 'Python 没有运算符优先级'),
    2,
    JSON_ARRAY('先算术，再比较。', '例如 3 + 2 > 4 意味着先计算 3+2。', '算术优先级高于比较。'),
    '算术运算先执行，比较運算在算术结果之上进行。',
    '3 + 2 > 4 等价于 (3 + 2) > 4。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    388,
    26,
    '比较运算与布尔上下文',
    '在 if 语句中使用比较运算会返回什么？',
    JSON_OBJECT('A', '整数 0 或 1', 'B', '字符串 "True" 或 "False"', 'C', '布尔值 True 或 False', 'D', 'None'),
    3,
    JSON_ARRAY('比较表达式本身就是布尔类型。', 'if 需要一个布尔上下文。', 'True/False 是关键字。'),
    '比较表达式在 if 中直接使用，会被当作布尔值判断。',
    'if a == b: ... 中的 a == b 会返回 True 或 False。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    389,
    26,
    '综合填空：年龄判断',
    '根据用户输入的年龄判断是否成年人并输出。',
    JSON_ARRAY('age = 18'),
    JSON_ARRAY('成年人'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "age = "}, {"type": "slot", "index": 0}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if age "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 18:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"成年人\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"未成年人\\")"}]}]}',
    JSON_ARRAY('int(input())', 'input()', '>=', '>', '=='),
    JSON_ARRAY(1, 3),
    '需要将输入转换为整数，并判断 age >= 18 来判断是否成年人。',
    'age = int(input())
if age >= 18: print("成年人")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    390,
    26,
    '补全链式比较',
    '补全使表达式判断 x 在 1 到 10 之间（包含端点）。',
    JSON_ARRAY('x = 5'),
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(1 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " x "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 10)"}]}]}',
    JSON_ARRAY('<', '<=', '>', '>=', '=='),
    JSON_ARRAY(2, 2),
    '使用链式比较 1 <= x <= 10 可以判断 x 在闭区间 [1,10]。',
    '1 <= 3 <= 10 为 True。'
);