USE `questions`;
-- Unit 112 | Start ID: 1666
-- Generated at 2025-12-24 23:33:17

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1666, 
    112, 
    '集合成员测试', 
    '在平均情况下，使用 in 检查某元素是否在 set 中的复杂度是？', 
    JSON_OBJECT('A', 'O(1)', 'B', 'O(n)', 'C', 'O(log n)', 'D', 'O(n^2)'), 
    1, 
    JSON_ARRAY('提示1：set 基于哈希表', '提示2：成员测试为常数时间', '提示3: 类似 dict 查找'), 
    '集合基于哈希实现，成员测试平均为 O(1)。', 
    'if x in myset: pass'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1667, 
    112, 
    '交并差复杂度', 
    '计算两个集合的交集 A & B 的复杂度与什么有关？', 
    JSON_OBJECT('A', '与较小集合的大小线性相关', 'B', '固定常数', 'C', '与两集合乘积相关', 'D', '与内存无关'), 
    1, 
    JSON_ARRAY('提示1：通常遍历较小的集合并检查成员', '提示2: 成本近似为 O(min(len(A),len(B)))', '提示3: hash 查找为 O(1)'), 
    '交集计算通常遍历较小集合并在另一集合中检查成员，从而与小集合大小线性相关。', 
    'A & B'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1668, 
    112, 
    '可变性', 
    'set 是否可变且可作为字典键？', 
    JSON_OBJECT('A', '不可作为字典键，因为 set 是可变的', 'B', '可以，性能更好', 'C', '仅 frozenset 可以', 'D', '所有可迭代对象都可以'), 
    3, 
    JSON_ARRAY('提示1：普通 set 是可变的', '提示2: frozenset 是不可变可哈希', '提示3: 可用作字典键的是可哈希对象'), 
    '普通 set 不能作为字典键或放入 set 中，但 frozenset（不可变集合）可以。', 
    'fs = frozenset([1,2])'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1669,
    112,
    '添加元素复杂度（填空）',
    '向集合添加元素 myset.add(x) 的平均复杂度为？',
    NULL,
    JSON_ARRAY('O(1)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"O(1)\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '添加操作基于哈希，平均为常数时间，扩容时有摊销成本。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1670,
    112,
    '集合去重（填空）',
    '将列表去重常用的方法是将其转换为 set，复杂度为？',
    NULL,
    JSON_ARRAY('O(n)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"O(n)\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '转换需要遍历列表并插入集合，平均为 O(n)。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1671, 
    112, 
    '集合迭代', 
    '迭代集合元素的复杂度与什么相关？', 
    JSON_OBJECT('A', '与集合大小线性相关', 'B', '恒定时间', 'C', '与键的哈希值相关', 'D', '与内存页数相关'), 
    1, 
    JSON_ARRAY('提示1：需要访问所有元素', '提示2：每个元素一次性处理', '提示3: 整体为 O(n)'), 
    '迭代需访问每个元素，时间与元素数量成正比。', 
    'for x in myset: pass'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1672, 
    112, 
    '集合适用场景', 
    '下列哪种场景适合使用集合？', 
    JSON_OBJECT('A', '快速去重和成员测试', 'B', '需要按索引访问元素', 'C', '需要键值映射', 'D', '需要有序序列'), 
    1, 
    JSON_ARRAY('提示1：集合提供快速成员测试', '提示2: 不保证顺序', '提示3: 常用于去重'), 
    '集合适合快速存在性检查与去重，但不适合按位置访问。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1673, 
    112, 
    '集合的内存特性', 
    'set 的内存消耗通常与什么成正比？', 
    JSON_OBJECT('A', '元素数量', 'B', '元素值大小无关', 'C', '与 CPU 核数相关', 'D', '与磁盘空间相关'), 
    1, 
    JSON_ARRAY('提示1：每个元素需存储哈希以及引用', '提示2: 元素越多占用越大', '提示3: 装载因子影响桶数'), 
    '集合内部为哈希表结构，所需内存与元素数量和实现相关。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1674,
    112,
    '子集检测（填空）',
    '检测 A 是否为 B 的子集 A.issubset(B) 的复杂度通常为？',
    NULL,
    JSON_ARRAY('O(len(A))'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"O(len(A))\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '通常遍历 A 的元素并在 B 中检测，每步为 O(1)，总体与 len(A) 线性相关。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1675,
    112,
    'frozenset 用途（填空）',
    'frozenset 的一个常见用途是作为？',
    NULL,
    JSON_ARRAY('dict 键或 set 元素'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"dict 键或 set 元素\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '因为 frozenset 是不可变且可哈希，可用于字典键或放入 set 中。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1676, 
    112, 
    '并集操作', 
    'A.union(B) 在实现上通常如何？', 
    JSON_OBJECT('A', '创建新集合并复制元素', 'B', '在 A 就地添加 B 的元素并返回 A', 'C', '仅返回视图', 'D', '返回列表'), 
    1, 
    JSON_ARRAY('提示1：union 返回新集合', '提示2: update 是就地操作', '提示3: 复制成本为两者长度之和'), 
    'union 通常返回一个新集合，包含两集合的所有元素，需复制。', 
    'C = A.union(B)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1677, 
    112, 
    'update vs union', 
    '当需要将 B 合并到 A 并节省内存时应使用？', 
    JSON_OBJECT('A', 'A.update(B)', 'B', 'A = A.union(B)', 'C', 'A + B', 'D', 'list(A)+list(B)'), 
    1, 
    JSON_ARRAY('提示1：update 就地修改 A', '提示2: 避免创建新集合', '提示3: 节省内存与复制成本'), 
    '使用 update 可在原集合上就地添加元素，避免分配新集合。', 
    'A.update(B)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1678, 
    112, 
    '去重顺序', 
    '将列表转换为 set 后再转换回列表，结果列表的顺序如何？', 
    JSON_OBJECT('A', '不保证原顺序', 'B', '保持原顺序', 'C', '按值排序', 'D', '按插入时间稳定'), 
    1, 
    JSON_ARRAY('提示1：set 不保证顺序', '提示2: 若需稳定去重可使用 dict.fromkeys 或 OrderedDict', '提示3: Python 3.7+ dict 保持顺序'), 
    'set 不保证元素顺序，转换后顺序不可预测。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1679,
    112,
    '集合交集的返回类型（填空）',
    'A & B 的返回类型是？',
    NULL,
    JSON_ARRAY('set'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"set\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '交集操作返回一个新的 set 对象。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1680,
    112,
    '总结（填空）',
    '集合的成员测试、添加和删除的平均复杂度通常为？',
    NULL,
    JSON_ARRAY('O(1), O(1), O(1)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"O(1), O(1), O(1)\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '集合的大多数基本操作在平均情况下为常数时间。',
    ''
);