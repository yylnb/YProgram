USE `questions`;
-- Unit 137 | Start ID: 2041
-- Generated at 2025-12-25 17:41:15

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2041,
    137,
    '协程定义',
    '在 asyncio 中，协程通常由什么定义？',
    JSON_OBJECT('A', 'async def 函数', 'B', '普通 def 函数', 'C', '线程函数', 'D', 'lambda'),
    1,
    JSON_ARRAY('提示1: 使用 async 关键字定义', '提示2: 返回协程对象', '提示3: 需要 await 来运行内部异步操作'),
    'async def 定义的函数在调用时返回协程对象，需要事件循环驱动。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2042,
    137,
    'await 用途',
    '在协程中使用 await 的作用是？',
    JSON_OBJECT('A', '挂起当前协程并等待可等待对象完成', 'B', '阻塞整个线程', 'C', '创建新线程', 'D', '终止程序'),
    1,
    JSON_ARRAY('提示1: await 用于等待 Future 或协程', '提示2: 非阻塞地交出执行权', '提示3: 必须在 async 函数内使用'),
    'await 会挂起协程并让出执行权，直到被等待对象完成再继续。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2043,
    137,
    '事件循环',
    '要运行顶层协程并获取结果，常用哪个函数？',
    JSON_OBJECT('A', 'asyncio.run', 'B', 'loop.run_forever', 'C', 'threading.run', 'D', 'multiprocessing.run'),
    1,
    JSON_ARRAY('提示1: asyncio.run 创建并管理事件循环', '提示2: 适合运行顶层协程一次性执行', '提示3: 在现有事件循环中不应调用 asyncio.run'),
    'asyncio.run 是运行单个顶层协程并返回其结果的简便入口。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2044,
    137,
    '并发启动协程（填空）',
    '若需并发等待多个协程完成可使用 asyncio.__1__。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import asyncio"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "results = asyncio."}, {"type": "slot", "index": 0}, {"type": "code", "value": "([coro1, coro2])"}]}]}',
    JSON_ARRAY('gather', 'sleep', 'run', 'wait'),
    JSON_ARRAY(1),
    'asyncio.gather 可并发运行多个协程并收集结果。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2045,
    137,
    '非阻塞睡眠（填空）',
    '在协程中暂停但不阻塞事件循环应使用 asyncio.__1__(seconds)。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "await asyncio."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(1)"}]}]}',
    JSON_ARRAY('sleep', 'pause', 'wait', 'delay'),
    JSON_ARRAY(1),
    'asyncio.sleep 是非阻塞的协程友好休眠函数。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2046,
    137,
    '异步 I/O 优势',
    '相较线程模型，asyncio 的优点是？',
    JSON_OBJECT('A', '极低的上下文切换开销，适合大量并发连接', 'B', '自动使用多核 CPU', 'C', '不需考虑同步问题', 'D', '替代数据库索引'),
    1,
    JSON_ARRAY('提示1: 协程切换成本低', '提示2: 需配合异步库使用', '提示3: 对 CPU 密集任务帮助有限'),
    'asyncio 的协程切换轻量，适合高并发 I/O 场景。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2047,
    137,
    '阻塞调用注意',
    '在异步代码中直接调用阻塞函数会如何？',
    JSON_OBJECT('A', '阻塞事件循环导致性能退化', 'B', '自动转为协程', 'C', '抛出异常', 'D', '无影响'),
    1,
    JSON_ARRAY('提示1: 阻塞操作会阻塞整个事件循环', '提示2: 可用 run_in_executor 移到线程池', '提示3: 推荐使用异步库替代阻塞调用'),
    '阻塞调用会阻塞事件循环，需用线程/进程池或异步替代方法避免。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2048,
    137,
    'run_in_executor',
    'asyncio.get_event_loop().run_in_executor 用于？',
    JSON_OBJECT('A', '在后台线程或进程中运行阻塞函数', 'B', '在事件循环内并发运行协程', 'C', '替代 asyncio.gather', 'D', '自动序列化对象'),
    1,
    JSON_ARRAY('提示1: 将阻塞调用委托到线程池', '提示2: 返回 Future 可 await', '提示3: 适合与已有阻塞库集成'),
    'run_in_executor 将阻塞函数移到线程/进程池以避免阻塞事件循环。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2049,
    137,
    '异步上下文（填空）',
    '支持异步上下文管理的魔法方法为 __1__ 与 __2__。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    async def "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(self): pass"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    async def "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(self, exc): pass"}]}]}',
    JSON_ARRAY('__aenter__', '__aexit__', '__enter__', '__exit__'),
    JSON_ARRAY(1, 2),
    '异步上下文管理器实现 __aenter__ 和 __aexit__，可用于 async with。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2050,
    137,
    '取消协程（填空）',
    '要取消一个正在运行的 Task，可调用 task.__1__().',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "t = asyncio.create_task(coro)"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('cancel', 'stop', 'kill', 'close'),
    JSON_ARRAY(1),
    'Task.cancel() 用于请求取消协程任务，需在协程内处理 CancelledError。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2051,
    137,
    '创建任务',
    '在事件循环中创建后台任务常用哪个函数？',
    JSON_OBJECT('A', 'asyncio.create_task', 'B', 'threading.Thread', 'C', 'multiprocessing.Process', 'D', 'os.fork'),
    1,
    JSON_ARRAY('提示1: create_task 返回 Task 对象', '提示2: 可与 await 搭配管理', '提示3: 适用于 Python3.7+'),
    'asyncio.create_task 用于并发调度协程并返回可管理的 Task。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2052,
    137,
    '异常传播',
    '如果 gather 中某个协程抛出异常，默认行为是？',
    JSON_OBJECT('A', 'gather 会将异常传播，且其他协程可能被取消（取决于参数）', 'B', '忽略异常继续返回 None', 'C', '自动重试失败协程', 'D', '将异常写入日志但不抛出'),
    1,
    JSON_ARRAY('提示1: 参数 return_exceptions 可影响行为', '提示2: 异常会在 await gather 时抛出', '提示3: 需显式处理失败情况'),
    'gather 默认会在 await 时抛出第一个异常，可通过 return_exceptions 控制返回行为。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2053,
    137,
    '事件循环获取（填空）',
    '在协程内部获取当前事件循环应使用 asyncio.__1__().',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "loop = asyncio."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}]}',
    JSON_ARRAY('get_running_loop', 'get_event_loop', 'run', 'new_event_loop'),
    JSON_ARRAY(1),
    '在协程内应使用 get_running_loop() 获取当前正在运行的事件循环。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2054,
    137,
    '超时控制（填空）',
    '要为协程添加超时，可使用 asyncio.__1__(coro, timeout).',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import asyncio"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "await asyncio."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(coro, 5)"}]}]}',
    JSON_ARRAY('wait_for', 'sleep', 'gather', 'shield'),
    JSON_ARRAY(1),
    'asyncio.wait_for 可设置超时并在超时抛出 TimeoutError。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2055,
    137,
    '总结（填空）',
    'asyncio 适合 __1__ 场景，需避免直接运行 __2__ 函数。',
    NULL,
    NULL,
    '{"segments": []}',
    JSON_ARRAY('I/O 密集型', '阻塞', 'CPU 密集型', '并行计算'),
    JSON_ARRAY(1, 2),
    'asyncio 适合 I/O 密集型场景，应避免直接调用阻塞函数，或将其移到 executor。',
    ''
);