USE `questions`;
-- Unit 37 | Start ID: 541
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    541,
    37,
    '字符串比较',
    '"a" < "b" 在 Python 中的结果是？',
    JSON_OBJECT('A', 'True', 'B', 'False', 'C', '报错', 'D', '取决于编码'),
    1,
    JSON_ARRAY('字符串按字典序比较', '基于 Unicode 编码', 'a 在 b 之前'),
    '字符串按字典序比较，"a" 在 "b" 之前因此为 True。',
    '"apple" < "banana" → True'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    542,
    37,
    '大小写比较',
    '"A" 和 "a" 的比较结果通常如何？',
    JSON_OBJECT('A', '不相等且先后由编码决定', 'B', '总是相等', 'C', '会报错', 'D', 'Python 忽略大小写比较'),
    1,
    JSON_ARRAY('大小写字母编码不同', '通常大写在小写之前', '可统一大小写后比较'),
    '大小写字母的 Unicode 码点不同，比较结果由编码决定。',
    's.lower() 可用于忽略大小写比较'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    543,
    37,
    'in 运算符',
    '表达式 "py" in "python" 的结果是？',
    JSON_OBJECT('A', 'True', 'B', 'False', 'C', '报错', 'D', 'None'),
    1,
    JSON_ARRAY('in 用于子串检查', '所给子串存在于字符串中', '返回布尔值'),
    '"py" 是 "python" 的子串，因此 in 返回 True。',
    '"a" in "abc" → True'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    544,
    37,
    '检查前后空白',
    '补全以判断输入是否为空或仅空白。',
    JSON_ARRAY('s=" \\t\\n"'),
    JSON_ARRAY('Empty'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Empty\\")"}]}]}',
    JSON_ARRAY('strip', 'lower', 'upper', 'split'),
    JSON_ARRAY(1),
    'strip() 去掉字符串两端空白，可判断是否为空或仅空白。',
    'if not s.strip(): print("empty")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    545,
    37,
    '子串查找',
    '补全：判断子串是否存在并打印 Found/Not Found。',
    JSON_ARRAY('hay="hello"; needle="ll"'),
    JSON_ARRAY('Found'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "hay = \\"hello\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "needle = \\"ll\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if needle "}, {"type": "slot", "index": 0}, {"type": "code", "value": " hay:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Found\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Not Found\\")"}]}]}',
    JSON_ARRAY('in', 'not in', 'find', 'index'),
    JSON_ARRAY(1),
    'in 用于检查子串存在性。',
    'if "py" in "python": ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    546,
    37,
    '大小写统一比较',
    '要不区分大小写地比较字符串，应该怎么做？',
    JSON_OBJECT('A', '同时 lower() 或 upper() 后比较', 'B', '直接比较', 'C', '用 is 比较', 'D', '用 == 且加 encoding 参数'),
    1,
    JSON_ARRAY('统一大小写是常用方法', 'lower() 或 upper() 效果相同', '避免直接用 is 做相等判断'),
    '先把字符串转换为统一大小写再比较可以忽略大小写差异。',
    'if s1.lower() == s2.lower(): ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    547,
    37,
    'startswith/endswith',
    '下面哪个方法用于判断字符串是否以某子串开头？',
    JSON_OBJECT('A', 'startswith', 'B', 'contains', 'C', 'index', 'D', 'find'),
    1,
    JSON_ARRAY('方法名语义明确', '返回布尔值', '常用于路径或前缀判断'),
    'startswith 用于判断前缀，endswith 判断后缀。',
    'if filename.endswith(".py"): ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    548,
    37,
    '字符串比较的语义',
    '字符串比较是按什么进行的？',
    JSON_OBJECT('A', '字典序（字符编码）', 'B', '长度先比较', 'C', '出现频率', 'D', '随机'),
    1,
    JSON_ARRAY('基于字符的编码值进行比较', '不是长度优先', '可用 locale 影响显示但内部比较仍编码'),
    'Python 按字符的 Unicode 编码进行逐字符比较，类似字典序。',
    '"cat" > "car" → True'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    549,
    37,
    '检查空串并提示',
    '补全判断使空串时提示。',
    JSON_ARRAY('s=""'),
    JSON_ARRAY('Empty'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = \\"\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if not "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Empty\\")"}]}]}',
    JSON_ARRAY('s', 's.strip()', 's == ""', 'len(s)'),
    JSON_ARRAY(1),
    '直接使用 if not s 可以判断空字符串。',
    'if not name: print("no name")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    550,
    37,
    '去除换行与空格',
    '补全：读取并去除末尾换行再比较。',
    JSON_ARRAY('用户输入后按回车'),
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "s = input()."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if s == \\"ok\\":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Good\\")"}]}]}',
    JSON_ARRAY('strip', 'rstrip', 'lstrip', 'replace'),
    JSON_ARRAY(1),
    'strip() 去除两端空白（包括换行）。',
    's = input().strip()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    551,
    37,
    '子串定位',
    '若想获得子串位置，使用哪个方法？',
    JSON_OBJECT('A', 'find', 'B', 'in', 'C', 'startswith', 'D', 'lower'),
    1,
    JSON_ARRAY('find 返回索引或 -1', 'in 只返回布尔值', 'index 在找不到时抛异常'),
    'find 返回首次出现的索引，找不到返回 -1；index 会抛出异常。',
    's.find("needle")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    552,
    37,
    'split 的用途',
    'split 方法一般用于？',
    JSON_OBJECT('A', '把字符串按分隔符切成列表', 'B', '替换子串', 'C', '统计字符', 'D', '反转字符串'),
    1,
    JSON_ARRAY('split 返回列表', '常用于解析输入', '参数可指定分隔符'),
    'split 将字符串按分隔符切割成子串列表，常用于解析 CSV 或行输入。',
    's.split(",")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    553,
    37,
    'strip 与rstrip',
    'rstrip 与 strip 的区别是什么？',
    JSON_OBJECT('A', 'rstrip 只去右侧空白', 'B', 'rstrip 去左右两侧', 'C', 'strip 只去右侧', 'D', '没有区别'),
    1,
    JSON_ARRAY('lstrip 去左侧', 'rstrip 去右侧', 'strip 去两侧'),
    'rstrip 只移除右侧空白，strip 移除两端空白，lstrip 移除左侧空白。',
    's.rstrip("\\n") 去掉右侧换行'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    554,
    37,
    '格式化判断',
    '补全：判断输入是否以 http 开头。',
    JSON_ARRAY('url = "http://example"'),
    JSON_ARRAY('Yes'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "url = \\"http://example\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if url."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\\"http\\"):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Yes\\")"}]}]}',
    JSON_ARRAY('startswith', 'find', 'in', 'index'),
    JSON_ARRAY(1),
    'startswith 判断前缀更高效且语义明确。',
    'if filename.endswith(".py"): ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    555,
    37,
    '实践：用户名检查',
    '补全：用户名非空且不包含空格才通过。',
    JSON_ARRAY('name="Tom"'),
    JSON_ARRAY('OK'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "name = \\"Tom\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if name and (\\" \\" not in name):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"OK\\")"}]}]}',
    JSON_ARRAY('示例已给出', '改为 strip 判断', '使用 is None', '使用 == ""'),
    JSON_ARRAY(1),
    '组合判断用户名非空且不含空格可确保合法性。',
    'if username and " " not in username: ...'
);