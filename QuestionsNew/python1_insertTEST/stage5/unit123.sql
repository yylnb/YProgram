USE `questions`;
-- Unit 123 | Start ID: 1831
-- Generated at 2025-12-24 18:18:56

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1831, 
    123, 
    'return 的作用', 
    '函数中的 return 主要用于什么？', 
    JSON_OBJECT('A', '将结果返回给调用方并结束函数执行', 'B', '打印结果', 'C', '注释代码', 'D', '定义变量'), 
    1, 
    JSON_ARRAY('提示1：return 会把值传回调用处', '提示2：return 之后函数不再继续执行', '提示3：没有 return 则返回 None'), 
    'return 将值返回并结束函数，调用者可以接收该返回值。', 
    'def add(a,b):
    return a+b'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1832, 
    123, 
    '多个 return', 
    '在同一函数中可以有多个 return 吗？', 
    JSON_OBJECT('A', '可以，根据不同分支返回不同结果', 'B', '不可以，只能有一个', 'C', '取决于 Python 版本', 'D', '只有在循环中可以'), 
    1, 
    JSON_ARRAY('提示1：在 if/else 分支中常见多个 return', '提示2：每个 return 对应不同执行路径', '提示3：只要语法正确即可'), 
    '函数可以在不同分支返回不同值，return 会结束当前调用路径。', 
    'def sign(x):
    if x>0: return 1
    else: return 0'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1833, 
    123, 
    'return 与 print 区别', 
    '下面哪个陈述更准确地描述 return 与 print 的区别？', 
    JSON_OBJECT('A', 'return 提供值给调用者，print 仅输出到屏幕', 'B', 'print 返回字符串，return 输出到屏幕', 'C', '两者都退出函数并返回值', 'D', '无区别'), 
    1, 
    JSON_ARRAY('提示1：print 仅在控制台输出', '提示2：return 的值可被变量接收', '提示3：调试时常用 print，但功能不同'), 
    'print 是展示性的 I/O，return 是函数间的数据传递机制。', 
    'def f():
    print(1)
    return 2'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1834, 
    123, 
    '返回多个值', 
    '函数可以返回多个值吗，返回时得到的类型通常是什么？', 
    JSON_OBJECT('A', '可以，通常会返回元组', 'B', '不可以，函数只能返回单一值', 'C', '可以，但返回列表', 'D', '可以，但返回字典'), 
    1, 
    JSON_ARRAY('提示1：Python 支持用逗号分隔返回多个值', '提示2：实际是打包成元组返回', '提示3：可以在调用方解包'), 
    '使用 return a, b 会返回一个元组 (a, b)，调用方可以解包到多个变量。', 
    'def f():
    return 1,2
