USE `questions`;
-- Unit 36 | Start ID: 526
-- Generated at 2025-12-24 23:10:06

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    526, 
    36, 
    '多层嵌套的风险', 
    '多层嵌套常带来的问题是什么？', 
    JSON_OBJECT('A', '更易维护', 'B', '更难阅读与测试', 'C', '更安全', 'D', '自动并行'), 
    2, 
    JSON_ARRAY('嵌套增加逻辑路径', '建议拆分为函数', '可读性下降'), 
    '深嵌套会增加理解难度与测试复杂度，建议重构。', 
    '把复杂逻辑拆为多个函数并命名清晰'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    527, 
    36, 
    '早期返回技巧', 
    '在函数中减少嵌套的一种常见技巧是？', 
    JSON_OBJECT('A', '使用早期返回 (early return)', 'B', '增加更多嵌套', 'C', '使用全局变量', 'D', '删除判断'), 
    1, 
    JSON_ARRAY('early return 可以减少缩进', '提高可读性', '常见于输入校验'), 
    '通过在不满足条件时立即返回，可以减少嵌套层数，代码更平坦。', 
    'if not valid: return
# 之后不需再缩进'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    528, 
    36, 
    '复杂逻辑重构', 
    '以下哪项常用于重构嵌套逻辑？', 
    JSON_OBJECT('A', '提炼函数', 'B', '增加嵌套层', 'C', '使用魔法数字', 'D', '删除注释'), 
    1, 
    JSON_ARRAY('提炼函数抽离职责', '便于测试', '提高可读性'), 
    '提炼函数可以把复杂嵌套拆成多个小函数，更易于理解与测试。', 
    'def is_valid(x):
    return x>0 and x<10
