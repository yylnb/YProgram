USE `questions`;
-- Unit 29 | Start ID: 421
-- Generated at 2025-12-24 23:07:31

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    421, 
    29, 
    '复合表达式的含义', 
    '下面哪个是复合逻辑表达式的例子？', 
    JSON_OBJECT('A', 'a + b', 'B', 'a and (b or c)', 'C', 'print(a)', 'D', 'len(lst)'), 
    2, 
    JSON_ARRAY('复合逻辑包含多个逻辑运算符。', '常用括号明确组。', '与算术运算不同。'), 
    'a and (b or c) 是典型的复合逻辑表达式。', 
    'if (x > 0 and x < 10) or flag: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    422, 
    29, 
    '优先级与短路结合', 
    '在表达式 A or B and C 中，哪部分先求值？', 
    JSON_OBJECT('A', 'A 或者 B，顺序自左向右', 'B', 'B and C 先求值，然后与 A 做 or', 'C', 'A 和 B 同时求值', 'D', '运算顺序不可确定'), 
    2, 
    JSON_ARRAY('and 优先于 or。', '短路规则仍然适用。', '可用括号改变顺序。'), 
    'and 的优先级高于 or，因此先计算 B and C，再和 A 做 or。', 
    'True or False and False → True（先算 and）'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    423, 
    29, 
    '括号的作用', 
    '为什么在复杂逻辑中推荐使用括号？', 
    JSON_OBJECT('A', '提高可读性并明确运算顺序', 'B', '加速程序执行', 'C', '减少内存占用', 'D', '避免语法错误，但不影响含义'), 
    1, 
    JSON_ARRAY('括号让优先级一目了然。', '可避免歧义。', '虽然有默认优先级，但不总直观。'), 
    '括号能清晰地表达开发者的意图，避免理解错误。', 
    'if (a and b) or c: 与 if a and (b or c): 含义不同。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    424,
    29,
    '综合填空：登录检查',
    '补全判断：已登录且角色为 admin 或 superuser 时允许访问。',
    'logged = True
role = "user"',
    JSON_ARRAY('Access Denied'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "logged = True"}, {"type": "code_line", "value": "role = \"user\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if logged and (role == \"admin\" "}, {"type": "slot", "index": 0}, {"type": "code", "value": " role == \"superuser\"):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"Access Granted\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\"Access Denied\")"}]}]}',
    JSON_ARRAY('and', 'or', 'not', '=='),
    JSON_ARRAY(2),
    '需要判断 role 等于 "admin" 或 "superuser"，用 or 将两者连接。',
    'if logged and (role == "admin" or role == "superuser"): ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    425,
    29,
    '优先级与括号',
    '补全使得第一个小表达式优先被判断。',
    'a=True; b=False; c=True',
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a=True"}, {"type": "code_line", "value": "b=False"}, {"type": "code_line", "value": "c=True"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print((a "}, {"type": "slot", "index": 0}, {"type": "code", "value": " b) or c)"}]}]}',
    JSON_ARRAY('and', 'or', 'not', '=='),
    JSON_ARRAY(1),
    '用括号 (a and b) 确保先计算 a and b，然后或 c。',
    'print((x>0 and x<5) or flag)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    426, 
    29, 
    '嵌套逻辑的阅读技巧', 
    '阅读复杂表达式时哪种做法最推荐？', 
    JSON_OBJECT('A', '一次看完并记住', 'B', '拆成多个小条件并命名', 'C', '直接运行代码猜测结果', 'D', '用注释替代括号'), 
    2, 
    JSON_ARRAY('拆分有助于测试每个子条件。', '命名变量提升可读性。', '避免一次性理解复杂逻辑。'), 
    '把复杂条件拆分成有意义的子条件可以提高可读性和可维护性。', 
    'is_valid = (a and b); if is_valid or c: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    427, 
    29, 
    '短路与副作用', 
    '在复合逻辑中，短路行为会如何影响副作用？', 
    JSON_OBJECT('A', '不会影响副作用', 'B', '可能避免某些函数调用的副作用', 'C', '会总是执行所有函数', 'D', '会导致语法错误'), 
    2, 
    JSON_ARRAY('短路会跳过右侧的求值。', '如果右侧有函数调用就可能被跳过。', '注意副作用顺序。'), 
    '短路机制可能导致某些函数调用不被执行，从而影响程序的副作用。', 
    'a or func() 当 a 为真时 func 不会被调用。'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    428, 
    29, 
    '逻辑表达式重写', 
    '将表达式 not (a and b) 用 De Morgan 定律重写，哪个是等价的？', 
    JSON_OBJECT('A', 'not a and not b', 'B', 'not a or not b', 'C', 'a or b', 'D', 'a and b'), 
    2, 
    JSON_ARRAY('De Morgan 法则将 and 与 or 互换并取反。', '注意括号与 not 的结合。', '回顾基本逻辑等价变形。'), 
    'not (a and b) 等价于 (not a) or (not b)。', 
    'not (x>0 and y>0) 等价于 x<=0 or y<=0（等价但注意边界）。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    429,
    29,
    '复杂条件的正确写法',
    '补全后使条件为真（年龄在 18 到 30，或有特殊通行证）。',
    'age = 25
