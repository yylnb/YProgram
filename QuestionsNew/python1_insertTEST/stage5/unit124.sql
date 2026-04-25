USE `questions`;
-- Unit 124 | Start ID: 1846
-- Generated at 2025-12-24 18:18:54

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1846, 
    124, 
    'return 的基本作用', 
    '在函数中使用 return 语句，最核心的作用是什么？', 
    JSON_OBJECT('A', '在屏幕上输出结果', 'B', '结束函数执行并把结果返回给调用者', 'C', '定义一个全局变量', 'D', '暂停函数，稍后再继续执行'), 
    2, 
    JSON_ARRAY('return 和 print 的作用并不相同。', '函数调用后，往往需要一个“结果”。', 'return 会把值交还给函数外部。'), 
    'return 用于结束函数执行，并将结果返回给调用该函数的地方。', 
    'def add(a, b):
    return a + b'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1847, 
    124, 
    '没有 return 会怎样', 
    '如果一个函数内部没有写 return，调用它时会返回什么？', 
    JSON_OBJECT('A', '0', 'B', 'False', 'C', 'None', 'D', '报错'), 
    3, 
    JSON_ARRAY('Python 中有一个特殊值表示“什么也没有”。', '函数默认也会有返回值。', '这个值经常用来表示“没有结果”。'), 
    '如果函数中没有显式的 return，Python 会默认返回 None。', 
    'def foo():
    pass
result = foo()  # result 是 None'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1848, 
    124, 
    'return 与 print 的区别', 
    '下面关于 return 和 print 的说法，哪一个是正确的？', 
    JSON_OBJECT('A', 'print 可以把值传递给函数外部，return 不行', 'B', 'return 会直接在控制台显示结果', 'C', 'print 用于显示，return 用于返回结果', 'D', 'return 和 print 可以完全互换使用'), 
    3, 
    JSON_ARRAY('print 的主要作用是“展示”。', 'return 的主要作用是“传值”。', '函数调用是否能拿到结果是关键区别。'), 
    'print 只负责输出到屏幕，而 return 才能把结果返回给调用者继续使用。', 
    'x = len("hello")  # len 内部用的是 return'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1849, 
    124, 
    '多个 return 的执行顺序', 
    '一个函数中存在多个 return，哪条规则是正确的？', 
    JSON_OBJECT('A', '所有 return 都会执行', 'B', '只执行最后一个 return', 'C', '只执行条件满足时遇到的第一个 return', 'D', 'return 的顺序不确定'), 
    3, 
    JSON_ARRAY('return 会立即结束函数。', '代码是从上到下执行的。', '遇到 return 后不会再继续往下走。'), 
    '函数执行到第一个被触发的 return 时就会结束，其后的代码不会执行。', 
    'if x > 0:
    return 1
return -1'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1850, 
    124, 
    'return 与条件判断', 
    '在函数中用 return 配合 if/else，主要是为了什么？', 
    JSON_OBJECT('A', '让函数更长', 'B', '根据不同情况返回不同结果', 'C', '替代所有的变量', 'D', '避免写函数名'), 
    2, 
    JSON_ARRAY('不同输入往往有不同输出。', 'if/else 用来分支逻辑。', 'return 决定最终结果。'), 
    '通过 if/else + return，可以让函数在不同条件下返回不同的结果。', 
    'def abs_val(x):
    if x >= 0:
        return x
    else:
        return -x'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1851, 
    124, 
    'return 后的代码', 
    '在函数中，return 语句后面的代码会怎样？', 
    JSON_OBJECT('A', '正常执行', 'B', '延迟执行', 'C', '被跳过，不会执行', 'D', '只执行一次'), 
    3, 
    JSON_ARRAY('return 会结束函数。', '函数结束意味着什么？', '结束后不再继续执行内部代码。'), 
    'return 会立刻结束函数，return 后面的代码永远不会被执行。', 
    'return 10
