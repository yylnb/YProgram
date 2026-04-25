USE `questions`;
-- Unit 108 | Start ID: 1606
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1606,
    108,
    'split 用法',
    's.split() 对字符串做了什么？',
    JSON_OBJECT('A', '按空白分割成子字符串列表', 'B', '把字符串转换为字符列表', 'C', '去除空格并返回字符串', 'D', '抛出异常'),
    1,
    JSON_ARRAY('提示1：split 默认按任意空白分割', '提示2：返回列表', '提示3：可传入分隔符参数'),
    'split 将字符串按分隔符拆分成子字符串并返回列表。',
    '"a b".split() -> ["a","b"]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1607,
    108,
    'join 用法',
    '"-".join(["a","b"]) 会返回？',
    JSON_OBJECT('A', 'a-b', 'B', '["a","b"]', 'C', 'ab', 'D', 'a b'),
    1,
    JSON_ARRAY('提示1：join 在每个元素间插入连接符', '提示2：列表元素需为字符串', '提示3：返回字符串'),
    'join 将列表元素以指定连接符拼接成字符串。',
    '" ".join(["a","b"]) -> "a b"'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1608,
    108,
    'split 与空字符串',
    '"".split() 的结果是什么？',
    JSON_OBJECT('A', '[]（空列表）', 'B', '[""]', 'C', '抛出异常', 'D', '空字符串'),
    1,
    JSON_ARRAY('提示1：split 默认按空白并忽略空项', '提示2：空字符串没有单词', '提示3：结果为空列表'),
    '空字符串调用 split() 返回空列表 []。',
    '"".split() -> []'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1609,
    108,
    '字符串转列表（填空）',
    '把输入字符串按空白分割并打印元素数量。',
    JSON_ARRAY('hello world'),
    JSON_ARRAY('2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(len(s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()))"}]}]}',
    JSON_ARRAY('split', 'join', 'list', 'strip'),
    JSON_ARRAY(1),
    'split 将字符串拆分为子字符串列表，len 取得元素个数。',
    'len("a b".split()) == 2'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1610,
    108,
    '列表转字符串（填空）',
    '把输入单词用逗号连接并打印。',
    JSON_ARRAY('a b'),
    JSON_ARRAY('a,b'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(\\",\\"."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(input().split()))"}]}]}',
    JSON_ARRAY('join', 'split', 'replace', 'format'),
    JSON_ARRAY(1),
    '使用 ",".join(list) 将字符串列表按逗号连接。',
    '",".join(["a","b"])'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1611,
    108,
    'join 限制',
    'join 的参数有什么限制？',
    JSON_OBJECT('A', '所有元素必须是字符串', 'B', '元素必须是整数', 'C', '只能用于列表', 'D', '只支持字母'),
    1,
    JSON_ARRAY('提示1：join 需要字符串元素', '提示2：非字符串需先转换', '提示3：可用 map(str, seq) 转换'),
    'join 要求序列中的每个元素都是字符串，否则需先转换为字符串。',
    '" ".join(map(str, [1,2]))'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1612,
    108,
    'split maxsplit',
    'split(sep, maxsplit=1) 的作用是什么？',
    JSON_OBJECT('A', '最多分割一次，返回两部分', 'B', '分割所有但最多保留一项', 'C', '抛出异常', 'D', '忽略 sep 参数'),
    1,
    JSON_ARRAY('提示1：maxsplit 限制分割次数', '提示2：分割后最多得到 maxsplit+1 项', '提示3：常用于只需头部几个字段'),
    'maxsplit=1 意味着最多分割一次，得到两项结果。',
    '"a b c".split(None,1) -> ["a","b c"]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1613,
    108,
    '字符列表',
    'list("abc") 会得到什么？',
    JSON_OBJECT('A', '["a","b","c"]', 'B', '"abc"', 'C', '["abc"]', 'D', '[]'),
    1,
    JSON_ARRAY('提示1：list 可把字符串拆成字符列表', '提示2：常用于逐字符处理', '提示3：与 split 不同'),
    'list("abc") 会把字符串拆成包含每个字符的列表。',
    'list("hi") -> ["h","i"]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1614,
    108,
    '拆分并取首项（填空）',
    '打印输入字符串第一个字段。',
    JSON_ARRAY('one two three'),
    JSON_ARRAY('one'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()[0])"}]}]}',
    JSON_ARRAY('split', 'join', 'strip', 'list'),
    JSON_ARRAY(1),
    '先 split 再取索引 0 即可得到第一个字段。',
    's.split()[0]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1615,
    108,
    '去除空白（填空）',
    '把输入左右空白去掉并按空白分割打印长度。',
    JSON_ARRAY('  a b  '),
    JSON_ARRAY('2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(len(s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "().split()))"}]}]}',
    JSON_ARRAY('strip', 'split', 'rstrip', 'lstrip'),
    JSON_ARRAY(1),
    'strip() 去除两端空白，再 split() 分割得到两个字段。',
    '" a b ".strip().split()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1616,
    108,
    'join 与非字符串元素',
    '要连接包含整数的列表，正确做法是？',
    JSON_OBJECT('A', '使用 map(str, lst) 然后 join', 'B', '直接 join(lst)', 'C', '先 sum(lst) 再 join', 'D', '使用 + 连接'),
    1,
    JSON_ARRAY('提示1：join 要求字符串元素', '提示2：map(str, lst) 可把元素转换为字符串', '提示3：否则会抛 TypeError'),
    '先用 map(str, lst) 把每个元素转换为字符串，再用 join 连接。',
    '",".join(map(str, [1,2]))'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1617,
    108,
    'split 参数 sep',
    'split("-") 与 split() 的区别是？',
    JSON_OBJECT('A', '前者按指定分隔符分割，后者按任意空白分割', 'B', '两者等价', 'C', 'split() 更慢', 'D', 'split("-") 忽略空白'),
    1,
    JSON_ARRAY('提示1：指定 sep 会精确匹配分隔符', '提示2：没指定时会按任意空白切分并去重', '提示3：split("-") 不会忽略空项'),
    '传入 sep 会用该字符精确分割，未传入则按任意空白分割。',
    '"a-b".split("-") -> ["a","b"]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1618,
    108,
    'split 性能',
    '大量字符串拆分时应注意什么？',
    JSON_OBJECT('A', '避免重复创建大中间列表，按需处理更好', 'B', 'split 总是最快', 'C', 'join 更慢', 'D', '直接操作字符串比 split 更低耗'),
    1,
    JSON_ARRAY('提示1：split 会创建新列表', '提示2：若流式处理可使用生成器', '提示3：注意内存开销'),
    '频繁拆分大量字符串会产生较多中间对象，应考虑流式或增量处理以节省内存。',
    'for line in file: process(line.split())'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1619,
    108,
    '字符串到字符列表（填空）',
    '把输入字符串转换为字符列表并打印。',
    JSON_ARRAY('ab'),
    JSON_ARRAY('a b'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(*list("}, {"type": "slot", "index": 0}, {"type": "code", "value": "))"}]}]}',
    JSON_ARRAY('s', 's.split()', 's.strip()', 's.join()'),
    JSON_ARRAY(1),
    'list(s) 会把字符串拆解为字符列表。',
    'list("ab") -> ["a","b"]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1620,
    108,
    '组合练习（填空）',
    '把输入逗号分隔的数字转换为列表并打印总和。',
    JSON_ARRAY('1,2,3'),
    JSON_ARRAY('6'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "nums = list(map(int, s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\\",\\")))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(sum(nums))"}]}]}',
    JSON_ARRAY('split', 'join', 'replace', 'strip'),
    JSON_ARRAY(1),
    '先用 split(",") 拆分字符串，再 map(int, ...) 转换为整数列表并求和。',
    'sum(map(int, "1,2,3".split(",")))'
);