USE `questions`;
-- Unit 87 | Start ID: 1291
-- Generated at 2025-12-24 23:25:14

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1291, 
    87, 
    're.search vs match', 
    're.match 与 re.search 区别是？', 
    JSON_OBJECT('A', 'match 从开头匹配，search 在任意位置匹配', 'B', '两者相同', 'C', 'search 更快', 'D', 'match 支持多行'), 
    1, 
    JSON_ARRAY('match 只匹配字符串开头'), 
    're.match 只在字符串开头尝试匹配，re.search 会在任意位置查找匹配。', 
    're.search("a", "ba")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1292, 
    87, 
    '转义字符', 
    '正则中要匹配特殊字符如 . 应如何处理？', 
    JSON_OBJECT('A', '使用 \ 转义或 re.escape', 'B', '直接写 .', 'C', '不可能匹配', 'D', '只用 find'), 
    1, 
    JSON_ARRAY('特殊字符需转义或用 re.escape'), 
    '使用 \ 转义或 re.escape 对用户输入的特殊字符进行转义以安全构造正则。', 
    're.escape(".")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1293, 
    87, 
    '分组捕获', 
    '正则中的捕获组用 () 表示，其作用是？', 
    JSON_OBJECT('A', '提取子串', 'B', '替换字符', 'C', '删除空白', 'D', '排序'), 
    1, 
    JSON_ARRAY('捕获组提取并可在替换中引用'), 
    '捕获组用于提取匹配的子串并可用于替换或后续处理。', 
    'm.group(1)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1294,
    87,
    '基本匹配',
    '补全：用 re 判断邮箱格式（简化示例）。',
    'a@b.com',
    JSON_ARRAY('Yes'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import re"}, {"type": "code_line", "value": "s=input().strip()"}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\"Yes\" if re.match(r\"^\\S+@\\S+\\.\\S+$\", s) else \"No\")"}]}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用简单正则判断 Email 格式示例，实际生产需更严格校验。',
    're.match(regex, s)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1295,
    87,
    '查找所有',
    '补全：用 re.findall 查找所有数字子串并打印。',
    'a1b22',
    JSON_ARRAY('1 22'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import re"}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(*re.findall(r\"\\d+\", input().strip()))"}]}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'findall 返回所有匹配的子串列表。',
    're.findall(pattern, s)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1296, 
    87, 
    '忽略大小写', 
    '正则忽略大小写匹配应使用哪个标志？', 
    JSON_OBJECT('A', 're.I 或 re.IGNORECASE', 'B', 're.M', 'C', 're.S', 'D', 're.X'), 
    1, 
    JSON_ARRAY('IGNORECASE 忽略字母大小写'), 
    '使用 re.I 可以使匹配忽略大小写差异。', 
    're.search(p, s, re.I)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1297, 
    87, 
    '贪婪与非贪婪', 
    '正则量词默认是贪婪的，如何使其非贪婪？', 
    JSON_OBJECT('A', '后接 ?', 'B', '加 *', 'C', '加 +', 'D', '无解'), 
    1, 
    JSON_ARRAY('使用 *? 或 +? 实现非贪婪'), 
    '量词后加 ? 能使其变为非贪婪匹配，匹配最短可能的长度。', 
    '<.*?> 匹配最短标签'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1298, 
    87, 
    '多行模式', 
    're.M 的作用是？', 
    JSON_OBJECT('A', '^ 和 $ 匹配每行的开头结尾', 'B', '忽略空白', 'C', '使 . 匹配换行', 'D', '注释模式'), 
    1, 
    JSON_ARRAY('多行模式影响 ^ $ 的行为'), 
    're.M (MULTILINE) 使 ^ 和 $ 匹配每行的开始和结束位置。', 
    're.M usage'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1299,
    87,
    '替换示例',
    '补全：把字符串中连续空白替换为单个空格。',
    'a   b',
    JSON_ARRAY('a b'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import re"}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(re.sub(r\"\\s+\", \" \", input().strip()))"}]}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    're.sub 可用于全局替换复杂模式。',
    're.sub(pattern,repl,s)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1300,
    87,
    '捕获组引用',
    '补全：把日期从 YYYY-MM-DD 改为 DD/MM/YYYY。',
    '2020-01-02',
    JSON_ARRAY('02/01/2020'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import re"}, {"type": "code_line", "value": "s=input().strip()"}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(re.sub(r\"(\\d{4})-(\\d{2})-(\\d{2})\", r\"\\\\3/\\\\2/\\\\1\", s))"}]}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用捕获组并在替换字符串中反向引用组号。',
    're.sub(pattern, r"\3/\2/\1", s)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1301, 
    87, 
    '预编译模式', 
    '当在循环中多次使用同一正则时应？', 
    JSON_OBJECT('A', '预编译 re.compile', 'B', '每次用 re.search 直接传字符串', 'C', '用 split 代替', 'D', '写成 C 扩展'), 
    1, 
    JSON_ARRAY('compile 能减少重复解析开销'), 
    '预编译正则对象在循环中重用可以提升性能。', 
    'p = re.compile(pattern)
for s in it: p.search(s)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1302, 
    87, 
    '安全构造正则', 
    '用户输入需作为正则的一部分时应如何处理？', 
    JSON_OBJECT('A', '用 re.escape 转义', 'B', '直接插入', 'C', '用 eval', 'D', '不支持'), 
    1, 
    JSON_ARRAY('escape 能对特殊字符转义'), 
    '为避免用户输入破坏正则语法，应先用 re.escape 转义。', 
    're.compile(re.escape(user))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1303, 
    87, 
    '性能陷阱', 
    '复杂正则可能导致的安全问题是？', 
    JSON_OBJECT('A', '正则灾难（Catastrophic backtracking）', 'B', '更安全', 'C', '不可执行', 'D', '无影响'), 
    1, 
    JSON_ARRAY('某些贪婪量词组合会引发指数级回溯'), 
    '不当的正则写法可能导致回溯爆炸，造成高 CPU 占用甚至拒绝服务。', 
    'avoid catastrophic patterns'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1304,
    87,
    '找到首个匹配',
    '补全：用 re.search 找到并打印第一个匹配。',
    'abc123',
    JSON_ARRAY('123'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import re"}, {"type": "code_line", "value": "m=re.search(r\"\\d+\", input().strip())"}, {"type": "code_line", "value": "if m:"}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(m.group())"}]}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    're.search 返回第一个匹配的 Match 对象，可用 group() 提取匹配文本。',
    'm.group()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1305,
    87,
    '用 finditer',
    '补全：用 re.finditer 遍历所有匹配并打印其起始位置。',
    'aba
a',
    JSON_ARRAY('0 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import re"}, {"type": "code_line", "value": "s=input().strip()"}, {"type": "code_line", "value": "for m in re.finditer(\"a\", s):"}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(m.start(), end=\" \")"}]}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    're.finditer 返回匹配迭代器，可逐个处理 Match 对象并获取位置信息。',
    'for m in re.finditer(p, s):'
);