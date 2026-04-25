USE `questions`;
-- Unit 82 | Start ID: 1216
-- Generated at 2025-12-24 23:23:51

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1216, 
    82, 
    '推导式优点', 
    '列表推导式相较于普通循环的优势是？', 
    JSON_OBJECT('A', '语法简洁且通常更快', 'B', '更慢', 'C', '内存更少', 'D', '不可读'), 
    1, 
    JSON_ARRAY('通常由 C 实现部分优化', '更简洁'), 
    '列表推导式语法紧凑且在许多情况下比显式循环性能更好。', 
    '[x*2 for x in lst]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1217, 
    82, 
    '生成器表达式', 
    '生成器表达式与列表推导的主要区别是？', 
    JSON_OBJECT('A', '生成器惰性产出节省内存', 'B', '生成器更快构建完整列表', 'C', '无区别', 'D', '只有列表推导可用于嵌套'), 
    1, 
    JSON_ARRAY('生成器不会一次性创建整个列表', '适合大数据流'), 
    '生成器表达式按需产生值，不占用全部内存，适合流式处理。', 
    '(x for x in it)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1218, 
    82, 
    '条件过滤', 
    '在推导式中添加条件过滤写法为？', 
    JSON_OBJECT('A', '[x for x in lst if cond(x)]', 'B', '[if cond: x for x]', 'C', 'filter 不能用', 'D', '使用 try/except'), 
    1, 
    JSON_ARRAY('在表达式末尾添加 if 作为过滤条件'), 
    '推导式末尾的 if 子句可用于过滤元素。', 
    '[x for x in lst if x%2==0]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1219,
    82,
    '简单推导',
    '补全：把输入数字都平方并输出。',
    '1 2 3',
    JSON_ARRAY('1 4 9'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(*[int(x)**2 for x in input().split()])"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '列表推导式能在一行内表达对每个元素的操作。',
    '[x*x for x in nums]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1220,
    82,
    '生成器内存',
    '补全：用生成器计算大序列的和。',
    '1 2 3',
    JSON_ARRAY('6'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import sys"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(sum(int(x) for x in sys.stdin.read().split()))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '生成器表达式在 sum 中按需提供元素，节省内存。',
    'sum(x for x in it)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1221, 
    82, 
    '嵌套推导', 
    '要扁平化二维列表可用？', 
    JSON_OBJECT('A', '[x for row in mat for x in row]', 'B', 'sum(mat)', 'C', 'zip(mat)', 'D', 'map only'), 
    1, 
    JSON_ARRAY('内置顺序为外层先，内层后'), 
    '嵌套推导可以将二维列表扁平化为一维。', 
    '[x for row in mat for x in row]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1222, 
    82, 
    '可读性折中', 
    '当推导式太复杂时应？', 
    JSON_OBJECT('A', '改写为显式循环以提高可读性', 'B', '坚持写复杂推导式', 'C', '压缩更多逻辑进一行', 'D', '用 lambda 嵌套'), 
    1, 
    JSON_ARRAY('可读性优先于一行写完的炫技'), 
    '当推导式变得难以理解时，显式循环更易维护。', 
    'use for loops instead'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1223, 
    82, 
    '生成器消费', 
    '消费生成器后要再用需如何？', 
    JSON_OBJECT('A', '重新创建生成器', 'B', '可以 reset', 'C', '直接再迭代', 'D', '转换为 tuple后可复用'), 
    1, 
    JSON_ARRAY('生成器被消费后不可复用', '可转为 list/tuple 以复用'), 
    '生成器被消费后不可复用，需要重新创建或转换为序列以复用。', 
    'g = (x for x in it); list(g)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1224,
    82,
    '带条件的推导',
    '补全：选出偶数并乘以 10。',
    '1 2 3 4',
    JSON_ARRAY('20 40'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(*[x*10 for x in map(int,input().split()) if x%2==0])"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '推导式可以同时进行过滤和转换。',
    '[f(x) for x in it if cond(x)]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1225,
    82,
    '生成器与函数',
    '补全：将生成器结果传入函数处理示例（如 sum）。',
    '1 2 3',
    JSON_ARRAY('6'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(sum(int(x) for x in input().split()))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '许多内建函数支持直接接受生成器表达式以节省内存。',
    'min(x for x in it)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1226, 
    82, 
    '嵌套生成器', 
    '嵌套生成器表达式可用于？', 
    JSON_OBJECT('A', '复杂扁平化或延迟计算', 'B', '不被允许', 'C', '仅在列表中有效', 'D', '会报错'), 
    1, 
    JSON_ARRAY('可用于扁平化与按需计算'), 
    '嵌套生成器可实现复杂的延迟计算与扁平化操作。', 
    '(x for row in mat for x in row)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1227, 
    82, 
    '转换代价', 
    '将生成器转换为列表的代价是？', 
    JSON_OBJECT('A', '需要一次性将所有元素存入内存', 'B', '更快', 'C', '无代价', 'D', '自动优化'), 
    1, 
    JSON_ARRAY('转换会消耗内存与时间'), 
    'list(generator) 会把所有元素载入内存，消耗与数据规模线性相关的资源。', 
    'list(it)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1228, 
    82, 
    '表达式复杂性', 
    '在推导式中用条件表达式会如何影响可读性？', 
    JSON_OBJECT('A', '可能降低可读性', 'B', '总是更清晰', 'C', '无影响', 'D', '禁止使用'), 
    1, 
    JSON_ARRAY('过多条件使表达式难以理解'), 
    '复杂的条件表达式会降低可读性，必要时改用显式循环。', 
    '[x if cond else y for x in it]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1229,
    82,
    '带索引的推导',
    '补全：使用 enumerate 在推导式中获得索引和值。',
    'a b',
    JSON_ARRAY('0-a 1-b'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(*[f\"{i}-{v}\" for i,v in enumerate(input().split())])"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '可以在推导式里使用 enumerate 获取索引信息。',
    '[ (i,v) for i,v in enumerate(lst) ]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1230,
    82,
    '复杂数据生成',
    '补全：生成 (i, x*2) 的生成器表达式示例。',
    '1 2',
    JSON_ARRAY('(0,2) (1,4)'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "g = ((i, x*2) for i,x in enumerate(map(int,input().split())))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(list(g))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '生成器表达式可用于生成复杂的元组序列以便后续处理。',
    '(func(x) for x in it)'
);