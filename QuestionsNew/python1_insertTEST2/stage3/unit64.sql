USE `questions`;
-- Unit 64 | Start ID: 946
-- Generated at 2025-12-24 23:18:29

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    946, 
    64, 
    '无限循环定义', 
    '以下哪种写法会产生无限循环？', 
    JSON_OBJECT('A', 'while True: pass', 'B', 'while i<3: i+=1', 'C', 'for i in range(3): pass', 'D', 'while False: pass'), 
    1, 
    JSON_ARRAY('True 恒为真', '没有 break 或更新条件', 'CPU 被持续占用'), 
    'while True 且无终止逻辑会导致无限循环。', 
    'while True: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    947, 
    64, 
    '合理退出', 
    '为避免无限循环，常见做法是？', 
    JSON_OBJECT('A', '使用 break 或更新条件', 'B', '不加任何退出', 'C', '使用递归代替', 'D', '永远 sleep'), 
    1, 
    JSON_ARRAY('提供结束条件', '加安全计数'), 
    '设置明确的退出条件或使用 break 可以防止无限循环。', 
    'if cond: break'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    948, 
    64, 
    '检测无限循环', 
    '发现程序卡住时首要检查通常是？', 
    JSON_OBJECT('A', '是否存在未更新的循环变量', 'B', '查看文件大小', 'C', '网络带宽', 'D', '用户输入'), 
    1, 
    JSON_ARRAY('循环变量可能未更新', '检查循环体内部逻辑'), 
    '未更新的控制变量是导致无限循环的常见原因。', 
    'missing increment'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    949,
    64,
    '添加超时保护',
    '补全：在循环中添加最大迭代限制。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while cond:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if i>10000:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        break"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '超时保护可避免长时间挂起。',
    'max_iters guard'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    950,
    64,
    '用户中断',
    '补全：响应 Ctrl+C（KeyboardInterrupt）。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "try:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    while True:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        pass"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "except KeyboardInterrupt:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"stopped\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '捕获 KeyboardInterrupt 可以友好处理用户中断。',
    'try/except around loop'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    951, 
    64, 
    '退出策略', 
    '循环内检测到异常情形应如何处理？', 
    JSON_OBJECT('A', '记录并 break 或修正', 'B', '忽略并继续', 'C', '立即退出程序不记录', 'D', '吞掉异常'), 
    1, 
    JSON_ARRAY('记录上下文', '决定是否恢复或退出'), 
    '对异常情形应记录并根据情况退出或尝试恢复。', 
    'log and break'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    952, 
    64, 
    '后台任务', 
    '后台常驻循环应注意？', 
    JSON_OBJECT('A', '添加 sleep 避免 CPU 空转', 'B', '不停忙等', 'C', '频繁写日志', 'D', '无须错误处理'), 
    1, 
    JSON_ARRAY('sleep 降低 CPU 占用', '合理间隔检查任务'), 
    '后台循环通常应包含适当的等待以降低资源使用。', 
    'while running: do(); time.sleep(1)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    953, 
    64, 
    '资源释放', 
    '循环异常退出时应保证？', 
    JSON_OBJECT('A', '资源被正确释放', 'B', '保留文件句柄', 'C', '忽略释放', 'D', '重启程序'), 
    1, 
    JSON_ARRAY('使用 finally 或 context manager', '避免资源泄漏'), 
    '异常退出后也要保证资源释放以防泄漏。', 
    'with open() as f: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    954,
    64,
    '检测条件改变',
    '补全：打印直到外部文件存在。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import os"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while not os.path.exists(\"flag.txt\"):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    pass"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"ready\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '轮询文件作为条件的一种方式，但应加入 sleep 避免 CPU 占用。',
    'time.sleep(1)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    955,
    64,
    '增加延时',
    '补全：在轮询中加入延时。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import time"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while not ready():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    time.sleep(0.5)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 sleep 可减少轮询对 CPU 的影响。',
    'time.sleep(0.1)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    956, 
    64, 
    '检测死循环', 
    '使用 profiling 工具可帮助发现？', 
    JSON_OBJECT('A', 'CPU 占用高的函数', 'B', '内存小的函数', 'C', '无用日志', 'D', '运行时间短的函数'), 
    1, 
    JSON_ARRAY('找出热点函数', '结合堆栈信息'), 
    'profiling 可帮助定位导致无限循环或高 CPU 的代码。', 
    '使用 cProfile'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    957, 
    64, 
    '停止条件可达性', 
    '设计循环条件时要保证什么？', 
    JSON_OBJECT('A', '条件在某步可被满足', 'B', '条件永远不可达', 'C', '条件随意设定', 'D', '不需要考虑'), 
    1, 
    JSON_ARRAY('确保退出条件可达', '验证边界情况'), 
    '循环条件应是可达的以确保循环可终止。', 
    'test with edge cases'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    958, 
    64, 
    '守护循环', 
    '守护循环在实现时要注意？', 
    JSON_OBJECT('A', '不要阻塞主线程或提供后台策略', 'B', '阻塞所有', 'C', '无限输出日志', 'D', '不处理异常'), 
    1, 
    JSON_ARRAY('后台任务分离', '提供合适退出机制'), 
    '守护循环应不会阻塞主流程且要能优雅退出。', 
    'daemon thread'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    959,
    64,
    '使用 sentinel 退出',
    '补全：遇到 sentinel 值则退出循环。',
    '-1',
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "while True:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    v=int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if v==-1:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        break"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用特定值作为结束信号是一种常见模式。',
    'sentinel = None'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    960,
    64,
    '安全重试',
    '补全：对失败的操作重试并在多次失败时退出。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "tries=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while tries<3:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if do():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        break"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    tries+=1"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '有限重试当操作偶发失败时可提高健壮性。',
    'retry with limit'
);