has_pass = False',
    JSON_ARRAY('允许'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "age = 25"}, {"type": "code_line", "value": "has_pass = False"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if (age >= 18 and age <= 30) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " has_pass:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"允许\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\"拒绝\")"}]}]}',
    JSON_ARRAY('and', 'or', 'not', '=='),
    JSON_ARRAY(2),
    '年龄条件或有通行证即可通过，使用 or 连接两部分。',
    'if (18 <= age <= 30) or is_vip: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    430,
    29,
    '把复杂条件拆成变量',
    '将复杂判断拆为两个子条件并复合。',
    'x=4; y=10',
    JSON_ARRAY('满足'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x=4"}, {"type": "code_line", "value": "y=10"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "cond1 = x > 0 and x < 5"}, {"type": "code_line", "value": "cond2 = y > 5"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if cond1 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " cond2:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"满足\")"}]}]}',
    JSON_ARRAY('and', 'or', 'not', '=='),
    JSON_ARRAY(2),
    '只要 cond1 或 cond2 为真则满足，使用 or。',
    'if valid or override: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    431, 
    29, 
    '避免逻辑歧义', 
    '下面哪个建议有助于避免逻辑表达式的歧义？', 
    JSON_OBJECT('A', '尽量把所有判断写在一行', 'B', '使用有意义的中间变量并加注释', 'C', '使用过多的括号以至难读', 'D', '用缩写变量名代替解释'), 
    2, 
    JSON_ARRAY('中间变量能提升可读性。', '注释帮助他人理解。', '避免一行包含太多逻辑。'), 
    '使用中间变量并加注释可以清晰表达逻辑意图，便于维护。', 
    'is_adult = age >= 18; if is_adult and has_ticket: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    432, 
    29, 
    '表达式简化', 
    '下面哪个是等价且更简洁的写法？ a and True', 
    JSON_OBJECT('A', 'a', 'B', 'True', 'C', 'a and False', 'D', 'not a'), 
    1, 
    JSON_ARRAY('与 True 做 and 不改变值（短路返回操作数）。', '可以直接用 a 代替。', '注意 a 的类型可能不是布尔型。'), 
    'a and True 等价于 a（在布尔语境中），因此可简化为 a。', 
    'x and True → x；x or False → x'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    433, 
    29, 
    '优先级总结', 
    '下列运算符优先级从高到低哪项正确？', 
    JSON_OBJECT('A', 'or > and > not', 'B', 'not > and > or', 'C', 'and > not > or', 'D', '优先级相同'), 
    2, 
    JSON_ARRAY('not 是一元运算符，优先级高。', 'and 高于 or。', '记住 not > and > or。'), 
    '运算符优先级为 not 最高，然后 and，最后 or。', 
    'not a and b 等价于 (not a) and b'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    434,
    29,
    '布尔代数转换',
    '将下面表达式化简为等价形式： not (x or y)',
    NULL,
    JSON_ARRAY('not x and not y'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "not (x or y) == "}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('not x and not y', 'not x or not y', 'x and y', 'x or y'),
    JSON_ARRAY(1),
    '根据 De Morgan 定律，not (x or y) 等价于 not x and not y。',
    'not (a and b) 等价于 not a or not b'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    435,
    29,
    '实战填空：复杂权限判断',
    '补全下列判断（满足任何一种条件即可）：年龄 >=18 且有票，或持 VIP。',
    'age=17; has_ticket=False; is_vip=True',
    JSON_ARRAY('允许'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "age=17"}, {"type": "code_line", "value": "has_ticket=False"}, {"type": "code_line", "value": "is_vip=True"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if (age >= 18 and has_ticket) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " is_vip:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"允许\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\"拒绝\")"}]}]}',
    JSON_ARRAY('and', 'or', 'not', '=='),
    JSON_ARRAY(2),
    '年龄与票需要同时满足，或只要是 VIP 即可；所以用 or 连接两大条件块。',
    'if (age>=18 and has_ticket) or is_vip: ...'
);