USE `questions`;
-- Unit 111 | Start ID: 1651
-- Generated at 2025-12-24 18:15:40

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1651, 
    111, 
    '字典查找复杂度', 
    '在平均情况下，使用 key 访问字典 dict[key] 的时间复杂度是？', 
    JSON_OBJECT('A', 'O(1)', 'B', 'O(n)', 'C', 'O(log n)', 'D', 'O(n log n)'), 
    1, 
    JSON_ARRAY('提示1：哈希表平均常数时间', '提示2：冲突会影响性能', '提示3: resize 会产生额外开销'), 
    '字典基于哈希表，平均查找为 O(1)，但最坏情况可能退化。', 
    'v = mydict.get(key)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1652, 
    111, 
    '插入与更新', 
    '向字典插入或更新键值对的平均复杂度是？', 
    JSON_OBJECT('A', 'O(1)', 'B', 'O(n)', 'C', 'O(log n)', 'D', 'O(n^2)'), 
    1, 
    JSON_ARRAY('提示1：哈希计算加常数时间', '提示2：扩容时会有摊销成本', '提示3: 平均为 O(1)'), 
    '插入/更新均为均摊 O(1)，扩容时开销摊到多次操作上。', 
    'mydict[key]=value'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1653, 
    111, 
    '键的可哈希性', 
    '作为字典键的对象必须满足什么条件？', 
    JSON_OBJECT('A', '可哈希且不可变', 'B', '可变且可哈希', 'C', '任意对象都可', 'D', '必须是字符串'), 
    1, 
    JSON_ARRAY('提示1：哈希值必须稳定', '提示2：可变对象的哈希可能改变', '提示3: tuple 可作为键而 list 不行'), 
    '字典键需是可哈希（hashable）且哈希值在生命周期中不变的对象。', 
    'd[(1,2)]=3'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1654, 
    111, 
    '字典大小与性能', 
    '当字典非常大且装载因子高时，常见问题是？', 
    JSON_OBJECT('A', '冲突增加导致性能下降', 'B', '访问变为 O(log n)', 'C', '字典自动变为列表', 'D', '内存不变'), 
    1, 
    JSON_ARRAY('提示1：装载因子高会增加冲突概率', '提示2: 冲突引发更多探测或链长', '提示3: 触发扩容可缓解'), 
    '装载因子高会提升冲突几率，影响查找与插入的常数时间。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1655, 
    111, 
    '使用 dict.get', 
    '相比直接索引，使用 dict.get(key) 的优势是什么？', 
    JSON_OBJECT('A', '避免 KeyError，可提供默认值', 'B', '速度更快', 'C', '降低内存', 'D', '转换为列表'), 
    1, 
    JSON_ARRAY('提示1：get 可指定默认返回', '提示2：索引不存在会抛异常', '提示3: 常用于安全访问'), 
    'dict.get 在键不存在时返回默认值而不是抛出异常，便于安全访问。', 
    'v = mydict.get(\'k\', 0)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1656, 
    111, 
    'ordered dict', 
    '从 Python 3.7 起，dict 的一个重要属性是？', 
    JSON_OBJECT('A', '保持插入顺序', 'B', '自动排序键', 'C', '使用二叉树存储', 'D', '键按哈希值排序'), 
    1, 
    JSON_ARRAY('提示1：插入顺序被保留', '提示2：这使得 ordered dict 常用场景减少', '提示3: 注意与排序不同'), 
    '从 CPython 3.7 起，字典保证插入顺序，这对序列化与可预测性有好处。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1657, 
    111, 
    '使用字典的场景', 
    '下列哪个场景最适合使用字典？', 
    JSON_OBJECT('A', '做快速键到值的映射', 'B', '顺序化的数列存储', 'C', '频繁按位置插入', 'D', '数值计算矩阵'), 
    1, 
    JSON_ARRAY('提示1：字典用于映射', '提示2：索引基于键而非位置', '提示3: 常用于缓存或索引'), 
    '字典是键到值的哈希映射，适合快速查找和映射场景。', 
    'cache[key]=result'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1658, 
    111, 
    'hash 冲突攻击', 
    '如果外部输入可控且大量相同哈希，会导致什么？', 
    JSON_OBJECT('A', '性能大幅下降，可能被利用为拒绝服务', 'B', '内存泄露', 'C', '自动转换为树', 'D', '影响浮点运算'), 
    1, 
    JSON_ARRAY('提示1：大量冲突会退化到链表查找', '提示2: 可能成为攻击面', '提示3: 应验证或限制用户输入'), 
    '可控输入造成大量冲突可导致哈希表退化，影响性能甚至安全。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1659, 
    111, 
    '浅拷贝 vs 深拷贝', 
    '对字典使用 copy() 会发生什么？', 
    JSON_OBJECT('A', '进行浅拷贝，引用相同的可变值', 'B', '进行深拷贝，递归复制所有对象', 'C', '不复制，返回原字典引用', 'D', '转换为列表'), 
    1, 
    JSON_ARRAY('提示1：copy 是浅拷贝', '提示2：可变值仍共享', '提示3: 使用 deepcopy 可完全复制'), 
    'dict.copy() 仅拷贝顶层映射，内部可变对象仍为同一引用。', 
    'd2 = d.copy()'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1660,
    111,
    '冲突处理（填空）',
    '哈希冲突出现时，哈希表通常会采取什么策略来处理？',
    NULL,
    JSON_ARRAY('开放寻址或链地址法'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"开放寻址或链地址法\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '常见策略包括开放寻址和链地址（链表/桶）来解决冲突。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1661,
    111,
    '遍历复杂度（填空）',
    '遍历字典所有键值对的时间复杂度为？',
    NULL,
    JSON_ARRAY('O(n)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"O(n)\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '必须访问每个元素，因此为 O(n)。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1662,
    111,
    '合并字典（填空）',
    '使用 {**a, **b} 合并两个字典的复杂度通常为？',
    NULL,
    JSON_ARRAY('O(len(a)+len(b))'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"O(len(a)+len(b))\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '需要复制两边元素到新字典，复杂度为两者长度之和。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1663,
    111,
    '键删除复杂度（填空）',
    '删除字典中一个键 del d[k] 的平均复杂度为？',
    NULL,
    JSON_ARRAY('O(1)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"O(1)\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '删除单个键在平均上为常数时间。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1664,
    111,
    '视图操作（填空）',
    '调用 d.keys()、d.values() 返回的对象类型通常为？',
    NULL,
    JSON_ARRAY('dict view objects'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"dict view objects\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '这些方法返回字典视图（view objects），不是列表，且与原字典动态关联。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1665,
    111,
    '总结（填空）',
    '字典常见操作的平均复杂度通常为？（访问/插入/删除）',
    NULL,
    JSON_ARRAY('O(1), O(1), O(1)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"O(1), O(1), O(1)\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '在平均情况下，访问、插入和删除均为常数时间。',
    ''
);