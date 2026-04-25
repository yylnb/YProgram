USE `questions`;
-- Unit 45 | Start ID: 661
-- Generated at 2025-12-24 23:12:45

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    661, 
    45, 
    'any 与 all 的用途', 
    '下列说法正确的是？', 
    JSON_OBJECT('A', 'any 用于检测是否至少有一真，all 用于全为真', 'B', 'any 检测全为真，all 检测至少一真', 'C', '两者功能相同', 'D', '两者返回原始值'), 
    1, 
    JSON_ARRAY('any/all 是内置聚合函数', '常用于组合多个条件', '返回布尔值'), 
    'any 在可迭代中只要有真值就返回 True，all 只有全部为真才返回 True。', 
    'if any([a>b, c>d]): ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    662, 
    45, 
    '重复计算的优化', 
    '当一个表达式在多处被重复计算时最好怎么做？', 
    JSON_OBJECT('A', '将表达式赋值给临时变量', 'B', '每次重复计算以确保最新', 'C', '复制表达式到注释', 'D', '用全局变量存储'), 
    1, 
    JSON_ARRAY('避免昂贵的重复计算', '临时变量提高可读性和性能', '注意变量命名'), 
    '把重复计算的结果存到变量既提高性能也便于阅读。', 
    'val = expensive(); if val>0 and val<10:'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    663, 
    45, 
    '使用集合或元组简化多个 or', 
    '判断变量是否为某些值时，下列更简洁的写法是？', 
    JSON_OBJECT('A', 'if x in (1,2,3):', 'B', 'if x==1 or x==2 or x==3:', 'C', 'if x in "123":', 'D', 'if x in [1,2] and x==3:'), 
    1, 
    JSON_ARRAY('in 能简洁表达多重比较', '使用元组或集合表示候选值', '避免长链 or'), 
    '使用 in 配合元组或集合更简洁、语义明确。', 
    'if status in ("ok","pass"): ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    664,
    45,
    '用 any 简化判断',
    '补全：检测列表中是否存在正数。',
    'lst=[-1,0,3]',
    JSON_ARRAY('Has positive'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if any(x > 0 for x in "}, {"type": "slot", "index": 0}, {"type": "code", "value": "):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"Has positive\")"}]}]}',
    JSON_ARRAY('lst', 'set', 'list', 'tuple'),
    JSON_ARRAY(1),
    'any 可配合生成器表达式检测任一元素满足条件。',
    'any(c.isdigit() for c in s)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    665,
    45,
    '把复杂条件抽变量',
    '补全：将复杂判断提取为布尔变量后使用。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "valid = x > 0 and y > 0"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"OK\")"}]}]}',
    JSON_ARRAY('valid', 'x', 'y', 'x and y'),
    JSON_ARRAY(1),
    '提前计算复杂布尔表达式可提高可读性并避免重复计算。',
    'is_ready = cond1 and cond2
if is_ready: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    666, 
    45, 
    '短路与性能', 
    '使用短路逻辑能否用于性能优化？', 
    JSON_OBJECT('A', '可以，若右侧计算代价高且左侧常为假', 'B', '不可以，短路无性能意义', 'C', '通常会降低性能', 'D', '只在循环中有意义'), 
    1, 
    JSON_ARRAY('短路避免不必要的计算', '适用于昂贵函数在右侧的场景', '注意可读性影响'), 
    '短路可避免昂贵操作被求值，从而提升性能，但需保证语义一致。', 
    'if cond and expensive(): ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    667, 
    45, 
    '使用元组作为字面量', 
    '在 in 判断中用 (a,b) 与 {a,b} 有何差别？', 
    JSON_OBJECT('A', '元组有序不可变，集合无序且去重', 'B', '元组更快速查找', 'C', '集合必须转为列表才能用 in', 'D', '语义等价'), 
    1, 
    JSON_ARRAY('集合用于大量元素成员测试更快', '元组适合小量候选常量', '两者语义不同'), 
    '元组是不可变序列，集合是无序且支持哈希查找，视场景选择。', 
    'if x in {1,2,3}: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    668, 
    45, 
    '避免重复表达式', 
    '下列重构能减少重复计算？', 
    JSON_OBJECT('A', '把重复子表达式赋值给变量', 'B', '把表达式重复写两次', 'C', '用注释替代计算', 'D', '在每处都调用函数'), 
    1, 
    JSON_ARRAY('提取公共子表达式', '减少错误且利于测试', '变量名要清晰'), 
    '为重复计算提取变量可提升性能并使代码更易读。', 
    'val = complex(); if val>0 and val<10:'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    669,
    45,
    '使用 all 简化多条件',
    '补全：同时满足多个条件时使用 all。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "conds = [a > 0, b > 0, c > 0]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if all(conds):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"All positive\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    '把条件放入列表并用 all 可以简洁地表达多个条件同时成立。',
    'if all(x>0 for x in arr): ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    670,
    45,
    '避免重复索引',
    '补全：避免多次计算相同索引。',
    'lst=[1,2,3]; i=1',
    JSON_ARRAY('OK'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "val = lst[i]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if val > 0 and val < 10:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"OK\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    '先把 lst[i] 存到变量再复用可避免重复索引和潜在副作用。',
    'x = data[idx]
if x: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    671, 
    45, 
    '条件分支过长的处理', 
    '若单个条件表达式过于复杂，最佳做法？', 
    JSON_OBJECT('A', '拆成多个具名布尔变量或函数', 'B', '保持原样以节省函数', 'C', '用注释替代重构', 'D', '合并成单行表达式'), 
    1, 
    JSON_ARRAY('具名变量提高可读性', '把复杂逻辑抽成函数便于测试', '避免过长单行表达式'), 
    '把复杂表达式拆成具名变量或函数能提升可读性与可维护性。', 
    'is_valid = check(x)
if is_valid and other: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    672, 
    45, 
    '用早返回简化复杂判断', 
    '早返回如何帮助简化多条件分支？', 
    JSON_OBJECT('A', '先处理异常或边界，减少后续条件', 'B', '增加函数长度', 'C', '使逻辑更难阅读', 'D', '无影响'), 
    1, 
    JSON_ARRAY('早返回减少嵌套', '把异常提前处理掉', '使主体更清晰'), 
    '先处理异常和边界可让主逻辑更平坦并减少复杂判断。', 
    'if not ok: return
# main flow'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    673, 
    45, 
    '可读性优先的重构', 
    '在优化条件表达式时应优先考虑哪项？', 
    JSON_OBJECT('A', '可读性而非过早优化', 'B', '始终以性能为先', 'C', '尽量缩短代码字符数', 'D', '避免任何重构'), 
    1, 
    JSON_ARRAY('可读性有助于长期维护', '性能优化需有证据', '写注释解释重构'), 
    '可读性更有价值，优化应基于实际性能瓶颈。', 
    '清晰变量名优先于神奇技巧'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    674,
    45,
    '实践：任何满足一个条件',
    '补全：若任一条件满足则通过。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if any([cond1, cond2, cond3]):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"Pass\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    'any 可直接接受列表或生成器表达式。',
    'if any(x>0 for x in arr): ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    675,
    45,
    '练习：提取子表达式',
    '补全：提取复杂子表达式后判断。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "valid_range = 0 < x < 100"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if valid_range and flag:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"OK\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    '提前计算子表达式使主判断更清晰。',
    'is_even = n%2==0
if is_even and n>0: ...'
);