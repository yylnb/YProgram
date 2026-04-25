USE `questions`;
-- Unit 118 | Start ID: 1756
-- Generated at 2025-12-24 18:17:24

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1756, 
    118, 
    '进程隔离', 
    '多进程相比多线程的一个主要优点是？', 
    JSON_OBJECT('A', '进程间内存隔离，崩溃互不影响', 'B', '进程更轻量', 'C', '无序执行', 'D', '自动共享内存'), 
    1, 
    JSON_ARRAY('提示1：进程拥有独立内存空间', '提示2: 一个进程崩溃不会直接破坏其它进程', '提示3: 进程间通信需显式实现'), 
    '多进程通过独立地址空间隔离故障，但会带来更高的内存和 IPC 成本。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1757, 
    118, 
    '通信开销', 
    '以下哪项通常导致多进程方案相比多线程更高的开销？', 
    JSON_OBJECT('A', '进程间通信（序列化/复制）', 'B', '线程上下文切换', 'C', '线程栈大小', 'D', '全局变量'), 
    1, 
    JSON_ARRAY('提示1：IPC 需要序列化/复制数据', '提示2: 大对象传输成本高', '提示3: 共享内存可减轻此问题'), 
    '进程间通信通常涉及数据序列化与复制，带来较高延迟与内存开销。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1758, 
    118, 
    '启动开销', 
    '相比创建线程，创建新进程通常如何？', 
    JSON_OBJECT('A', '启动开销更大，消耗更多内存', 'B', '更快', 'C', '相同', 'D', '更节省资源'), 
    1, 
    JSON_ARRAY('提示1：进程需复制或重新加载解释器', '提示2: 进程数量多时内存占用显著', '提示3: 使用进程池可复用进程'), 
    '创建进程会启动独立解释器，带来更高的时间和内存开销，进程池能减少频繁创建销毁成本。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1759, 
    118, 
    '进程池优势', 
    '使用进程池（ProcessPoolExecutor）时的优势是？', 
    JSON_OBJECT('A', '复用进程减少创建销毁开销', 'B', '自动共享大对象', 'C', '不需要序列化', 'D', '节省内存'), 
    1, 
    JSON_ARRAY('提示1：进程池预先启动工作进程', '提示2: 避免频繁创建进程开销', '提示3: 仍需考虑 IPC 成本'), 
    '进程池通过复用进程降低了频繁创建的成本，但传输数据仍需序列化。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1760, 
    118, 
    '信号与进程', 
    '在多进程程序中使用信号处理需注意？', 
    JSON_OBJECT('A', '信号处理通常发生在主进程，子进程行为可能不同', 'B', '信号会广播到所有进程并相同处理', 'C', '子进程无法接收信号', 'D', '信号用于线程间通信'), 
    1, 
    JSON_ARRAY('提示1：不同平台对信号的处理不同', '提示2: 在子进程中需小心注册处理器', '提示3: 常在主进程集中管理'), 
    '信号处理需要谨慎设计，通常在主进程处理并向子进程传达控制信息。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1761, 
    118, 
    '序列化成本', 
    '在进程间传输复杂对象时，主要性能瓶颈通常是？', 
    JSON_OBJECT('A', '序列化/反序列化与数据复制', 'B', '函数调用开销', 'C', '线程锁竞争', 'D', '内存不足与 CPU 无关'), 
    1, 
    JSON_ARRAY('提示1: \'pickle 等序列化库会消耗 CPU\'', '提示2: 大对象复制代价高', '提示3: 使用共享内存可减少复制'), 
    '序列化与拷贝是进程间传输大对象的主要性能开销。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1762, 
    118, 
    '混合策略', 
    '在复杂应用中常见的并发策略是？', 
    JSON_OBJECT('A', '异步 I/O + 进程池/线程池 混合使用', 'B', '只使用多线程', 'C', '只使用多进程', 'D', '禁止并发'), 
    1, 
    JSON_ARRAY('提示1: \'组合不同模型发挥各自优势\'', '提示2: \'例如 asyncio 负责 I/O，进程池处理 CPU 任务\'', '提示3: \'需关注边界与数据传递\''), 
    '混合方案能兼顾 I/O 并发与 CPU 并行，适合复杂生产环境。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1763, 
    118, 
    '序列化格式选择', 
    '在进程间频繁传输数据时，选择高效序列化格式的理由是？', 
    JSON_OBJECT('A', '减少 CPU 与传输开销', 'B', '增加可读性', 'C', '便于手工编辑', 'D', '降低安全'), 
    1, 
    JSON_ARRAY('提示1: 二进制格式（msgpack）常比 pickle 高效', '提示2: 注意兼容性和安全', '提示3: 测试不同方案性能'), 
    '高效序列化可降低 CPU 负载与传输时间，提升整体吞吐。', 
    ''
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1764,
    118,
    '适用场景（填空）',
    '当任务需要在多核上并行运行并避免 GIL 限制，应选择？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"多进程\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '多进程能在多核上实现真正并行，适合 CPU 密集任务。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1765,
    118,
    '共享数据（填空）',
    '在多线程中共享数据通常比多进程更容易，因为？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"线程共享同一地址空间\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '线程共享地址空间，访问共享内存方便但需同步以避免竞态。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1766,
    118,
    '进程间通信（填空）',
    '常见的 IPC 方式包括哪些？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"管道、队列、共享内存、sockets、mmap\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '常见 IPC 机制包含管道、队列、共享内存、socket 与 mmap 等，各有性能与复杂度权衡。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1767,
    118,
    '调试难度（填空）',
    '在并发模型中，通常哪种更容易调试，线程还是进程？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"进程更易隔离但调试跨进程交互更复杂\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '线程共享地址空间便于 inspect，但竞态难复现；进程隔离更稳健但跨进程交互复杂。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1768,
    118,
    '资源限制（填空）',
    '部署并发程序时应关注的系统级资源包括？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"CPU、内存、文件描述符、网络带宽\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '监控并配置 CPU、内存、文件句柄与网络等资源以避免瓶颈或限制。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1769,
    118,
    '最佳实践（填空）',
    '选择并发模型时首要考虑什么？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"任务类型（I/O 或 CPU）、资源与可维护性\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '根据任务特性（I/O/CPU）、可用资源与复杂度权衡并发策略。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1770,
    118,
    '总结（填空）',
    '多线程与多进程各自的权衡要点是？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"线程轻量共享但受 GIL；进程隔离并行但开销大\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '线程适合 I/O 密集且共享数据；进程适合并行 CPU 密集任务，但需考虑 IPC 与内存。',
    ''
);