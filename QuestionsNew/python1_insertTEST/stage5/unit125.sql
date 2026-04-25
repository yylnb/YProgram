USE `questions`;
-- Unit 125 | Start ID: 1861
-- Generated at 2025-12-24 18:18:59

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1861, 
    125, 
    '返回值类型', 
    '函数返回值的类型由什么决定？', 
    JSON_OBJECT('A', 'return 后表达式的类型', 'B', '函数定义时声明的类型', 'C', '调用者决定', 'D', 'Python 版本'), 
    1, 
    JSON_ARRAY('提示1：返回的是表达式的计算结果', '提示2：没有静态类型声明影响返回类型', '提示3：可以返回任意对象'), 
    '函数返回值的类型由 return 后表达式在运行时决定。', 
    'def f(): return 1
# 返回 int'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1862, 
    125, 
    '显式类型转换', 
    '将整数转换为字符串应使用哪个函数？', 
    JSON_OBJECT('A', 'str', 'B', 'int', 'C', 'float', 'D', 'bool'), 
    1, 
    JSON_ARRAY('提示1：str() 用于转换为字符串', '提示2：int() 用于转换为整数', '提示3：注意转换失败可能抛异常'), 
    '使用 str(n) 将整数或其他对象转换为字符串。', 
    'str(123)  # "123"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1863, 
    125, 
    '自动类型转换', 
    '表达式 1 + 2.0 的结果类型是？', 
    JSON_OBJECT('A', 'float', 'B', 'int', 'C', 'str', 'D', 'complex'), 
    1, 
    JSON_ARRAY('提示1：有 float 参与通常会转为 float', '提示2：数值运算遵循类型提升规则', '提示3：1 是 int，2.0 是 float'), 
    '混合整数和浮点数运算会得到浮点数结果。', 
    '1 + 2.0  # 3.0'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1864, 
    125, 
    'repr 与 str', 
    '下面关于 repr() 与 str() 的区别，说法正确的是？', 
    JSON_OBJECT('A', 'repr 更明确用于调试，str 更友好用于展示', 'B', '两者完全相同', 'C', 'str 用于调试', 'D', 'repr 返回 HTML'), 
    1, 
    JSON_ARRAY('提示1：repr 会尽量给出可以 eval 的表示', '提示2：str 更可读', '提示3：repr 常用于调试输出'), 
    'repr 给出更精确的表示，str 给出更易读的表示。', 
    'repr("a\n")  # "\'a\\n\'"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1865, 
    125, 
    '返回布尔值', 
    '函数要返回布尔值，下面哪个写法更推荐？', 
    JSON_OBJECT('A', '直接返回比较表达式，如 return x>0', 'B', '先 if then return True else return False', 'C', '返回字符串 "True"', 'D', '返回 1/0'), 
    1, 
    JSON_ARRAY('提示1：比较表达式已经是布尔值', '提示2：简洁且可读', '提示3：避免使用字符串表示布尔'), 
    '直接返回比较表达式更简洁和 Pythonic。', 
    'def is_pos(x):
    return x>0'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1866, 
    125, 
    '异常与返回', 
    '函数在执行时抛出异常会怎样？', 
    JSON_OBJECT('A', '不会返回正常值，而是传播异常', 'B', '自动返回 None', 'C', '返回 False', 'D', '忽略异常继续返回'), 
    1, 
    JSON_ARRAY('提示1：异常会中断正常流程', '提示2：可以捕获异常并返回默认值', '提示3：未捕获会向上抛出'), 
    '异常会打断函数执行，除非捕获，否则不会返回普通的返回值。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1867, 
    125, 
    '隐式转换副作用', 
    '隐式类型转换（coercion）有何潜在问题？', 
    JSON_OBJECT('A', '可能导致精度或语义丢失', 'B', '总是更快更安全', 'C', 'Python 不会进行隐式转换', 'D', '仅在字符串间发生'), 
    1, 
    JSON_ARRAY('提示1：混合类型运算需注意', '提示2：浮点运算可能丢失精度', '提示3：转换应显式进行以提高可读性'), 
    '隐式转换可能导致意外结果，显式转换更安全。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1868, 
    125, 
    '返回值文档', 
    '如何在函数文档字符串中说明返回值类型？', 
    JSON_OBJECT('A', '在 docstring 中描述返回的类型与含义', 'B', '不需要说明', 'C', '用注释代替 docstring', 'D', '只在源码注解中写'), 
    1, 
    JSON_ARRAY('提示1：清晰的 docstring 有助于使用者', '提示2：可配合类型注解', '提示3：包括返回值的含义'), 
    '在 docstring 中明确说明返回值类型与语义是良好实践。', 
    '"""Returns: int: count of items"""'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1869, 
    125, 
    '返回生成器', 
    '若函数使用 yield 返回值，函数本身会返回什么？', 
    JSON_OBJECT('A', '返回生成器对象', 'B', '返回列表', 'C', '返回 None', 'D', '立刻执行并返回所有值'), 
    1, 
    JSON_ARRAY('提示1：yield 会使函数变为生成器', '提示2：生成器按需产出值', '提示3：可用 next() 或 for 遍历'), 
    '包含 yield 的函数返回生成器对象，值在迭代时生成。', 
    'def g():
    yield 1
