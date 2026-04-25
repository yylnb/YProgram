USE `questions`;
-- Unit 120 | Start ID: 1786
-- Generated at 2025-12-24 23:34:52

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1786, 
    120, 
    '性能分析首步', 
    '在开始优化之前，第一步应该是？', 
    JSON_OBJECT('A', '通过基准测试和分析定位真实瓶颈', 'B', '先全面重写代码', 'C', '随意优化热点', 'D', '增加硬件资源'), 
    1, 
    JSON_ARRAY('测量胜于猜测', '使用分析器（profiler）找瓶颈', '优化前后做对比'), 
    '先测量再优化能确保工作针对真实瓶颈并避免无谓改动。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1787, 
    120, 
    '采样与统计分析', 
    '采样型分析器（如 py-spy）相比于跟踪型分析器的优势是？', 
    JSON_OBJECT('A', '低开销可在生产环境中使用', 'B', '更精确到每行代码', 'C', '不需要堆栈信息', 'D', '替代单元测试'), 
    1, 
    JSON_ARRAY('采样分析器以低频截取堆栈样本', '开销小适合线上采样', '可能漏掉短时事件'), 
    '采样分析器开销低，适合生产环境观察长期趋势，但分辨率不如跟踪器高。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1788, 
    120, 
    '内存分析', 
    '分析内存泄露或内存增长常用工具包括？', 
    JSON_OBJECT('A', 'tracemalloc, objgraph 等', 'B', 'pytest', 'C', 'flake8', 'D', 'pylint'), 
    1, 
    JSON_ARRAY('tracemalloc 可以跟踪内存分配', 'objgraph 有助于对象引用关系分析', '用于定位泄露源'), 
    'tracemalloc 和 objgraph 等工具可帮助定位内存分配热点与泄露来源。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1789,
    120,
    '微基准陷阱（填空）',
    '在做微基准时常见的陷阱包括？',
    NULL,
    JSON_ARRAY('未考虑缓存热身、JIT/解释器优化和测量误差'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"未考虑缓存热身、JIT/解释器优化和测量误差\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '微基准需注意热身、重复、多次运行并取统计量以避免噪声误导。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1790,
    120,
    '剖析热点（填空）',
    '在 profiler 中发现某函数占用大量时间，下一步通常是？',
    NULL,
    JSON_ARRAY('审查函数实现、检查调用频率并考虑优化或缓存'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"审查函数实现、检查调用频率并考虑优化或缓存\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '分析函数是否被频繁调用或内部有低效算法，然后采取缓存、算法替换或编写扩展等措施。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1791, 
    120, 
    'I/O 与 CPU 瓶颈', 
    '如何快速判断瓶颈是 I/O 还是 CPU？', 
    JSON_OBJECT('A', '观察 CPU 利用率与 I/O 等待/延迟', 'B', '只看内存', 'C', '查看代码行数', 'D', '增加线程数'), 
    1, 
    JSON_ARRAY('高 CPU 利用率指向 CPU 瓶颈', '高 I/O 等待或阻塞指向 I/O 瓶颈', '使用系统监控与 profiler 结合'), 
    '结合系统级监控（top/iostat）与应用级 profiler 可区分瓶颈类型并指导优化策略。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1792, 
    120, 
    '算法优化优先', 
    '当可能时，应优先考虑哪类优化以获得最大收益？', 
    JSON_OBJECT('A', '改进算法或数据结构', 'B', '微观循环优化', 'C', '变量命名', 'D', '删除注释'), 
    1, 
    JSON_ARRAY('算法改进能显著降低复杂度', '数据结构选择影响整体性能', '先高阶优化再微调'), 
    '改进算法或选择合适数据结构通常能带来数量级的性能提升，应优先考虑。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1793, 
    120, 
    '异步采样', 
    '在生产环境采样 profiler 时要注意？', 
    JSON_OBJECT('A', '尽量低侵入并验证对性能影响', 'B', '随意配置高频采样', 'C', '只在开发环境采样', 'D', '采样能自动优化代码'), 
    1, 
    JSON_ARRAY('采样频率影响开销与精度', '监控期间需验证应用可用性', '采样应与负载场景一致'), 
    '线上采样需控制开销并确保采样能代表真实负载场景。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1794,
    120,
    '延迟与吞吐（填空）',
    '系统优化时延迟和吞吐常常存在什么关系？',
    NULL,
    JSON_ARRAY('可能冲突，需要根据目标优先级权衡'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"可能冲突，需要根据目标优先级权衡\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '有时增加吞吐会增加单次请求延迟，需根据业务目标选择优化方向。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1795,
    120,
    '回归测试（填空）',
    '在优化完成后，应做什么以防止性能回退？',
    NULL,
    JSON_ARRAY('引入性能回归测试并在 CI 中运行'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"引入性能回归测试并在 CI 中运行\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '通过基准与回归测试将性能指标纳入 CI 流水线，可及时发现退化。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1796, 
    120, 
    '微调策略', 
    '在确定热点后，哪种操作通常是低成本且有效的微调？', 
    JSON_OBJECT('A', '减少函数调用开销与局部变量绑定优化', 'B', '增加日志详细度', 'C', '重命名变量', 'D', '拆分提交'), 
    1, 
    JSON_ARRAY('减少不必要的函数调用有助降低开销', '将全局引用绑定为局部可加速访问', '先验证性能改善'), 
    '低成本的微优化如减少调用、局部化常用变量常能获得显著常数因子提升。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1797, 
    120, 
    '回退机制', 
    '在部署性能相关更改时，应当保留什么以应对回归？', 
    JSON_OBJECT('A', '快速回退路径与监控告警', 'B', '仅日志记录', 'C', '无须回退', 'D', '自动删除所有监控'), 
    1, 
    JSON_ARRAY('部署前准备回退计划', '实时监控帮助发现回归', '慢速回退会影响用户'), 
    '部署优化需配合监控与快速回退机制以应对意外的性能回退。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1798,
    120,
    'A/B 基准（填空）',
    '进行 A/B 性能比较时应保证哪些条件一致？',
    NULL,
    JSON_ARRAY('负载、环境、数据集与运行次数一致'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"负载、环境、数据集与运行次数一致\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '确保比较时负载模型、环境与测试数据一致以得到可比结果，并多次运行取统计量。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1799,
    120,
    '持续优化（填空）',
    '性能优化应如何作为工程实践纳入项目？',
    NULL,
    JSON_ARRAY('纳入基准测试、监控与回归检测流程'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"纳入基准测试、监控与回归检测流程\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '将性能基准、监控与回归测试纳入 CI/CD 和日常开发流程，保证长期性能稳定。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1800,
    120,
    '总结（填空）',
    '性能优化的三步法是什么？',
    NULL,
    JSON_ARRAY('测量 -> 优化 -> 验证'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"测量 -> 优化 -> 验证\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '性能改进遵循测量（定位瓶颈）—优化（针对性改进）—验证（基准测试与监控）的循环。',
    ''
);