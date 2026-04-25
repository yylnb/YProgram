USE `questions`;
-- Unit 136 | Start ID: 2026
-- Generated at 2025-12-24 23:40:28

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2026, 
    136, 
    '线程与进程区别', 
    '下列关于线程与进程的描述，哪项正确？', 
    JSON_OBJECT('A', '进程拥有独立内存空间，线程共享进程内存', 'B', '线程更重量级于进程', 'C', '线程无法并发', 'D', '进程共享栈'), 
    1, 
    JSON_ARRAY('提示1: 进程隔离内存', '提示2: 线程共享堆内存', '提示3: 线程切换开销较小'), 
    '进程有独立内存，线程在同一进程内共享内存，适合轻量并发。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2027, 
    136, 
    'GIL 的影响', 
    'Python 中 GIL（全局解释器锁）会导致什么？', 
    JSON_OBJECT('A', '限制 CPU 密集型线程的并行执行', 'B', '禁止任何多线程', 'C', '提高多线程 CPU 利用率', 'D', '与多进程无关'), 
    1, 
    JSON_ARRAY('提示1: GIL 影响多线程的 CPU 并行', '提示2: I/O 密集型受益于线程', '提示3: 可用多进程绕过 GIL'), 
    'GIL 限制了同一时刻只有一个线程执行 Python 字节码，影响 CPU 密集型任务。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2028, 
    136, 
    'multiprocessing 何时用', 
    '在何种场景下推荐使用 multiprocessing？', 
    JSON_OBJECT('A', 'CPU 密集型任务以利用多核', 'B', '仅用于 I/O 密集型', 'C', '禁止在 Windows 上使用', 'D', '替代所有线程使用'), 
    1, 
    JSON_ARRAY('提示1: 多进程可绕过 GIL', '提示2: 进程间通信成本较高', '提示3: 适合并行计算'), 
    'multiprocessing 可启动多个进程并利用多核 CPU，适合 CPU 密集型任务。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2029,
    136,
    '线程同步（填空）',
    '在多线程中保护共享资源常用 __1__（互斥锁）。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from threading import Lock"}, {"type": "code_line", "value": "lock = Lock()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "with lock:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    "}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('lock.acquire()', 'lock.release()', 'lock', 'lock.wait()'),
    JSON_ARRAY(1, 2),
    '使用 Lock 的 acquire/release 或上下文管理确保互斥访问，共享资源不会被并发破坏。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2030,
    136,
    '进程间通信（填空）',
    'multiprocessing 提供 Pipe 和 __1__ 用于进程间通信。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from multiprocessing import Queue"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "q = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}]}',
    JSON_ARRAY('Queue', 'Lock', 'Event', 'Thread'),
    JSON_ARRAY(1),
    'multiprocessing.Queue 用于在进程间安全传递数据。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2031, 
    136, 
    '线程守护（daemon）', 
    '将线程设为守护线程的效果是？', 
    JSON_OBJECT('A', '主线程退出时守护线程会被强制结束', 'B', '守护线程运行优先于主线程', 'C', '守护线程不可被创建', 'D', '守护线程不使用 CPU'), 
    1, 
    JSON_ARRAY('提示1: daemon 线程随主线程结束', '提示2: 适合后台任务', '提示3: 注意资源清理'), 
    '守护线程会在主线程退出时被终止，不适合需要优雅停止的任务。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2032, 
    136, 
    'concurrent.futures 用途', 
    'concurrent.futures 提供的 ThreadPoolExecutor 与 ProcessPoolExecutor 用于？', 
    JSON_OBJECT('A', '简化线程/进程池的提交与管理', 'B', '替换 asyncio', 'C', '只能在 Linux 使用', 'D', '用于图形界面'), 
    1, 
    JSON_ARRAY('提示1: 提供 submit 和 map 接口', '提示2: 方便管理并发任务', '提示3: 自动处理结果获取'), 
    'concurrent.futures 封装线程/进程池，简化并发任务提交与结果处理。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2033, 
    136, 
    '死锁', 
    '哪种情形可能导致死锁？', 
    JSON_OBJECT('A', '两个线程互相等待对方持有的锁', 'B', '单线程执行 I/O', 'C', '仅使用局部变量', 'D', '使用 with 语句'), 
    1, 
    JSON_ARRAY('提示1: 避免锁的交叉获取', '提示2: 按固定顺序获取多个锁可降低风险', '提示3: 使用超时或尝试锁机制'), 
    '死锁通常因不同线程按不同顺序持有并等待对方的锁导致。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2034,
    136,
    '线程安全集合（填空）',
    '队列模块提供线程安全的 __1__ 能用于线程间通讯。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from queue import Queue"}, {"type": "code_line", "value": "q = Queue()"}, {"type": "code_line", "value": "q.put(1)"}]}]}',
    JSON_ARRAY('Queue', 'dict', 'list', 'set'),
    JSON_ARRAY(1),
    'queue.Queue 是线程安全的队列，常用于线程间传递任务或数据。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2035,
    136,
    '进程池示例（填空）',
    '使用 ProcessPoolExecutor 提交任务可调用 executor.__1__(fn, *args)。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from concurrent.futures import ProcessPoolExecutor"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "with ProcessPoolExecutor() as executor:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    future = executor."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(func, 1)"}]}]}',
    JSON_ARRAY('submit', 'map', 'run', 'start'),
    JSON_ARRAY(1),
    'submit 用于提交单个可调用并返回 Future 对象。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2036, 
    136, 
    '线程模型选择', 
    '对于大量 I/O 小任务，哪种并发模型常更高效？', 
    JSON_OBJECT('A', '线程或异步 I/O', 'B', '多进程一定更好', 'C', '只有单线程可用', 'D', '使用数据库代替并发'), 
    1, 
    JSON_ARRAY('提示1: I/O 可以释放 GIL', '提示2: asyncio 对大量连接友好', '提示3: 线程实现简单'), 
    'I/O 密集型任务适合线程或异步模型来提高吞吐量。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2037, 
    136, 
    'asyncio 适用场景', 
    'asyncio 最适合哪类任务？', 
    JSON_OBJECT('A', '大量并发 I/O（例如网络）', 'B', 'CPU 密集型计算', 'C', '替代数据库事务', 'D', '管理操作系统进程'), 
    1, 
    JSON_ARRAY('提示1: 协程轻量且切换开销小', '提示2: 需要使用异步库配合', '提示3: 不适用于 CPU 密集任务'), 
    'asyncio 适合高并发 I/O 场景，如网络连接与异步处理。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2038,
    136,
    '线程启动（填空）',
    '创建并启动线程常写 t = Thread(target=fn); __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from threading import Thread"}, {"type": "code_line", "value": "t = Thread(target=fn)"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('t.start()', 't.run()', 't.join()', 't.create()'),
    JSON_ARRAY(1),
    '调用 t.start() 启动线程并创建新的执行流，t.run() 只是直接调用目标函数。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2039,
    136,
    '线程等待（填空）',
    '要等待线程结束应调用 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "t.start()"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('t.join()', 't.wait()', 't.stop()', 't.terminate()'),
    JSON_ARRAY(1),
    't.join() 会阻塞直到线程执行结束。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2040,
    136,
    '总结（填空）',
    'CPU 密集型选用 __1__，I/O 密集型可选 __2__ 或 __3__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('multiprocessing', 'threading', 'asyncio', 'socket'),
    JSON_ARRAY(1, 2, 3),
    'CPU 密集型使用多进程，I/O 密集型可使用线程或异步 I/O。',
    ''
);