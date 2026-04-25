USE `questions`;
-- Unit 71 | Start ID: 1051
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1051,
    71,
    'for 的用途',
    'for 循环通常用于？',
    JSON_OBJECT('A', '遍历序列或可迭代对象', 'B', '基于条件无限循环', 'C', '定义类', 'D', '处理异常'),
    1,
    JSON_ARRAY('遍历列表、字符串等', '已知元素集合时使用'),
    'for 用于遍历序列或任何可迭代对象。',
    'for x in lst: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1052,
    71,
    '迭代次数',
    'for 循环的迭代次数由什么决定？',
    JSON_OBJECT('A', '可迭代对象长度', 'B', 'while 条件', 'C', '用户输入', 'D', '系统时间'),
    1,
    JSON_ARRAY('由序列长度决定', '遍历到末尾停止'),
    'for 遍历序列直到耗尽元素。',
    'for i in range(3): ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1053,
    71,
    '循环变量',
    'for 中的循环变量作用是什么？',
    JSON_OBJECT('A', '接收当前元素值', 'B', '定义函数', 'C', '作为计数器必须为整数', 'D', '存储配置'),
    1,
    JSON_ARRAY('变量代表序列的每个项', '可重用变量名'),
    '循环变量在每次迭代中绑定到当前元素值。',
    'for item in items: print(item)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1054,
    71,
    '遍历列表',
    '补全：遍历并打印列表元素。',
    NULL,
    JSON_ARRAY('a', 'b'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for x in [\\"a\\",\\"b\\"]:"}, {"type": "code_line", "value": "    print(x)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '直接遍历列表并打印元素。',
    'basic for'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1055,
    71,
    '遍历字符串',
    '补全：打印字符串每个字符。',
    JSON_ARRAY('abc'),
    JSON_ARRAY('a', 'b', 'c'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for ch in \\"abc\\":"}, {"type": "code_line", "value": "    print(ch)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '字符串也是可迭代对象，可以逐字符遍历。',
    'for ch in s'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1056,
    71,
    'for vs while',
    '何时优先使用 for 而不是 while？',
    JSON_OBJECT('A', '已知集合或次数时使用 for', 'B', '未知次数时使用 for', 'C', '永远用 while', 'D', '两者无差'),
    1,
    JSON_ARRAY('遍历容器更自然用 for', 'for 更简洁清晰'),
    '当需要遍历集合或按固定次数迭代时，for 更简洁。',
    'for i in range(n)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1057,
    71,
    '迭代器协议',
    'for 在背后使用什么机制遍历对象？',
    JSON_OBJECT('A', '迭代器协议（__iter__/__next__）', 'B', '索引访问', 'C', '反射', 'D', '进程间通信'),
    1,
    JSON_ARRAY('iter() 和 next()', '适配各种可迭代对象'),
    'for 循环使用迭代器协议来遍历可迭代对象。',
    'iter(obj) -> next()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1058,
    71,
    '循环提前退出',
    '在 for 中使用 break 会怎样？',
    JSON_OBJECT('A', '立即退出循环', 'B', '跳到下一次迭代', 'C', '抛出异常', 'D', '无影响'),
    1,
    JSON_ARRAY('与 while 相同语义', '用于找到目标后停止'),
    'break 在 for 中同样用于立即退出循环。',
    'for x in seq: if cond: break'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1059,
    71,
    '索引与元素',
    '补全：同时获取索引和值。',
    NULL,
    JSON_ARRAY('0 a'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for i, v in enumerate([\\"a\\"]):"}, {"type": "code_line", "value": "    print(i, v)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 enumerate 可以同时获取索引和值。',
    'for i, v in enumerate(lst)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1060,
    71,
    '遍历 range',
    '补全：打印 0,1,2。',
    NULL,
    JSON_ARRAY('0', '1', '2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for i in range(3):"}, {"type": "code_line", "value": "    print(i)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'range(n) 生成从 0 到 n-1 的整数序列。',
    'for i in range(n)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1061,
    71,
    '可迭代对象',
    '下列哪个不是可迭代对象？',
    JSON_OBJECT('A', 'int', 'B', 'list', 'C', 'str', 'D', 'tuple'),
    1,
    JSON_ARRAY('int 不是序列', 'list/str/tuple 都可迭代'),
    '整数不可迭代，不能直接用于 for 循环。',
    'for x in 3: -> TypeError'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1062,
    71,
    '嵌套 for',
    '嵌套 for 常用于？',
    JSON_OBJECT('A', '处理二维数据或组合', 'B', '减少代码', 'C', '替代函数', 'D', '并行处理'),
    1,
    JSON_ARRAY('矩阵遍历', '双重嵌套用于组合'),
    '嵌套 for 常用于遍历二维结构或产生笛卡儿积。',
    'for i in range(n): for j in range(m): ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1063,
    71,
    'for 循环变量范围',
    'for i in range(3): i 的取值为？',
    JSON_OBJECT('A', '0,1,2', 'B', '1,2,3', 'C', '0..3 包括 3', 'D', '随机'),
    1,
    JSON_ARRAY('range 的结束不包含', '常见 off-by-one 错误'),
    'range(3) 生成 0,1,2 三个值。',
    'for i in range(3): print(i)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1064,
    71,
    '遍历字典键',
    '补全：遍历字典默认遍历什么？',
    NULL,
    JSON_ARRAY('a', 'b'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "d={\\"a\\":1,\\"b\\":2}"}, {"type": "code_line", "value": "for k in d:"}, {"type": "code_line", "value": "    print(k)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '默认遍历字典时会迭代键。',
    'for k in dict'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1065,
    71,
    '通过列表生成次数',
    '补全：执行某动作 n 次。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "n=3"}, {"type": "code_line", "value": "for _ in range(n):"}, {"type": "code_line", "value": "    do()"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用 for _ in range(n) 表示重复 n 次且忽略索引值。',
    'repeat action n times'
);