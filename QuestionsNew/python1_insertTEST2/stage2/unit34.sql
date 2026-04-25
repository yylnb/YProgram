USE `questions`;
-- Unit 34 | Start ID: 496
-- Generated at 2025-12-25 11:18:46

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    496,
    34,
    '多个 elif 的用处',
    '为何会使用多个 elif？',
    JSON_OBJECT('A', '处理多个互斥情况', 'B', '提高程序运行速度', 'C', '替代循环', 'D', '定义常量'),
    1,
    JSON_ARRAY('用于互斥分支', '便于分段处理', '比一堆 if 更语义化'),
    '多个 elif 常用于处理多个互斥条件的判断。',
    'if ...
elif ...
elif ...
else: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    497,
    34,
    '顺序覆盖问题',
    '哪个会导致后续分支无法触发？',
    JSON_OBJECT('A', '把更宽泛条件放在前面', 'B', '把更具体条件放在前面', 'C', '条件互不相交', 'D', '增加 else'),
    1,
    JSON_ARRAY('宽泛条件可能先匹配', '后面的条件被挡住', '按优先级安排条件'),
    '应把更具体的条件放在前面以免被更宽泛的条件捕获。',
    'if x>0 ... elif x>5 ... 这会出问题'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    498,
    34,
    'elif 与互斥性',
    '使用 elif 能保证什么？',
    JSON_OBJECT('A', '所有分支都执行', 'B', '只执行第一个匹配分支', 'C', '随机执行一个分支', 'D', '不执行任何分支'),
    2,
    JSON_ARRAY('互斥逻辑', '按顺序匹配', '第一个为真则终止链'),
    'elif 链保证只执行第一个满足条件的分支。',
    'if a: ...
elif b: ...
else: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    499,
    34,
    '按区间分配',
    '补全分支输出 Low/Med/High。',
    'x=50',
    JSON_ARRAY('Med'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x=50"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if x < 30:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Low\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "elif x < 70:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"High\\")"}]}]}',
    JSON_ARRAY('Low', 'Med', 'High', 'OK'),
    JSON_ARRAY(2),
    '50 在 30–69 区间，输出 Med。',
    '区间判断常用 elif 实现。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    500,
    34,
    '覆盖测试',
    '将更具体条件放前以修复逻辑。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x=8"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if x>0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\">0\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "elif x>5:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\">5\\")"}]}]}',
    JSON_ARRAY('将 x>5 放前', '删除第二行', '改为 while', '改为函数'),
    JSON_ARRAY(1),
    '将更具体的 x>5 放在前面，才能正确匹配。',
    'if x>5:
    ...
elif x>0:
    ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    501,
    34,
    '多个 elif 的性能',
    '大量 elif 会导致？',
    JSON_OBJECT('A', '必然变慢很多', 'B', '在最坏情况遍历多次条件', 'C', '引发语法错误', 'D', '内存泄露'),
    2,
    JSON_ARRAY('顺序影响执行次数', '最好把常见情况放前', '可用映射表替代大量分支'),
    '大量 elif 在最坏情况下会评估多次条件，应优化顺序或使用数据结构替代。',
    '使用 dict mapping 处理众多平行分支。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    502,
    34,
    '调试 elif 链',
    '调试复杂 elif 链时最好做什么？',
    JSON_OBJECT('A', '添加日志打印每个条件', 'B', '随机修改顺序', 'C', '删除所有 elif', 'D', '增加全局变量'),
    1,
    JSON_ARRAY('日志能帮助定位匹配分支', '逐步验证条件', '不要盲改顺序'),
    '在每个分支处打印或记录可以帮助调试分支匹配问题。',
    'print("checking x>5") before condition'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    503,
    34,
    'elif 的替代方案',
    '哪种情况建议使用字典映射而非大量 elif？',
    JSON_OBJECT('A', '基于数值区间', 'B', '基于离散键映射相应函数', 'C', '需要复杂布尔表达式', 'D', '需要嵌套循环'),
    2,
    JSON_ARRAY('离散键适合映射', '函数映射可提高可读性', '区间判断仍用 elif'),
    '当条件基于离散值时，使用 dict 映射到处理函数更清晰且容易扩展。',
    'actions = {1: f1, 2: f2}; actions.get(cmd, default)()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    504,
    34,
    '分支重构',
    '将以下代码重构为更优顺序。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x=100"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if x>0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"pos\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "elif x>50:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\">50\\")"}]}]}',
    JSON_ARRAY('先判断 x>50 再判断 x>0', '保持不变', '删除第一条', '改为 while'),
    JSON_ARRAY(1),
    '应先判断 100 是否 >50，然后再判断 >0，避免被更宽泛条件挡住。',
    'if x>50:
    ...
