USE `questions`;
-- Unit 99 | Start ID: 1471
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1471,
    99,
    'pop 的默认行为',
    'lst.pop() 默认移除并返回哪个元素？',
    JSON_OBJECT('A', '最后一个元素', 'B', '第一个元素', 'C', '指定索引元素', 'D', '整列'),
    1,
    JSON_ARRAY('提示1：pop 无参时弹出末尾元素', '提示2：可传入索引如 pop(0)', '提示3：返回被移除的值'),
    'pop() 在不传参时移除并返回最后一个元素；传参可移除指定索引。',
    'a=[1,2]; x=a.pop(); print(x)  # 2'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1472,
    99,
    'remove 行为',
    'lst.remove(x) 做了什么？',
    JSON_OBJECT('A', '移除第一个值等于 x 的元素', 'B', '移除所有等于 x 的元素', 'C', '按索引移除', 'D', '返回被移除的元素'),
    1,
    JSON_ARRAY('提示1：remove 按值移除第一处匹配', '提示2：若不存在会抛 ValueError', '提示3：移除多个需要循环或列表推导'),
    'remove 删去第一个匹配的值并返回 None，若无匹配则抛出异常。',
    'a=[1,2,1]; a.remove(1); print(a)  # [2,1]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1473,
    99,
    'sort 就地排序',
    'lst.sort() 与 sorted(lst) 的区别？',
    JSON_OBJECT('A', 'sort 就地修改返回 None，sorted 返回新列表', 'B', '两者相同', 'C', 'sort 返回新列表', 'D', 'sorted 就地修改'),
    1,
    JSON_ARRAY('提示1：sort 返回 None', '提示2：sorted 不修改原列表', '提示3：sorted 可用于生成新排序序列'),
    'sort 就地修改且返回 None，而 sorted 返回新的已排序列表。',
    'a=[2,1]; b=sorted(a); a.sort()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1474,
    99,
    'pop 示例（填空）',
    '读取一行列表并 pop 出最后一个元素打印。',
    JSON_ARRAY('1 2 3'),
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "())"}]}]}',
    JSON_ARRAY('pop', 'remove', 'pop(0)', 'pop_last'),
    JSON_ARRAY(1),
    '使用 lst.pop() 可以弹出并打印最后一个元素。',
    'a.pop()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1475,
    99,
    'remove 示例（填空）',
    '从列表中移除值 2 并打印列表。',
    JSON_ARRAY('1 2 3 2'),
    JSON_ARRAY('1 3 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(2)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('remove', 'pop', 'discard', 'delete'),
    JSON_ARRAY(1),
    '使用 lst.remove(2) 会移除第一个出现的 2。',
    'a.remove(5)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1476,
    99,
    'reverse 方法',
    'lst.reverse() 与 lst[::-1] 的区别？',
    JSON_OBJECT('A', 'reverse 就地修改，lst[::-1] 返回新列表', 'B', '两者等价并就地修改', 'C', 'lst[::-1] 就地修改', 'D', 'reverse 返回新列表'),
    1,
    JSON_ARRAY('提示1：reverse 是就地操作', '提示2：切片会生成副本', '提示3：选择取决于是否要保留原列表'),
    'reverse 会就地反转列表，切片 lst[::-1] 会生成反向副本。',
    'a.reverse(); b = a[::-1]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1477,
    99,
    'pop 指定索引',
    'lst.pop(i) 会怎样？',
    JSON_OBJECT('A', '移除并返回索引 i 的元素', 'B', '移除第一个元素', 'C', '移除最后一个元素', 'D', '按值移除'),
    1,
    JSON_ARRAY('提示1：pop 可带参数指定索引', '提示2：pop 返回被移除的元素', '提示3：若索引越界会抛 IndexError'),
    'pop(i) 会删除指定索引位置的元素并返回该元素。',
    'a.pop(0)  # 移除第一个元素并返回'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1478,
    99,
    'remove 异常',
    '当调用 lst.remove(x) 且 x 不在列表中会怎样？',
    JSON_OBJECT('A', '抛出 ValueError', 'B', '返回 None', 'C', '什么也不做', 'D', '返回 False'),
    1,
    JSON_ARRAY('提示1：remove 在找不到时会抛异常', '提示2：若不想异常可先判断 x in lst', '提示3：或用 try/except 捕获'),
    'remove 在找不到对应值时会抛 ValueError。',
    'if x in a: a.remove(x)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1479,
    99,
    'sort 示例（填空）',
    '对列表进行升序就地排序并打印。',
    JSON_ARRAY('3 1 2'),
    JSON_ARRAY('1 2 3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('sort', 'sorted', 'reverse', 'order'),
    JSON_ARRAY(1),
    '使用 lst.sort() 就地升序排列列表。',
    'a.sort()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1480,
    99,
    'reverse 示例（填空）',
    '就地反向列表并打印。',
    JSON_ARRAY('1 2 3'),
    JSON_ARRAY('3 2 1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('reverse', 'reversed', 'sort', 'pop'),
    JSON_ARRAY(1),
    '使用 lst.reverse() 可就地反转列表顺序。',
    'a.reverse()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1481,
    99,
    'pop 返回类型',
    'pop 返回的值是什么类型？',
    JSON_OBJECT('A', '被移除元素的类型', 'B', '列表类型', 'C', 'None', 'D', '布尔值'),
    1,
    JSON_ARRAY('提示1：pop 返回被移除的元素', '提示2：类型依赖于列表元素本身', '提示3：如果列表是整数列表，pop 返回整数'),
    'pop 返回被移除的元素，其类型即该元素的类型。',
    'x = a.pop()  # x 的类型与 a 的元素类型一致'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1482,
    99,
    'sort 参数 key',
    '使用 sort(key=...) 可以做什么？',
    JSON_OBJECT('A', '指定排序依据函数', 'B', '指定是否就地排序', 'C', '指定是否稳定排序', 'D', '无效参数'),
    1,
    JSON_ARRAY('提示1：key 用于对每个元素取关键字以比较', '提示2：常用 lambda 或 operator.itemgetter', '提示3：stable 属性由算法保证'),
    'sort(key=...) 允许提供函数以提取比较键，从而按自定义规则排序。',
    'lst.sort(key=lambda x: x[1])'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1483,
    99,
    'remove 与 del 区别',
    'remove(x) 与 del lst[i] 最大区别是？',
    JSON_OBJECT('A', 'remove 按值，del 按索引', 'B', 'remove 按索引，del 按值', 'C', '两者等价', 'D', 'remove 会返回值'),
    1,
    JSON_ARRAY('提示1：remove 查找第一个匹配的值并删除', '提示2：del 直接根据索引删除', '提示3：del 语句不是方法'),
    'remove 使用值删除第一个匹配项，del 通过索引删除并不返回值。',
    'del lst[0]; lst.remove(3)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1484,
    99,
    'pop 指定索引（填空）',
    '从索引 1 弹出元素并打印该值。',
    JSON_ARRAY('10 20 30'),
    JSON_ARRAY('20'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(1))"}]}]}',
    JSON_ARRAY('pop', 'remove', 'pop(1)', 'pop_index'),
    JSON_ARRAY(3),
    'pop(1) 返回并移除索引 1 的元素。',
    'x = lst.pop(2)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1485,
    99,
    'sort 返回值（填空）',
    '下列代码打印什么？

a=[3,1,2]
print(a.sort())
print(a)',
    NULL,
    JSON_ARRAY('None', '1 2 3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a=[3,1,2]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(a."}, {"type": "slot", "index": 0}, {"type": "code", "value": "())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*a)"}]}]}',
    JSON_ARRAY('None and 1 2 3', '[1,2,3] and [1,2,3]', 'Error', 'None and original'),
    JSON_ARRAY(1),
    'a.sort() 返回 None（打印 None），但 a 被就地排序后为 [1,2,3]。',
    'a.sort(); print(a)'
);