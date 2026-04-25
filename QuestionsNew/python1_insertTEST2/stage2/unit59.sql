USE `questions`;
-- Unit 59 | Start ID: 871
-- Generated at 2025-12-24 23:17:00

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    871, 
    59, 
    '阅读理解：输出预测', 
    '看代码并预测输出：
if x>0:
    print("pos")
else:
    print("non-pos")
当 x=0 时输出是什么？', 
    JSON_OBJECT('A', 'non-pos', 'B', 'pos', 'C', '无输出', 'D', '错误'), 
    1, 
    JSON_ARRAY('0 不大于 0', '进入 else 分支'), 
    'x=0 时不满足 x>0 条件，因此执行 else 分支打印 non-pos。', 
    '同理判断负数情况'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    872, 
    59, 
    '阅读理解：条件顺序', 
    '代码：
if n>10:
    print(">10")
elif n>5:
    print(">5")
else:
    print("<=5")
当 n=12 输出为？', 
    JSON_OBJECT('A', '>10', 'B', '>5', 'C', '<=5', 'D', '无输出'), 
    1, 
    JSON_ARRAY('第一个条件满足即返回', 'elif 不再被执行'), 
    'n=12 满足 n>10，执行第一个分支并结束条件链。', 
    'elif 仅在之前条件不满足时才评估'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    873, 
    59, 
    '阅读理解：嵌套分支', 
    '代码：
if a:
    if b:
        print("x")
    else:
        print("y")
else:
    print("z")
当 a=True b=False 输出？', 
    JSON_OBJECT('A', 'y', 'B', 'x', 'C', 'z', 'D', '无输出'), 
    1, 
    JSON_ARRAY('进入外层 if', '再判断内层 b'), 
    '外层为 True，进入内层，b=False，进入 else 打印 y。', 
    '嵌套结构按层次执行'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    874,
    59,
    '预测输出练习',
    '补全：给出运行结果（填写输出字符串）。
代码：if True:
    print("ok")',
    NULL,
    JSON_ARRAY('ok'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if True:"}, {"type": "code_line", "value": "    print(\"ok\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '条件为 True，打印 ok。',
    'if False 则不打印'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    875,
    59,
    '阅读代码并解释',
    '补全：解释代码含义：if not s: print("empty")',
    NULL,
    JSON_ARRAY('当 s 为空或为 False 值时打印 empty'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if not s:"}, {"type": "code_line", "value": "    print(\"empty\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'not s 为真表示 s 是空、0 或 None 等假值。',
    'if s=="": print("empty")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    876, 
    59, 
    '阅读：短路行为', 
    '代码：
if a or expensive():
    pass
若 a 为 True，则 expensive 会被调用吗？', 
    JSON_OBJECT('A', '不会', 'B', '会', 'C', '视情况而定', 'D', '会抛异常'), 
    1, 
    JSON_ARRAY('or 的短路求值', '左侧为真时右侧不评估'), 
    'or 的短路行为会在左侧为 True 时跳过右侧表达式的计算。', 
    'True or f() 不会调用 f'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    877, 
    59, 
    '阅读：elif 逻辑', 
    '若多个 elif 条件都为 True，最终会执行哪个？', 
    JSON_OBJECT('A', '第一个满足的 elif', 'B', '最后一个满足的 elif', 'C', '所有满足的 elif', 'D', '都不执行'), 
    1, 
    JSON_ARRAY('条件链左到右依次判断', '一旦满足则跳过后续'), 
    '条件链在第一个满足的分支后就停止，不会执行后续的 elif。', 
    'if ... elif ... elif ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    878, 
    59, 
    '阅读：逻辑表达式返回值', 
    '表达式 a or b 在 Python 中返回什么？', 
    JSON_OBJECT('A', '第一个真值或最后一个值', 'B', '总是布尔值', 'C', '仅返回 True/False', 'D', '返回 None'), 
    1, 
    JSON_ARRAY('or 返回实际的操作数而非布尔化结果'), 
    'or 返回第一个真值，如果都为假则返回最后一个值。', 
    '"" or "x" -> "x"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    879,
    59,
    '阅读并写出输出',
    '补全：给出代码运行后的输出。
代码：print(1 if True else 2)',
    NULL,
    JSON_ARRAY('1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(1 if True else 2)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '条件表达式为 True，结果为 1。',
    'print(x if cond else y)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    880,
    59,
    '复杂代码片段理解',
    '补全：若 a=False b=True c=True，代码 if a and b or c 打印什么？',
    NULL,
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if a and b or c"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '表达式按优先级为 (a and b) or c，结果为 True。',
    '短路示例'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    881, 
    59, 
    '阅读：else 的用途', 
    'else 在 if 结构中通常用于？', 
    JSON_OBJECT('A', '在所有前面条件都不满足时执行', 'B', '在第一个条件满足时执行', 'C', '用于循环外部', 'D', '作为注释'), 
    1, 
    JSON_ARRAY('else 是兜底分支', '用于处理未命中情形'), 
    'else 在 if/elif 链未触发任何一个分支时作为默认处理。', 
    'if x>0: ... else: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    882, 
    59, 
    '阅读：条件表达式简化', 
    '下面哪种写法是条件表达式（三元表达式）？', 
    JSON_OBJECT('A', 'x if cond else y', 'B', 'if cond: x else: y', 'C', 'cond ? x : y', 'D', 'x ? y : cond'), 
    1, 
    JSON_ARRAY('Python 的三元表达式格式'), 
    'Python 用 x if cond else y 表示条件表达式。', 
    'res = 1 if a>0 else -1'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    883, 
    59, 
    '阅读：条件短路与函数调用', 
    '在 a and f() 中，若 a 为 False，f() 会被调用吗？', 
    JSON_OBJECT('A', '不会', 'B', '会', 'C', '视 f() 返回而定', 'D', '抛出异常'), 
    1, 
    JSON_ARRAY('and 的短路求值', '左侧为 False 时不再评估右侧'), 
    'and 会在左侧为 False 时短路，右侧表达式不被求值。', 
    'False and f() 不会调用 f'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    884,
    59,
    '阅读并说明结果原因',
    '补全：解释 print("a" or "b") 输出为何为 a。',
    NULL,
    JSON_ARRAY('a'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"a\" or \"b\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'or 返回第一个真值字符串 "a"，因此输出 a。',
    '"" or "x" -> "x"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    885,
    59,
    '代码阅读综合',
    '补全：给出下面代码执行后的输出：
print(1 if 0 else 2)',
    NULL,
    JSON_ARRAY('2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(1 if 0 else 2)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '条件为 0 (假)，因此结果为 else 分支 2。',
    '条件表达式示例'
);