print(f())  # (1, 2)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1835, 
    123, 
    'return 放在循环内', 
    '如果在循环内执行 return，会发生什么？', 
    JSON_OBJECT('A', '函数立即结束并返回值', 'B', '循环继续直到结束', 'C', '抛出异常', 'D', '忽略 return'), 
    1, 
    JSON_ARRAY('提示1：return 会终止函数的执行', '提示2：在循环内 return 会提前退出', '提示3：小心循环中不必要的提前退出'), 
    '在循环中使用 return 会导致函数立即结束并返回指定值。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1836, 
    123, 
    'return None 的判断', 
    '要判断函数返回值是否为 None，推荐写法是？', 
    JSON_OBJECT('A', 'if res is None:', 'B', 'if res == None:', 'C', 'if not res:', 'D', 'if res === None:'), 
    1, 
    JSON_ARRAY('提示1：比较 None 推荐使用 is', '提示2：== 在某些情况下也可用但不是最佳实践', '提示3：Python 中没有 === 运算符'), 
    '判断 None 推荐使用身份运算符 is，以区分 False/0/"" 等假值。', 
    'if func() is None: pass'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1837, 
    123, 
    'return 后的代码', 
    'return 之后的语句会怎样？', 
    JSON_OBJECT('A', '不会被执行，函数已结束', 'B', '仍会被执行', 'C', '会被排队到下次调用', 'D', '会报语法错误'), 
    1, 
    JSON_ARRAY('提示1：return 立即结束函数', '提示2：后续语句不会执行', '提示3：因此放在函数末尾没有意义'), 
    'return 立即终止函数，后面的代码不会运行，除非在其他分支中。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1838, 
    123, 
    '函数链式调用', 
    '若 f() 返回一个对象且该对象有方法 m()，可以直接写 f().m() 吗？', 
    JSON_OBJECT('A', '可以，只要 f() 返回的对象有 m 方法', 'B', '不可以，必须先赋值', 'C', '只有在 Python 3.8+ 才可', 'D', '仅限字符串对象'), 
    1, 
    JSON_ARRAY('提示1：这是常见的链式调用写法', '提示2：确保返回对象支持该方法', '提示3：一般用于流式接口'), 
    '链式调用是有效的，前提是中间返回对象具有被调用的方法或属性。', 
    'get_user().send_email()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1839, 
    123, 
    '返回引用', 
    '若函数返回可变对象（如列表），调用方对其修改会如何？', 
    JSON_OBJECT('A', '调用方修改会影响原对象引用', 'B', '调用方修改不会影响', 'C', '会抛异常', 'D', '返回后对象变为不可变'), 
    1, 
    JSON_ARRAY('提示1：可变对象通过引用传递', '提示2：修改会反映到所有引用处', '提示3：若需保护可返回副本'), 
    '返回可变对象会传递引用，修改会反映在所有引用该对象的地方。', 
    ''
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1840,
    123,
    '提前返回（填空）',
    '补全代码，使在满足条件时提前返回字符串 "too small"。',
    NULL,
    JSON_ARRAY('too small'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def check(n):"}, {"type": "code_line", "value": "    if n < 10:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        "}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    return \"ok\""}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "print(check(3))  # 输出 too small"}]}]}',
    JSON_ARRAY('return "too small"', 'print("too small")', 'break', 'yield "too small"'),
    JSON_ARRAY(1),
    '在满足条件时应使用 return 提前返回指定字符串。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1841,
    123,
    '无返回值（填空）',
    '若函数不显式返回值，print(f()) 打印的是什么？',
    NULL,
    JSON_ARRAY('None'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def f():"}, {"type": "code_line", "value": "    x=1"}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "print(f())  # 输出 "}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('None', '0', '1', '""'),
    JSON_ARRAY(1),
    '函数默认返回 None，因此打印 f() 会显示 None。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1842,
    123,
    '返回解包（填空）',
    '若函数返回 (1,2)，下列写法可正确将两个值赋给 a,b 吗？',
    NULL,
    JSON_ARRAY('1 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def f():"}, {"type": "code_line", "value": "    return 1,2"}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "a, b = "}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(a, b)  # 1 2"}]}]}',
    JSON_ARRAY('f()', '(1,2)', '[1,2]', 'f'),
    JSON_ARRAY(1),
    '直接把函数调用的返回值解包到 a,b 即可，使用 f()。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1843,
    123,
    '立即返回（填空）',
    '下面代码中，若要在 i 为 3 时立即返回 i，应填哪些序号？',
    NULL,
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def find():"}, {"type": "code_line", "value": "    for i in range(5):"}, {"type": "code_line", "value": "        if i==3:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "            "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    return -1"}]}]}',
    JSON_ARRAY('return i', 'print(i)', 'break', 'yield i'),
    JSON_ARRAY(1),
    '需要用 return i 在满足条件时返回并结束函数。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1844,
    123,
    '函数嵌套返回（填空）',
    '下面代码要返回内部函数的引用，填入正确序号。',
    NULL,
    JSON_ARRAY('1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def outer():"}, {"type": "code_line", "value": "    def inner():"}, {"type": "code_line", "value": "        return 1"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}, {"type": "code_line", "value": "f = outer()"}, {"type": "code_line", "value": "print(f())  # 输出 1"}]}]}',
    JSON_ARRAY('return inner', 'return inner()', 'print(inner)'),
    JSON_ARRAY(1),
    '要返回函数对象本身，应返回 inner 而不是调用它。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1845,
    123,
    '总结（填空）',
    'return 的作用是 __1__ 并且可以返回 __2__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('结束函数', '传值给调用者', '打印输出', '抛出异常', 'None 或任意对象'),
    JSON_ARRAY(1, 2),
    'return 会结束函数并将值传回调用者，返回的可以是 None 或任意对象。',
    ''
);