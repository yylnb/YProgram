USE `questions`;
-- Unit 72 | Start ID: 1066
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1066,
    72,
    '字符遍历',
    '遍历字符串每个字符时推荐使用？',
    JSON_OBJECT('A', 'for ch in s', 'B', 'while True', 'C', '索引访问只能', 'D', '不能遍历'),
    1,
    JSON_ARRAY('直接迭代最简洁', '避免下标错误'),
    '用 for 直接遍历字符串最简洁明了。',
    'for ch in "abc": print(ch)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1067,
    72,
    '不可变字符串',
    '字符串是可变还是不可变对象？',
    JSON_OBJECT('A', '不可变', 'B', '可变', 'C', '部分可变', 'D', '随实现不同'),
    1,
    JSON_ARRAY('不能直接修改单个字符', '常通过新字符串替代'),
    '字符串在 Python 中是不可变的，修改需生成新字符串。',
    's = s.replace()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1068,
    72,
    '遍历与索引',
    '需要索引和字符同时使用时推荐？',
    JSON_OBJECT('A', 'enumerate(s)', 'B', '手动计数', 'C', 'zip with range', 'D', '不可实现'),
    1,
    JSON_ARRAY('enumerate 同时提供索引与值', '更简洁'),
    '使用 enumerate 可同时获得索引和值。',
    'for i,ch in enumerate(s):'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1069,
    72,
    '统计字符',
    '补全：统计字符串中 a 的个数。',
    JSON_ARRAY('aba'),
    JSON_ARRAY('2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s=input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "count=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for ch in s:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if ch==\\"a\\":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        count+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(count)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '遍历并计数特定字符。',
    's.count("a")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1070,
    72,
    '转大写遍历',
    '补全：遍历并打印大写字符。',
    JSON_ARRAY('ab'),
    JSON_ARRAY('A', 'B'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s=input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for ch in s:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(ch.upper())"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '对每个字符调用 upper 得到大写字符。',
    'ch.upper()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1071,
    72,
    '多字节字符',
    '遍历包含中文的字符串时？',
    JSON_OBJECT('A', '按字符遍历同样有效', 'B', '必须按字节处理', 'C', '不可遍历', 'D', '会报错'),
    1,
    JSON_ARRAY('Python 按字符处理 Unicode', '正常遍历即可'),
    'Python 字符串是 Unicode，按字符遍历能正确处理中文。',
    'for ch in "你好": print(ch)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1072,
    72,
    '性能注意',
    '对非常长的字符串进行逐字符处理时应注意？',
    JSON_OBJECT('A', '避免在循环中做昂贵操作', 'B', '无限循环', 'C', '内存不足', 'D', '不可运行'),
    1,
    JSON_ARRAY('把昂贵操作移出循环或缓存结果', '使用生成器优化'),
    '在循环中应尽量避免重复昂贵计算以提升性能。',
    'precompute value'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1073,
    72,
    '切片与遍历',
    '用 s[i] 访问字符和直接 for ch in s 相比？',
    JSON_OBJECT('A', '直接遍历更简洁且安全', 'B', '索引更快', 'C', '两者等价', 'D', '索引无法使用'),
    1,
    JSON_ARRAY('避免越界问题', '代码更清晰'),
    '直接遍历更简洁，索引方式在需要索引时才使用。',
    'for ch in s'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1074,
    72,
    '倒序遍历',
    '补全：倒序打印字符串。',
    JSON_ARRAY('ab'),
    JSON_ARRAY('b', 'a'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s=input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for ch in s[::-1]:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(ch)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '切片 s[::-1] 产生倒序字符串。',
    'reverse slice'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1075,
    72,
    '查找子串',
    '补全：判断子串是否存在并打印位置。',
    JSON_ARRAY('hello
ll'),
    JSON_ARRAY('2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s=input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "sub=input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(s.find(sub))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'find 返回子串首次出现索引或 -1。',
    's.find("a")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1076,
    72,
    '不可直接修改',
    '想替换字符串中某个字符，正确做法是？',
    JSON_OBJECT('A', '生成新字符串', 'B', '直接赋值 s[i] = x', 'C', '使用 del', 'D', '调用 sort'),
    1,
    JSON_ARRAY('字符串不可变', '使用 replace 或拼接生成新字符串'),
    '因为字符串不可变，需要通过 replace 或重建字符串来得到新结果。',
    's = s[:i]+"x"+s[i+1:]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1077,
    72,
    'strip 与 split',
    '在逐行遍历文件字符串时常用的清洗操作是？',
    JSON_OBJECT('A', 'strip 去除换行和空白', 'B', '直接 eval', 'C', '不处理', 'D', '写入数据库'),
    1,
    JSON_ARRAY('strip 常用于清理输入', '避免尾部 \\n 影响判断'),
    '使用 strip 清理左右空白是读取文本时常见步骤。',
    'line=line.strip()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1078,
    72,
    '遍历与编码',
    '读取文本文件并遍历字符时应注意文件的什么？',
    JSON_OBJECT('A', '编码（encoding）', 'B', '行数', 'C', '文件权限', 'D', '文件名长度'),
    1,
    JSON_ARRAY('确保以正确编码读取以避免乱码', '常用 utf-8'),
    '读取文件时需指定正确编码以正确解析字符。',
    'open(file, encoding="utf-8")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1079,
    72,
    '过滤指定字符',
    '补全：只打印不是空格的字符。',
    JSON_ARRAY('a b'),
    JSON_ARRAY('a', 'b'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s=input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for ch in s:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if ch==\\" \\":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        continue"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(ch)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用 continue 跳过空格字符。',
    'skip spaces'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1080,
    72,
    '字符转码',
    '补全：将字符的 unicode 码点打印。',
    JSON_ARRAY('A'),
    JSON_ARRAY('65'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "ch=input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(ord(ch))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'ord 返回字符的 Unicode 码点整数表示。',
    'ord("A") -> 65'
);