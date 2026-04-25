USE `questions`;
-- Unit 107 | Start ID: 1591
-- Generated at 2025-12-24 23:32:11

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1591, 
    107, 
    'zip 用途', 
    'zip(a,b) 的行为是？', 
    JSON_OBJECT('A', '按位置将 a 和 b 的元素配对成元组', 'B', '把两个列表合并成单个元素', 'C', '计算 a 和 b 的和', 'D', '抛出异常'), 
    1, 
    JSON_ARRAY('提示1：zip 会把对应位置元素打包成元组', '提示2：短的可迭代决定长度', '提示3：常用在并行遍历场景'), 
    'zip 将可迭代对象对应位置的元素配对，生成元组序列。', 
    'list(zip([1,2],[3,4])) -> [(1,3),(2,4)]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1592, 
    107, 
    'enumerate 作用', 
    'enumerate(seq, start=0) 会返回什么？', 
    JSON_OBJECT('A', '每个元素及其索引的元组序列', 'B', '只返回索引', 'C', '只返回元素', 'D', '返回 count 对象'), 
    1, 
    JSON_ARRAY('提示1：enumerate 常用于需索引的遍历', '提示2：可指定起始索引', '提示3：返回可迭代的 (index, value) 对'), 
    'enumerate 会为可迭代对象生成 (index,value) 对，便于遍历索引和值。', 
    'for i,v in enumerate(["a","b"],1): print(i,v)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1593, 
    107, 
    'zip 长度', 
    'zip 当输入长度不等时如何处理？', 
    JSON_OBJECT('A', '以最短可迭代的长度为准', 'B', '以最长为准并填充 None', 'C', '抛出异常', 'D', '阻塞直到所有可迭代都结束'), 
    1, 
    JSON_ARRAY('提示1：zip 会在最短序列耗尽后停止', '提示2：itertools.zip_longest 可用于最长对齐', '提示3：避免误解长度时注意检查'), 
    'zip 的长度取决于最短输入，可使用 itertools.zip_longest 来以最长为准并填充。', 
    'list(zip([1,2,3],[4])) -> [(1,4)]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1594,
    107,
    '并行遍历（填空）',
    '并行遍历两行数字并打印对应和。',
    '1 2
3 4',
    JSON_ARRAY('4 6'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "for x,y in "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(x+y, end=\" \")"}]}]}',
    JSON_ARRAY('zip(a,b)', 'enumerate(a,b)', 'map(a,b)', 'list(a,b)'),
    JSON_ARRAY(1),
    '使用 zip(a,b) 可并行访问对应元素并相加。',
    'for x,y in zip(a,b): ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1595,
    107,
    '带索引遍历（填空）',
    '用 enumerate 打印索引和值。',
    'a b',
    JSON_ARRAY('0:a 1:b'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "for i, v in "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(f\"{i}:{v}\", end=\" \")"}]}]}',
    JSON_ARRAY('enumerate(lst)', 'zip(lst)', 'list(enumerate(lst))', 'enumerate(lst,1)'),
    JSON_ARRAY(1),
    '使用 enumerate(lst) 返回 (index, value) 对进行遍历。',
    'for i,v in enumerate(["a","b"]): print(i,v)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1596, 
    107, 
    'zip 与 unpack', 
    '如何把二维列表解包为列的列表？', 
    JSON_OBJECT('A', 'list(zip(*matrix))', 'B', 'zip(matrix)', 'C', 'matrix.zip()', 'D', 'matrix.unpack()'), 
    1, 
    JSON_ARRAY('提示1：* 运算符用于解包参数', '提示2：zip(*matrix) 会把列组合成行', '提示3：配合 list 可得到列表形式'), 
    '使用 list(zip(*matrix)) 可把行列表转置为列列表。', 
    'cols = list(zip(*rows))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1597, 
    107, 
    'enumerate start', 
    'enumerate(lst, start=1) 的用途是？', 
    JSON_OBJECT('A', '索引从 1 开始', 'B', '索引从 0 开始', 'C', '返回值从 1 开始', 'D', '无效参数'), 
    1, 
    JSON_ARRAY('提示1：start 参数指定起始索引', '提示2：常用于用户友好的编号', '提示3：默认 start=0'), 
    'enumerate 的 start 参数可改变索引起始值，常设为 1 以便人类阅读。', 
    'for i,v in enumerate(lst,1): ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1598, 
    107, 
    'zip_longest 使用', 
    '若需以最长列表为准并用 None 填充缺失值，应使用哪个函数？', 
    JSON_OBJECT('A', 'itertools.zip_longest', 'B', 'zip', 'C', 'enumerate', 'D', 'map'), 
    1, 
    JSON_ARRAY('提示1：itertools 有 zip_longest', '提示2：zip 以最短为准', '提示3：zip_longest 可指定填充值'), 
    'itertools.zip_longest 可以以最长可迭代为准并填充值来补齐短序列。', 
    'from itertools import zip_longest'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1599,
    107,
    '解包示例（填空）',
    '把两列数分别解包并打印它们第一列。',
    '1 2
