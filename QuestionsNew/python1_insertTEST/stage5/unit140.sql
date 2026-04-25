USE `questions`;
-- Unit 140 | Start ID: 2086
-- Generated at 2025-12-24 18:23:18

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2086, 
    140, 
    '性能分析工具', 
    '用于分析 Python 程序性能的标准库工具是？', 
    JSON_OBJECT('A', 'cProfile', 'B', 'timeit', 'C', 'tracemalloc', 'D', 'logging'), 
    1, 
    JSON_ARRAY('提示1: cProfile 可分析函数调用耗时', '提示2: timeit 适合基准微测', '提示3: tracemalloc 用于内存分析'), 
    'cProfile 用于收集函数调用的性能统计信息。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2087, 
    140, 
    '微基准', 
    '进行小段代码性能比较常用哪个模块？', 
    JSON_OBJECT('A', 'timeit', 'B', 'cProfile', 'C', 'unittest', 'D', 'pdb'), 
    1, 
    JSON_ARRAY('提示1: timeit 运行多次并统计稳定值', '提示2: 用于微基准测试', '提示3: 避免测 I/O 操作'), 
    'timeit 适合对小代码片段进行可靠的时间测量。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2088, 
    140, 
    '内存跟踪', 
    '要检查内存分配并查找泄漏，应使用哪个工具？', 
    JSON_OBJECT('A', 'tracemalloc', 'B', 'cProfile', 'C', 'timeit', 'D', 'logging'), 
    1, 
    JSON_ARRAY('提示1: tracemalloc 跟踪分配堆栈', '提示2: 可比较不同时间点内存变动', '提示3: 有助于查找泄漏来源'), 
    'tracemalloc 用于跟踪内存分配并找出热点位置。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2089, 
    140, 
    '算法复杂度', 
    '对于大数据量问题，首要考虑的通常是？', 
    JSON_OBJECT('A', '选择合适的算法与数据结构以降低时间复杂度', 'B', '增加注释', 'C', '使用更短变量名', 'D', '改用单线程'), 
    1, 
    JSON_ARRAY('提示1: 算法复杂度对大数据影响最大', '提示2: 数据结构决定操作耗时', '提示3: 优化算法常比微优化更有效'), 
    '选择更好算法和数据结构能显著改善性能，尤其在数据规模较大时。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2090, 
    140, 
    '内置函数优势', 
    '使用内置函数或库（如 sum、map）通常比手写 Python 循环更快的原因是？', 
    JSON_OBJECT('A', '内置函数在 C 层实现，减少 Python 解释器开销', 'B', '更容易出错', 'C', '自动并行化', 'D', '占用更少内存'), 
    1, 
    JSON_ARRAY('提示1: 内置函数在 C 层执行速度快', '提示2: 避免频繁的 Python 层交互', '提示3: 优先使用成熟库实现'), 
    '内置函数在 C 层运行，通常具有更高的执行效率。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2091, 
    140, 
    '延迟计算', 
    '哪种技巧可用于避免不必要的计算以节省资源？', 
    JSON_OBJECT('A', '延迟计算（lazy evaluation）', 'B', '立即计算所有结果', 'C', '频繁复制数据', 'D', '降低缓存使用'), 
    1, 
    JSON_ARRAY('提示1: 仅在需要时才计算', '提示2: 生成器可实现惰性序列', '提示3: 缓存也可减少重复计算'), 
    '延迟计算延后执行，避免不必要的开销，生成器是常用手段。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2092, 
    140, 
    '内存泄漏来源', 
    'Python 中常见的内存泄漏来源是？', 
    JSON_OBJECT('A', '长寿命容器意外保存大量对象', 'B', '垃圾回收不会释放任何对象', 'C', '内存自动无限增长是正常的', 'D', '只在 C 扩展中发生'), 
    1, 
    JSON_ARRAY('提示1: 全局缓存或单例持有大量对象', '提示2: 闭包或缓存可能导致泄漏', '提示3: 使用 tracemalloc 查找泄漏来源'), 
    '长寿命容器持续持有对象引用会导致内存无法释放，形成泄漏。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2093, 
    140, 
    '并行化建议', 
    '要利用多核 CPU 处理计算密集型任务，推荐使用？', 
    JSON_OBJECT('A', 'multiprocessing 或 C/C++ 扩展', 'B', '多线程', 'C', 'asyncio', 'D', '单线程优化'), 
    1, 
    JSON_ARRAY('提示1: 多进程能绕过 GIL', '提示2: C 扩展可在 C 层并行计算', '提示3: 视场景选择合适方案'), 
    'multiprocessing 或用 C 扩展能更好地利用多核 CPU。', 
    ''
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2094,
    140,
    '优化优先级（填空）',
    '优化前应先使用分析工具找出 __1__，再优化热点。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('瓶颈', '测试', '文档', '注释'),
    JSON_ARRAY(1),
    '先找出性能瓶颈再优化能更有效果。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2095,
    140,
    '避免函数调用开销（填空）',
    '在性能敏感的循环中，减少 __1__ 次数可提升性能（例如把方法引用赋给局部变量）。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for i in range(1000000):"}, {"type": "code_line", "value": "    f = obj.method"}, {"type": "code_line", "value": "    f()"}]}]}',
    JSON_ARRAY('属性查找', 'I/O', '内存分配', '异常抛出'),
    JSON_ARRAY(1),
    '减少属性查找与函数调用开销可提升循环性能。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2096,
    140,
    '缓存结果（填空）',
    '使用 functools.__1__ 可以缓存函数结果以避免重复计算。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "from functools import "}, {"type": "slot", "index": 0}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "@"}, {"type": "slot", "index": 0}, {"type": "code", "value": "(maxsize=128)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "def f(x): pass"}]}]}',
    JSON_ARRAY('lru_cache', 'cached_property', 'wraps', 'partial'),
    JSON_ARRAY(1),
    'functools.lru_cache 用于缓存函数返回结果提高性能。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2097,
    140,
    '避免临时字符串（填空）',
    '在大量字符串拼接时，推荐使用 __1__ 列表再 join 来减少临时对象。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "parts = []"}, {"type": "code_line", "value": "parts.append(s)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "result = \"\"."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(parts)"}]}]}',
    JSON_ARRAY('join', 'split', 'format', 'replace'),
    JSON_ARRAY(1),
    '使用 "".join(parts) 比频繁使用 + 创建更少临时字符串更高效。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2098,
    140,
    '基准测试（填空）',
    '在做性能对比时，应尽量固定 __1__ 以减少噪声（例如硬件与外部负载）。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('环境', '代码', '注释', '文档'),
    JSON_ARRAY(1),
    '固定环境与重复测量有助于获得可靠的基准结果。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2099,
    140,
    'GC 控制（填空）',
    '可以使用 gc.__1__() 暂时禁用垃圾回收以排查内存问题。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import gc"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "gc."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}]}',
    JSON_ARRAY('disable', 'enable', 'collect', 'stats'),
    JSON_ARRAY(1),
    'gc.disable() 可在调试时关闭自动 GC，谨慎使用并在结束后恢复。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2100,
    140,
    '总结（填空）',
    '分析用 cProfile，内存测用 __1__，微基准用 __2__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('tracemalloc', 'timeit', 'logging', 'cProfile'),
    JSON_ARRAY(1, 2),
    'tracemalloc 用于内存，timeit 用于微基准，cProfile 用于性能分析。',
    ''
);