USE `questions`;
-- Unit 113 | Start ID: 1681
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1681,
    113,
    '生成器内存优势',
    '与一次性创建完整列表相比，生成器的主要优势是？',
    JSON_OBJECT('A', '延迟计算并显著节省内存', 'B', '更快的随机访问', 'C', '更低的 CPU 使用', 'D', '可以索引'),
    1,
    JSON_ARRAY('提示1：生成器按需生成元素', '提示2：不需要同时将所有元素载入内存', '提示3: 适合流式处理大数据'),
    '生成器通过惰性求值逐个生成元素，节省内存开销。',
    'def gen():
  for i in range(1000000):
    yield i'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1682,
    113,
    '生成器 vs 列表推导',
    '使用 (x for x in it) 与 [x for x in it] 的差别是？',
    JSON_OBJECT('A', '前者是生成器，惰性；后者创建完整列表', 'B', '两者等价', 'C', '前者更耗内存', 'D', '后者不能遍历'),
    1,
    JSON_ARRAY('提示1：圆括号创建生成器表达式', '提示2：方括号创建完整列表', '提示3: 根据需求选择'),
    '生成器表达式惰性生成，适合大数据流，列表推导一次性计算并占用内存。',
    'g = (x*x for x in range(10))
L = [x*x for x in range(10)]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1683,
    113,
    '惰性评估适用',
    '下面哪种情况最适合使用生成器？',
    JSON_OBJECT('A', '处理大文件或流数据', 'B', '需要频繁随机访问', 'C', '需要并行索引', 'D', '需要固定长度数组'),
    1,
    JSON_ARRAY('提示1：生成器避免一次性加载', '提示2: 非随机访问友好', '提示3: 适合流水线处理'),
    '生成器非常适合逐行处理大文件或流式数据，减少内存占用。',
    'for line in open(\'big.txt\'): process(line)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1684,
    113,
    'next 调用成本（填空）',
    '对生成器调用 next() 的平均复杂度通常为？',
    NULL,
    JSON_ARRAY('O(1)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"O(1)\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    'next() 通常执行常数时间的步骤并返回下一个值，取决于生成逻辑。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1685,
    113,
    '迭代器一次性消耗（填空）',
    '迭代器在遍历后还能重用吗？',
    NULL,
    JSON_ARRAY('通常不能，除非重新创建'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"通常不能，除非重新创建\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '大部分迭代器（如生成器）被消耗后不可重用，需重新创建。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1686,
    113,
    '链式迭代',
    '使用 itertools.chain 合并多个迭代器对内存的影响是？',
    JSON_OBJECT('A', '仍然是惰性并节省内存', 'B', '会创建新的列表', 'C', '把所有元素复制到内存', 'D', '不能用于惰性迭代'),
    1,
    JSON_ARRAY('提示1：chain 逐个产出元素', '提示2: 不会把所有元素放到内存中', '提示3: 适合串联流式数据'),
    'itertools.chain 是惰性的，按需合并迭代器，不会同时加载所有元素。',
    'from itertools import chain
for x in chain(it1, it2): pass'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1687,
    113,
    '生成器的异常传播',
    '生成器在执行过程中抛出异常会怎样？',
    JSON_OBJECT('A', '异常会从 next() 处传播到调用者', 'B', '异常会被自动吞掉', 'C', '生成器会返回 None 并继续', 'D', '生成器会无限重试'),
    1,
    JSON_ARRAY('提示1：异常不会被隐式捕获', '提示2: 可以在生成器内部捕获处理', '提示3: 调用者会看到异常'),
    '生成器内的异常会在 next() 调用处传播，除非在生成器内部被捕获。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1688,
    113,
    'peek 行为',
    '想在不消费生成器的情况下查看下一个元素，通常应如何处理？',
    JSON_OBJECT('A', '使用 itertools.tee 复制迭代器', 'B', '直接 next() 并丢弃', 'C', '无法实现', 'D', '将生成器转换为列表'),
    1,
    JSON_ARRAY('提示1：itertools.tee 可复制迭代器', '提示2: 复制会有缓存开销', '提示3: 注意内存与性能权衡'),
    'itertools.tee 可以生成多个独立迭代器，但内部可能会缓存已消费数据。',
    'from itertools import tee
a, b = tee(gen)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1689,
    113,
    '生成器表达式内联（填空）',
    '当函数参数期望迭代器时，直接传入生成器表达式是否更节省内存？',
    NULL,
    JSON_ARRAY('是'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"是\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '直接传入生成器表达式避免先创建中间列表，从而节省内存。',
    'sum(x*x for x in range(1000000))'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1690,
    113,
    '生成器速率（填空）',
    '生成器每次产生值的开销取决于什么？',
    NULL,
    JSON_ARRAY('生成逻辑的复杂度'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"生成逻辑的复杂度\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '每次 next 的成本取决于生成器内部的计算量与 I/O 操作。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1691,
    113,
    '生成器与并发',
    '生成器本身是否提供并发？',
    JSON_OBJECT('A', '不提供，需配合线程/async 使用', 'B', '可以自动并发', 'C', '生成器是并行的', 'D', '生成器会多线程处理'),
    1,
    JSON_ARRAY('提示1：生成器是同步的', '提示2: 可与异步或线程结合使用', '提示3: async generator 提供异步语义'),
    '普通生成器是顺序执行的，不具备并发特性，需结合线程、进程或 async。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1692,
    113,
    '内存泄露风险',
    '使用生成器时要注意哪些导致内存持续增长的情况？',
    JSON_OBJECT('A', '在外部保存对生成器内部大型对象的引用', 'B', '生成器永远不释放', 'C', '生成器自动释放所有引用', 'D', '生成器无法与 GC 协同'),
    1,
    JSON_ARRAY('提示1：闭包或外部缓存可能持有引用', '提示2: 导致已生成对象无法释放', '提示3: 要注意迭代器生命周期'),
    '若外部保留生成器生成的对象或生成器闭包引用大量数据，可能导致内存无法回收。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1693,
    113,
    '生成器调试',
    '调试生成器最直接的方法是？',
    JSON_OBJECT('A', '在生成器内部加入打印或日志', 'B', '将其转换为列表再调试', 'C', '无法调试', 'D', '使用 assert 替代'),
    1,
    JSON_ARRAY('提示1：打印每次 yield 前后的状态', '提示2: 日志能帮助理解惰性执行', '提示3: 转换为列表会丧失惰性优势'),
    '在生成器中添加日志或使用调试器逐步执行能观察到执行流程与状态。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1694,
    113,
    '生成器关闭（填空）',
    '如何显式关闭生成器以释放资源？',
    NULL,
    JSON_ARRAY('调用 generator.close()'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"调用 generator.close()\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '可以调用 generator.close() 或让生成器函数自然结束以释放资源。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1695,
    113,
    '总结（填空）',
    '生成器最适合用于哪些场景？',
    NULL,
    JSON_ARRAY('大数据流、延迟计算与逐项处理'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"大数据流、延迟计算与逐项处理\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '生成器适合处理大型或无限数据流、流水线处理并节省内存。',
    ''
);