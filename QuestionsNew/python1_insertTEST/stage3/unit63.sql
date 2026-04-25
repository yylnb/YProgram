USE `questions`;
-- Unit 63 | Start ID: 931
-- Generated at 2025-12-24 18:01:07

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    931, 
    63, 
    '首次判断', 
    'while 循环在执行前会？', 
    JSON_OBJECT('A', '先判断条件再进入', 'B', '先执行再判断', 'C', '无条件执行', 'D', '随机执行'), 
    1, 
    JSON_ARRAY('条件控制循环', '第一次也要判断', '与 do-while 不同'), 
    'while 在进入循环前就会判断条件。', 
    'while cond: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    932, 
    63, 
    '迭代顺序', 
    '循环体内语句的执行顺序是？', 
    JSON_OBJECT('A', '从上到下依次执行', 'B', '随机执行顺序', 'C', '从下到上', 'D', '并行执行'), 
    1, 
    JSON_ARRAY('语句按顺序执行', '控制流顺序性'), 
    '在每次迭代中语句按书写顺序执行。', 
    'line1; line2'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    933, 
    63, 
    '条件变更时机', 
    '如果循环体最后修改条件变量，下一次何时生效？', 
    JSON_OBJECT('A', '下一次迭代判断时生效', 'B', '本次立即生效', 'C', '不会生效', 'D', '随机生效'), 
    1, 
    JSON_ARRAY('修改会影响下一次判断', '当前迭代已执行完相关语句'), 
    '修改在当前迭代结束后，在下一次条件判断时生效。', 
    'i+=1 affects next check'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    934, 
    63, 
    '中途修改条件', 
    '在循环体中修改决定是否继续的变量合理吗？', 
    JSON_OBJECT('A', '合理且常见', 'B', '不允许', 'C', '效率过低', 'D', '总是错误'), 
    1, 
    JSON_ARRAY('常用于计数器或状态机', '需确保逻辑清晰'), 
    '在循环体中修改状态是常见做法，只需保证清晰且不会导致无限循环。', 
    'flag=False to stop'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    935, 
    63, 
    '资源清理', 
    '在循环结束后释放资源通常放到哪里？', 
    JSON_OBJECT('A', '循环外部', 'B', '循环内部每次', 'C', '用 continue', 'D', '不需要释放'), 
    1, 
    JSON_ARRAY('释放应在循环结束时进行', '避免重复释放'), 
    '通常在循环外清理或在 finally 中处理资源释放。', 
    'close file after loop'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    936, 
    63, 
    '异常时机', 
    '循环中未处理异常将导致？', 
    JSON_OBJECT('A', '跳出并传播异常', 'B', '继续执行', 'C', '忽略异常', 'D', '自动重试'), 
    1, 
    JSON_ARRAY('异常会中断控制流', '除非捕获'), 
    '未捕获异常会中断循环并向外层传播。', 
    'try/except to handle'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    937, 
    63, 
    '循环与函数调用', 
    '循环内频繁调用开销大的函数应如何处理？', 
    JSON_OBJECT('A', '尽量减少调用或缓存结果', 'B', '无限制调用', 'C', '让函数自己循环', 'D', '删除函数'), 
    1, 
    JSON_ARRAY('性能考虑', '缓存或移动调用位置'), 
    '对于昂贵操作应考虑缓存或减少调用次数以优化性能。', 
    'compute once then reuse'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    938, 
    63, 
    '状态变量', 
    '在循环中使用多个状态变量时应注意？', 
    JSON_OBJECT('A', '保持清晰的更新顺序', 'B', '随意更新', 'C', '一次只用一个变量', 'D', '用全局变量'), 
    1, 
    JSON_ARRAY('明确更新顺序', '防止竞态与冲突'), 
    '多个状态变量应明确定义更新顺序以保证逻辑正确。', 
    'update counter then flag'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    939, 
    63, 
    '调试技巧', 
    '查看循环行为的简单方法是？', 
    JSON_OBJECT('A', '在迭代中打印关键变量', 'B', '删除循环', 'C', '增加随机数', 'D', '写注释'), 
    1, 
    JSON_ARRAY('打印最直接', '注意不要过多日志'), 
    '打印中间状态是调试循环的常用方法，注意性能影响。', 
    'print(i, state)'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    940,
    63,
    '逐步追踪',
    '补全：打印每次循环开始的 i 值。',
    NULL,
    JSON_ARRAY('0', '1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while i<2:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(\"start\", "}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '在循环体开始处打印能追踪执行顺序。',
    'print at start'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    941,
    63,
    '写出迭代日志',
    '补全：每次迭代记录序号。',
    NULL,
    JSON_ARRAY('iter 0', 'iter 1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while i<2:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(f\"iter {"}, {"type": "slot", "index": 0}, {"type": "code", "value": "}\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '日志有助于调试循环行为。',
    'print f-string'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    942,
    63,
    '中断示例',
    '补全：当遇到负数时退出循环。',
    '2 -1',
    JSON_ARRAY('2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "while True:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    n = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if n < 0:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(n)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '遇到负数用 break 退出循环。',
    'break on sentinel'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    943,
    63,
    '跳过本次示例',
    '补全：遇到 0 跳过打印。',
    '1 0 2',
    JSON_ARRAY('1', '2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while i<3:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    v = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if v==0:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(v)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 continue 跳过当前迭代的剩余语句。',
    'skip when zero'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    944,
    63,
    '循环与用户输入',
    '补全：反复读取直到空行。',
    'a\nb\n
',
    JSON_ARRAY('a', 'b'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "while True:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    s = input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if s == \"\":"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(s)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '空行作为结束标志时用 break 退出循环。',
    'sentinel input'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    945,
    63,
    '循环体重入',
    '补全：确保循环体对变量的修改能影响条件。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while x<2:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    "}, {"type": "slot", "index": 0}, {"type": "code", "value": "+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    # condition changes"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '循环体应修改控制条件否则可能无限循环。',
    'update control var'
);