USE `questions`;
-- Unit 51 | Start ID: 751
-- Generated at 2025-12-24 23:14:38

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    751, 
    51, 
    '分类器的基本思路', 
    '实现简单规则分类器时通常先做什么？', 
    JSON_OBJECT('A', '定义判定规则并按优先级判断', 'B', '随机分类', 'C', '用正则表达式匹配所有场景', 'D', '直接用数据库'), 
    1, 
    JSON_ARRAY('规则化思考', '按优先级应用规则', '从简单到复杂逐步增加规则'), 
    '先定义简单规则并按优先级判断有助于实现清晰且可维护的分类器。', 
    'if cond1: return "A"
elif cond2: return "B"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    752, 
    51, 
    '优先级处理', 
    '在多规则分类器中，优先级高的规则应如何放置？', 
    JSON_OBJECT('A', '放在前面先判断', 'B', '放在最后', 'C', '随机顺序', 'D', '按字母顺序'), 
    1, 
    JSON_ARRAY('先匹配高优先级规则', '避免被低优先级早捕获'), 
    '应把优先级高的规则放在前面，确保先被判断并返回结果。', 
    'if is_admin: ...
elif is_user: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    753, 
    51, 
    '测试分类器', 
    '编写测试用例时应包含哪类样例？', 
    JSON_OBJECT('A', '典型样例、边界样例和异常样例', 'B', '仅典型样例', 'C', '仅边界样例', 'D', '仅异常样例'), 
    1, 
    JSON_ARRAY('全面覆盖有助捕捉错误', '边界与异常易出问题'), 
    '测试应覆盖典型、边界及异常情形以确保分类器健壮。', 
    'assert classify(x)=="A"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    754,
    51,
    '实现简单规则',
    '补全：若 age>=18 返回 adult，否则 child。',
    'age=20',
    JSON_ARRAY('adult'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "age = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if age >= 18:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"adult\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"child\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '根据年龄边界判断并返回类别。',
    'if score>=60: print("pass") else: print("fail")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    755,
    51,
    '优先级覆盖练习',
    '补全：注意先判断特殊情况再判断一般情况。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if user.is_admin():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"admin\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "elif user.is_active():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"user\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '先判断特殊或更严格的条件可以避免被宽松条件提前捕获。',
    '先判断异常或缺失值再处理一般逻辑'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    756, 
    51, 
    '默认分类', 
    '分类器若无法匹配任何规则，通常做法是？', 
    JSON_OBJECT('A', '返回默认类别或 unknown', 'B', '抛出错误退出', 'C', '返回随机类别', 'D', '无限循环'), 
    1, 
    JSON_ARRAY('提供安全默认', '便于后续处理和日志记录'), 
    '返回默认类别（如 "unknown"）可以保证函数总有返回值且便于记录。', 
    'return "unknown"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    757, 
    51, 
    '可解释性提示', 
    '实现规则化分类器时，记录哪些信息有助于排查？', 
    JSON_OBJECT('A', '匹配到的规则与输入摘要', 'B', '完全输出所有内部变量', 'C', '不记录任何信息', 'D', '只记录错误'), 
    1, 
    JSON_ARRAY('记录关键信息便于复现', '避免泄露敏感信息'), 
    '记录匹配到的规则和输入摘要便于理解分类器输出的原因。', 
    'log("matched rule: x")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    758, 
    51, 
    '逐步扩展', 
    '当规则过多时如何组织代码更好？', 
    JSON_OBJECT('A', '把规则拆到独立函数或表中', 'B', '把所有规则写在一个长 if 链中', 'C', '用注释隔开', 'D', '用 print 追踪'), 
    1, 
    JSON_ARRAY('拆模块便于维护', '规则表或字典能清晰表达优先级'), 
    '将规则拆成函数或表格便于阅读、测试与维护。', 
    'rules = [rule1, rule2]
for r in rules: if r.match(x): ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    759,
    51,
    '实践：简单分类器函数',
    '补全：实现 classify 返回 "even" 或 "odd"。',
    'n=3',
    JSON_ARRAY('odd'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "n = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if n % 2 == 0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"even\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"odd\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用 % 判断奇偶并返回相应类别。',
    'if x%2: print("odd")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    760,
    51,
    '异常输入的默认处理',
    '补全：当输入无法解析时返回 unknown。',
    's="abc"',
    JSON_ARRAY('unknown'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "try:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    v = int(s)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "except ValueError:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"unknown\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '通过异常处理返回默认类别可以保证稳定性。',
    'except: return "unknown"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    761, 
    51, 
    '日志记录的粒度', 
    '记录分类器日志时应避免？', 
    JSON_OBJECT('A', '记录敏感用户原始数据', 'B', '记录规则编号', 'C', '记录输入摘要', 'D', '记录输出类别'), 
    1, 
    JSON_ARRAY('注意隐私保护', '记录摘要而非原文以规避泄露'), 
    '避免记录敏感的原始数据，选择记录摘要和规则编号以便排查同时保护隐私。', 
    'log("user: ***, matched: rule1")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    762, 
    51, 
    '回退策略', 
    '当规则冲突导致不确定时，常见做法是？', 
    JSON_OBJECT('A', '使用优先级或默认值', 'B', '抛出异常停止服务', 'C', '随机选择一个类别', 'D', '返回 None'), 
    1, 
    JSON_ARRAY('优先级和默认策略很重要', '应明确冲突解决规则'), 
    '通过优先级或默认值来处理冲突，保证系统可预期运行。', 
    '优先 admin 再 user'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    763, 
    51, 
    '可扩展性', 
    '设计分类器规则表时应如何以便扩展？', 
    JSON_OBJECT('A', '用结构化数据表示规则并加载', 'B', '硬编码在源文件中', 'C', '写在注释中', 'D', '在运行时用交互输入'), 
    1, 
    JSON_ARRAY('规则表易于维护与更新', '可以从配置文件加载'), 
    '将规则以结构化形式存储（如 JSON）便于扩展和动态调整。', 
    'rules = load_rules("rules.json")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    764,
    51,
    '实践：用字典映射类别',
    '补全：根据 key 返回类别或 default。',
    'k="a"',
    JSON_ARRAY('A'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "m = {\"a\":\"A\",\"b\":\"B\"}"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(m.get(k, \"unknown\"))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 dict.get 可以提供默认返回值。',
    'm.get(k, "-")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    765,
    51,
    '综合练习：简单文本分类',
    '补全：基于关键词判断文本是否为问候语。',
    's="hello there"',
    JSON_ARRAY('greeting'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input().lower()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if \"hello\" in s or \"hi\" in s:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"greeting\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"other\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '根据关键词判断是一种简单的文本分类方法。',
    'if any(k in s for k in ["hello","hi"]): ...'
);