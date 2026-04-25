USE `questions`;
-- Unit 100 | Start ID: 1486
-- Generated at 2025-12-24 23:29:29

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1486, 
    100, 
    '方法返回值复习', 
    '下面哪个方法是就地修改并返回 None？', 
    JSON_OBJECT('A', 'append', 'B', 'sorted', 'C', 'reversed', 'D', 'sum'), 
    1, 
    JSON_ARRAY('提示1：append 就地修改', '提示2：sorted 返回新列表', '提示3：sum 返回数值'), 
    'append 就地修改并返回 None，而 sorted 返回新列表。', 
    'res = lst.append(1)  # res 为 None'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1487, 
    100, 
    '切片与方法区别', 
    '下列哪种操作不会改变原列表对象引用（id）？', 
    JSON_OBJECT('A', 'lst[:] = [1]', 'B', 'lst = [1]', 'C', 'lst = lst + [1]', 'D', 'lst = [1] + lst'), 
    1, 
    JSON_ARRAY('提示1：lst[:] 就地替换', '提示2：赋值给 lst 会改变引用', '提示3：+ 会生成新列表'), 
    'lst[:] = ... 会保留原对象并替换其内容，从而保持 id 不变。', 
    'a=[1]; b=a; a[:] = [2]; print(a,b)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1488, 
    100, 
    '方法选择题', 
    '要把列表 [1,2] 变为 [1,9,2] 最合适的方法是？', 
    JSON_OBJECT('A', 'insert', 'B', 'extend', 'C', 'append', 'D', 'remove'), 
    1, 
    JSON_ARRAY('提示1：需要在中间插入元素', '提示2：insert 可在指定位置插入', '提示3：append 只能添加到末尾'), 
    'insert 可在索引 1 处插入 9，使得列表变成 [1,9,2]。', 
    'a.insert(1,9)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1489,
    100,
    '综合操作（填空）',
    '先 append(9) 再 pop() 并打印列表。',
    '1 2',
    JSON_ARRAY('1 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "lst.append(9)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('pop', 'remove', 'sort', 'reverse'),
    JSON_ARRAY(1),
    'append 后 pop 会移除刚加入的 9，列表恢复原状。',
    'a.append(3); a.pop()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1490,
    100,
    '组合操作（填空）',
    '在索引 1 插入 0，然后就地排序并打印。',
    '3 1 2',
    JSON_ARRAY('0 1 2 3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "lst.insert(1,0)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('sort', 'reverse', 'extend', 'pop'),
    JSON_ARRAY(1),
    '插入后使用 sort() 就地排序。',
    'a.insert(1,0); a.sort()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1491, 
    100, 
    '常见错误', 
    '下列哪种写法会导致链式 append 调用失败？', 
    JSON_OBJECT('A', 'lst.append(1).append(2)', 'B', 'lst.append(1); lst.append(2)', 'C', 'lst.extend([1,2])', 'D', 'lst += [1,2]'), 
    1, 
    JSON_ARRAY('提示1：append 返回 None', '提示2：Therefore 链式写法不可用', '提示3：用分号或换行分两步调用'), 
    'append 返回 None，不能链式调用。', 
    '正确写法：lst.append(1); lst.append(2)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1492, 
    100, 
    '切片插入复习', 
    '用哪个操作可在索引 2 处插入多个元素？', 
    JSON_OBJECT('A', 'lst[2:2] = [a,b]', 'B', 'lst.insert(2, [a,b])', 'C', 'lst.append([a,b])', 'D', 'lst.extend([a,b]) at position 2'), 
    1, 
    JSON_ARRAY('提示1：切片赋值可在中间位置插入序列', '提示2：insert 会把序列作为单个元素插入', '提示3：extend 不能指定位置'), 
    'lst[2:2] = [...] 会在索引 2 处插入多个元素。', 
    'a[1:1]=[9,9]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1493, 
    100, 
    'pop 与 del 对比', 
    '要移除并使用被移除的值应使用？', 
    JSON_OBJECT('A', 'pop', 'B', 'del', 'C', 'remove', 'D', 'clear'), 
    1, 
    JSON_ARRAY('提示1：pop 返回被移除值', '提示2：del 不返回值', '提示3：remove 按值删除'), 
    'pop 会返回被移除的元素，方便随后使用。', 
    'x = a.pop()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1494,
    100,
    '复合练习（填空）',
    '对列表执行 append(7) 然后 remove 第一个 1 并打印。',
    '1 2 1',
    JSON_ARRAY('2 1 7'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "lst.append(7)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(1)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('remove', 'pop', 'sort', 'reverse'),
    JSON_ARRAY(1),
    'append 加入 7，remove(1) 移除第一个出现的 1。',
    'a.append(5); a.remove(5)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1495,
    100,
    '排序并弹出（填空）',
    '对列表升序排序后弹出最大值并打印该值。',
    '3 1 2',
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "lst.sort()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "())"}]}]}',
    JSON_ARRAY('pop', 'remove', 'pop(0)', 'pop_last'),
    JSON_ARRAY(1),
    '排序后最大值位于末尾，用 pop() 弹出并返回该值。',
    'a.sort(); print(a.pop())'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1496, 
    100, 
    'in 操作与 remove', 
    '在 remove 前检查元素是否存在通常应先做什么？', 
    JSON_OBJECT('A', '使用 if x in lst', 'B', '直接调用 remove', 'C', '使用 try/except 不用检查', 'D', '用 pop 替代'), 
    1, 
    JSON_ARRAY('提示1：remove 在值不存在时会抛异常', '提示2：in 操作是快速检查', '提示3：也可用 try/except 捕获'), 
    '先用 if x in lst 可避免调用 remove 时抛出 ValueError。', 
    'if x in a: a.remove(x)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1497, 
    100, 
    'reverse 与 sorted', 
    '要得到降序的新列表应使用？', 
    JSON_OBJECT('A', 'sorted(lst, reverse=True)', 'B', 'lst.sort(reverse=True) 并赋值给新变量', 'C', 'lst.reverse()', 'D', 'lst[::-1]'), 
    1, 
    JSON_ARRAY('提示1：sorted 返回新列表', '提示2：lst.sort() 就地修改', '提示3：lst[::-1] 生成反向副本但不是按值排序'), 
    'sorted(lst, reverse=True) 会返回按值降序的新列表，适合需要新对象的场景。', 
    'b = sorted(a, reverse=True)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1498, 
    100, 
    '清空列表', 
    '哪种方法可清空列表但保留对象引用？', 
    JSON_OBJECT('A', 'lst.clear()', 'B', 'lst = []', 'C', 'del lst', 'D', 'lst.pop() 多次'), 
    1, 
    JSON_ARRAY('提示1：clear 就地清空', '提示2：lst = [] 会改变引用', '提示3：del 会删除变量'), 
    'lst.clear() 会清空列表内容同时保持对象引用不变。', 
    'a.clear()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1499,
    100,
    '清空演示（填空）',
    '对列表调用 clear() 并打印与引用变量。',
    '1 2',
    JSON_ARRAY('[] []'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b = a"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "a."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(a, b)"}]}]}',
    JSON_ARRAY('clear', 'del', '=[]', 'pop', 'remove'),
    JSON_ARRAY(1),
    'clear 就地清空，b 作为引用亦会看到空列表。',
    'a.clear()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1500,
    100,
    '复合题（填空）',
    '对列表执行 extend([4,5]) 然后 pop() 并打印最终列表。',
    '1 2',
    JSON_ARRAY('1 2 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "lst.extend([4,5])"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('pop', 'remove', 'pop(0)', 'clear'),
    JSON_ARRAY(1),
    'extend 后 pop() 弹出末尾元素 5，剩下 ...4。',
    'a.extend([4,5]); a.pop()'
);