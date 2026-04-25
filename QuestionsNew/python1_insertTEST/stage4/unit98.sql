USE `questions`;
-- Unit 98 | Start ID: 1456
-- Generated at 2025-12-24 22:45:08

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1456, 
    98, 
    'append 的作用', 
    'lst.append(x) 会怎样？', 
    JSON_OBJECT('A', '在末尾添加单个元素 x', 'B', '在末尾添加序列的每个元素', 'C', '替换末尾元素', 'D', '报错'), 
    1, 
    JSON_ARRAY('提示1：append 添加整个对象作为单个元素', '提示2：若传入列表作为参数，会把该列表作为单个元素添加', '提示3：想添加多个元素用 extend'), 
    'append 将传入对象作为单个元素追加到列表末尾。', 
    'a=[1]; a.append([2]); print(a)  # [1,[2]]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1457, 
    98, 
    'extend 的区别', 
    'lst.extend([1,2]) 与 append([1,2]) 的差别？', 
    JSON_OBJECT('A', 'extend 会展开序列并逐个添加', 'B', '两者等价', 'C', 'append 更快', 'D', 'extend 替换原列表'), 
    1, 
    JSON_ARRAY('提示1：extend 把参数当作可迭代项序列展开', '提示2：append 把整个参数当单个元素添加', '提示3：选择哪种方法取决于你想添加的粒度'), 
    'extend 会将传入的可迭代对象逐个追加到列表中，而 append 是作为一个元素整体添加。', 
    'a=[1]; a.extend([2,3])  # [1,2,3]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1458, 
    98, 
    'insert 用法', 
    'lst.insert(i, x) 会怎么做？', 
    JSON_OBJECT('A', '在索引 i 前插入元素 x', 'B', '替换索引 i 的元素', 'C', '在末尾插入', 'D', '抛出异常'), 
    1, 
    JSON_ARRAY('提示1：insert 在指定位置插入元素', '提示2：原有元素向后移动', '提示3：i 可为负值表示从末尾计算'), 
    'insert 在指定索引位置前插入元素，原元素右移。', 
    'a=[1,2]; a.insert(1,9)  # [1,9,2]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1459, 
    98, 
    'append 返回值', 
    '调用 lst.append(x) 后返回值通常是？', 
    JSON_OBJECT('A', 'None', 'B', '新列表', 'C', 'x', 'D', '布尔值'), 
    1, 
    JSON_ARRAY('提示1：append 就地修改列表', '提示2：就地修改方法一般返回 None', '提示3：不要把 lst.append(...) 赋值给变量期望得到新列表'), 
    'append 就地修改列表并返回 None。', 
    'res = lst.append(1); print(res)  # None'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1460, 
    98, 
    'insert 索引范围', 
    '当 i 大于列表长度时 insert(i,x) 会怎样？', 
    JSON_OBJECT('A', '在末尾插入', 'B', '抛出 IndexError', 'C', '在开始插入', 'D', '不做任何事'), 
    1, 
    JSON_ARRAY('提示1：insert 会在指定位置插入元素', '提示2：超出右边界会在末尾插入', '提示3：负索引会从右向左计数'), 
    'insert 若给定索引超出右边界，会把元素插入列表末尾。', 
    'a.insert(100,9)  # 相当于 append(9)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1461, 
    98, 
    'extend 可迭代性', 
    'extend 的参数必须是？', 
    JSON_OBJECT('A', '可迭代对象', 'B', '整数', 'C', '布尔值', 'D', '关键字参数'), 
    1, 
    JSON_ARRAY('提示1：extend 会迭代其参数并追加每个元素', '提示2：传入整数会被当作不可迭代并报错', '提示3：字符串是可迭代，会按字符添加'), 
    'extend 要求参数是可迭代对象，否则会报 TypeError。', 
    'a.extend("ab")  # 会把 "a" 和 "b" 分别加入'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1462, 
    98, 
    'append 与 extend 的选择', 
    '如果希望把一个列表作为单个元素加入，应该使用？', 
    JSON_OBJECT('A', 'append', 'B', 'extend', 'C', 'insert', 'D', 'remove'), 
    1, 
    JSON_ARRAY('提示1：append 将整体对象作为单元素加入', '提示2：extend 会展开参数', '提示3：insert 可指定位置但也作为单个元素'), 
    '若要把列表作为单个元素加入，使用 append。', 
    'a.append([1,2])  # 结果 [ [...], ... ]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1463, 
    98, 
    '链式调用', 
    '为什么不能像 lst.append(1).append(2) 链式调用？', 
    JSON_OBJECT('A', '因为 append 返回 None', 'B', '因为 append 返回新列表', 'C', '语法错误', 'D', '类型错误'), 
    1, 
    JSON_ARRAY('提示1：append 返回 None', '提示2：链式调用要求返回对象本身', '提示3：一些方法如 list.sort() 也返回 None'), 
    'append 返回 None，因此无法继续对返回值调用 append。', 
    'lst.append(1); lst.append(2)  # 分开写'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1464, 
    98, 
    'extend 性能', 
    '向大列表追加很多元素时，为什么 prefer extend 而不是多次 append？', 
    JSON_OBJECT('A', 'extend 只做一次扩容（更高效）', 'B', 'append 更快', 'C', '两者一样', 'D', 'append 会合并元素'), 
    1, 
    JSON_ARRAY('提示1：extend 可以一次性加入多个元素', '提示2：多次 append 可能导致多次重分配', '提示3：性能差距在大量元素时更明显'), 
    'extend 将整个可迭代对象一次性展开追加，通常比多次 append 更高效。', 
    'lst.extend(range(1000))'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1465,
    98,
    'append 示例（填空）',
    '向列表末尾添加元素 5 并打印。',
    '1 2',
    JSON_ARRAY('1 2 5'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(5)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('append', 'extend', 'insert', 'add'),
    JSON_ARRAY(1),
    '使用 lst.append(5) 将 5 作为单个元素加入末尾。',
    'a.append(3)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1466,
    98,
    'extend 示例（填空）',
    '将 [9,9] 展开加入列表末尾并打印。',
    '1 2',
    JSON_ARRAY('1 2 9 9'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "([9,9])"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('append', 'extend', 'insert', 'push'),
    JSON_ARRAY(2),
    '使用 extend 将序列的每个元素追加到列表末尾。',
    'a.extend([4,5])'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1467,
    98,
    'insert 示例（填空）',
    '在索引 1 处插入 99 并打印。',
    '1 2 3',
    JSON_ARRAY('1 99 2 3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(1,99)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('append', 'extend', 'insert', 'add'),
    JSON_ARRAY(3),
    '使用 lst.insert(1,99) 在位置 1 插入 99。',
    'a.insert(0,0)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1468,
    98,
    'extend 字符串行为（填空）',
    '对空列表执行 extend("ab") 后打印。',
    NULL,
    JSON_ARRAY('a b'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = []"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"ab\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('append', 'extend', 'insert', 'add'),
    JSON_ARRAY(2),
    '字符串是可迭代的，extend("ab") 会把字符逐一加入列表。',
    '[] .extend("hi") -> ["h","i"]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1469,
    98,
    'append 列表作为元素（填空）',
    '把 [9,9] 作为一个元素加入并打印。',
    '1 2',
    JSON_ARRAY('1 2 [9,9]'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "([9,9])"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(lst)"}]}]}',
    JSON_ARRAY('append', 'extend', 'insert', 'add'),
    JSON_ARRAY(1),
    'append 会把整个 [9,9] 作为单一元素追加。',
    'a.append([1,2])'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1470,
    98,
    'extend 对字符串（填空）',
    '对空列表执行 extend("abc") 并打印。',
    NULL,
    JSON_ARRAY('a b c'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = []"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"abc\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('append', 'extend', 'insert', 'add'),
    JSON_ARRAY(2),
    'extend 会把字符串按字符展开并添加到列表。',
    '[] .extend("hi") -> ["h","i"]'
);