USE `questions`;
-- Unit 95 | Start ID: 1411
-- Generated at 2025-12-24 18:10:34

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1411, 
    95, 
    'del 用途', 
    'del lst[i] 会怎样？', 
    JSON_OBJECT('A', '删除索引 i 的元素并改变长度', 'B', '返回被删除元素', 'C', '替换元素为 None', 'D', '抛出异常'), 
    1, 
    JSON_ARRAY('del 是语句非函数', '会移除元素并缩短列表长度'), 
    'del 会删除指定索引的元素并修改列表。', 
    'del lst[0]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1412, 
    95, 
    'remove 用法', 
    'lst.remove(x) 的作用是？', 
    JSON_OBJECT('A', '删除首次出现的 x', 'B', '删除所有 x', 'C', '按索引删除', 'D', '弹出末尾元素'), 
    1, 
    JSON_ARRAY('remove 按值删除首次匹配元素', '不存在时抛出 ValueError'), 
    'remove 会删除第一个匹配的元素并抛出异常若不存在。', 
    'lst.remove(3)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1413, 
    95, 
    'pop 用途', 
    'lst.pop(i) 是什么行为？', 
    JSON_OBJECT('A', '移除并返回索引 i 的元素（默认最后一个）', 'B', '仅返回元素不删除', 'C', '删除所有元素', 'D', '只适用于栈'), 
    1, 
    JSON_ARRAY('pop 返回被移除元素', '不传 i 则弹出末尾'), 
    'pop 在删除元素的同时返回其值。', 
    'x = lst.pop()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1414, 
    95, 
    'clear 用途', 
    'lst.clear() 会怎样？', 
    JSON_OBJECT('A', '移除所有元素', 'B', '删除列表对象', 'C', '返回空列表副本', 'D', '将所有元素设为 None'), 
    1, 
    JSON_ARRAY('clear 使列表变为空列表'), 
    'clear 会就地清除列表中的所有元素。', 
    'lst.clear()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1415, 
    95, 
    'del 效果', 
    'del lst[i:j] 会怎样？', 
    JSON_OBJECT('A', '删除区间内元素', 'B', '保留区间元素', 'C', '抛错', 'D', '仅标记删除'), 
    1, 
    JSON_ARRAY('切片赋值和 del 切片都可批量删除'), 
    'del 对切片范围会删除对应的所有元素。', 
    'del lst[1:3]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1416, 
    95, 
    'remove 异常', 
    'remove 在找不到值时会怎样？', 
    JSON_OBJECT('A', '抛出 ValueError', 'B', '返回 False', 'C', '不做任何事', 'D', '添加该元素'), 
    1, 
    JSON_ARRAY('需要预先检查是否存在或捕获异常'), 
    'remove 找不到元素时会抛出 ValueError，需小心使用。', 
    'try: lst.remove(x) except ValueError:'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1417, 
    95, 
    '删除效率', 
    '大量删除列表元素时推荐？', 
    JSON_OBJECT('A', '生成新列表并赋值', 'B', '循环 remove', 'C', '多次 pop(0)', 'D', 'insert'), 
    1, 
    JSON_ARRAY('循环 remove 或 pop(0) 可能效率低下'), 
    '生成新列表通常更高效且避免迭代删除时索引跳变问题。', 
    'res=[x for x in lst if cond]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1418, 
    95, 
    'pop 参数', 
    'pop 不传参数时弹出哪个元素？', 
    JSON_OBJECT('A', '最后一个', 'B', '第一个', 'C', '中间元素', 'D', '抛错'), 
    1, 
    JSON_ARRAY('默认行为为弹出末尾元素'), 
    'pop() 默认弹出并返回最后一个元素。', 
    'lst.pop()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1419, 
    95, 
    'del vs remove', 
    'del 与 remove 的主要区别是？', 
    JSON_OBJECT('A', 'del 按索引删除，remove 按值删除', 'B', 'del 按值，remove 按索引', 'C', '两者相同', 'D', 'remove 返回删除值'), 
    1, 
    JSON_ARRAY('remove 需要值作为参数', 'del 使用索引或切片'), 
    'del 用于索引和切片删除，remove 根据值删除首次匹配项。', 
    'del lst[0]; lst.remove(0)'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1420,
    95,
    '删除指定值',
    '补全：删除列表中的 5（若存在）。',
    '1 5 3',
    JSON_ARRAY('1 3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": " in lst:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    lst."}, {"type": "slot", "index": 1}, {"type": "code", "value": "(5)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('in', 'remove', 'del', 'pop'),
    JSON_ARRAY(1, 2),
    '先判断存在再调用 remove 可避免异常。',
    'if x in lst: lst.remove(x)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1421,
    95,
    'pop 返回值',
    '补全：弹出并打印最后一个元素。',
    '1 2 3',
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "())"}]}]}',
    JSON_ARRAY('pop', 'remove', 'del', 'append'),
    JSON_ARRAY(1),
    'pop 会返回被弹出的元素值。',
    'v = lst.pop()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1422,
    95,
    '删除多个',
    '补全：删除列表中所有为 0 的元素并打印。',
    '0 1 0 2',
    JSON_ARRAY('1 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(*[x for x in lst if x!=0])"}]}]}',
    JSON_ARRAY('list compr', 'remove', 'pop', 'del'),
    JSON_ARRAY(1),
    '生成新列表保留不等于 0 的元素是安全且直接的方法。',
    'res = [x for x in lst if cond]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1423,
    95,
    '按索引删除',
    '补全：删除索引 1 的元素并打印结果。',
    'a b c',
    JSON_ARRAY('a c'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=input().split()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": ""}, {"type": "slot", "index": 0}, {"type": "code", "value": " lst[1]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('del', 'pop', 'remove', 'clear'),
    JSON_ARRAY(1),
    'del 可用于按索引删除元素。',
    'del lst[i]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1424,
    95,
    'safe remove',
    '补全：尝试删除 x，若不存在则打印 NotFound。',
    '1 2 3
4',
    JSON_ARRAY('NotFound'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "x=int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": " in lst:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    lst."}, {"type": "slot", "index": 1}, {"type": "code", "value": "(x)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "else:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    "}, {"type": "slot", "index": 2}, {"type": "code", "value": "(\"NotFound\")"}]}]}',
    JSON_ARRAY('in', 'remove', 'print', 'del'),
    JSON_ARRAY(1, 2, 3, 4),
    '先检查再删除能避免异常并提供友好提示。',
    'if x in lst:'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1425,
    95,
    '清空列表',
    '补全：就地清空列表并打印长度。',
    '1 2 3',
    JSON_ARRAY('0'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(len(lst))"}]}]}',
    JSON_ARRAY('clear', 'del', 'remove', 'pop'),
    JSON_ARRAY(1),
    'clear 方法会清空所有元素，len 返回 0。',
    'lst.clear()'
);