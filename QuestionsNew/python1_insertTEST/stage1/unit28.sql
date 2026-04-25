USE `questions`;
-- Unit 28 | Start ID: 406
-- Generated at 2025-12-24 17:12:08

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    406, 
    28, 
    '哪些值被视为 False？', 
    '下列哪个值在布尔上下文中被视为 False？', 
    JSON_OBJECT('A', '0, "", None, []', 'B', '非空字符串', 'C', '非零数字', 'D', '包含元素的列表'), 
    1, 
    JSON_ARRAY('空集合和 0 通常为假。', 'None 也为假。', '非空容器为真。'), 
    '0、空字符串、None、空列表等在布尔上下文中为 False。', 
    'if []: print("有元素") 不会执行。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    407, 
    28, 
    '空字符串的真值', 
    '表达式 bool("") 的结果是？', 
    JSON_OBJECT('A', 'True', 'B', 'False', 'C', 'None', 'D', '抛出异常'), 
    2, 
    JSON_ARRAY('空字符串没有内容。', '空容器通常为 False。', '可以用 bool() 检查。'), 
    '空字符串被视为 False。', 
    'bool("") → False, bool("a") → True。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    408, 
    28, 
    'None 的真值', 
    '在布尔上下文中，None 的值是？', 
    JSON_OBJECT('A', 'True', 'B', 'False', 'C', '取决于 Python 版本', 'D', 'Undefined'), 
    2, 
    JSON_ARRAY('None 表示缺失或空。', '通常被当作假值处理。', '适合用 is None 判断。'), 
    'None 在布尔上下文中为 False。', 
    'if value is None: ... 与 if not value: ... 行为不同。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    409, 
    28, 
    '容器的真值', 
    '哪个集合在布尔上下文中为 False？', 
    JSON_OBJECT('A', '{1,2}', 'B', 'set()', 'C', '[0]', 'D', '(1,)'), 
    2, 
    JSON_ARRAY('空集合为假。', '非空容器通常为真。', '注意 [0] 虽包含 0，但非空。'), 
    '空集合 set() 在布尔上下文中为 False。', 
    'if not set(): print("空集合")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    410, 
    28, 
    '自定义对象的真值', 
    '如果类没有定义 __bool__ 或 __len__，其实例在布尔上下文中为？', 
    JSON_OBJECT('A', 'True', 'B', 'False', 'C', '取决于内部字段', 'D', '报错'), 
    1, 
    JSON_ARRAY('默认情况下对象为真。', '可通过实现 __bool__ 改变行为。', '只有特殊实现会让实例为假。'), 
    '没有定义 __bool__ 或 __len__ 的对象实例在布尔上下文中被视为 True。', 
    'class A: pass; bool(A()) → True'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    411, 
    28, 
    'None 与空串的区别', 
    '哪种说法正确？', 
    JSON_OBJECT('A', 'None 与 "" 在布尔上下文中都为假，但语义不同', 'B', 'None 与 "" 完全等价', 'C', 'None 总是 True', 'D', '空串会抛出异常'), 
    1, 
    JSON_ARRAY('None 表示缺失', '"" 是有效但为空的字符串', '两者语义不同，应分别处理'), 
    'None 表示没有值；空字符串表示有值但为空，二者布尔值都为 False，但应根据语义选择判断方式。', 
    'if s is None: ... 与 if not s: ... 含义不同。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    412, 
    28, 
    'empty 与 None 的比较', 
    '如果 s = ""，下面哪种判断能明确区分 None 与 空字符串？', 
    JSON_OBJECT('A', 'if not s:', 'B', 'if s is None:', 'C', 'if s == None:', 'D', '以上都可以'), 
    2, 
    JSON_ARRAY('is None 用于判断 None。', 's == None 也可，但不推荐。', 'not s 无法区分空串与 None。'), 
    '使用 is None 可以明确判断是否为 None，not s 无法区分空值与 None。', 
    'if value is None: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    413, 
    28, 
    '布尔转换函数', 
    '哪个函数可将任意值转换为布尔值？', 
    JSON_OBJECT('A', 'int()', 'B', 'bool()', 'C', 'str()', 'D', 'len()'), 
    2, 
    JSON_ARRAY('bool() 用于布尔转换。', 'int() 转为整数。', 'len() 返回长度。'), 
    '使用 bool(x) 可以得到 x 在布尔上下文中的真值。', 
    'bool("") → False，bool([1]) → True。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    414, 
    28, 
    '空白的判断习惯', 
    '检查字符串是否非空的习惯写法是什么？', 
    JSON_OBJECT('A', 'if len(s) > 0:', 'B', 'if s:', 'C', 'if s != "":', 'D', '以上都行，但最 Pythonic 是 if s:'), 
    4, 
    JSON_ARRAY('Pythonic 风格更简洁。', 'len(s) > 0 也可以。', '但 if s 更常见。'), 
    '三种写法都能判断非空，但 Pythonic 推荐直接使用 if s。', 
    'if items: print("有元素")'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    415,
    28,
    '空列表判断',
    '补全代码，只有当列表非空时打印内容。',
    'lst = [1,2]',
    JSON_ARRAY('有元素'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = [1,2]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"有元素\")"}]}]}',
    JSON_ARRAY('lst', 'len(lst) > 0', 'lst != []', 'not lst'),
    JSON_ARRAY(1),
    '直接在 if 中使用 lst 会在非空时为 True。',
    'if items: print("有元素")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    416,
    28,
    '零的真值',
    '补全输出 False。',
    NULL,
    JSON_ARRAY('False'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(bool("}, {"type": "slot", "index": 0}, {"type": "code", "value": "))"}]}]}',
    JSON_ARRAY('0', '1', '-1', '0.1'),
    JSON_ARRAY(1),
    '整数 0 在布尔上下文中为 False。',
    'bool(0) → False, bool(5) → True'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    417,
    28,
    '使用 truthiness 简化判断',
    '用最简洁的方式判断字典是否有键。',
    'd = {"a":1}',
    JSON_ARRAY('包含'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "d = {\"a\":1}"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"包含\")"}]}]}',
    JSON_ARRAY('d', 'len(d) > 0', 'd != {}', 'not d'),
    JSON_ARRAY(1),
    '直接使用字典对象在布尔上下文中判断是否非空。',
    'if config: print("配置存在")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    418,
    28,
    'False 值判定',
    '补全使输出 False。',
    NULL,
    JSON_ARRAY('False'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(bool("}, {"type": "slot", "index": 0}, {"type": "code", "value": "))"}]}]}',
    JSON_ARRAY('[]', '0', 'None', '"text"'),
    JSON_ARRAY(1, 2, 3),
    '[], 0, None 都会被 bool() 判为 False；题目可任选其一，示例中我们列出三个可选项。',
    'bool([]) → False'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    419,
    28,
    '组合判断示例',
    '补全，使只有当列表非空且第一个元素为真时打印。',
    'lst = [0,1]',
    JSON_ARRAY('通过'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = [0,1]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": " and "}, {"type": "slot", "index": 1}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"通过\")"}]}]}',
    JSON_ARRAY('lst', 'lst[0]', 'not lst', 'len(lst) == 0'),
    JSON_ARRAY(1, 2),
    '先判断列表非空，再判断第一个元素的真值。',
    'if items and items[0]: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    420,
    28,
    '使用 truthiness 简化代码',
    '将以下两行用一行 if 简化。',
    's = "text"',
    JSON_ARRAY('存在'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = \"text\""}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": "    print(\"存在\")"}]}]}',
    JSON_ARRAY('if s:', 'if not s:', 'if s is None:', 'if len(s):'),
    JSON_ARRAY(1),
    '直接使用 if s 更简洁，等价于 len(s) > 0 的判断。',
    'if username: print(username)'
);