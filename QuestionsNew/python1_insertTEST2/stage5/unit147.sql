USE `questions`;
-- Unit 147 | Start ID: 2191
-- Generated at 2025-12-24 23:42:47

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2191, 
    147, 
    'GIL 概念', 
    'CPython 中的 GIL 是什么？', 
    JSON_OBJECT('A', '全局解释器锁，限制同一时刻只有一个线程执行 Python 字节码', 'B', '垃圾回收机制', 'C', '线程池实现', 'D', '协程调度器'), 
    1, 
    JSON_ARRAY('提示1：GIL 影响 CPU 密集型多线程', '提示2：I/O 密集型仍可受益于线程'), 
    'GIL 使得多线程在 CPU 密集型任务下不能并行执行 Python 字节码。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2192, 
    147, 
    '多进程模块', 
    '在 Python 中用于多进程编程的标准库是？', 
    JSON_OBJECT('A', 'multiprocessing', 'B', 'threading', 'C', 'asyncio', 'D', 'concurrent.futures'), 
    1, 
    JSON_ARRAY('提示1：multiprocessing 提供独立进程并规避 GIL', '提示2：也可使用 concurrent.futures.ProcessPoolExecutor'), 
    'multiprocessing 提供进程式并行，避免 GIL 限制适合 CPU 密集型任务。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2193, 
    147, 
    '进程间通信', 
    '下列哪种不是进程间通信（IPC）方式？', 
    JSON_OBJECT('A', 'shared memory, pipes, queues', 'B', 'sockets', 'C', 'global variables in same process', 'D', 'files'), 
    3, 
    JSON_ARRAY('提示1：全局变量不能跨进程共享'), 
    '跨进程不能直接共享同一进程的全局变量，需要 IPC 机制。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2194,
    147,
    '线程同步（填空）',
    'threading 模块中的 Lock 对象常用于 __1__ 线程对共享变量的访问。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('保护', '加速', '隔离', '删除'),
    JSON_ARRAY(1),
    'Lock 用于同步，避免竞态条件。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2195,
    147,
    '线程池（填空）',
    'concurrent.futures 模块中创建线程池使用 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('ThreadPoolExecutor', 'ProcessPoolExecutor', 'Pool', 'PoolExecutor'),
    JSON_ARRAY(1),
    'ThreadPoolExecutor 用于管理线程池并提交任务。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2196, 
    147, 
    '守护线程', 
    '守护线程（daemon）在主线程结束时如何表现？', 
    JSON_OBJECT('A', '会随主线程一起退出', 'B', '保持运行直到手动结束', 'C', '自动提升为非守护', 'D', '转换为进程'), 
    1, 
    JSON_ARRAY('提示1：daemon=True 表示随主线程结束'), 
    '守护线程不会阻止程序退出，会随主线程一同结束。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2197, 
    147, 
    '竞态条件', 
    '竞态条件通常是由什么导致的？', 
    JSON_OBJECT('A', '多个执行单位并发访问共享可变状态', 'B', '单线程程序', 'C', '缺少函数注释', 'D', '循环嵌套'), 
    1, 
    JSON_ARRAY('提示1：使用锁或队列可避免'), 
    '并发访问共享可变状态若无同步会导致竞态条件。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2198, 
    147, 
    '进程启动方式', 
    'multiprocessing 在 Windows 上默认使用哪种启动方式？', 
    JSON_OBJECT('A', 'spawn', 'B', 'fork', 'C', 'forkserver', 'D', 'exec'), 
    1, 
    JSON_ARRAY('提示1：Windows 不支持 fork', '提示2：spawn 会导入主模块'), 
    'Windows 使用 spawn 启动新进程，因此要保护入口点。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2199,
    147,
    '进程池（填空）',
    '使用 multiprocessing.Pool.apply_async 可实现异步提交任务并通过 __1__ 获取结果。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('get', 'result', 'fetch', 'join'),
    JSON_ARRAY(1),
    'apply_async 返回 AsyncResult，调用 get() 获取返回值。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2200,
    147,
    'IPC 队列（填空）',
    'multiprocessing 提供 __1__ 对象在进程间传递数据。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('Queue', 'Lock', 'Pipe', 'Manager'),
    JSON_ARRAY(1),
    'multiprocessing.Queue 可跨进程传递序列化的数据。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2201, 
    147, 
    '并发选择', 
    '对于 I/O 密集型任务哪个并发模型更合适？', 
    JSON_OBJECT('A', '线程或异步（asyncio）', 'B', '多进程', 'C', '单线程阻塞', 'D', '不适合并发'), 
    1, 
    JSON_ARRAY('提示1：I/O 密集型不受 GIL 限制明显影响', '提示2：异步可进一步降低线程开销'), 
    'I/O 密集型常用线程或异步以充分利用等待时间。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2202, 
    147, 
    '最佳实践', 
    '在并发程序中，关于共享状态的处理最佳实践是？', 
    JSON_OBJECT('A', '尽量避免共享状态，使用消息传递', 'B', '任意共享并依赖 GC', 'C', '使用全局变量', 'D', '随意使用线程'), 
    1, 
    JSON_ARRAY('提示1：消息传递可降低竞争', '提示2：不可变对象更安全'), 
    '尽量无共享或使用消息/队列设计可以提高并发安全性。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2203,
    147,
    '锁的上下文（填空）',
    '推荐使用 with lock: 来自动获取和释放 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('锁', '条件', '事件', '信号量'),
    JSON_ARRAY(1),
    'with lock 可以自动 acquire/release，简化同步代码。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2204,
    147,
    '死锁（填空）',
    '死锁通常由多个线程相互等待对方释放 __1__ 导致。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('资源', '变量', '函数', '模块'),
    JSON_ARRAY(1),
    '相互持有并等待资源释放会导致死锁。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2205,
    147,
    '总结（填空）',
    '选择并发模型应根据任务类型（__1__ 或 CPU 密集）来决定。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('I/O', '内存', '网络', '存储'),
    JSON_ARRAY(1),
    '根据任务是 I/O 密集还是 CPU 密集选择线程/异步或多进程。',
    ''
);