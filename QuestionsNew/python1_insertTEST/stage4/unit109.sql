USE `questions`;
-- Unit 109 | Start ID: 1621
-- Generated at 2025-12-24 18:14:57

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1621, 
    109, 
    'append 复杂度', 
    '在平均情况下，列表 append 的时间复杂度是？', 
    JSON_OBJECT('A', '摊销 O(1)', 'B', 'O(n)', 'C', 'O(log n)', 'D', 'O(n^2)'), 
    1, 
    JSON_ARRAY('提示1：append 摊销常数时间', '提示2：偶尔会触发扩容导致更高成本', '提示3: \'平均而言为 O(1)\''), 
    '列表 append 在摊销意义上为 O(1)，尽管偶尔扩容会有额外成本。', 
    'for i in range(1000): a.append(i)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1622, 
    109, 
    '索引访问复杂度', 
    '通过索引访问列表元素 lst[i] 的复杂度是？', 
    JSON_OBJECT('A', 'O(1)', 'B', 'O(n)', 'C', 'O(log n)', 'D', 'O(n^2)'), 
    1, 
    JSON_ARRAY('提示1：列表底层支持随机访问', '提示2：通过索引可常数时间访问', '提示3: \'区别于链表\''), 
    '列表支持索引随机访问，时间复杂度为 O(1)。', 
    'x = lst[10]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1623, 
    109, 
    '插入复杂度', 
    '在列表头部插入元素（insert(0,x)）的复杂度通常是？', 
    JSON_OBJECT('A', 'O(n)', 'B', 'O(1)', 'C', 'O(log n)', 'D', 'O(n^2)'), 
    1, 
    JSON_ARRAY('提示1：头部插入需移动后续元素', '提示2: 整体移动导致线性时间', '提示3: 使用 deque 可避免该成本\''), 
    '在头部插入需要移动原有元素，时间复杂度为 O(n)。', 
    'lst.insert(0, x)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1624, 
    109, 
    '列表扩容策略', 
    '列表扩容通常会导致什么？', 
    JSON_OBJECT('A', '分配更大内存并复制元素', 'B', '原地扩展而无成本', 'C', '抛出内存错误', 'D', '自动释放内存'), 
    1, 
    JSON_ARRAY('提示1：扩容时会重新分配更大缓冲区并复制元素', '提示2: 这导致偶尔的高成本操作', '提示3: 摊销后 append 仍为 O(1)\''), 
    '当缓冲区不足时，列表会分配更大空间并复制元素，导致偶发的高成本。', 
    'append 触发扩容'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1625, 
    109, 
    '删除复杂度', 
    '从中间位置删除元素（del lst[i]）通常的时间复杂度是？', 
    JSON_OBJECT('A', 'O(n)', 'B', 'O(1)', 'C', 'O(log n)', 'D', 'O(n^2)'), 
    1, 
    JSON_ARRAY('提示1：删除后需移动后续元素', '提示2: 移动成本线性', '提示3: 头部与中间删除都是 O(n)\''), 
    '删除中间元素需要移动后续元素，时间复杂度为 O(n)。', 
    'del lst[2]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1626, 
    109, 
    '重复元素查找', 
    '若频繁查找是否存在某元素，哪种数据结构比列表更合适？', 
    JSON_OBJECT('A', 'set（集合）', 'B', 'tuple', 'C', 'list', 'D', 'string'), 
    1, 
    JSON_ARRAY('提示1：集合的查找平均为 O(1)', '提示2: 列表查找为 O(n)', '提示3: 适用于高频查找场景\''), 
    '集合提供平均 O(1) 的成员测试，适合大量存在性判断。', 
    'if x in myset:'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1627, 
    109, 
    '内存局部性', 
    '列表在内存上是如何布局的？', 
    JSON_OBJECT('A', '连续分配引用数组，元素引用可能在堆上', 'B', '链表结构', 'C', '树形结构', 'D', '分散在多个文件'), 
    1, 
    JSON_ARRAY('提示1：列表底层为动态数组存放引用', '提示2: 元素对象通常存于堆上', '提示3: 连续引用带来良好局部性\''), 
    '列表存放对象引用的连续数组，而对象本身分配在堆上。', 
    'list 内部为指针数组'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1628, 
    109, 
    '使用场景', 
    '哪种情况最适合使用列表？', 
    JSON_OBJECT('A', '需要有序可变序列并频繁按索引访问', 'B', '需要唯一元素集合', 'C', '需要不可变序列', 'D', '需要键值映射'), 
    1, 
    JSON_ARRAY('提示1：列表支持有序与可变', '提示2: 集合用于唯一元素', '提示3: dict 用于键值映射\''), 
    '列表适合需要按索引快速访问且可变的有序序列场景。', 
    'a[10] 访问'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1629, 
    109, 
    '重复追加与预分配', 
    '若事先知道最终长度，如何提高多次 append 的性能？', 
    JSON_OBJECT('A', '使用乘法创建预分配大小的列表并按索引赋值', 'B', '无法优化', 'C', '使用 tuple', 'D', '每次都扩容'), 
    1, 
    JSON_ARRAY('提示1：预分配可避免多次扩容', '提示2: 可通过 [None]*n 创建固定长度列表', '提示3: 然后按索引赋值\''), 
    '若已知大小，可预先分配并按索引赋值以减少扩容次数。', 
    'a = [None]*100; a[i]=x'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1630,
    109,
    '查找复杂度（填空）',
    '使用 in 操作查找元素是否在列表中通常耗时为多少复杂度？',
    NULL,
    JSON_ARRAY('O(n)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"O(n)\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    'in 操作需要线性查找，复杂度为 O(n)。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1631,
    109,
    '复制复杂度（填空）',
    '复制长度为 n 的列表（如 a[:]）的时间复杂度为？',
    NULL,
    JSON_ARRAY('O(n)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"O(n)\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '复制需要逐元素复制，时间复杂度为 O(n)。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1632,
    109,
    '列表遍历复杂度（填空）',
    '遍历长度为 n 的列表并做 O(1) 操作，总复杂度为？',
    NULL,
    JSON_ARRAY('O(n)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"O(n)\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '遍历 n 个元素并对每个执行常数耗时操作总体为 O(n)。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1633,
    109,
    '排序复杂度（填空）',
    'Python 内置排序的平均时间复杂度通常为？',
    NULL,
    JSON_ARRAY('O(n log n)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"O(n log n)\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    'Python 的 Timsort 平均和最坏情况均为 O(n log n)。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1634,
    109,
    'append vs extend（填空）',
    '频繁加入多个元素时 prefer 使用 extend 还是 append？',
    NULL,
    JSON_ARRAY('extend'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"extend\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    'extend 一次性添加多个元素通常比多次 append 更高效。',
    'lst.extend(iterable)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1635,
    109,
    '总结（填空）',
    '访问、追加和索引常见时间复杂度分别为？',
    NULL,
    JSON_ARRAY('O(1), O(1) amortized, O(1)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"O(1), O(1) amortized, O(1)\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '索引访问 O(1)，append 平均摊销 O(1)，索引赋值 O(1)。',
    ''
);