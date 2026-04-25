USE `questions`;
-- Unit 58 | Start ID: 856
-- Generated at 2025-12-24 23:16:51

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    856, 
    58, 
    '逻辑组合优先级', 
    '在 Python 中，哪个运算符优先级更高？', 
    JSON_OBJECT('A', 'and 比 or 优先', 'B', 'or 比 and 优先', 'C', '两者相同', 'D', '优先级不可比较'), 
    1, 
    JSON_ARRAY('and 绑定更紧密', '查看运算符优先级表'), 
    'and 的优先级高于 or，因此 a or b and c 相当于 a or (b and c)。', 
    'True or False and False == True'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    857, 
    58, 
    '使用括号', 
    '有复杂逻辑表达式时应采取什么操作以减少歧义？', 
    JSON_OBJECT('A', '用括号明确优先级', 'B', '不加括号让解释器决定', 'C', '用注释代替括号', 'D', '拆成多行注释'), 
    1, 
    JSON_ARRAY('括号能显式表达意图', '提高可读性'), 
    '在复杂逻辑中使用括号能明确优先级并避免误解。', 
    'if (a or b) and c: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    858, 
    58, 
    '短路求值', 
    '逻辑运算符短路求值的含义是？', 
    JSON_OBJECT('A', '表达式可能不会评估所有子表达式', 'B', '总会评估所有子表达式', 'C', '抛出异常停止', 'D', '转换为数字求和'), 
    1, 
    JSON_ARRAY('and/or 会在确定结果时停止评估'), 
    '短路求值意味着在 and/or 中如果已能确定结果则不会再求值后续表达式。', 
    'False and risky_call() 不会调用 risky_call'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    859,
    58,
    '组合布尔表达式',
    '补全：判断 a 或 (b 且 c) 的表达式。',
    NULL,
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if a or (b and c):"}, {"type": "code_line", "value": "    print(\"yes\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '加括号能明确优先级使逻辑表达更直观。',
    'if x and (y or z): ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    860,
    58,
    '避免副作用的顺序',
    '补全：把带有副作用的表达式放在短路后面。',
    NULL,
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if condition and do_side_effect():"}, {"type": "code_line", "value": "    pass"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '短路求值可以避免不必要的副作用调用。',
    'if a and expensive(): ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    861, 
    58, 
    '组合表达式可读性', 
    '当逻辑表达式过长时，最佳实践是？', 
    JSON_OBJECT('A', '拆成多个中间变量并加注释', 'B', '用一行写完所有表达式', 'C', '不解释直接返回', 'D', '用魔法数字替代'), 
    1, 
    JSON_ARRAY('中间变量有助于描述含义', '更易调试'), 
    '通过中间变量分解复杂逻辑能提高可读性与可维护性。', 
    'is_valid = a and (b or c)
if is_valid: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    862, 
    58, 
    '布尔表达式简写', 
    '下面哪种写法常用于简写条件赋值？', 
    JSON_OBJECT('A', 'x = a or b', 'B', 'x = a and b or c', 'C', 'x = if a else b', 'D', 'x = a ? b : c'), 
    1, 
    JSON_ARRAY('利用 or 的短路返回值特性'), 
    'x = a or b 会把 a 视为真值则返回 a，否则返回 b，是 Python 常见简写。', 
    'name = input() or "guest"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    863, 
    58, 
    '避免布尔陷阱', 
    '判断对象是否为空时应使用？', 
    JSON_OBJECT('A', 'if not seq:', 'B', 'if seq == None:', 'C', 'if seq is False:', 'D', 'if len(seq) > 0:'), 
    1, 
    JSON_ARRAY('直接判断空容器更简洁且普适'), 
    '使用 if not seq 能正确处理 None/空列表等情况。', 
    'if not items: print("no items")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    864,
    58,
    '组合判断示例',
    '补全：判断 0<a<=b 且 c 为真。',
    NULL,
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if 0 < a <= b and c:"}, {"type": "code_line", "value": "    print(\"ok\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '链式比较与 and 组合能清晰表达多重条件。',
    'if 1<=x<=10 and y>0: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    865,
    58,
    '用括号提高可读性',
    '补全：为复杂表达式增加括号。',
    NULL,
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if (a and b) or (c and d):"}, {"type": "code_line", "value": "    print(\"group\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '括号能让读者迅速理解表达式的逻辑分组。',
    'if (x>0 and y>0) or z: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    866, 
    58, 
    '短路副作用风险', 
    '在 and/or 表达式中有副作用的函数应放在哪一侧更安全？', 
    JSON_OBJECT('A', '放在右侧以利用短路避免无谓调用', 'B', '放在左侧', 'C', '放在中间', 'D', '无所谓'), 
    1, 
    JSON_ARRAY('短路可避免调用右侧的副作用函数'), 
    '把副作用函数放在右侧可在不满足左侧条件时避免其被调用。', 
    'if cond and do(): ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    867, 
    58, 
    '复合条件调试', 
    '要调试复杂布尔表达式应如何分步骤检查？', 
    JSON_OBJECT('A', '把子表达式拆成变量并打印', 'B', '直接打印整个表达式', 'C', '用正则匹配', 'D', '用随机数测试'), 
    1, 
    JSON_ARRAY('分解更易定位错误', '添加描述性变量名'), 
    '把复杂表达式分解并命名有助于理解每部分的真值。', 
    'left = a and b
right = c and d
if left or right: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    868, 
    58, 
    '逻辑表达式与可读性权衡', 
    '当简洁写法牺牲可读性时应如何选择？', 
    JSON_OBJECT('A', '优先可读性，适当展开表达式', 'B', '总是追求最短写法', 'C', '隐藏在注释中', 'D', '不写注释只保留短写'), 
    1, 
    JSON_ARRAY('可读性优于极致简洁', '团队合作尤为重要'), 
    '在团队代码中清晰易懂比极端简洁更重要。', 
    '拆成多个变量并注释'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    869,
    58,
    '分解复杂逻辑示例',
    '补全：把复杂判断分解成中间变量。',
    NULL,
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "cond1 = a and b"}, {"type": "code_line", "value": "cond2 = c and d"}, {"type": "code_line", "value": "if cond1 or cond2:"}, {"type": "code_line", "value": "    print(\"ok\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '先命名子表达式便于理解与调试。',
    'is_valid = check1() and check2()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    870,
    58,
    '显式比较',
    '补全：避免用 is 比较数值，应用 ==。',
    NULL,
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if a == 1:"}, {"type": "code_line", "value": "    print(\"one\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'is 比较对象标识，数值应用 == 以比较值相等性。',
    'if x==0: ...'
);