USE `questions`;
-- Unit 117 | Start ID: 1741
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1741,
    117,
    'asyncio 优势',
    '在大量并发 I/O 请求场景下，asyncio 相对于线程的主要优势是？',
    JSON_OBJECT('A', '内存占用低且上下文切换开销小', 'B', '自动并行 CPU 运算', 'C', '无需异步库支持', 'D', '不用考虑回调'),
    1,
    JSON_ARRAY('提示1：事件循环在单线程中管理大量任务', '提示2: 无需为每个任务创建线程堆栈', '提示3: 上下文切换为协程切换开销低'),
    'asyncio 使用协程与事件循环，能在单线程中高效调度大量并发 I/O，节省内存与切换开销。',
    'async def fetch(): await aiohttp.get(url)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1742,
    117,
    '阻塞调用问题',
    '在 asyncio 中直接运行阻塞函数会导致？',
    JSON_OBJECT('A', '阻塞事件循环，影响所有协程', 'B', '提升并发性', 'C', '自动转为异步', 'D', '无影响'),
    1,
    JSON_ARRAY('提示1：事件循环在同一线程执行协程', '提示2: 阻塞调用会阻塞整个循环', '提示3: 使用 run_in_executor 将阻塞函数移到线程池'),
    '阻塞调用会阻塞事件循环，应使用异步库或把阻塞任务放到线程/进程池中执行。',
    'await loop.run_in_executor(None, blocking_func)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1743,
    117,
    '限流与并发控制',
    '在 asyncio 中控制并发数量常用的做法是？',
    JSON_OBJECT('A', '使用 asyncio.Semaphore 限制并发', 'B', '随意启动无限协程', 'C', '用 sleep 延迟所有任务', 'D', '不需要控制'),
    1,
    JSON_ARRAY('提示1：Semaphore 控制同时运行协程数量', '提示2: 防止资源耗尽', '提示3: 结合 gather 使用'),
    '使用信号量或限速器可以限制并发协程数量，避免过度占用资源导致失败。',
    'sem = asyncio.Semaphore(100)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1744,
    117,
    '并发吞吐（填空）',
    'asyncio 在大量短时 I/O 任务下通常能提高吞吐，因为？',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"协程切换比线程切换更轻量\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '协程切换开销小，避免线程栈和操作系统上下文切换，从而提升短时 I/O 任务吞吐。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1745,
    117,
    '事件循环成本（填空）',
    '事件循环调度成百上千协程的主要开销通常是？',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"调度与上下文切换的常数开销\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '主要开销为调度与协程状态保存/恢复，I/O 本身仍可能是瓶颈。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1746,
    117,
    '第三方库兼容',
    '在 asyncio 项目中使用第三方阻塞库应如何处理？',
    JSON_OBJECT('A', '用 executor 执行或寻找异步替代库', 'B', '直接调用阻塞库', 'C', '直接将其转换为协程', 'D', '不可能一起使用'),
    1,
    JSON_ARRAY('提示1：run_in_executor 可将阻塞调用转到线程池', '提示2: 异步版本通常更高效', '提示3: 尽量减少阻塞点'),
    '对阻塞库可使用 executor 或换用异步实现以避免阻塞事件循环。',
    'await loop.run_in_executor(None, blocking_func)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1747,
    117,
    'asyncio.gather',
    '使用 asyncio.gather 并发等待多个协程时需注意？',
    JSON_OBJECT('A', 'gather 会同时调度所有协程，可能导致资源峰值', 'B', 'gather 会顺序执行协程', 'C', 'gather 会限制为单协程', 'D', 'gather 不能与 Semaphore 一起用'),
    1,
    JSON_ARRAY('提示1：一次性调度大量协程会占用并发资源', '提示2: 结合 Semaphore 控制并发量', '提示3: 使用批次化运行'),
    'gather 会立即调度参数中的所有协程，若数量巨大会造成瞬时资源耗尽，应采用限流或分批。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1748,
    117,
    '阻塞 I/O 在 asyncio 中',
    '直接在协程内进行阻塞 I/O 会导致什么？',
    JSON_OBJECT('A', '阻塞整个事件循环，影响其他协程', 'B', '只阻塞当前协程', 'C', '自动并发执行', 'D', '提高性能'),
    1,
    JSON_ARRAY('提示1：事件循环在单线程运行', '提示2: 阻塞操作必须移到 executor', '提示3: 使用异步库替代'),
    '阻塞 I/O 会阻塞事件循环，导致所有协程无法运行，应避免在协程中直接执行阻塞调用。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1749,
    117,
    '超时处理（填空）',
    '为避免单个协程阻塞整个流程，通常使用什么机制设置超时？',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"asyncio.wait_for 或超时包装\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '使用 asyncio.wait_for 为协程设置超时，或在应用层实现限时逻辑以保证可恢复性。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1750,
    117,
    '性能测量（填空）',
    '评估 asyncio 性能时应关注哪些指标？',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"吞吐量、延迟、事件循环延迟、内存占用\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '关注吞吐、响应延迟、事件循环延迟（loop lag）以及内存/句柄使用情况。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1751,
    117,
    '事件循环延迟',
    '事件循环延迟（loop lag）通常由什么引起？',
    JSON_OBJECT('A', '某个协程长时间运行或阻塞', 'B', '协程过短', 'C', '内存太小', 'D', 'CPU 超频'),
    1,
    JSON_ARRAY('提示1：长时间同步计算或阻塞 I/O 会阻塞循环', '提示2: 检测 loop delay 有助定位问题', '提示3: 使用工具监控'),
    '长时间执行的任务会占用事件循环时间片，导致延迟升高，应拆分或放到 executor。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1752,
    117,
    '异步数据库驱动',
    '使用异步数据库驱动（如 asyncpg）相对于同步驱动的主要好处是？',
    JSON_OBJECT('A', '避免阻塞事件循环，可提高并发连接数', 'B', '自动加速查询', 'C', '降低数据库负载', 'D', '不需要连接池'),
    1,
    JSON_ARRAY('提示1：异步驱动在等待 I/O 时不会阻塞事件循环', '提示2: 需要配合连接池使用', '提示3: 有助于高并发场景'),
    '异步驱动在等待数据库响应时不会阻塞事件循环，可提升单进程的并发能力。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1753,
    117,
    '最佳实践',
    '在设计高并发 asyncio 服务时，优先考虑的设计点是？',
    JSON_OBJECT('A', '限流、超时、资源隔离与监控', 'B', '尽量不加限流', 'C', '忽略超时', 'D', '把所有阻塞都放在协程内'),
    1,
    JSON_ARRAY('提示1：控制并发量防止资源枯竭', '提示2: 超时防止单个请求拖垮系统', '提示3: 监控事件循环与任务'),
    '限流、超时、隔离与监控是保证 asyncio 服务稳定性的关键要素。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1754,
    117,
    '回收任务（填空）',
    '未取消或未回收的协程任务会导致什么问题？',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"资源泄露或内存持续增长\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    '未取消的任务或未处理的异常会导致资源泄露，应显式取消并处理异常。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1755,
    117,
    '总结（填空）',
    'asyncio 最适合解决哪类问题？',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"大量并发 I/O、短时任务与低内存占用场景\\")"}]}]}',
    NULL,
    JSON_ARRAY(0),
    'asyncio 适合大量并发 I/O 操作和流式处理场景，但需避免阻塞调用。',
    ''
);