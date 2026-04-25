USE `questions`;
-- Unit 83 | Start ID: 1231
-- Generated at 2025-12-24 23:24:23

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1231, 
    83, 
    'chain 用途', 
    'itertools.chain 用来做什么？', 
    JSON_OBJECT('A', '串联多个可迭代对象', 'B', '并行迭代', 'C', '分割序列', 'D', '压缩数据'), 
    1, 
    JSON_ARRAY('chain 不会复制元素', '适合流式合并'), 
    'itertools.chain 可以把多个可迭代对象串联成一个迭代序列而不生成中间列表。', 
    'for x in itertools.chain(a,b):'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1232, 
    83, 
    'islice 用途', 
    'itertools.islice 的作用是？', 
    JSON_OBJECT('A', '从迭代器中切片取出部分元素', 'B', '替代 list 切片', 'C', '只用于列表', 'D', '不适用于迭代器'), 
    1, 
    JSON_ARRAY('islice 支持对迭代器按索引区间取子序列'), 
    'islice 可对迭代器按索引区间取出子序列，适合从流中取有限元素。', 
    'islice(it, start, stop)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1233, 
    83, 
    'groupby 特点', 
    'itertools.groupby 在使用时需要注意？', 
    JSON_OBJECT('A', '输入必须先排序以得到预期分组', 'B', '不需排序', 'C', '自动去重', 'D', '返回 dict'), 
    1, 
    JSON_ARRAY('groupby 按相邻相同元素分组'), 
    'groupby 只对相邻相同元素分组，因此通常需要先根据键对序列排序。', 
    'for k, g in groupby(sorted(data), key=...):'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1234,
    83,
    '用 chain',
    '补全：把两行输入串联并打印。',
    'a b
c d',
    JSON_ARRAY('a b c d'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import itertools"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "for x in itertools.chain(input().split(), input().split()):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(x, end=\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'chain 可按顺序串联多个可迭代对象进行遍历。',
    'chain(a,b)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1235,
    83,
    '用 islice',
    '补全：从输入流取前 2 个元素并打印。',
    '1 2 3',
    JSON_ARRAY('1 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from itertools import islice"}, {"type": "code_line", "value": "import sys"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "it=map(int, sys.stdin.read().split())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(list(islice(it,"}, {"type": "slot", "index": 0}, {"type": "code", "value": ")))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'islice 可以从迭代器中取指定数量元素。',
    'islice(it, n)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1236, 
    83, 
    '无限迭代器', 
    'itertools.count 是什么？', 
    JSON_OBJECT('A', '生成无限递增序列', 'B', '计数列表长度', 'C', '终止迭代器', 'D', '返回最后元素'), 
    1, 
    JSON_ARRAY('count 从起始值开始无限递增'), 
    'itertools.count 会产生一个无限序列，通常需要配合其他工具限制长度。', 
    'for i in itertools.count(1): if i>n: break'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1237, 
    83, 
    'repeat 用途', 
    'itertools.repeat 常用于？', 
    JSON_OBJECT('A', '生成重复值（如占位）', 'B', '重复列表元素', 'C', '不常用', 'D', '替代乘法'), 
    1, 
    JSON_ARRAY('repeat 可以和 map/zipped 一起使用'), 
    'repeat 可生成重复的常量值，用于配合 map 或提供默认值。', 
    'zip(it, itertools.repeat(default))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1238, 
    83, 
    '过滤工具', 
    'itertools.filterfalse 与 filter 有何区别？', 
    JSON_OBJECT('A', 'filterfalse 选出不满足谓词的项', 'B', '功能相同', 'C', 'filterfalse 更快', 'D', '已弃用'), 
    1, 
    JSON_ARRAY('filter 选出满足谓词的项'), 
    'filterfalse 会返回不满足谓词的元素，和 filter 相反。', 
    'from itertools import filterfalse'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1239,
    83,
    '用 groupby',
    '补全：对按第一个字符分组的简单示例。',
    'a1 a2 b1',
    JSON_ARRAY('group a: a1 a2', 'group b: b1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from itertools import groupby"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "arr=input().split()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "for k,g in groupby(sorted(arr, key=lambda x: x[0]), key=lambda x: x[0]):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(\"group\", k, \":\", *list(g))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '对数据按某个键排序后用 groupby 得到分组迭代器。',
    'groupby(sorted(data), key=...)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1240,
    83,
    '限制无限迭代',
    '补全：配合 islice 限制 count 的输出。',
    NULL,
    JSON_ARRAY('(none)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import itertools"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "for i in itertools.islice(itertools.count(1), "}, {"type": "slot", "index": 0}, {"type": "code", "value": "):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(i, end=\""}, {"type": "slot", "index": 1}, {"type": "code", "value": "\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '把无限迭代器与 islice 结合可拾取有限数量元素。',
    'islice(count(), n)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1241, 
    83, 
    '工具组合', 
    'itertools 常与何种类型函数配合使用？', 
    JSON_OBJECT('A', '生成器与迭代器函数', 'B', 'GUI 函数', 'C', '数据库调用', 'D', '仅用于字符串'), 
    1, 
    JSON_ARRAY('itertools 设计用于迭代式数据流处理'), 
    'itertools 提供对迭代器的高效组合与变换，常与生成器结合使用。', 
    'map, filter, chain, islice 等'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1242, 
    83, 
    '性能优势', 
    '使用 itertools 的优势通常是？', 
    JSON_OBJECT('A', '延迟计算且内存友好', 'B', '更耗内存', 'C', '语法糖无性能优势', 'D', '无法工作于大数据'), 
    1, 
    JSON_ARRAY('itertools 基于迭代器可节省内存'), 
    'itertools 的函数多数返回迭代器，支持延迟计算，适合大数据流处理。', 
    'itertools.chain, islice'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1243, 
    83, 
    '使用场景', 
    '何时用 itertools.groupby？', 
    JSON_OBJECT('A', '需要按相邻相同键分组时', 'B', '统计长度时', 'C', '替代 dict.get', 'D', 'JSON 解析'), 
    1, 
    JSON_ARRAY('groupby 依据相邻元素键值分组，常配合排序使用'), 
    'groupby 常用于对排序后数据进行按键分组的场景。', 
    'for k,g in groupby(sorted(data), key=...):'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1244,
    83,
    'chain 应用',
    '补全：用 chain 合并三组数据并遍历。',
    'a b
c d
e f',
    JSON_ARRAY('a b c d e f'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import itertools"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "a=input().split()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "b=input().split()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "c=input().split()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "for x in itertools.chain(a,b,c):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(x, end=\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'chain 可以将多个可迭代对象串联为单个迭代器。',
    'chain(a,b,c)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1245,
    83,
    'filterfalse 示例',
    '补全：使用 filterfalse 筛选出非数字字符串。',
    '1 a 2 b',
    JSON_ARRAY('a b'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from itertools import filterfalse"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(*filterfalse(lambda x: x.isdigit(), input().split()))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'filterfalse 返回不满足谓词条件的元素集合。',
    'filterfalse(lambda x: cond, it)'
);