elif x>0:
    ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    505,
    34,
    '实践：等级判断',
    '补全：>=90 A, >=80 B, >=70 C, else D。',
    'score=77',
    JSON_ARRAY('C'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "score=77"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if score >= 90:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"A\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "elif score >= 80:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"B\\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "elif score >= 70:\\n    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"D\\")"}]}]}',
    JSON_ARRAY('A', 'B', 'C', 'D'),
    JSON_ARRAY(3),
    '77 属于 70–79，应输出 C。',
    'elif 常用于评分分档。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    506,
    34,
    '顺序不当的后果',
    '若把最常见条件放到最后会怎样？',
    JSON_OBJECT('A', '可提高效率', 'B', '可能每次都要遍历所有条件', 'C', '无影响', 'D', '语法错误'),
    2,
    JSON_ARRAY('顺序决定匹配次数', '常见情况应优先处理', '性能受影响'),
    '将最常见情况放后会导致在多数情况下遍历更多分支，影响性能。',
    '把常见情况放在前面减少判断次数'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    507,
    34,
    '边界条件处理',
    '处理数值分段时应注意什么？',
    JSON_OBJECT('A', '边界是否包含左闭右开', 'B', '顺序可以随意', 'C', '忽略等号', 'D', '用字符串比较'),
    1,
    JSON_ARRAY('注意 >= 与 > 的使用', '边界重复会造成歧义', '写清楚包含端点'),
    '应明确区间端点（包含或不包含）以避免覆盖或漏判。',
    'if x>=70 and x<80: ... 或使用 elif x>=70:...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    508,
    34,
    '测试大量分支',
    '如何对大量 elif 分支进行自动化测试？',
    JSON_OBJECT('A', '手工测试每个分支', 'B', '编写单元测试覆盖每个条件', 'C', '不需要测试', 'D', '只测试边界'),
    2,
    JSON_ARRAY('单元测试可覆盖所有条件', '自动化测试减少人为遗漏', '确保边界也被测试'),
    '为每个分支写单元测试能保证分支逻辑正确并在修改后保持稳定。',
    'pytest 编写多个用例覆盖所有分支'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    509,
    34,
    '实际演练：奖金分配',
    '补全分支：>1000 大奖, >500 较大, else 普通。',
    'amount=600',
    JSON_ARRAY('较大'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "amount=600"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if amount > 1000:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"大奖\\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "elif amount > 500:\\n    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"普通\\")"}]}]}',
    JSON_ARRAY('大奖', '较大', '普通', '无'),
    JSON_ARRAY(2),
    '600 在 500–1000，应输出 较大。',
    'elif 常用于金额分级。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    510,
    34,
    '练习：星期映射',
    '使用 elif 根据数字输出工作日/周末',
    'd=6',
    JSON_ARRAY('Weekend'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "d=6"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if d in [1,2,3,4,5]:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Workday\\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "elif d in [6,7]:\\n    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Invalid\\")"}]}]}',
    JSON_ARRAY('Weekend', 'Workday', 'Invalid', 'Holiday'),
    JSON_ARRAY(1),
    '6,7 为周末。',
    'elif 可用于集合匹配。'
);