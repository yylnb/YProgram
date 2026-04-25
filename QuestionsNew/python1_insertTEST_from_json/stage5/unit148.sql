USE `questions`;
-- Unit 148 | Start ID: 2206
-- Generated at 2025-12-25 17:41:15

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2206,
    148,
    'async/await',
    '在 Python 中声明异步函数使用哪个关键字？',
    JSON_OBJECT('A', 'async def', 'B', 'def async', 'C', 'await def', 'D', 'async function'),
    1,
    JSON_ARRAY('提示1：async def 定义协程函数', '提示2：await 在协程中等待'),
    '使用 async def 定义协程，内部可使用 await 等待异步操作。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2207,
    148,
    '事件循环',
    'asyncio 的核心组件是？',
    JSON_OBJECT('A', '事件循环 (event loop)', 'B', '线程池', 'C', '进程池', 'D', '消息队列'),
    1,
    JSON_ARRAY('提示1：事件循环调度协程执行'),
    '事件循环负责调度协程、处理 I/O 与回调。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2208,
    148,
    '并发任务',
    '并行运行多个协程并等待所有完成可使用哪个函数？',
    JSON_OBJECT('A', 'asyncio.gather', 'B', 'asyncio.wait_for', 'C', 'asyncio.sleep', 'D', 'asyncio.open'),
    1,
    JSON_ARRAY('提示1：gather 聚合多个协程', '提示2：wait 提供超时控制'),
    'asyncio.gather 可并发运行传入的协程并返回聚合结果。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2209,
    148,
    '运行协程（填空）',
    '在脚本中运行顶层协程常用 asyncio.__1__() 方法。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "asyncio."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}]}',
    JSON_ARRAY('run', 'start', 'execute', 'loop'),
    JSON_ARRAY(1),
    'asyncio.run(coro()) 用于执行顶层协程并管理事件循环。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2210,
    148,
    'IO 阻塞（填空）',
    '在异步环境中要避免调用会阻塞事件循环的函数，可通过 __1__ 在线程池中运行阻塞代码。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('loop.run_in_executor', 'threading.Thread', 'multiprocessing.Process', 'subprocess.run'),
    JSON_ARRAY(1),
    'loop.run_in_executor 可以把阻塞调用委托到线程池或进程池中，避免阻塞事件循环。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2211,
    148,
    '异步上下文管理',
    '支持异步上下文管理的语法是什么？',
    JSON_OBJECT('A', 'async with', 'B', 'with async', 'C', 'await with', 'D', 'with await'),
    1,
    JSON_ARRAY('提示1：async with 可用于异步资源管理'),
    '使用 async with 管理需异步进入/退出的资源。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2212,
    148,
    '异步 HTTP',
    '常用的异步 HTTP 客户端库是？',
    JSON_OBJECT('A', 'aiohttp', 'B', 'requests', 'C', 'urllib', 'D', 'http.client'),
    1,
    JSON_ARRAY('提示1：aiohttp 支持异步会话和服务端'),
    'aiohttp 提供客户端和服务端的异步 HTTP 支持。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2213,
    148,
    '协程与生成器',
    '协程与生成器的一个关键区别是协程可以使用哪个关键字暂停等待结果？',
    JSON_OBJECT('A', 'await', 'B', 'yield', 'C', 'yield from', 'D', 'send'),
    1,
    JSON_ARRAY('提示1：await 在协程内使用', '提示2：yield 用于生成器'),
    'await 用于等待异步操作的结果，yield 是生成器产出值的机制。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2214,
    148,
    '超时控制（填空）',
    'asyncio.wait_for 可用于给协程设置 __1__。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "asyncio.wait_for 可用于给协程设置 "}, {"type": "slot", "index": 0}, {"type": "code", "value": "。"}]}]}',
    JSON_ARRAY('超时', '并发', '重试', '优先级'),
    JSON_ARRAY(1),
    'wait_for 可在指定秒数内等待协程完成，超时则抛出异常。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2215,
    148,
    '取消任务（填空）',
    '可以调用 task.__1__() 来取消一个正在运行的任务对象。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "task."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}]}',
    JSON_ARRAY('cancel', 'stop', 'terminate', 'kill'),
    JSON_ARRAY(1),
    'task.cancel() 请求取消任务，任务需处理 CancelledError',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2216,
    148,
    '回调与协程',
    '在 asyncio 中，回调通常通过哪个机制调度？',
    JSON_OBJECT('A', '事件循环的 call_soon/call_later', 'B', '线程池直接调用', 'C', '操作系统中断', 'D', 'multiprocessing'),
    1,
    JSON_ARRAY('提示1：call_soon 在下一个循环迭代调度回调'),
    '事件循环提供 call_soon/call_later 等接口调度回调函数。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2217,
    148,
    '适用场景',
    '异步编程更适合哪类任务？',
    JSON_OBJECT('A', '大量 I/O 操作且单线程可处理', 'B', 'CPU 密集型计算', 'C', '需要进程隔离', 'D', '必须使用数据库事务'),
    1,
    JSON_ARRAY('提示1：异步适合高并发 I/O'),
    '异步适合处理大量并发 I/O，如网络请求、文件 I/O（若支持异步）等。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2218,
    148,
    '并发限制（填空）',
    '可以使用 asyncio.__1__ 控制同时运行的协程数量（信号量）。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "asyncio."}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('Semaphore', 'Lock', 'Event', 'Queue'),
    JSON_ARRAY(1),
    'Semaphore 可用于限制并发协程数量以控制资源消耗。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2219,
    148,
    '阻塞检测（填空）',
    '若协程中有阻塞操作会导致 __1__，应替换为异步或移到线程池。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "若协程中有阻塞操作会导致 "}, {"type": "slot", "index": 0}, {"type": "code", "value": "，应替换为异步或移到线程池。"}]}]}',
    JSON_ARRAY('事件循环阻塞', '并行', '加速', '内存泄漏'),
    JSON_ARRAY(1),
    '阻塞操作会阻塞事件循环，影响其他协程执行。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2220,
    148,
    '总结（填空）',
    '使用 asyncio 时应尽量避免阻塞，并合理使用 __1__ 与线程池执行阻塞代码。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "使用 asyncio 时应尽量避免阻塞，并合理使用 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 与线程池执行阻塞代码。"}]}]}',
    JSON_ARRAY('run_in_executor', 'join', 'sleep', 'yield'),
    JSON_ARRAY(1),
    'run_in_executor 可将阻塞调用委托到线程/进程池，保护事件循环。',
    ''
);