USE `questions`;
-- Unit 43 | Start ID: 631
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    631,
    43,
    '集合成员检查',
    '检查元素是否在集合中通常使用哪个运算符？',
    JSON_OBJECT('A', 'in', 'B', 'contains', 'C', 'has', 'D', 'find'),
    1,
    JSON_ARRAY('in 用于序列/集合成员测试', '集合的成员测试效率高', '语义直观'),
    '使用 in 来测试元素是否存在于集合或序列中。',
    'if x in myset: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    632,
    43,
    '列表与集合的区别',
    '集合和列表主要区别是什么？',
    JSON_OBJECT('A', '集合元素唯一且无序', 'B', '列表元素唯一', 'C', '集合有索引', 'D', '列表无序'),
    1,
    JSON_ARRAY('集合不保存顺序', '集合里不能有重复元素', '列表保留顺序并允许重复'),
    '集合保证唯一性且无序，列表保留顺序且允许重复。',
    'set([1,1,2]) -> {1,2}'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    633,
    43,
    '集合运算',
    '下面哪个操作可以得到两个集合的交集？',
    JSON_OBJECT('A', 'a & b 或 a.intersection(b)', 'B', 'a + b', 'C', 'a * b', 'D', 'a | b'),
    1,
    JSON_ARRAY('& 表示交集', '| 表示并集', '- 表示差集'),
    '使用 & 或 intersection 得到交集。',
    '{1,2} & {2,3} -> {2}'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    634,
    43,
    '集合去重练习',
    '补全：用集合快速去重并打印长度。',
    JSON_ARRAY('lst=[1,1,2]'),
    JSON_ARRAY('2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = [1,1,2]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(len(set("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")))"}]}]}',
    JSON_ARRAY('lst', 'set', 'list', 'tuple'),
    JSON_ARRAY(1),
    '将列表转为集合可去重，然后用 len 计数。',
    'len(set([1,2,2]))'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    635,
    43,
    '用集合判断重复',
    '补全：检测列表中是否有重复元素。',
    JSON_ARRAY('lst=[1,2,2]'),
    JSON_ARRAY('Has duplicate'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = [1,2,2]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if len(set(lst)) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " len(lst):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Has duplicate\\")"}]}]}',
    JSON_ARRAY('<', '>', '==', '!='),
    JSON_ARRAY(1),
    '去重后长度小于原始长度表示存在重复。',
    'if len(set(a)) != len(a): ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    636,
    43,
    '集合不可变类型',
    '下列哪种元素不能直接放入集合？',
    JSON_OBJECT('A', 'list', 'B', 'int', 'C', 'tuple (只含不可变)', 'D', 'str'),
    1,
    JSON_ARRAY('集合元素必须可哈希', 'list 是可变类型不可哈希', 'tuple 若其元素可哈希则可作为集合元素'),
    'list 是可变且不可哈希，不能作为集合元素。',
    's = set()
s.add((1,2))'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    637,
    43,
    '集合常见用途',
    '集合常用于？',
    JSON_OBJECT('A', '去重、成员检测、集合运算', 'B', '保持元素顺序', 'C', '索引访问', 'D', '存储键值对'),
    1,
    JSON_ARRAY('集合提供高效成员检测', '不保证顺序', '适合去重和集合运算'),
    '集合最常用于去重和高效的成员检测与集合运算。',
    'a_set = set(lst)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    638,
    43,
    '使用 in 的性能',
    '在集合中使用 in 的时间复杂度通常是？',
    JSON_OBJECT('A', '平均 O(1)', 'B', 'O(n)', 'C', 'O(log n)', 'D', 'O(n^2)'),
    1,
    JSON_ARRAY('集合基于哈希表', '平均常数时间查找', '最坏情况可能退化'),
    '集合的成员检测在平均情况下为 O(1)。',
    'if x in large_set: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    639,
    43,
    '集合交并练习',
    '补全：计算 a 与 b 的并集并打印大小。',
    JSON_ARRAY('a=[1,2]; b=[2,3]'),
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = [1,2]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b = [2,3]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(len(set(a) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " set(b)))"}]}]}',
    JSON_ARRAY('&', '|', '-', '^'),
    JSON_ARRAY(2),
    '并集用 | 或 union 表示。',
    'set(a) | set(b)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    640,
    43,
    '集合差集练习',
    '补全：求 a 中有但 b 中没有的元素。',
    JSON_ARRAY('a=[1,2,3]; b=[2]'),
    JSON_ARRAY('{1,3}'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = [1,2,3]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b = [2]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(set(a) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " set(b))"}]}]}',
    JSON_ARRAY('|', '&', '-', '^'),
    JSON_ARRAY(3),
    '差集用 - 表示。',
    'set(a) - set(b)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    641,
    43,
    'frozenset 的用途',
    '何时使用 frozenset？',
    JSON_OBJECT('A', '需要不可变集合作为字典键时', 'B', '需要可变集合', 'C', '用于列表拼接', 'D', '用于字符串拼接'),
    1,
    JSON_ARRAY('frozenset 是不可变的', '可作为字典的键或其他集合元素', '用于需要哈希的场景'),
    'frozenset 不可变且可哈希，适合作为字典键或集合元素。',
    'd[frozenset([1,2])] = 3'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    642,
    43,
    '列表转集合的副作用',
    '把列表转为集合会发生什么？',
    JSON_OBJECT('A', '去重且丢弃顺序', 'B', '保留原列表顺序并去重', 'C', '变成列表的拷贝', 'D', '转换失败'),
    1,
    JSON_ARRAY('集合不保序', '会去掉重复元素', '适合去重使用'),
    '转换会去重并且结果集合没有原始的顺序保证。',
    'set([3,1,2,1]) -> {1,2,3}'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    643,
    43,
    '集合推导',
    '下面哪个是集合推导的正确语法？',
    JSON_OBJECT('A', '{x for x in seq if cond}', 'B', '[x for x in seq]', 'C', '(x for x in seq)', 'D', '{x: x for x in seq}'),
    1,
    JSON_ARRAY('{} 包含集合推导或 dict 推导', '带冒号时是 dict 推导', '圆括号是生成器表达式'),
    '集合推导写作 {x for x in seq if cond}。',
    '{n for n in nums if n%2==0}'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    644,
    43,
    '练习：从列表中选偶数并去重',
    '补全：用集合推导保存偶数。',
    JSON_ARRAY('lst=[1,2,2,3,4]'),
    JSON_ARRAY('{2,4}'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = [1,2,2,3,4]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "evens = {x for x in lst if x % 2 == 0}"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(evens)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    '集合推导可同时筛选并去重。',
    '见代码'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    645,
    43,
    '实践：集合在判断中的应用',
    '补全：判断输入字符是否是元音（用集合）。',
    JSON_ARRAY('ch="e"'),
    JSON_ARRAY('vowel'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "vowels = {\\"a\\",\\"e\\",\\"i\\",\\"o\\",\\"u\\"}"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "ch = input().lower()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if ch in vowels:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"vowel\\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    '使用集合进行成员检测简洁且高效。',
    'if c in {"0","1"}: ...'
);