3 4',
    JSON_ARRAY('1 3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "rows = [list(map(int, input().split())) for _ in range(2)]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "cols = list(zip(*rows))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(*cols["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('0', '1', '-1', '2'),
    JSON_ARRAY(1),
    'cols[0] 为第一列，打印其元素。',
    'cols = list(zip(*rows))'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1600,
    107,
    '枚举与索引（填空）',
    '打印带编号的元素（编号从 1 开始）。',
    'a b',
    JSON_ARRAY('1 a 2 b'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "for i,v in enumerate(input().split(), "}, {"type": "slot", "index": 0}, {"type": "code", "value": "):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(i, v, end=\" \")"}]}]}',
    JSON_ARRAY('1', '0', '2', '-1'),
    JSON_ARRAY(1),
    '指定 start=1 可让枚举从 1 开始编号。',
    'for i,v in enumerate(lst,1): print(i,v)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1601, 
    107, 
    'zip 与解包互逆', 
    '下列哪个语句可把 zip 的结果恢复为原始多个序列？', 
    JSON_OBJECT('A', 'zip(*zip(a,b))', 'B', 'zip(zip(a,b))', 'C', 'list(zip(a,b))', 'D', 'unzip(a,b)'), 
    1, 
    JSON_ARRAY('提示1：* 运算符可解包参数', '提示2：zip(*zip(a,b)) 可类似恢复', '提示3：list(zip(a,b)) 只是打包'), 
    'zip(*zip(a,b)) 可以在没有丢失信息的情况下近似恢复原序列（注意类型可能为元组）。', 
    'a2,b2 = zip(*zip(a,b))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1602, 
    107, 
    'enumerate 返回值', 
    'enumerate 返回的每一项是什么类型？', 
    JSON_OBJECT('A', '(index, value) 的元组', 'B', '仅索引整数', 'C', '仅值', 'D', '列表'), 
    1, 
    JSON_ARRAY('提示1：每一项是包含索引与值的二元元组', '提示2：常用于 for i,v in enumerate(...)', '提示3：可用在解包语句中'), 
    'enumerate 迭代时每一项为 (index, value) 的元组。', 
    'for i,v in enumerate(["a"]): print(i,v)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1603, 
    107, 
    'zip 与迭代器一次性', 
    'zip 返回的可迭代对象可否重复遍历？', 
    JSON_OBJECT('A', '通常不可重复遍历（视为迭代器）', 'B', '总是可重复遍历', 'C', '取决于元素数量', 'D', '视 Python 版本而定'), 
    1, 
    JSON_ARRAY('提示1：zip 返回迭代器类型', '提示2：需要转换为列表以重复遍历', '提示3：第一次遍历会耗尽'), 
    'zip 在 Python3 返回迭代器，遍历后会被耗尽，若需多次使用请先转换为列表。', 
    'z = zip(a,b); list(z)  # 第二次为空'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1604,
    107,
    '并行字符串拼接（填空）',
    '并行拼接两行字符串对应项并打印。',
    'a b
c d',
    JSON_ARRAY('ac bd'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = input().split()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b = input().split()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x,y in zip(a,b):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(x+"}, {"type": "slot", "index": 0}, {"type": "code", "value": "+y, end=\" \")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '示例将 x 与 y 直接拼接，若需中间无分隔，使用空字符串。',
    'print(x+y)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1605,
    107,
    '枚举过滤（填空）',
    '打印索引为偶数的元素（索引从 0 开始）。',
    'a b c d',
    JSON_ARRAY('a c'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for i, v in enumerate(input().split()):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        print(v, end=\" \")"}]}]}',
    JSON_ARRAY('i%2==0', 'i%2==1', 'i>0', 'v'),
    JSON_ARRAY(1),
    '判断索引 i%2==0 可选择偶数索引的元素。',
    'for i,v in enumerate(lst): if i%2==0: ...'
);