if is_valid(a): ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    529,
    36,
    '错误处理的嵌套',
    '补全使得当输入为负数时提示错误。',
    'n=-1',
    JSON_ARRAY('Invalid'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "n = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if n >= 0:"}, {"type": "code_line", "value": "    if n == 0:"}, {"type": "code_line", "value": "        print(\"Zero\")"}, {"type": "code_line", "value": "    else:"}, {"type": "code_line", "value": "        print(\"Positive\")"}, {"type": "code_line", "value": "else:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('"Invalid"', '"Zero"', '"Positive"', '"None"'),
    JSON_ARRAY(1),
    '外层 else 用于处理负数并输出 Invalid。',
    '嵌套常用于进一步细分分支内部逻辑。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    530,
    36,
    '复合判断替代',
    '将嵌套 if 改写为逻辑表达式（示例）。',
    'a=True; b=True',
    JSON_ARRAY('OK'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = True"}, {"type": "code_line", "value": "b = True"}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"OK\")"}]}]}]}',
    JSON_ARRAY('a and b', 'a:
    if b', 'not a', 'a or b'),
    JSON_ARRAY(1),
    'a and b 可以替代 if a:
    if b: ... 并更简洁。',
    'if a and b: do()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    531, 
    36, 
    '如何降低复杂度', 
    '哪个做法可以降低嵌套复杂度？', 
    JSON_OBJECT('A', '拆分函数', 'B', '增加全局变量', 'C', '在每层嵌套都打印', 'D', '减少注释'), 
    1, 
    JSON_ARRAY('封装可以降低嵌套层', '函数命名提高语义', '方便单元测试'), 
    '拆分为小函数可减少嵌套并提高可维护性。', 
    'def check_user(u): ... if check_user(u): ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    532, 
    36, 
    '逻辑短路 vs 嵌套', 
    '下列哪种情形更适合使用逻辑短路？', 
    JSON_OBJECT('A', '需要按步骤处理副作用', 'B', '简单的布尔连接无需额外动作', 'C', '需要多层复杂判断', 'D', '需要创建新作用域'), 
    2, 
    JSON_ARRAY('逻辑短路适合连接布尔值', '嵌套可处理副作用和其他动作', '短路不创建新块'), 
    '当仅需判断布尔值组合时，逻辑短路写法更简洁。', 
    'if user and user.active: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    533, 
    36, 
    '避免重复计算', 
    '嵌套中若重复计算表达式应如何处理？', 
    JSON_OBJECT('A', '缓存结果到变量', 'B', '重复计算以确保新鲜', 'C', '放弃优化', 'D', '用全局存储'), 
    1, 
    JSON_ARRAY('将结果赋给变量可避免重复计算', '有利可读性与性能', '尤其当计算耗时时更重要'), 
    '把计算结果保存到变量并复用可以减少重复计算并提高可读性。', 
    'valid = expensive_check(); if valid: if other: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    534,
    36,
    '早期返回示例',
    '用早期返回重写以减少嵌套。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def process(x):"}, {"type": "code_line", "value": "    if not x:"}, {"type": "code_line", "value": "        return"}, {"type": "code_line", "value": "    if x > 0:"}, {"type": "code_line", "value": "        print(\"OK\")"}]}]}',
    JSON_ARRAY('示例已给出', '需要改动', '抛异常', '删除函数'),
    JSON_ARRAY(1),
    '示例展示早期返回无需额外缩进，降低嵌套。',
    'if not valid: return
# 之后逻辑不缩进'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    535,
    36,
    '嵌套替换练习',
    '把嵌套 if 替换为逻辑连接。',
    'a=True;b=True',
    JSON_ARRAY('OK'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a=True"}, {"type": "code_line", "value": "b=True"}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"OK\")"}]}]}]}',
    JSON_ARRAY('a and b', 'if a:
    if b', 'not a', 'a or b'),
    JSON_ARRAY(1),
    '逻辑连接更简洁且等价于嵌套。',
    'if x>0 and y>0: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    536, 
    36, 
    '可读性优先', 
    '当简洁写法难以理解时应如何处理？', 
    JSON_OBJECT('A', '保留复杂简洁写法', 'B', '改为更可读的多行写法', 'C', '删掉注释', 'D', '压缩为一行'), 
    2, 
    JSON_ARRAY('可读性优先于过度简洁', '团队协作时尤其重要', '注释可补充意图'), 
    '当简洁写法导致可读性下降时，应选择更直观的实现。', 
    '把长条件分拆并用变量命名'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    537, 
    36, 
    '高耦合风险', 
    '嵌套逻辑若耦合过高会导致什么？', 
    JSON_OBJECT('A', '更易复用', 'B', '难以修改某一行为', 'C', '自动生成文档', 'D', '提高性能'), 
    2, 
    JSON_ARRAY('耦合导致修改一处影响多处', '建议解耦和模块化', '小函数可降低耦合度'), 
    '耦合高使得修改或测试单一逻辑变得困难，应解耦以便维护。', 
    '把权限检查拆到独立函数中'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    538, 
    36, 
    '嵌套的替代设计', 
    '以下哪种设计能替代复杂嵌套？', 
    JSON_OBJECT('A', '状态机/表驱动', 'B', '增加嵌套层数', 'C', '使用全局变量', 'D', '删除条件'), 
    1, 
    JSON_ARRAY('状态机/表驱动可将复杂条件转为数据', '提高扩展性', '适合复杂流程'), 
    '状态机或表驱动可把条件逻辑转为可配置的数据结构，减少嵌套并提高可维护性。', 
    'state_handlers = {"START": start_handler, ... }'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    539,
    36,
    '实践：权限与日志',
    '补全：登录并且有权限才记录操作。',
    'logged=True; has_perm=True',
    JSON_ARRAY('Recorded'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "logged=True"}, {"type": "code_line", "value": "has_perm=True"}, {"type": "code_line", "value": "if logged:"}, {"type": "code_line", "value": "    if has_perm:"}, {"type": "code_line", "value": "        print(\"Recorded\")"}]}]}',
    JSON_ARRAY('示例已给出', '改为 else', '删除 if', '异常处理'),
    JSON_ARRAY(1),
    '仅在两层条件都满足时才记录。',
    '权限检查常见于审计场景。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    540,
    36,
    '练习：复合校验',
    '补全：只有当所有检查都通过才允许提交。',
    'check1=True; check2=True',
    JSON_ARRAY('Submit'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "check1=True"}, {"type": "code_line", "value": "check2=True"}, {"type": "code_line", "value": "if check1:"}, {"type": "code_line", "value": "    if check2:"}, {"type": "code_inline", "parts": [{"type": "code", "value": "        print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}]}',
    JSON_ARRAY('"Submit"', '"Fail"', '"OK"', '"None"'),
    JSON_ARRAY(1),
    '当两个检查均为 True 时应提交。',
    '多项校验通过后才执行关键操作。'
);