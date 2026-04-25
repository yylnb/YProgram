USE `questions`;
-- Unit 114 | Start ID: 1696
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1696,
    114,
    '列表推导的好处',
    '相比显式循环，列表推导通常具有什么优点？',
    JSON_OBJECT('A', '更简洁且通常更快（由 C 实现的内部循环）', 'B', '使用更少内存', 'C', '支持并行执行', 'D', '自动排序'),
    1,
    JSON_ARRAY('提示1：列表推导在 C 层面完成循环和附加', '提示2：更少的 Python 层函数调用开销', '提示3：可读性更高'),
    '列表推导在内部优化循环和元素添加，一般比等价的 Python 循环更快。',
    'squares = [x*x for x in range(1000)]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1697,
    114,
    '推导与生成器',
    '当数据量很大且不需要保存全部结果时，更适合使用？',
    JSON_OBJECT('A', '生成器表达式', 'B', '列表推导', 'C', '集合推导', 'D', '三元表达式'),
    1,
    JSON_ARRAY('提示1：生成器惰性产出', '提示2：列表推导会占用内存存储所有元素', '提示3：适合流式处理'),
    '生成器表达式按需生成元素，适合节省内存。',
    '(x for x in big_iter)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1698,
    114,
    '避免副作用',
    '在列表推导中不推荐做什么？',
    JSON_OBJECT('A', '在推导体中产生副作用（如写文件或修改外部状态）', 'B', '做纯计算', 'C', '使用条件过滤', 'D', '简单表达式'),
    1,
    JSON_ARRAY('提示1：推导应保持表达式式的纯粹性', '提示2：副作用会降低可读性和可测试性', '提示3：副作用最好放在显式循环中'),
    '列表推导用于构造序列，不应在内部执行影响外部状态的副作用。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1699,
    114,
    '嵌套推导复杂度（填空）',
    '嵌套列表推导的时间复杂度通常如何计算？',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"乘积级别，例如 O(n*m)\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '嵌套循环会产生乘积级别的复杂度，取决于各层循环大小。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1700,
    114,
    '推导与内存（填空）',
    '若需要生成但不保存大量结果，应使用？',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"生成器表达式或迭代器\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '生成器表达式或迭代器可避免同时保留大量数据。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1701,
    114,
    '多条件过滤',
    '在推导中使用多个条件过滤会如何影响性能？',
    JSON_OBJECT('A', '每个条件都会增加判断成本，但通常仍为线性遍历', 'B', '变为指数级', 'C', '忽略后续条件', 'D', '自动并行'),
    1,
    JSON_ARRAY('提示1：条件越多每个元素判断成本越高', '提示2：遍历仍然线性', '提示3：可通过提前过滤减少成本'),
    '多个过滤条件会增加每元素的常数判断开销，但总体仍按元素线性执行。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1702,
    114,
    '构造大型列表',
    '若需要构建非常大的列表并随后多次访问，最佳做法是？',
    JSON_OBJECT('A', '直接创建列表并复用', 'B', '每次重新生成', 'C', '使用生成器并每次遍历生成', 'D', '使用 set'),
    1,
    JSON_ARRAY('提示1：如果多次访问，预先创建并保存避免重复计算', '提示2：考虑内存与访问频率权衡', '提示3：可能使用缓存'),
    '若需要重复访问，先生成并保留列表可避免重复计算，但需考虑内存成本。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1703,
    114,
    '避免重复计算',
    '在推导中若某子表达式重复计算，如何优化？',
    JSON_OBJECT('A', '在 comprehension 之前计算并重用', 'B', '无法优化', 'C', '使用全局变量', 'D', '增加条件'),
    1,
    JSON_ARRAY('提示1：将常量或不变结果提取到外部', '提示2：减少每次迭代的工作量', '提示3：提高性能'),
    '将不变或可缓存的子表达式移出推导体可以减少重复计算开销。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1704,
    114,
    '推导与函数调用（填空）',
    '在推导中频繁调用开销大的函数会使性能如何？',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"显著下降\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '每次迭代调用昂贵函数会显著增加总体耗时，考虑缓存或提前计算。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1705,
    114,
    '推导返回类型（填空）',
    '列表推导、集合推导和字典推导分别返回什么类型？',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"list, set, dict\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '语法不同会产生对应类型：[]=>list, {} with one expr=>set or dict 取决于键值对',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1706,
    114,
    '可读性权衡',
    '复杂的嵌套推导是否推荐？',
    JSON_OBJECT('A', '不推荐，影响可读性，考虑显式循环', 'B', '一律推荐', 'C', '性能总是更好', 'D', '编译器会自动简化'),
    1,
    JSON_ARRAY('提示1：可读性优先于少量性能提升', '提示2：复杂逻辑应拆分', '提示3：便于测试'),
    '深度嵌套的推导可读性差，应用显式循环或拆分步骤提高可维护性。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1707,
    114,
    '推导与局部变量',
    '列表推导中的变量作用域如何影响性能？',
    JSON_OBJECT('A', '局部变量访问快于全局，适当将函数或常量作为局部引用', 'B', '全局更快', 'C', '无差别', 'D', '推导不允许局部变量'),
    1,
    JSON_ARRAY('提示1：局部变量查找更快', '提示2：可以通过绑定函数或常量到局部提高效率', '提示3：小幅优化'),
    '在推导中使用局部变量（或把全局绑定为局部）能略微提升性能。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1708,
    114,
    '何时优先可读性',
    '在追求性能时何时应优先选择更可读的写法？',
    JSON_OBJECT('A', '当性能差异微小且影响维护时', 'B', '永远不考虑可读性', 'C', '始终牺牲可读性换取性能', 'D', '仅在脚本中考虑'),
    1,
    JSON_ARRAY('提示1：权衡维护成本和性能', '提示2：先衡量再优化', '提示3：使用基准测试验证'),
    '在多数工程场景下，可读性与维护性应优先，只有在确有性能瓶颈时再优化。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1709,
    114,
    '内存峰值（填空）',
    '一次性创建巨大列表会产生什么问题？',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"高内存峰值，可能导致 OOM\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '一次性分配大量内存可能导致内存峰值过高并引发内存不足。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1710,
    114,
    '总结（填空）',
    '列表推导主要优点是？',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"简洁且通常更快\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '推导简洁、在 C 层优化循环，通常比纯 Python 循环更快。',
    ''
);