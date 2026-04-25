USE `questions`;
-- Unit 143 | Start ID: 2131
-- Generated at 2025-12-24 18:24:09

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2131, 
    143, 
    're 模块', 
    'Python 中处理正则表达式常用哪个模块？', 
    JSON_OBJECT('A', 're', 'B', 'regex', 'C', 're2', 'D', 'regexlib'), 
    1, 
    JSON_ARRAY('提示1：re 是标准库', '提示2：也有第三方 regex 提供扩展', '提示3：常用方法有 match/search/findall'), 
    're 是 Python 内置的正则表达式模块，提供常用匹配与替换方法。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2132, 
    143, 
    'search 与 match', 
    're.search 与 re.match 的区别是？', 
    JSON_OBJECT('A', 'match 从字符串开头匹配，search 在任意位置查找', 'B', '两者相同', 'C', 'search 仅在结尾匹配', 'D', 'match 更慢'), 
    1, 
    JSON_ARRAY('提示1：match 等价于 ^ 开头匹配', '提示2：search 更灵活', '提示3：常用 findall 获取所有匹配'), 
    'match 从开头开始尝试匹配；search 会在字符串任意位置查找第一个匹配。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2133, 
    143, 
    '常用元字符', 
    '下列哪组是正则表达式常用元字符？', 
    JSON_OBJECT('A', '. * + ? ^ $ [ ] ( ) |', 'B', '&& || ==', 'C', '< > =', 'D', '# ! %'), 
    1, 
    JSON_ARRAY('提示1：. 匹配任意字符', '提示2：* 表示前项重复', '提示3：方括号表示字符集合'), 
    '正则常用元字符包括 . * + ? ^ $ [] () | 等，用于构造模式。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2134, 
    143, 
    '贪婪与懒惰', 
    '默认量词（如 *）是贪婪的，意思是？', 
    JSON_OBJECT('A', '尽可能多地匹配', 'B', '尽可能少地匹配', 'C', '匹配失败抛异常', 'D', '仅匹配空字符串'), 
    1, 
    JSON_ARRAY('提示1：可用 *? 让其懒惰', '提示2：贪婪会匹配最长字符串', '提示3：谨慎使用以避免过度匹配'), 
    '贪婪量词会匹配尽可能多的字符；使用 ? 可使其变为非贪婪（懒惰）。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2135, 
    143, 
    '捕获组', 
    '在正则中使用圆括号 () 的一个常见用途是？', 
    JSON_OBJECT('A', '创建捕获组以便提取子串', 'B', '表示注释', 'C', '表示字符集合', 'D', '表示量词'), 
    1, 
    JSON_ARRAY('提示1：match.group(1) 获取第一个捕获组', '提示2：(?: ) 用于非捕获组', '提示3：分组可用于提取或引用'), 
    '圆括号用于捕获子匹配或改变运算顺序，便于提取子串。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2136, 
    143, 
    '替换文本', 
    '使用 re.sub 可以完成什么？', 
    JSON_OBJECT('A', '基于正则模式替换文本', 'B', '查找文件', 'C', '分割二进制流', 'D', '编译模式'), 
    1, 
    JSON_ARRAY('提示1：re.sub(pattern, repl, text)', '提示2：支持回调函数作为 repl', '提示3：常用于清洗文本'), 
    're.sub 用于将匹配模式替换为指定文本或回调返回值。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2137, 
    143, 
    'DOTALL 标志', 
    're.DOTALL 的作用是？', 
    JSON_OBJECT('A', '让 . 匹配换行符', 'B', '忽略大小写', 'C', '开启多行模式', 'D', '禁用贪婪模式'), 
    1, 
    JSON_ARRAY('提示1：默认 . 不匹配换行', '提示2：DOTALL 改变 . 的行为', '提示3：常用于跨行匹配'), 
    'DOTALL 标志使点号 . 也能匹配换行符，从而匹配跨行文本。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2138, 
    143, 
    '捕获组引用', 
    '在替换字符串中引用第一个捕获组，可以使用哪个语法？', 
    JSON_OBJECT('A', '\1', 'B', '$1', 'C', '{1}', 'D', '%1'), 
    1, 
    JSON_ARRAY('提示1：在替换字符串中常用 \1 表示第一个组', '提示2：回调方式更灵活', '提示3：注意转义'), 
    '在 re.sub 的替换字符串中可使用 \1 这样的反向引用来代表捕获组。', 
    ''
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2139,
    143,
    '转义字符（填空）',
    '若要匹配字符 "." 本身，应使用正则模式中写为 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "import re\nre.search(\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\", \"a.b\")"}]}]}',
    JSON_ARRAY('\.', '\d', '.', '\w'),
    JSON_ARRAY(1),
    '用 \. 可以匹配句点字符本身，因为 . 是元字符。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2140,
    143,
    '字符类（填空）',
    '表示数字字符的简写元字符是 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "re.findall(\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "+\\\", \\\"a123b\\\")"}]}]}',
    JSON_ARRAY('\d', '\w', '\s', '.'),
    JSON_ARRAY(1),
    '\d 表示数字字符，\w 表示字母数字下划线，\s 表示空白。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2141,
    143,
    '编译模式（填空）',
    '为了在多次匹配中提高效率，可先用 re.__1__(pattern) 编译正则对象。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "pat = re."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"\\\\d+\")\npat.findall(\"a123b\")"}]}]}',
    JSON_ARRAY('compile', 'match', 'search', 'fullmatch'),
    JSON_ARRAY(1),
    're.compile 可创建可复用的正则对象以提高性能。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2142,
    143,
    '多行模式（填空）',
    '使用 re.M 或 re.MULTILINE 可以让 ^ 和 $ 匹配 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "re.search(pattern, text, flags=re."}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('MULTILINE', 'IGNORECASE', 'DOTALL', 'VERBOSE'),
    JSON_ARRAY(1),
    'MULTILINE 使 ^/$ 匹配每行的开头结尾，而不是整个字符串的开始/结束。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2143,
    143,
    '非捕获组（填空）',
    '若仅需分组但不捕获，可使用语法 (?:pattern) 写为 __1__.',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "pat = re.compile(\"(?:ab)+\")"}]}]}',
    JSON_ARRAY('(?: )', '(?= )', '(?<= )', '(?! )'),
    JSON_ARRAY(1),
    '(?: ) 表示非捕获分组，用于结构化但不产生捕获编号。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2144,
    143,
    '性能建议（填空）',
    '复杂正则可能影响性能，建议逐步测试并尽量 __1__ 模式以提高可读性和效率。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('简化', '复杂化', '嵌套', '压缩'),
    JSON_ARRAY(1),
    '简化和分解复杂模式有助于提高性能与可维护性。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2145,
    143,
    '总结（填空）',
    '正则用于 __1__ 文本匹配与提取，但应注意可读性和性能。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('复杂', '简单', '二分', '统计'),
    JSON_ARRAY(1),
    '正则擅长复杂文本模式匹配，但应合理使用以免造成难以维护的代码。',
    ''
);