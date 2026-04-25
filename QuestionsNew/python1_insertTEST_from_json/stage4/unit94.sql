USE `questions`;
-- Unit 94 | Start ID: 1396
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1396,
    94,
    'append 用途',
    'list.append(x) 做什么？',
    JSON_OBJECT('A', '在末尾添加元素', 'B', '在开头添加', 'C', '插入指定索引', 'D', '删除元素'),
    1,
    JSON_ARRAY('append 在末尾追加', 'insert 可用于任意位置'),
    'append 方法将元素添加到列表末尾并改变原列表。',
    'lst.append(1)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1397,
    94,
    'insert 用法',
    'list.insert(i,x) 的作用是？',
    JSON_OBJECT('A', '在索引 i 前插入 x', 'B', '替换索引 i', 'C', '删除索引 i', 'D', '交换元素'),
    1,
    JSON_ARRAY('insert 不会覆盖原有元素，会右移它们'),
    'insert 在指定位置插入元素，后续元素向右移动。',
    'lst.insert(0, x)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1398,
    94,
    'extend vs append',
    'lst.extend([1,2]) 与 lst.append([1,2]) 区别是？',
    JSON_OBJECT('A', 'extend 展开序列并添加元素', 'B', '两者相同', 'C', 'append 把元素逐个添加', 'D', 'extend 添加为子列表'),
    1,
    JSON_ARRAY('append 把整个对象当作单个元素追加'),
    'extend 会把可迭代拆开逐个添加，而 append 将整个对象作为单一元素追加。',
    'lst.extend([1,2])'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1399,
    94,
    'append 示例',
    '补全：把输入数字逐个追加到列表并打印。',
    JSON_ARRAY('1 2 3'),
    JSON_ARRAY('[1,2,3]'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=[]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x in input().split():"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(int(x))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(lst)"}]}]}',
    JSON_ARRAY('append', 'extend', 'insert', 'split'),
    JSON_ARRAY(1),
    '使用 append 在循环中逐个添加元素。',
    'for x in data: lst.append(x)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1400,
    94,
    'extend 示例',
    '补全：将两个列表合并到第一个列表（就地）。',
    JSON_ARRAY('1 2
3 4'),
    JSON_ARRAY('[1,2,3,4]'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "a."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(b)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(a)"}]}]}',
    JSON_ARRAY('extend', 'append', '+', 'insert'),
    JSON_ARRAY(1),
    'extend 会在原列表上就地添加另一个可迭代的元素。',
    'a.extend(b)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1401,
    94,
    'append 返回值',
    'list.append 的返回值是什么？',
    JSON_OBJECT('A', 'None', 'B', '新列表', 'C', '被添加元素', 'D', '布尔值'),
    1,
    JSON_ARRAY('就地操作通常返回 None'),
    'append 就地修改列表并返回 None，这是 Python 的常见设计。',
    'x = lst.append(1) # x 是 None'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1402,
    94,
    '插入边界',
    '使用 insert 插入索引超出范围时发生？',
    JSON_OBJECT('A', '插入到末尾', 'B', '抛出异常', 'C', '插入到开头', 'D', '不插入'),
    1,
    JSON_ARRAY('超出上界会追加到末尾'),
    '插入索引大于长度时，元素会被追加到列表末尾。',
    'lst.insert(100, x)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1403,
    94,
    'extend 性能',
    '大量拼接列表时推荐使用？',
    JSON_OBJECT('A', 'extend 或 收集后 join', 'B', '在循环中多次 +', 'C', '不断创建新列表', 'D', '使用 insert'),
    1,
    JSON_ARRAY('extend 就地扩展效率更高'),
    'extend 就地扩展更高效，频繁使用 + 会产生大量临时对象。',
    'a.extend(b)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1404,
    94,
    '插入示例',
    '补全：将 99 插入索引 1 并打印。',
    JSON_ARRAY('1 2 3'),
    JSON_ARRAY('1 99 2 3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(1,99)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*lst)"}]}]}',
    JSON_ARRAY('insert', 'append', 'extend', 'del'),
    JSON_ARRAY(1),
    'insert 用于在指定位置插入元素并保持顺序。',
    'lst.insert(i,x)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1405,
    94,
    'concat vs extend',
    '补全：用 extend 就地合并并打印第一个列表。',
    JSON_ARRAY('1 2
3 4'),
    JSON_ARRAY('1 2 3 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "a."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(b)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*a)"}]}]}',
    JSON_ARRAY('extend', '+', 'append', 'insert'),
    JSON_ARRAY(1),
    'extend 就地扩展，不会返回新列表。',
    'a.extend(b)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1406,
    94,
    '插入耗时',
    '在列表开头插入大量元素通常会怎样？',
    JSON_OBJECT('A', '较慢，因为需移动大量元素', 'B', '很快', 'C', '和末尾相同', 'D', 'total O(1)'),
    1,
    JSON_ARRAY('列表为数组结构，开头插入需移动元素'),
    '在列表开头插入会触发后续元素整体移动，成本较高，适合使用 deque。',
    'from collections import deque'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1407,
    94,
    'append 多次',
    '若需重复添加很多元素，推荐做法是？',
    JSON_OBJECT('A', '预分配或收集后 extend', 'B', '每次 append', 'C', '使用 insert 头部添加', 'D', '使用 tuple'),
    1,
    JSON_ARRAY('减少重复扩容开销'),
    '收集元素后一次 extend 或预估并分配能减少多次扩容的成本。',
    'parts=[]; parts.extend(chunk)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1408,
    94,
    'append 与 +=',
    'lst += [1,2] 与 lst.extend([1,2]) 区别？',
    JSON_OBJECT('A', '等价（就地扩展）', 'B', '不同，前者返回新列表', 'C', '前者报错', 'D', '后者返回 None'),
    1,
    JSON_ARRAY('+= 在列表上就地扩展'),
    '对于列表，+= 会就地扩展，等价于 extend。',
    'lst += other'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1409,
    94,
    'append None',
    '补全：向列表追加 None 并打印。',
    JSON_ARRAY('1 2'),
    JSON_ARRAY('1 2 None'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(lst)"}]}]}',
    JSON_ARRAY('append', 'None', 'extend', 'insert'),
    JSON_ARRAY(1, 2),
    'append 可以添加任意对象，包括 None。',
    'lst.append(obj)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1410,
    94,
    'extend 可迭代',
    '补全：extend 接受的参数类型是？',
    JSON_ARRAY('1 2
3 4'),
    JSON_ARRAY('(combined)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b=map(int,input().split())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "a."}, {"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*a)"}]}]}',
    JSON_ARRAY('iterable', 'list', 'dict', 'int'),
    JSON_ARRAY(1, 2),
    'extend 接受任意可迭代对象。',
    'a.extend(range(3))'
);