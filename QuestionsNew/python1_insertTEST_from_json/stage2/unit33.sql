USE `questions`;
-- Unit 33 | Start ID: 481
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    481,
    33,
    'elif 的基本用途',
    'elif 用于什么场景？',
    JSON_OBJECT('A', '替代 if', 'B', '在 if 不满足时提供额外条件', 'C', '结束函数', 'D', '定义变量'),
    2,
    JSON_ARRAY('elif 是 else if', '用于链式互斥分支', '多个 elif 可以存在'),
    'elif 在前面的 if/elif 条件都为假时作为后续条件判断。',
    'if x<0: ...\\nelif x==0: ...\\nelse: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    482,
    33,
    '多个 elif 顺序',
    '为什么顺序重要？',
    JSON_OBJECT('A', '顺序不影响结果', 'B', '先匹配的分支会截断后续判断', 'C', 'Python 会并行判断所有分支', 'D', '只能有一个 elif'),
    2,
    JSON_ARRAY('第一个为真的分支会执行', '后面的不会再判断', '谨慎排列条件'),
    '一旦某个分支为真，后续 elif 不会被执行，因此条件顺序会影响结果。',
    'if x>0: ...\\nelif x>5: ...  # 第二个将永远不被触发'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    483,
    33,
    'elif 与 else 的关系',
    '下面哪项是正确搭配？',
    JSON_OBJECT('A', 'if 之后必须有 elif', 'B', 'elif 可以没有 if', 'C', 'elif 要在 if 之后，else 可选', 'D', 'else 必须在最前面'),
    3,
    JSON_ARRAY('elif 必须在 if 之后', 'else 放最后', 'if 可以单独存在'),
    'elif 必须跟在 if 之后，else 可选且位于链的末尾。',
    'if ...\\nelif ...\\nelse: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    484,
    33,
    '补全多分支',
    '用 elif 补全下列评分输出。',
    JSON_ARRAY('score = 85'),
    JSON_ARRAY('B'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "score = 85"}, {"type": "code_line", "value": "if score >= 90:"}, {"type": "code_line", "value": "    print(\\"A\\")"}, {"type": "code_line", "value": "elif score >= 80:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\"C\\")"}]}]}',
    JSON_ARRAY('A', 'B', 'C', 'D'),
    JSON_ARRAY(2),
    '85 属于 80–89，应输出 B。',
    'elif 有助于分段判断。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    485,
    33,
    '避免覆盖',
    '补全顺序以保证正确匹配区间。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 7"}, {"type": "code_line", "value": "if x > 0:"}, {"type": "code_line", "value": "    print(\\">0\\")"}, {"type": "code_line", "value": "elif x > 5:"}, {"type": "code_line", "value": "    print(\\">5\\")"}]}]}',
    JSON_ARRAY('调整顺序', '保持不变', '删除 if', '改为 while'),
    JSON_ARRAY(1),
    '应先判断更具体的条件（x>5），否则 x>0 会先匹配遮盖后续。',
    'if x>5:\\n    ...\\nelif x>0:\\n    ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    486,
    33,
    'elif 可否多个',
    '可以在一个 if 链中使用多个 elif 吗？',
    JSON_OBJECT('A', '不可以', 'B', '可以任意多个', 'C', '最多两个', 'D', '只在函数内可用'),
    2,
    JSON_ARRAY('多个 elif 用于细分条件', '没有数量限制', '顺序仍然重要'),
    '可以使用多个 elif 来实现多个互斥条件的判别。',
    'if ...\\nelif ...\\nelif ...\\nelse: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    487,
    33,
    'elif 与嵌套',
    'elif 是否可以出现在嵌套 if 内？',
    JSON_OBJECT('A', '不能', 'B', '可以', 'C', '只能在函数内', 'D', '只在循环内'),
    2,
    JSON_ARRAY('嵌套结构中也能使用 elif', '注意缩进层级', '逻辑需清晰'),
    'elif 可以在任意 if 语句后使用，包括嵌套的情形。',
    'if a:\\n    if b:\\n        ...\\n    elif c:\\n        ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    488,
    33,
    'elif 的可读性建议',
    '为了可读性，应该如何组织 elif？',
    JSON_OBJECT('A', '尽量合并为一个复杂条件', 'B', '把互斥条件按优先级排序', 'C', '随意顺序', 'D', '全部写成单行'),
    2,
    JSON_ARRAY('优先级高的先判断', '避免重复计算', '保持逻辑清晰'),
    '按优先级排列条件更容易理解并避免错误覆盖。',
    'if x>100: ...\\nelif x>50: ...\\nelse: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    489,
    33,
    '多重分类实例',
    '补全代码：根据分数输出等级。',
    JSON_ARRAY('score = 72'),
    JSON_ARRAY('C'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "score = 72"}, {"type": "code_line", "value": "if score >= 90:"}, {"type": "code_line", "value": "    print(\\"A\\")"}, {"type": "code_line", "value": "elif score >= 80:"}, {"type": "code_line", "value": "    print(\\"B\\")"}, {"type": "code_line", "value": "elif score >= 70:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\"D\\")"}]}]}',
    JSON_ARRAY('A', 'B', 'C', 'D'),
    JSON_ARRAY(3),
    '72 属于 70–79，应输出 C。',
    'elif 可用于分段评分。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    490,
    33,
    '链式逻辑的错误示例',
    '修正顺序错误使条件按预期工作。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 8"}, {"type": "code_line", "value": "if x > 0:"}, {"type": "code_line", "value": "    print(\\">0\\")"}, {"type": "code_line", "value": "elif x > 5:"}, {"type": "code_line", "value": "    print(\\">5\\")"}]}]}',
    JSON_ARRAY('先判断 x>5', '再判断 x>0', '不变', '删除第二条'),
    JSON_ARRAY(0),
    '先判断更具体的条件（x>5）以避免被更宽泛的条件捕获。',
    'if x>5:\\n    ...\\nelif x>0:\\n    ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    491,
    33,
    '使用 elif 的优势',
    '使用 elif 与多个独立 if 相比的优势是什么？',
    JSON_OBJECT('A', '提高执行速度', 'B', '保证互斥性', 'C', '减少代码行数', 'D', '可以避免缩进'),
    2,
    JSON_ARRAY('elif 可以保证一旦有分支成立其余不再判断', '适用于互斥情况', '有助于逻辑清晰'),
    'elif 可以保证互斥分支，只会执行第一个匹配的分支。',
    'if a:\\n    ...\\nelif b:\\n    ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    492,
    33,
    '常见误区',
    '下面哪个是常见的 elif 误用？',
    JSON_OBJECT('A', '使用 elif 组织互斥条件', 'B', '把互斥条件写成多个独立 if', 'C', '按优先级排列条件', 'D', '在 elif 中写复杂表达式'),
    2,
    JSON_ARRAY('独立 if 无法保证互斥', '可能同时满足多个条件', '导致多次执行'),
    '把互斥条件写成多个独立 if 会导致多个分支被触发，不能保证互斥。',
    '使用 elif 代替多个 if 来实现互斥。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    493,
    33,
    'elif 的替代',
    '在某些情况下，elif 可被什么替代以提高可读性？',
    JSON_OBJECT('A', '嵌套 if', 'B', '字典映射函数', 'C', 'while 循环', 'D', 'try/except'),
    2,
    JSON_ARRAY('映射表可简化大量平行分支', '适用于离散值的情况', '提高可维护性'),
    '当分支基于有限离散值时，用字典映射到处理函数更简洁清晰。',
    'actions = {"a":f1, "b":f2}; actions.get(key, default)()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    494,
    33,
    '练习：温度分级',
    '补全：>=30 Hot, >=20 Warm, else Cold。',
    JSON_ARRAY('t=22'),
    JSON_ARRAY('Warm'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "t=22"}, {"type": "code_line", "value": "if t >= 30:"}, {"type": "code_line", "value": "    print(\\"Hot\\")"}, {"type": "code_line", "value": "elif t >= 20:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\"Cold\\")"}]}]}',
    JSON_ARRAY('Hot', 'Warm', 'Cold', 'OK'),
    JSON_ARRAY(2),
    '22 属于 20–29，应输出 Warm。',
    'elif 用于分档判断。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    495,
    33,
    '练习：状态码',
    '补全：200 OK, 404 Not Found, 其他 Error。',
    JSON_ARRAY('code=404'),
    JSON_ARRAY('Not Found'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "code=404"}, {"type": "code_line", "value": "if code == 200:"}, {"type": "code_line", "value": "    print(\\"OK\\")"}, {"type": "code_line", "value": "elif code == 404:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\"Error\\")"}]}]}',
    JSON_ARRAY('OK', 'Not Found', 'Error', 'Unknown'),
    JSON_ARRAY(2),
    '404 对应 Not Found。',
    'elif 便于处理不同状态码。'
);