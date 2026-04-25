USE `questions`;
-- Unit 65 | Start ID: 961
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    961,
    65,
    'break 的基本作用',
    '在循环中使用 break 会？',
    JSON_OBJECT('A', '立即退出循环', 'B', '跳过本次迭代', 'C', '结束程序', 'D', '重置变量'),
    1,
    JSON_ARRAY('强制终止循环', '跳到循环外继续执行'),
    'break 会立即退出最近的循环并继续执行循环后面的代码。',
    'for i in range(5):
    if cond: break'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    962,
    65,
    'break 所在层级',
    '当循环嵌套时，break 会退出哪一层？',
    JSON_OBJECT('A', '最近的那一层循环', 'B', '最外层循环', 'C', '所有循环', 'D', '不会退出任何循环'),
    1,
    JSON_ARRAY('局部退出', '配合标志变量可退出外层'),
    'break 只退出包含它的最内层循环。',
    'use flag to exit outer loop'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    963,
    65,
    'break vs return',
    '在函数内循环中，break 与 return 区别？',
    JSON_OBJECT('A', 'break 退出循环，return 返回函数', 'B', '两者相同', 'C', 'break 返回值', 'D', 'return 只跳过一轮'),
    1,
    JSON_ARRAY('return 结束整个函数', 'break 只结束循环'),
    'return 会结束函数执行并返回值，而 break 仅跳出循环。',
    'return vs break'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    964,
    65,
    '用 break 退出',
    '补全：找到目标值时退出循环。',
    JSON_ARRAY('3'),
    JSON_ARRAY('found'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while True:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if i==3:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        print(\\"found\\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        "}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '遇到目标立即使用 break 退出循环。',
    'break on match'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    965,
    65,
    '嵌套中用 break',
    '补全：内层 break 不会退出外层。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for i in range(2):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    for j in range(3):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        "}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '内层 break 只终止内层循环。',
    '需要 flag 退出外层'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    966,
    65,
    'break 的常见用途',
    '下面哪个是 break 常见用途？',
    JSON_OBJECT('A', '在找到结果后停止搜索', 'B', '强制重启程序', 'C', '跳过循环体第一行', 'D', '用于定义函数'),
    1,
    JSON_ARRAY('搜索类算法常用', '效率考虑'),
    '在遍历中一旦找到匹配项常用 break 提高效率。',
    'find and break'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    967,
    65,
    '与 else 一起使用',
    'for/while 的 else 块在何种情况下执行？',
    JSON_OBJECT('A', '循环未被 break 打断时执行', 'B', '循环每次都执行', 'C', '循环被 break 时执行', 'D', '无意义'),
    1,
    JSON_ARRAY('else 是循环完成后的补充', '被 break 则不执行'),
    '循环正常结束时（未被 break）会执行 else 语句块。',
    'for x in seq: ... else: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    968,
    65,
    '性能影响',
    '频繁使用 break 会如何影响性能？',
    JSON_OBJECT('A', '通常有利于性能但要确保逻辑正确', 'B', '总是降低性能', 'C', '提升内存', 'D', '无影响'),
    1,
    JSON_ARRAY('快速退出避免不必要迭代', '但过度复杂的跳转影响可读性'),
    'break 可减少不必要的迭代，从性能角度可能有好处，但影响代码可读性要权衡。',
    'break early'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    969,
    65,
    '在循环中查找元素',
    '补全：找到元素后退出并打印索引。',
    NULL,
    JSON_ARRAY('2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "arr=[1,2,3]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for i,v in enumerate(arr):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if v==3:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        print(i)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        "}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '找到目标后打印索引并 break。',
    'enumerate + break'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    970,
    65,
    '标志退出外层',
    '补全：用 flag 在内层触发退出外层。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "done=False"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for i in range(5):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    for j in range(5):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        if cond:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "            done=True"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "            "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if done:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        "}, {"type": "slot", "index": 1}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '通过 flag 在内层触发后检查以退出外层循环。',
    'flag pattern'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    971,
    65,
    '不当使用风险',
    '在循环中随处使用 break 可能导致？',
    JSON_OBJECT('A', '降低可读性', 'B', '自动并行', 'C', '提升稳定性', 'D', '语法错误'),
    1,
    JSON_ARRAY('跳转太多使逻辑难懂', '应控制使用场景'),
    '频繁使用 break 会使控制流跳转复杂，影响可读性。',
    'limit break usage'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    972,
    65,
    '替代方案',
    '如果不想用 break，常用替代是？',
    JSON_OBJECT('A', '用条件变量控制循环', 'B', '删除循环', 'C', '无限循环', 'D', '用 goto'),
    1,
    JSON_ARRAY('使用布尔变量或修改条件'),
    '通过布尔变量改变循环条件可代替 break，代码更显式。',
    'running=False'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    973,
    65,
    'break 在 while 的位置',
    '将 break 放在循环体中靠近检测点有什么好处？',
    JSON_OBJECT('A', '更直观并减少额外代码', 'B', '没有区别', 'C', '不推荐', 'D', '会报错'),
    1,
    JSON_ARRAY('靠近检测点便于理解', '减少状态传播'),
    '把 break 放在检测点能使退出意图更清晰。',
    'if found: break'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    974,
    65,
    '在 user input 中退出',
    '补全：当输入 "q" 时退出。',
    JSON_ARRAY('q'),
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "while True:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    s=input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if s==\\"q\\":"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        "}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '基于用户输入的 sentinel 值可立即退出循环。',
    'sentinel input'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    975,
    65,
    '结合异常使用 break',
    '补全：遇异常打印并 break。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "while True:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    try:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        do()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    except Exception as e:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        print(e)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        "}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '在异常情形下可以记录并使用 break 优雅退出循环。',
    'handle exception then break'
);