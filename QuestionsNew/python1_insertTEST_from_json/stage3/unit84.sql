USE `questions`;
-- Unit 84 | Start ID: 1246
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1246,
    84,
    '线程 vs 进程',
    '对于 CPU 密集型循环任务通常推荐？',
    JSON_OBJECT('A', '多进程', 'B', '多线程', 'C', '单线程就够', 'D', '协程'),
    1,
    JSON_ARRAY('GIL 限制多线程 CPU 并行', '多进程可并行利用多核'),
    'Python 的 GIL 导致多线程在 CPU 密集型任务中受限，多进程更能利用多核。',
    'multiprocessing.Pool'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1247,
    84,
    '协程优势',
    '协程（asyncio）在循环处理中适合？',
    JSON_OBJECT('A', 'IO 密集型并发任务', 'B', 'CPU 密集型计算', 'C', '无法并发', 'D', '替代多进程'),
    1,
    JSON_ARRAY('协程适合大量 IO 等待的场景'),
    'asyncio 在大量 IO 等待时能高效调度协程，减少线程/进程开销。',
    'await asyncio.sleep(1)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1248,
    84,
    '线程安全',
    '当多个线程在循环中修改同一变量时应使用？',
    JSON_OBJECT('A', '锁（Lock）', 'B', '不需任何保护', 'C', '只用 print', 'D', 'assert'),
    1,
    JSON_ARRAY('使用锁保护共享资源避免竞态'),
    '对共享可变状态需要使用同步原语如 Lock 以避免竞态条件。',
    'with lock: counter += 1'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1249,
    84,
    '进程池 map',
    '补全：用进程池并行处理并返回结果。',
    JSON_ARRAY('1 2 3'),
    JSON_ARRAY('[2,4,6]'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from multiprocessing import Pool"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "def f(x): return x*2"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "with Pool() as p:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(p.map(f, list(map(int,input().split()))))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'Pool.map 可并行运行函数并收集结果。',
    'Pool().map(func, data)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1250,
    84,
    '协程示例',
    '补全：简单 asyncio 并发运行两任务。',
    NULL,
    JSON_ARRAY('(none)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import asyncio"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "async def t(n):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    await asyncio.sleep(0)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    return n"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(asyncio.run(asyncio.gather(t(1), t(2))))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'asyncio.gather 可并发运行协程并收集结果。',
    'asyncio.run(gather(...))'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1251,
    84,
    'I/O 密集型',
    '大量网络请求循环中优先使用？',
    JSON_OBJECT('A', '异步/线程池', 'B', '多进程', 'C', '纯阻塞调用', 'D', '不建议并发'),
    1,
    JSON_ARRAY('IO 密集型适合协程或线程池并发'),
    '网络 IO 等待时间长，使用异步或线程池能提高吞吐量。',
    'use aiohttp or ThreadPoolExecutor'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1252,
    84,
    '共享数据设计',
    '并发循环中共享数据最安全的模式是？',
    JSON_OBJECT('A', '使用队列传递数据', 'B', '直接共享全局变量', 'C', '每线程写同一列表', 'D', '不管理'),
    1,
    JSON_ARRAY('队列提供线程/进程安全的数据交换'),
    '使用 Queue 或 multiprocessing.Queue 在并发环境中安全传递数据。',
    'from queue import Queue'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1253,
    84,
    '进程开销',
    '相比线程，进程的劣势通常是？',
    JSON_OBJECT('A', '启动开销与内存开销更大', 'B', '更快启动', 'C', '更低内存', 'D', '无差别'),
    1,
    JSON_ARRAY('进程需要复制或独立内存空间'),
    '进程隔离带来更高的资源开销，但提供更好的独立性与 CPU 并行。',
    'multiprocessing vs threading'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1254,
    84,
    '用线程池',
    '补全：用 ThreadPoolExecutor 并发执行函数并打印结果。',
    JSON_ARRAY('1 2 3'),
    JSON_ARRAY('(results)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from concurrent.futures import ThreadPoolExecutor"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "def f(x): return x*2"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "with ThreadPoolExecutor() as e:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(list(e.map(f, map(int,input().split()))))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'ThreadPoolExecutor.map 可并发执行并返回结果生成器。',
    'executor.map(fn, data)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1255,
    84,
    '避免共享状态',
    '补全：尽量避免在线程间共享可变数据，示例用队列传递任务。',
    NULL,
    JSON_ARRAY('(none)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from queue import Queue"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "q=Queue()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "q.put(1)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(q.get())"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '队列提供线程安全的生产/消费模型，减少共享状态问题。',
    'q.put(item)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1256,
    84,
    'GIL 影响',
    'GIL 对多线程的影响是？',
    JSON_OBJECT('A', '限制 Python 线程的 CPU 并行性', 'B', '完全无影响', 'C', '使多线程更快', 'D', '只影响 I/O'),
    1,
    JSON_ARRAY('GIL 主要影响 CPU 密集型代码'),
    'GIL 导致 Python 多线程在 CPU 密集型任务上不能同时利用多核。',
    'use multiprocessing for CPU work'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1257,
    84,
    '协程与回调',
    'async/await 与回调风格相比的优势？',
    JSON_OBJECT('A', '更直观的顺序代码风格', 'B', '更复杂', 'C', '性能更差', 'D', '不可组合'),
    1,
    JSON_ARRAY('async/await 写法更接近同步逻辑'),
    'async/await 提供更直观的异步控制流，避免复杂回调地狱。',
    'async def main():'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1258,
    84,
    '并发调试',
    '并发程序调试困难，常用手段是？',
    JSON_OBJECT('A', '添加日志与重现最小场景', 'B', '不调试', 'C', '使用 print 取代日志', 'D', '仅重启服务'),
    1,
    JSON_ARRAY('日志和可重复的最小重现有助定位并发问题'),
    '通过详尽日志并构建可重复的测试场景有助调试并发问题。',
    'add contextual logs'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1259,
    84,
    '进程间通信',
    '补全：使用 multiprocessing.Queue 在父进程获取子进程结果。',
    NULL,
    JSON_ARRAY('(none)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from multiprocessing import Process, Queue"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "q=Queue()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "def f(q): q.put(1)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "p=Process(target=f,args=(q,))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "p.start()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(q.get())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "p.join()"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'multiprocessing.Queue 用于进程间安全通信。',
    'q.put(x) and q.get()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1260,
    84,
    '并发安全写文件',
    '补全：多个线程写同一文件时应如何保证安全？',
    NULL,
    JSON_ARRAY('(none)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from threading import Lock"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lock=Lock()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "with open(\\"out.txt\\",\\"a\\") as f:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    with lock:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        f.write(\\"data\\\\n\\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用锁保护写文件的临界区以避免数据混杂。',
    'with lock: f.write(...)'
);