# g() 是生成器'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1870,
    125,
    '返回数字字符串（填空）',
    '将返回值转换为字符串并返回，填入正确序号。',
    NULL,
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def f(x):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    return "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}, {"type": "code_line", "value": "print(f(10))  # 输出 \"10\""}]}]}',
    JSON_ARRAY('str(x)', 'int(x)', 'float(x)', 'repr(x)'),
    JSON_ARRAY(1),
    '使用 str(x) 将数字转换为字符串后返回。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1871,
    125,
    '解析字符串（填空）',
    '把字符串 "123" 解析为整数应使用哪个序号？',
    NULL,
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = \"123\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")  # 123"}]}]}',
    JSON_ARRAY('int(s)', 'str(s)', 'float(s)', 'bool(s)'),
    JSON_ARRAY(1),
    'int(s) 将数字形式的字符串转换为整数。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1872,
    125,
    '安全转换（填空）',
    '把可能不是数字的字符串转换为整数，并在失败时返回 __1__。',
    NULL,
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def safe_int(s):"}, {"type": "code_line", "value": "    try:"}, {"type": "code_line", "value": "        return int(s)"}, {"type": "code_line", "value": "    except ValueError:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        return "}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('None', '0', '""', '-1'),
    JSON_ARRAY(1),
    '返回 None 可表示转换失败且不误导为有效数字。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1873,
    125,
    '类型检查（填空）',
    '若要检查变量是否为整数，应使用 __1__。',
    NULL,
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 1"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"int\")"}]}]}',
    JSON_ARRAY('isinstance(x, int)', 'type(x)==int', 'x.__class__==int', 'isinstance(x, str)'),
    JSON_ARRAY(1),
    'isinstance 更灵活且支持继承关系，推荐使用。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1874,
    125,
    '复合返回（填空）',
    '要从函数中返回多个不同类型的值，推荐返回 __1__。',
    NULL,
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def f():"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    return "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}, {"type": "code_line", "value": "# 接收: a,b = f()"}]}]}',
    JSON_ARRAY('元组', '字符串', '单个整数', '列表'),
    JSON_ARRAY(1),
    '返回元组是一种常见且简洁的方式来返回多个值。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1875,
    125,
    '练习（填空）',
    '写一行代码把变量 x 转为浮点并返回： return __1__',
    NULL,
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "return "}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('float(x)', 'int(x)', 'str(x)', 'bool(x)'),
    JSON_ARRAY(1),
    'float(x) 将 x 转为浮点数并返回。',
    ''
);