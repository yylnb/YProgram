USE `questions`;
-- Unit 9 | Start ID: 121
-- Generated at 2025-12-24 23:00:20

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    121, 
    9, 
    '为什么 0.1 + 0.2 不等于 0.3？', 
    '你在做折扣计算时写了0.1 + 0.2，结果居然不是0.3，这背后最核心的原因是什么？', 
    JSON_OBJECT('A', 'Python算错了', 'B', '浮点数用二进制存储，无法精确表示某些小数', 'C', '程序被病毒篡改了', 'D', '加法运算默认四舍五入'), 
    2, 
    JSON_ARRAY('这是所有语言都会遇到的经典问题。', '思考：0.1能否在二进制中被精确表示？', '注意：浮点数的底层是二进制近似值。'), 
    '浮点数使用二进制表示，许多十进制小数无法被精确存储，会产生微小误差。', 
    'print(0.1 + 0.2)  # 输出 0.30000000000000004'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    122, 
    9, 
    '整数除法陷阱', 
    '为什么 5 / 2 得到的是 2.5 而不是传统数学除法中的“取整”？', 
    JSON_OBJECT('A', '/ 在 Python 中是浮点除法', 'B', '/ 会自动向下取整', 'C', '/ 会根据输入自动选择整数或浮点', 'D', '/ 会把结果变成字符串'), 
    1, 
    JSON_ARRAY('回忆：整数除法在 Python 是哪个符号？', '是不是应该使用 //？', 'Python 中 / 永远产生浮点数。'), 
    '/ 是真正的除法运算符，结果永远是浮点，不管两边是否是整数。', 
    'print(5 / 2)  # 2.5
