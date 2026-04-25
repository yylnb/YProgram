USE `questions`;
-- Unit 74 | Start ID: 1096
-- Generated at 2025-12-24 18:04:11

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1096, 
    74, 
    '遍历同时删除', 
    '遍历列表同时删除元素，安全做法是？', 
    JSON_OBJECT('A', '遍历副本并在原列表删除', 'B', '边遍历边删除原列表', 'C', '使用索引 skip', 'D', '不可实现'), 
    1, 
    JSON_ARRAY('遍历列表副本避免跳跃问题', '或反向遍历'), 
    '直接在遍历同一列表时删除会跳过元素，应遍历副本或反向遍历。', 
    'for x in lst[:]:'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1097, 
    74, 
    '过滤生成新列表', 
    '最 Pythonic 的过滤列表方法是？', 
    JSON_OBJECT('A', '列表推导式', 'B', '手动循环并 append', 'C', 'map with lambda', 'D', '使用 while'), 
    1, 
    JSON_ARRAY('列表推导式简洁高效', '可读性好'), 
    '列表推导式通常既简洁又高效。', 
    'new=[x for x in lst if cond(x)]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1098, 
    74, 
    '反向删除', 
    '反向遍历删除元素的优点？', 
    JSON_OBJECT('A', '避免索引移动影响未遍历元素', 'B', '性能更差', 'C', '不推荐', 'D', '只能用于数字'), 
    1, 
    JSON_ARRAY('从后往前删除不会改变未遍历的前面元素索引'), 
    '反向遍历在删除元素时可避免跳过问题。', 
    'for i in range(len(lst)-1,-1,-1):'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1099, 
    74, 
    '迭代器失效', 
    '在循环中修改列表会导致什么？', 
    JSON_OBJECT('A', '迭代器行为异常（跳过元素）', 'B', '抛出异常', 'C', '自动复制', 'D', '无影响'), 
    1, 
    JSON_ARRAY('迭代器基于原列表索引', '删除会改变索引序列'), 
    '在遍历时修改列表会导致迭代器跳过或重复元素。', 
    'remove during iteration'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1100, 
    74, 
    '用 filter', 
    '使用 filter 函数与列表推导相比，优势是？', 
    JSON_OBJECT('A', '延迟执行（结合迭代器）', 'B', '更易读', 'C', '更快很多', 'D', '不兼容 Python3'), 
    1, 
    JSON_ARRAY('filter 返回迭代器（Python3 需转 list）', '适合链式操作'), 
    'filter 可与迭代器配合节省内存。', 
    'filter(cond, iterable)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1101, 
    74, 
    '插入与延展', 
    '在遍历时使用 insert 或 extend 的注意点？', 
    JSON_OBJECT('A', '可能改变正在遍历的序列', 'B', '不会改变', 'C', '总是报错', 'D', '只影响副本'), 
    1, 
    JSON_ARRAY('插入会改变后续索引', '谨慎在遍历原列表时修改'), 
    '插入会改变序列长度和索引，影响遍历行为。', 
    'lst.insert(0,x)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1102, 
    74, 
    '复制浅拷贝', 
    'list.copy() 与 lst[:] 的差别？', 
    JSON_OBJECT('A', '基本相同，为浅拷贝', 'B', 'deep copy', 'C', '不复制', 'D', '返回迭代器'), 
    1, 
    JSON_ARRAY('两者返回浅拷贝', '对于嵌套结构需注意'), 
    '两者都做浅拷贝，嵌套对象仍为引用。', 
    'b = a.copy()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1103, 
    74, 
    '速度考量', 
    '对大列表进行过滤时通常应？', 
    JSON_OBJECT('A', '使用生成器或迭代器', 'B', '一次性创建新列表总是最好', 'C', '使用 while 更快', 'D', '使用递归'), 
    1, 
    JSON_ARRAY('节省内存', '延迟处理有优势'), 
    '生成器按需处理可减少内存峰值。', 
    '(x for x in lst if cond(x))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1104, 
    74, 
    '原地 vs 新列表', 
    '何时优先原地修改？', 
    JSON_OBJECT('A', '当内存受限且不需原始顺序', 'B', '永远原地更好', 'C', '从不原地修改', 'D', '仅在函数中'), 
    1, 
    JSON_ARRAY('考虑内存与可变性需求', '避免破坏原数据'), 
    '原地修改节省内存，但需确认是否破坏原数据可接受。', 
    'lst.sort() in-place'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1105,
    74,
    '就地修改',
    '补全：将列表中每个元素乘以 2（就地修改）。',
    '1 2 3',
    JSON_ARRAY('2 4 6'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for i in range(len(lst)):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    lst[i]*=2"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '通过索引就地修改元素避免生成新列表。',
    'in-place multiply'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1106,
    74,
    '安全删除示例',
    '补全：遍历并删除所有负数（安全方式）。',
    '1 -1 2 -3',
    JSON_ARRAY('1 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "res=[x for x in lst if x>=0]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*res)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '通过生成新列表来避免在遍历中删除产生的问题。',
    'list comprehension filter'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1107,
    74,
    '删除指定元素',
    '补全：删除列表中所有出现的 x。',
    '5 1 5 2
5',
    JSON_ARRAY('1 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "x=int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*[v for v in lst if v!=x])"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '生成新列表保留不等于 x 的元素。',
    'filter x out'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1108,
    74,
    '替换元素',
    '补全：将列表中所有 0 替换为 1。',
    '0 2 0',
    JSON_ARRAY('1 2 1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for i,v in enumerate(lst):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if v==0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        lst[i]=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用索引就地修改元素更直接。',
    'enumerate for index'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1109,
    74,
    '反向遍历删除',
    '补全：反向遍历并删除奇数。',
    '1 2 3 4 5',
    JSON_ARRAY('2 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for i in range(len(lst)-1,-1,-1):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if lst[i]%2==1:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        del lst[i]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '反向遍历删除安全且直接。',
    'del by index'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1110,
    74,
    '就地排序',
    '补全：对列表就地升序排序并打印。',
    '3 1 2',
    JSON_ARRAY('1 2 3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "lst.sort()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'list.sort() 在原列表就地排序，返回 None。',
    'lst.sort()'
);