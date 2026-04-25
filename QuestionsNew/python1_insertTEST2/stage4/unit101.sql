USE `questions`;
-- Unit 101 | Start ID: 1501
-- Generated at 2025-12-24 23:30:12

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1501, 
    101, 
    '基本切片', 
    '表达式 lst[1:4] 会得到什么？', 
    JSON_OBJECT('A', '从索引 1 到 3 的子列表', 'B', '包括索引 4 的元素', 'C', '从开始到索引 4', 'D', '只返回单个元素'), 
    1, 
    JSON_ARRAY('提示1：切片右端为开区间', '提示2：包含索引 1，不包含 4', '提示3：结果是列表的子序列'), 
    '切片 [1:4] 返回索引 1,2,3 的元素，右端不包含 4。', 
    '[0,1,2,3,4][1:4] -> [1,2,3]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1502, 
    101, 
    '步长用法', 
    '切片 lst[::2] 表示？', 
    JSON_OBJECT('A', '每隔 2 个元素取一个，从头开始', 'B', '从索引 2 开始取', 'C', '取最后两个元素', 'D', '取整个列表并倒序'), 
    1, 
    JSON_ARRAY('提示1：第三个参数是步长', '提示2：::2 意味着从头开始每两个取一个', '提示3：步长为负可反向'), 
    '切片的第三个参数为步长，::2 表示步长为 2，从头开始。', 
    '[0,1,2,3,4][::2] -> [0,2,4]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1503, 
    101, 
    '负步长', 
    '切片 lst[::-1] 的效果是？', 
    JSON_OBJECT('A', '生成反转的列表副本', 'B', '就地反转', 'C', '按 1 步长正序取', 'D', '抛出异常'), 
    1, 
    JSON_ARRAY('提示1：切片返回副本', '提示2：::-1 是常见的反转技巧', '提示3：区别于 list.reverse()'), 
    'lst[::-1] 会创建一个反向顺序的新列表副本。', 
    '[1,2,3][::-1] -> [3,2,1]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1504,
    101,
    '选取范围（填空）',
    '取索引 2 至末尾的切片并打印。',
    'a b c d',
    JSON_ARRAY('c d'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = input().split()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(*lst["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('2:', '2', ':2', '2:4'),
    JSON_ARRAY(1),
    '使用 lst[2:] 可从索引 2 一直到列表末尾。',
    'x[2:]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1505,
    101,
    '步长填空（填空）',
    '从列表中每隔一个元素取一次并打印。',
    '1 2 3 4',
    JSON_ARRAY('1 3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = input().split()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(*lst["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('::2', ':2', '1::', '::-1'),
    JSON_ARRAY(1),
    '使用 lst[::2] 每隔一个元素取一次。',
    '[0,1,2,3][::2] -> [0,2]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1506, 
    101, 
    '切片是否复制', 
    '切片操作是否返回新的列表对象？', 
    JSON_OBJECT('A', '是，切片返回副本', 'B', '否，切片就地修改', 'C', '视情况而定', 'D', '仅对数字列表返回副本'), 
    1, 
    JSON_ARRAY('提示1：切片创建新对象', '提示2：切片改变不会影响原列表', '提示3：区别于切片赋值'), 
    '切片返回的是原列表的一份浅拷贝（新列表对象）。', 
    'b = a[1:3]; id(b) != id(a)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1507, 
    101, 
    '切片赋值改变原列表', 
    '执行 lst[1:3] = [9] 会如何？', 
    JSON_OBJECT('A', '把索引 1 到 2 的范围替换为 [9]', 'B', '抛出错误', 'C', '添加新元素而不删除', 'D', '在末尾追加'), 
    1, 
    JSON_ARRAY('提示1：切片赋值可以改变长度', '提示2：原区间将被替换', '提示3：新序列长度可不同'), 
    '切片赋值会用新的序列替换给定区间，可收缩或扩展列表。', 
    'a=[1,2,3]; a[1:3] = [9]  # [1,9]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1508, 
    101, 
    '切片步长为 1', 
    '切片 lst[a:b:1] 等价于？', 
    JSON_OBJECT('A', 'lst[a:b]', 'B', 'lst[a:b:2]', 'C', 'lst[::-1]', 'D', 'lst[a+1:b+1]'), 
    1, 
    JSON_ARRAY('提示1：步长为 1 是默认行为', '提示2：省略步长即为 1', '提示3：与 ::1 等价'), 
    '第三个参数为 1 时与未指定步长等价，等同于 lst[a:b]。', 
    'a[1:3:1] == a[1:3]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1509,
    101,
    '反向切片（填空）',
    '打印列表的倒数第二和倒数第四元素（步长为 -2）。',
    '1 2 3 4 5',
    JSON_ARRAY('4 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(*lst["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('[-2::-2]', '[-2:-5:-2]', '[:-2:-2]', '[::-2]'),
    JSON_ARRAY(2),
    '使用 lst[-2:-5:-2] 可从倒数第 2 个开始每隔两个取向左。',
    '[1,2,3,4,5][-2:-5:-2] -> [4,2]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1510,
    101,
    '替换切片（填空）',
    '把索引 0:2 的元素替换为 a b 并打印。',
    'x y z',
    JSON_ARRAY('a b z'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = input().split()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst[0:2] = "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('[\'a\',\'b\']', '[\'ab\']', '[\'a\',\'b\',\'c\']', '[\'a\']'),
    JSON_ARRAY(1),
    '切片赋值需要可迭代对象，如 [\'a\',\'b\']。',
    'lst[0:2] = [\'a\',\'b\']'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1511, 
    101, 
    '浅拷贝与切片', 
    '使用切片复制列表会产生浅拷贝还是深拷贝？', 
    JSON_OBJECT('A', '浅拷贝', 'B', '深拷贝', 'C', '不拷贝', 'D', '取决于元素类型'), 
    1, 
    JSON_ARRAY('提示1：切片复制是浅拷贝', '提示2：若元素是可变对象，引用会被共享', '提示3：深拷贝需用 copy.deepcopy'), 
    '切片返回的是浅拷贝，新列表中元素引用原对象。', 
    'b = a[:]  # 浅拷贝'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1512, 
    101, 
    '步长为负的切片', 
    '切片 a[5:1:-1] 会遍历哪些索引？', 
    JSON_OBJECT('A', '5,4,3,2', 'B', '1,2,3,4,5', 'C', '5,4,3,2,1', 'D', '无法确定'), 
    1, 
    JSON_ARRAY('提示1：右端为开区间，步长为 -1 向左遍历', '提示2：终止索引为 1 不包含', '提示3：所以包含 5 到 2'), 
    'a[5:1:-1] 包含索引 5、4、3、2（不包含 1）。', 
    'list(range(10))[5:1:-1] -> [5,4,3,2]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1513, 
    101, 
    '切片边界省略', 
    '切片 [:] 与 list() 有何异同？', 
    JSON_OBJECT('A', '都返回列表副本，但 list() 更通用', 'B', '[:] 返回引用', 'C', 'list() 返回原对象', 'D', '两者等价且性能相同'), 
    1, 
    JSON_ARRAY('提示1：[:] 返回浅拷贝', '提示2：list(iterable) 也可复制', '提示3：两者在某些情况下等价'), 
    '[:] 与 list() 都可用于生成浅拷贝，list() 更灵活可接受任意可迭代对象。', 
    'b = a[:]; c = list(a)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1514,
    101,
    '切片长度（填空）',
    '输入为 5 个元素，切片 lst[1:4] 长度为多少？',
    '1 2 3 4 5',
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = input().split()"}, {"type": "code_line", "value": "print(len(lst[1:4]))"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(),
    '索引 1 到 3 共 3 个元素。',
    'len([1,2,3]) == 3'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1515,
    101,
    '切片与步长综合（填空）',
    '打印从第二个元素开始，每两个取一个的子序列。',
    'a b c d e',
    JSON_ARRAY('b d'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = input().split()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(*lst["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('1::2', '1: :2', '1::2', '1: : -2'),
    JSON_ARRAY(1),
    'lst[1::2] 从索引 1 开始每两个取一个。',
    '[0,1,2,3,4][1::2] -> [1,3]'
);