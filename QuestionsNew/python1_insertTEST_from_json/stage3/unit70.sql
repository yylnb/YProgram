USE `questions`;
-- Unit 70 | Start ID: 1036
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1036,
    70,
    '复习：while 用途',
    'while 最适合用于？',
    JSON_OBJECT('A', '未知次数、条件驱动的循环', 'B', '固定次数迭代', 'C', '仅遍历列表', 'D', '定义函数'),
    1,
    JSON_ARRAY('条件控制循环', '如等待事件发生'),
    'while 用于条件驱动的循环而非已知次数的简单遍历。',
    'while cond: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1037,
    70,
    '复习：break',
    'break 的作用是？',
    JSON_OBJECT('A', '立即退出当前循环', 'B', '跳过本次迭代', 'C', '继续函数', 'D', '重置循环'),
    1,
    JSON_ARRAY('强制退出', '影响最内层循环'),
    'break 会立即退出包含它的最内层循环。',
    'if found: break'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1038,
    70,
    '复习：continue',
    'continue 会导致？',
    JSON_OBJECT('A', '跳到下一次迭代', 'B', '退出循环', 'C', '结束程序', 'D', '无作用'),
    1,
    JSON_ARRAY('跳过本次余下语句', '继续判断条件'),
    'continue 跳过当前迭代剩余语句并进入下一次迭代。',
    'if cond: continue'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1039,
    70,
    '复习：计数器',
    '补全：计数器初始为 0，不断加 1，循环结束条件为 i>=3。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while i<3:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '通过 i 的递增和条件判断控制循环次数。',
    'i increment'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1040,
    70,
    '复习：安全退出',
    '补全：在循环中加入最大迭代限制以防死循环。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while cond:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if i>1000:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        break"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '超时或迭代上限可以作为安全退出措施。',
    'max_iters guard'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1041,
    70,
    '复习：轮询等待',
    '轮询等待外部状态时应加入？',
    JSON_OBJECT('A', '适当的 sleep', 'B', '不断 busy-wait', 'C', '更多计算', 'D', '跳过休眠'),
    1,
    JSON_ARRAY('sleep 降低 CPU 占用', '控制检查频率'),
    '轮询应适当 sleep 避免 CPU 资源浪费。',
    'time.sleep(0.5)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1042,
    70,
    '复习：用户交互',
    '交互式循环接收输入时要注意？',
    JSON_OBJECT('A', '校验和清洗输入', 'B', '直接 eval', 'C', '忽略空格', 'D', '不记录历史'),
    1,
    JSON_ARRAY('strip 和验证', '避免安全风险'),
    '处理用户输入应先清洗并校验安全性。',
    's = input().strip()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1043,
    70,
    '复习：日志',
    '为什么在循环中记录日志需要谨慎？',
    JSON_OBJECT('A', '过多日志会影响性能并泄露信息', 'B', '永远记录越多越好', 'C', '减少调试效率', 'D', '不必要'),
    1,
    JSON_ARRAY('注意性能与隐私', '只记录必要摘要'),
    '在循环中频繁记录日志可能影响性能且需注意敏感数据保护。',
    'log.debug limited'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1044,
    70,
    '复习：示例 break',
    '补全：找到 0 时退出。',
    JSON_ARRAY('1 0 2'),
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "while True:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    v=int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if v==0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        break"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '遇 sentinel 值退出循环。',
    'sentinel'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1045,
    70,
    '复习：示例 continue',
    '补全：遇到负数跳过处理。',
    JSON_ARRAY('1 -1 2'),
    JSON_ARRAY('1', '2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for v in [1,-1,2]:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if v<0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        continue"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(v)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'continue 可跳过不想处理的项。',
    'skip negatives'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1046,
    70,
    '复习：资源释放',
    '循环中若打开文件，推荐使用？',
    JSON_OBJECT('A', 'with 语句自动释放', 'B', '不关闭', 'C', '留到程序结束', 'D', '写到全局'),
    1,
    JSON_ARRAY('上下文管理自动释放', '避免资源泄漏'),
    '使用 with 可以确保文件在离开上下文时被自动关闭。',
    'with open() as f: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1047,
    70,
    '复习：检测死循环',
    '哪个手段有助于发现死循环？',
    JSON_OBJECT('A', '使用日志和 profiling', 'B', '删掉循环', 'C', '增加随机数', 'D', '不调试'),
    1,
    JSON_ARRAY('记录循环次数', '定位热点函数'),
    '日志和 profiling 可以帮助定位导致死循环或高 CPU 的代码段。',
    'cProfile'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1048,
    70,
    '复习：交互退出',
    '交互循环中用户退出时应如何处理？',
    JSON_OBJECT('A', '清理并退出循环', 'B', '直接崩溃', 'C', '忽略退出', 'D', '退出但不释放资源'),
    1,
    JSON_ARRAY('释放资源', '保存状态'),
    '用户退出应做必要的清理和状态保存再退出。',
    'save history then break'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1049,
    70,
    '复习：打印计数',
    '补全：打印 0 到 2。',
    NULL,
    JSON_ARRAY('0', '1', '2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while i<3:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(i)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '基本计数循环示例。',
    'i increment loop'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1050,
    70,
    '复习：安全 guard',
    '补全：加入最大迭代以防万一。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while cond:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if i>10000:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        break"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '添加上限保护是稳健做法。',
    'max_iters guard'
);