print("这里永远不会执行")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1852, 
    124, 
    'return 的返回值类型', 
    '关于 return 返回值的类型，下列说法正确的是哪一个？', 
    JSON_OBJECT('A', '只能返回整数', 'B', '只能返回字符串', 'C', '可以返回任意类型的对象', 'D', '只能返回一个变量'), 
    3, 
    JSON_ARRAY('Python 是动态类型语言。', '函数结果不局限于一种类型。', '列表、字典等也可以作为结果。'), 
    'Python 的 return 可以返回任意类型的对象，包括数字、字符串、列表、字典等。', 
    'return [1, 2, 3]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1853, 
    124, 
    'return 多个值', 
    '函数中写 return a, b 实际返回的是什么？', 
    JSON_OBJECT('A', '两个独立的值', 'B', '一个列表', 'C', '一个元组', 'D', '报错'), 
    3, 
    JSON_ARRAY('Python 中逗号有特殊含义。', 'a, b 本身就是一种结构。', '可以用多个变量接收这个返回值。'), 
    'return a, b 实际上返回的是一个元组 (a, b)。', 
    'x, y = get_pos()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1854, 
    124, 
    'return 与函数调用结果', 
    '下面哪种写法能正确接收函数返回值？', 
    JSON_OBJECT('A', 'print = my_func()', 'B', 'my_func() = x', 'C', 'x = my_func()', 'D', 'return = my_func()'), 
    3, 
    JSON_ARRAY('函数调用可以出现在赋值右侧。', '左侧应该是变量。', 'return 不能作为变量名使用。'), 
    '函数调用的返回值可以赋给变量，如 x = my_func()。', 
    'length = len("abc")'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1855,
    124,
    '最简单的返回值',
    '补全函数，使其返回变量 result 的值。',
    'result = 42',
    JSON_ARRAY('42'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def get_result():"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " result"}]}]}',
    JSON_ARRAY('print', 'return', 'yield', 'pass', 'output'),
    JSON_ARRAY(2),
    '要把函数内部的值交给外部使用，必须使用 return。',
    'def get_pi():
    return 3.14'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1856,
    124,
    'return 结束函数',
    '补全代码，使函数在条件满足时提前结束。',
    'x = -1',
    JSON_ARRAY('None'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def check_positive(x):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if x < 0:"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    return x"}]}]}',
    JSON_ARRAY('break', 'continue', 'return', 'return None', 'pass'),
    JSON_ARRAY(4),
    'return 会立刻结束函数执行，这里 return None 用于提前返回。',
    'if not data:
    return None'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1857,
    124,
    '返回计算结果',
    '补全代码，使函数返回两个数的和。',
    'a = 2
b = 3',
    JSON_ARRAY('5'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def add(a, b):"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " a + b"}]}]}',
    JSON_ARRAY('print', 'return', 'yield', 'output', 'sum'),
    JSON_ARRAY(2),
    '函数需要用 return 把计算结果 a + b 返回。',
    'total = add(5, 7)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1858,
    124,
    'return None 的省略写法',
    '补全代码，使函数在条件不满足时返回 None。',
    'x = 0',
    JSON_ARRAY('None'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def check(x):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if x == 0:"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    return x"}]}]}',
    JSON_ARRAY('return', 'return None', 'pass', 'break', 'continue'),
    JSON_ARRAY(1),
    '单独写 return 等价于 return None。',
    'def stop():
    return'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1859,
    124,
    '返回布尔结果',
    '补全函数，使其判断数字是否为偶数并返回结果。',
    'n = 4',
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def is_even(n):"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " n % 2 == 0"}]}]}',
    JSON_ARRAY('print', 'return', 'yield', 'output', 'bool'),
    JSON_ARRAY(2),
    '函数应使用 return 返回 True 或 False。',
    'if is_even(10):
    print("偶数")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1860,
    124,
    '用 return 控制流程',
    '补全代码：当列表为空时立即返回 0，否则返回元素个数。',
    'data = []',
    JSON_ARRAY('0'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def count_items(data):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if not data:"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " 0"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 1}, {"type": "code", "value": " len(data)"}]}]}',
    JSON_ARRAY('return', 'print', 'yield', 'pass', 'output'),
    JSON_ARRAY(1, 1),
    'return 不仅返回值，还能控制函数流程，在需要时提前结束。',
    'def safe_len(x):
    if x is None:
        return 0
    return len(x)'
);