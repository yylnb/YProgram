USE `questions`;
-- Unit 81 | Start ID: 1201
-- Generated at 2025-12-24 23:23:07

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1201, 
    81, 
    '可迭代对象', 
    '哪些对象是可迭代的？', 
    JSON_OBJECT('A', '实现 __iter__ 或 __getitem__ 的对象', 'B', '只有 list', 'C', '只有 str', 'D', '所有对象'), 
    1, 
    JSON_ARRAY('实现迭代协议即可迭代', '常见有 list/tuple/dict/str'), 
    '只要实现迭代协议（__iter__ 或 __getitem__）的对象就可以用于 for 循环。', 
    'for x in obj:'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1202, 
    81, 
    '迭代器消耗', 
    '迭代器在遍历后还能再次遍历吗？', 
    JSON_OBJECT('A', '不能（已消费）', 'B', '总能再次遍历', 'C', '取决于实现', 'D', '需 reset 方法'), 
    1, 
    JSON_ARRAY('一般一次性消费', '可将数据转换为 list 以重用'), 
    '迭代器在遍历后通常被消耗，要重用需重新创建或转换为序列。', 
    'list(iterator) to reuse'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1203, 
    81, 
    'for else', 
    'for…else 结构中 else 在何时执行？', 
    JSON_OBJECT('A', '循环正常结束（无 break）', 'B', '每次循环都会执行', 'C', '只在 break 时执行', 'D', '在异常时执行'), 
    1, 
    JSON_ARRAY('else 与 break 的配合常用于查找并区分找到与未找到情况'), 
    '当循环没有通过 break 提前退出时，会执行 else 块。', 
    'for x in it: if cond: break
else: not found'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1204,
    81,
    '迭代字典',
    '补全：遍历字典并打印键与值。',
    'a:1 b:2',
    JSON_ARRAY('a 1', 'b 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "d=dict(x.split(\":\") for x in input().split())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "for k,v in d."}, {"type": "slot", "index": 0}, {"type": "code", "value": "():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(k, v)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 items() 可同时遍历键和值。',
    'for k,v in d.items():'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1205,
    81,
    '并行迭代',
    '补全：并行遍历两个列表。',
    'a b
1 2',
    JSON_ARRAY('a 1', 'b 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a=input().split()"}, {"type": "code_line", "value": "b=input().split()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "for x,y in "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(a,b):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(x, y)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'zip 可并行迭代多个序列，按最短长度停止。',
    'for x,y in zip(a,b):'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1206, 
    81, 
    'zip 行为', 
    'zip(a,b) 在长度不同时如何终止？', 
    JSON_OBJECT('A', '以最短序列长度终止', 'B', '以最长序列终止并填 None', 'C', '报错', 'D', '无限循环'), 
    1, 
    JSON_ARRAY('zip 会按最短长度配对元素'), 
    'zip 会在最短输入序列耗尽时停止迭代。', 
    'list(zip([1,2],[3])) -> [(1,3)]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1207, 
    81, 
    '迭代器与内存', 
    '对大数据使用迭代器而不是 list 的优势？', 
    JSON_OBJECT('A', '节省内存', 'B', '更快随机访问', 'C', '更易索引', 'D', '更安全'), 
    1, 
    JSON_ARRAY('迭代器惰性产生值', '适合流式处理'), 
    '使用迭代器按需生成元素可以减少内存占用。', 
    'generator expression'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1208, 
    81, 
    '枚举起始', 
    'enumerate 可指定起始索引参数吗？', 
    JSON_OBJECT('A', '可以（start=）', 'B', '不可以', 'C', '仅在 Python2 可用', 'D', '只用于 dict'), 
    1, 
    JSON_ARRAY('常用 enumerate(iterable, 1) 来从 1 开始编号'), 
    'enumerate 可以通过第二个参数指定起始索引。', 
    'for i,x in enumerate(lst,1):'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1209,
    81,
    '解包迭代',
    '补全：遍历嵌套元组并解包打印。',
    '(a,1) (b,2)',
    JSON_ARRAY('a 1', 'b 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for k,v in [tuple(x.split()) for x in input().split(\",\")]:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(k, "}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'for 循环支持对可迭代元素进行多变量解包。',
    'for a,b in pairs:'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1210,
    81,
    '可迭代转列表',
    '补全：把迭代器的前 3 个元素转列表。',
    '1 2 3 4',
    JSON_ARRAY('[1,2,3]'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "it=map(int,input().split())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(list(__import__(\"itertools\")."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(it,3)))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'islice 可从迭代器中获取指定数量元素并转换为列表。',
    'from itertools import islice'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1211, 
    81, 
    '可迭代与迭代器区别', 
    '迭代器对象与可迭代对象区别是？', 
    JSON_OBJECT('A', '迭代器有 __next__ 方法并可消费', 'B', '可迭代有 __next__', 'C', '二者相同', 'D', '不可比较'), 
    1, 
    JSON_ARRAY('迭代器可以直接 next()', '可迭代对象提供 __iter__ 返回迭代器'), 
    '迭代器支持 __next__ 被消费，可迭代对象实现 __iter__ 返回迭代器。', 
    'it = iter([1,2])'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1212, 
    81, 
    'for else 用例', 
    'for…else 常用于？', 
    JSON_OBJECT('A', '查找并判断未找到情况', 'B', '计数', 'C', '排序', 'D', '打印'), 
    1, 
    JSON_ARRAY('在没找到就执行 else'), 
    'for…else 常用于在循环中查找元素，未找到时在 else 中处理。', 
    'for x in lst: if x==v: break
else: print("not found")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1213, 
    81, 
    '遍历字典键', 
    '直接 for k in d 时遍历的是什么？', 
    JSON_OBJECT('A', '键', 'B', '值', 'C', '键值对', 'D', '项目索引'), 
    1, 
    JSON_ARRAY('默认遍历字典键'), 
    '直接遍历字典会得到键；用 d.values()/d.items() 可遍历值或键值对。', 
    'for k in d:'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1214,
    81,
    '链式迭代',
    '补全：把多个可迭代对象串联后遍历。',
    '1 2
3 4',
    JSON_ARRAY('1 2 3 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import itertools"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "for x in itertools."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(input().split(), input().split()):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(x, end=\" \")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'itertools.chain 可将多个可迭代对象串联为单一迭代序列。',
    'chain(a,b)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1215,
    81,
    '反向迭代',
    '补全：倒序遍历列表。',
    '1 2 3',
    JSON_ARRAY('3 2 1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for x in reversed(list(map(int,input().split()))):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(x, "}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'reversed 返回反向迭代器，无需拷贝序列即可倒序遍历。',
    'for x in reversed(lst):'
);