print(5 // 2) # 2'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    123, 
    9, 
    '奇怪的取模结果', 
    '为什么 -7 % 3 的结果是 2？', 
    JSON_OBJECT('A', 'Python把负号忽略了', 'B', 'Python出错了', 'C', 'Python取模的结果符号与除数相同', 'D', '取模运算先对负数取反'), 
    3, 
    JSON_ARRAY('Python 的模运算符有符号规则。', '思考：结果必须满足：被除数 = 除数 * 商 + 余数。', '余数的符号 = 除数的符号。'), 
    'Python 的模运算余数符号跟除数一致，因此 -7 % 3 = 2。', 
    'print(-7 % 3)  # 2'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    124,
    9,
    '浮点误差导致的判断失败',
    '请修复比较操作使其更可靠。',
    NULL,
    JSON_ARRAY('相等'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = 0.1 + 0.2"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": " == 0.3:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\'相等\')"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\'不相等\')"}]}]}',
    JSON_ARRAY('round(a, 1)', 'a', 'int(a)', 'str(a)', 'round(a, 2)', 'abs(a - 0.3) < 1e-9'),
    JSON_ARRAY(6),
    '直接比较浮点数可能失败，应使用“差值小于某个阈值”的方式比较。',
    'if abs((0.1+0.2) - 0.3) < 1e-9:
    print(\'相等\')'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    125,
    9,
    '整数除法与浮点除法混用',
    '修复表达式，使 total 保持整数类型。',
    NULL,
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 17"}, {"type": "code_line", "value": "y = 5"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "total = x "}, {"type": "slot", "index": 0}, {"type": "code", "value": " y"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(total)"}]}]}',
    JSON_ARRAY('/', '//', '%', '+', '*', '**'),
    JSON_ARRAY(2),
    '要得到整数结果，应使用 // 进行整数除法。',
    'print(17 // 5)  # 输出 3'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    126, 
    9, 
    '浮点累积误差', 
    '以下哪一项最可能导致长期循环累计误差越来越明显？', 
    JSON_OBJECT('A', '使用整数存储计数', 'B', '反复累加浮点小数', 'C', '使用 += 语句', 'D', '在循环里使用 print'), 
    2, 
    JSON_ARRAY('浮点误差很小，但会累积。', '反复计算会放大误差。', '整数不会有这个问题。'), 
    '小的浮点误差反复累加会形成显著偏差。', 
    'for _ in range(1000000): x += 0.1  # 误差累积明显'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    127, 
    9, 
    '除法产生意外浮点', 
    '为什么 4/2 的结果是 2.0 而不是 2？', 
    JSON_OBJECT('A', '因为 4 是偶数', 'B', 'Python 保留整数类型', 'C', 'Python 的除法结果永远为浮点', 'D', '因为写错了语法'), 
    3, 
    JSON_ARRAY('关于 / 的规则记得吗？', '不论结果是否为整数，/ 都产生 float。', '4/2 结果数学上为整数，但类型依然是 float。'), 
    '/ 始终返回 float。', 
    'print(type(4/2))  # float'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    128, 
    9, 
    '意外的字符串拼接', 
    '为什么 \'5\' + 3 会报错？', 
    JSON_OBJECT('A', 'Python 不支持加号', 'B', '不能把字符串和整数直接相加', 'C', 'Python 自动把3转成字符串', 'D', '字符串加法会做乘法'), 
    2, 
    JSON_ARRAY('类型不一致。', '字符串加法只能连接字符串。', '可以使用 str() 或 int() 转换类型。'), 
    '字符串和数字不能直接相加，需要显式转换。', 
    'print(\'5\' + str(3))  # \'53\''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    129,
    9,
    '修复数值类型混乱',
    '修复代码，使结果变成整数加整数。',
    NULL,
    JSON_ARRAY('10'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = \'7\'"}, {"type": "code_line", "value": "b = 3"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "c = int(a) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " b"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(c)"}]}]}',
    JSON_ARRAY('+', '-', '*', '/', '//', '%'),
    JSON_ARRAY(1),
    '将字符串转为整数后，可直接进行整数加法。',
    'print(int(\'7\') + 3)  # 10'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    130,
    9,
    '取模陷阱修复',
    '填空使得结果为 1，而不是负数。',
    NULL,
    JSON_ARRAY('1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = -10"}, {"type": "code_line", "value": "y = 3"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "r = x "}, {"type": "slot", "index": 0}, {"type": "code", "value": " y"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(r)"}]}]}',
    JSON_ARRAY('%', '//', '/', '+', '*', '**'),
    JSON_ARRAY(1),
    '-10 % 3 的结果为 2，但若想得到 1，可以配合整数除法和运算调整。',
    'print(-10 % 3)  # 2'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    131, 
    9, 
    '舍入行为理解', 
    'round(2.5) 的结果为什么是 2？', 
    JSON_OBJECT('A', 'Python 向上取整', 'B', 'Python 向下取整', 'C', 'Python 的 round 使用“银行家舍入法”', 'D', 'Python 自动判断最接近的整数'), 
    3, 
    JSON_ARRAY('round 的规则不是单纯四舍五入。', '遇到 .5 时，会舍入到偶数。', '这叫银行家舍入法。'), 
    'Python 的 round 遵循银行家舍入：2.5 → 2，3.5 → 4。', 
    'print(round(3.5), round(2.5))  # 4 2'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    132, 
    9, 
    '浮点比较的替代方案', 
    '哪一种比较方式更适合用于浮点数等值判断？', 
    JSON_OBJECT('A', '直接使用 ==', 'B', '打印出来肉眼比较', 'C', '比较两个值的差是否在容许误差范围内', 'D', '把浮点数改成字符串比较'), 
    3, 
    JSON_ARRAY('误差不可避免。', '差值比较是最稳妥的方式。', '许多科学计算库都推荐此做法。'), 
    '使用容差判断可以规避浮点误差。', 
    'abs(a-b) < 1e-9'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    133, 
    9, 
    '复合表达式中的隐式浮点', 
    '表达式 3 + 2/2 的结果为什么是 4.0？', 
    JSON_OBJECT('A', 'Python 自动把所有数字转换成字符串', 'B', '表达式含有 / 就会产生 float', 'C', '因为 3+1 必须是浮点数', 'D', 'Python 使用整数优先规则'), 
    2, 
    JSON_ARRAY('/ 一出现，结果就是 float。', '再和整数相加结果也会变成 float。', '因此得到 4.0 而不是 4。'), 
    '2/2 = 1.0，其后所有运算都在浮点环境中进行。', 
    'print(3 + 2/2)  # 4.0'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    134,
    9,
    '避免累积误差的计数方式',
    '修复代码，使累加保持精准整数。',
    NULL,
    JSON_ARRAY('5'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "total = 0.0"}, {"type": "code_line", "value": "for i in range(5):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    total = total "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(total)"}]}]}',
    JSON_ARRAY('+', '+ 1.0', '+ 0.1', '-', '*', '//', '+ int(1)'),
    JSON_ARRAY(7),
    '使用整数进行计数最可靠，避免浮点累积误差。',
    'total = 0
for i in range(5): total += 1'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    135,
    9,
    '避免浮点结构比较失败',
    '修复以下代码，使 if 判断为 True。',
    NULL,
    JSON_ARRAY('通过'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 0.3"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if abs(x - (0.1 + 0.2)) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 1e-9:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\'通过\')"}]}]}',
    JSON_ARRAY('<', '>', '<=', '>=', '==', '!='),
    JSON_ARRAY(1),
    '使用容差判断，abs(差) < 阈值。',
    'if abs(0.3 - (0.1+0.2)) < 1e-9: print(\'ok\')'
);