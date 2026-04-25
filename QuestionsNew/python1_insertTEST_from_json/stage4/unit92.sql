USE `questions`;
-- Unit 92 | Start ID: 1366
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1366,
    92,
    '索引从哪里开始',
    'Python 列表索引从哪个数字开始？',
    JSON_OBJECT('A', '0', 'B', '1', 'C', '-1', 'D', '任意'),
    1,
    JSON_ARRAY('Python 使用 0-based 索引', '第一个元素索引为 0'),
    'Python 列表和大多数序列类型均采用从 0 开始索引。',
    'lst[0]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1367,
    92,
    '负索引含义',
    '负索引如 lst[-1] 表示？',
    JSON_OBJECT('A', '最后一个元素', 'B', '第一个元素', 'C', '报错', 'D', '倒数第二个元素'),
    1,
    JSON_ARRAY('-1 指向末尾元素', '-2 指向倒数第二'),
    '负索引从末尾开始计数，-1 表示最后一个元素。',
    'lst[-1]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1368,
    92,
    '索引越界',
    '访问超出范围的索引会怎样？',
    JSON_OBJECT('A', '抛出 IndexError', 'B', '返回 None', 'C', '返回空字符串', 'D', '自动扩展列表'),
    1,
    JSON_ARRAY('超出边界会抛出异常'),
    '越界读取会抛出 IndexError，需要检查索引或使用异常处理。',
    'try: x = lst[10] except IndexError:'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1369,
    92,
    '获取最后元素',
    '补全：打印列表最后一个元素。',
    JSON_ARRAY('1 2 3'),
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(lst["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('-1', 'last', '0', '1'),
    JSON_ARRAY(1),
    '负索引 -1 可直接访问最后一个元素。',
    'lst[-1]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1370,
    92,
    '安全访问',
    '补全：安全访问索引若越界返回 -1。',
    JSON_ARRAY('1 2
5'),
    JSON_ARRAY('-1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}, {"type": "code_line", "value": "i=int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(lst[i] "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 0<=i<"}, {"type": "slot", "index": 1}, {"type": "code", "value": "(lst) "}, {"type": "slot", "index": 2}, {"type": "code", "value": " -1)"}]}]}',
    JSON_ARRAY('if', 'else', 'len', 'print'),
    JSON_ARRAY(1, 2, 3),
    '先判断索引范围后再访问，避免异常。',
    'if 0<=i<len(lst): ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1371,
    92,
    '多维索引',
    '二维列表访问元素通常写成？',
    JSON_OBJECT('A', 'mat[i][j]', 'B', 'mat[i,j]', 'C', 'mat(i)(j)', 'D', 'mat[j][i]'),
    1,
    JSON_ARRAY('列表嵌套使用双重索引'),
    '二维列表是列表的列表，访问需两次索引。',
    'mat[0][1]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1372,
    92,
    '索引为负',
    '切片支持负步长，如 s[::-1] 的作用是？',
    JSON_OBJECT('A', '反转序列', 'B', '复制序列', 'C', '报错', 'D', '只适用于字符串'),
    1,
    JSON_ARRAY('负步长可倒序切片'),
    's[::-1] 是常用的倒序切片技巧。',
    '[1,2,3][::-1] -> [3,2,1]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1373,
    92,
    '切片安全',
    '切片超出范围会怎样？',
    JSON_OBJECT('A', '不会抛错，返回尽可能的子序列', 'B', '抛出异常', 'C', '返回 None', 'D', '返回空列表总是'),
    1,
    JSON_ARRAY('切片比单索引更安全'),
    '切片会自动裁剪索引而不会抛异常。',
    '[1,2][0:10] -> [1,2]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1374,
    92,
    '取子列',
    '补全：取出列表中索引 1 到 3（含）元素。',
    JSON_ARRAY('a b c d e'),
    JSON_ARRAY('b c d'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=input().split()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(lst["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('1:4', '1..4', '1:3', '1:5'),
    JSON_ARRAY(1),
    '切片的结束索引为上界且不包含该位置元素。',
    'lst[1:4]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1375,
    92,
    '替换索引元素',
    '补全：将索引 0 元素替换为 9。',
    JSON_ARRAY('1 2 3'),
    JSON_ARRAY('9 2 3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": "\\nprint(*lst)"}]}]}',
    JSON_ARRAY('lst[0]=9', 'append', 'insert', 'del lst[0]'),
    JSON_ARRAY(1),
    '通过索引直接赋值可就地修改列表元素。',
    'lst[0]=x'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1376,
    92,
    '索引为表达式',
    '索引可以使用表达式作为下标吗？',
    JSON_OBJECT('A', '可以，如 lst[i+1]', 'B', '不可以', 'C', '只限常数', 'D', '只限整数常量'),
    1,
    JSON_ARRAY('下标表达式会先求值为整数'),
    '索引表达式会先计算为整数然后用于访问列表。',
    'i=0; lst[i+1]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1377,
    92,
    'list 的可变长度',
    '对列表使用索引赋值改变长度吗？',
    JSON_OBJECT('A', '不会改变长度', 'B', '会增加长度', 'C', '会减少长度', 'D', '取决于赋值值'),
    1,
    JSON_ARRAY('单个索引赋值替换元素而非插入'),
    '索引赋值替换已有位置的元素，保持列表长度不变。',
    'lst[1]=5'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1378,
    92,
    '切片赋值',
    '使用切片赋值可以替换多元素并改变列表长度吗？',
    JSON_OBJECT('A', '可以', 'B', '不可以', 'C', '只可缩短', 'D', '只可扩展'),
    1,
    JSON_ARRAY('切片赋值可替换任意长度序列'),
    '切片赋值可以插入或删除元素，从而改变列表长度。',
    'lst[1:2]=[9,9]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1379,
    92,
    'pop 返回',
    '补全：pop 方法返回被删除的元素并打印。',
    JSON_ARRAY('1 2 3'),
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "())"}]}]}',
    JSON_ARRAY('pop', 'remove', 'del', 'append'),
    JSON_ARRAY(1),
    'pop 默认弹出并返回最后一个元素。',
    'x = lst.pop()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1380,
    92,
    '索引查找',
    '补全：打印某元素在列表中首次出现的索引（不存在时报 -1）。',
    JSON_ARRAY('1 2 3
2'),
    JSON_ARRAY('1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}, {"type": "code_line", "value": "x=int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(x) "}, {"type": "slot", "index": 1}, {"type": "code", "value": " x "}, {"type": "slot", "index": 2}, {"type": "code", "value": " lst "}, {"type": "slot", "index": 3}, {"type": "code", "value": " -1)"}]}]}',
    JSON_ARRAY('index', 'in', 'find', 'count'),
    JSON_ARRAY(1, 2),
    '先判断是否存在再调用 index 避免 ValueError。',
    'if x in lst: i = lst.index(x)'
);