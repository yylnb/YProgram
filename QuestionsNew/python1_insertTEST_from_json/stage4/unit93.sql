USE `questions`;
-- Unit 93 | Start ID: 1381
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1381,
    93,
    '切片语法',
    '列表切片常用语法是？',
    JSON_OBJECT('A', 'lst[start:stop:step]', 'B', 'lst.range(start,stop)', 'C', 'lst.slice(start,stop)', 'D', 'lst[start;stop]'),
    1,
    JSON_ARRAY('包含 step 参数可控制步长', 'stop 为上界不包含'),
    'Python 切片语法为 [start:stop:step]，其中 stop 不包含在结果中。',
    'a[1:5:2]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1382,
    93,
    '默认步长',
    '切片未指定 step 时默认步长为？',
    JSON_OBJECT('A', '1', 'B', '0', 'C', '-1', 'D', 'None'),
    1,
    JSON_ARRAY('默认按顺序前进'),
    '默认步长为 1。',
    'a[0:3] 等于 a[0:3:1]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1383,
    93,
    '省略边界',
    '切片写作 a[:3] 会包含哪些元素？',
    JSON_OBJECT('A', '从开头到索引 2', 'B', '从索引 3 到结尾', 'C', '仅索引 3 元素', 'D', '抛出异常'),
    1,
    JSON_ARRAY('省略 start 表示从 0 开始'),
    'a[:3] 相当于 a[0:3]，包含索引 0,1,2。',
    '[0,1,2][:3] -> [0,1,2]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1384,
    93,
    '取步长',
    '补全：取每隔一个元素的子序列。',
    JSON_ARRAY('1 2 3 4'),
    JSON_ARRAY('1 3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(lst["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('::2', '1::', '2::', ':-2'),
    JSON_ARRAY(1),
    '切片 [::2] 表示从头到尾步长为 2。',
    's[::2]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1385,
    93,
    '倒序切片',
    '补全：用切片反转列表并打印。',
    JSON_ARRAY('1 2 3'),
    JSON_ARRAY('3 2 1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(lst["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('[::-1]', '[::1]', '[1::-1]', '[-1::-1]'),
    JSON_ARRAY(1),
    '[::-1] 是常用的反转技巧。',
    's[::-1]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1386,
    93,
    '切片返回类型',
    '切片返回的是新列表还是视图？',
    JSON_OBJECT('A', '新列表（拷贝）', 'B', '原列表视图', 'C', '引用同一对象', 'D', '迭代器'),
    1,
    JSON_ARRAY('切片会生成列表副本'),
    '切片返回一个新的列表对象，原列表保持不变。',
    'a[1:3] is not a'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1387,
    93,
    '切片与赋值',
    '切片赋值可否改变原列表长度？',
    JSON_OBJECT('A', '可以', 'B', '不可以', 'C', '仅在 Python2', 'D', '仅当 step 为 1'),
    1,
    JSON_ARRAY('切片赋值能替换不同长度序列'),
    '通过切片赋值可插入或删除元素从而改变长度。',
    'a[1:2] = [x,y]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1388,
    93,
    '步长为负',
    '步长为负的切片会如何？',
    JSON_OBJECT('A', '从右向左遍历', 'B', '报错', 'C', '返回空', 'D', '忽略步长'),
    1,
    JSON_ARRAY('负步长常用于倒序并跳跃取值'),
    '负步长使切片按逆序方向取值。',
    'a[::-2]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1389,
    93,
    '替换子段',
    '补全：把索引 1:3 替换为 [9,9]',
    JSON_ARRAY('1 2 3 4'),
    JSON_ARRAY('1 9 9 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst"}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('[1:3]=[9,9]', 'append', 'insert', 'del'),
    JSON_ARRAY(1),
    '切片赋值替换范围内元素。',
    'lst[1:3]=[a,b]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1390,
    93,
    '子串切片',
    '补全：对字符串使用切片获取前 3 字符。',
    JSON_ARRAY('abcdef'),
    JSON_ARRAY('abc'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s=input().strip()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('[:3]', '[0:3]', '[1:4]', '[-3:]'),
    JSON_ARRAY(1, 2),
    '字符串也支持切片，语法与列表相同。',
    's[:n]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1391,
    93,
    '切片复杂度',
    '切片创建副本，其时间复杂度通常为？',
    JSON_OBJECT('A', 'O(k)（k 为切片长度）', 'B', 'O(1)', 'C', 'O(n^2)', 'D', '取决于实现'),
    1,
    JSON_ARRAY('需要复制 k 个元素'),
    '切片需要创建新序列并拷贝相应元素，成本与长度线性相关。',
    'a[0:100] cost ~100'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1392,
    93,
    '切片为空',
    '当 start>stop 时默认步长为正数会返回？',
    JSON_OBJECT('A', '空列表', 'B', '抛错', 'C', '倒序结果', 'D', '原序列'),
    1,
    JSON_ARRAY('起点超过终点会返回空序列（除非步长为负）'),
    '当步长为正且 start>=stop 时切片结果为空。',
    '[1,2,3][2:1] -> []'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1393,
    93,
    '切片与内存',
    '频繁对大列表切片可能导致？',
    JSON_OBJECT('A', '较高内存使用', 'B', '减少内存', 'C', '无影响', 'D', '垃圾回收失效'),
    1,
    JSON_ARRAY('每次切片生成新列表会占用额外内存'),
    '大量或大范围切片会产生新的副本，消耗内存。',
    'avoid many large slices'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1394,
    93,
    '步长应用',
    '补全：取索引 1 到末尾，每隔 2 个元素取一个。',
    JSON_ARRAY('1 2 3 4 5'),
    JSON_ARRAY('2 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(lst["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('1::2', '::2', '1:2', '1:4'),
    JSON_ARRAY(1),
    '切片 [1::2] 从索引 1 开始步长为 2。',
    'lst[1::2]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1395,
    93,
    '切片复制',
    '补全：复制整个列表的一种简洁写法。',
    JSON_ARRAY('1 2 3'),
    JSON_ARRAY('1 2 3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "copy = lst["}, {"type": "slot", "index": 0}, {"type": "code", "value": "]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*copy)"}]}]}',
    JSON_ARRAY('lst[:]', 'list(lst)', 'copy()', 'deepcopy()'),
    JSON_ARRAY(1, 2),
    'lst[:] 可以快速复制列表，等价于 list(lst)。',
    'b = a[:]'
);