USE `questions`;
-- Unit 15 | Start ID: 211
-- Generated at 2025-12-24 17:07:13

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    211, 
    15, 
    '步长为负的含义', 
    '若 s = "abcdefg"，表达式 s[5:1:-1] 会得到什么？', 
    JSON_OBJECT('A', '"fedc"', 'B', '"feds"', 'C', '"fed"', 'D', '"gfed"'), 
    3, 
    JSON_ARRAY('步长为 -1 表示从右向左取字符。', '结束索引 1 不包含在结果里。', '起点 5 对应字符 "f"。'), 
    's[5:1:-1] 会从索引 5(f) 向左取到索引 2(d)（因为 1 不包含），结果为 "fed"。', 
    '例如 "abcdefg"[5:1:-1] → "fed"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    212, 
    15, 
    '步长与包含关系', 
    '表达式 s[::3] 对字符串 s = "0123456789" 会返回什么？', 
    JSON_OBJECT('A', '"0369"', 'B', '"048"', 'C', '"0123456789"', 'D', '"0369?"'), 
    1, 
    JSON_ARRAY('步长 3 表示每隔两个字符取一个。', '从索引 0 开始（默认）取：0,3,6,9。', '结果是这些索引对应的字符组合。'), 
    's[::3] 取索引 0,3,6,9 对应 "0","3","6","9" → "0369"。', 
    '例如 "abcdef"[::2] → "ace"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    213, 
    15, 
    'slice 对象用途', 
    '下列哪一项关于 slice(1,5,2) 的说法正确？', 
    JSON_OBJECT('A', '它直接对字符串进行切片并返回结果', 'B', '它是一个表示切片参数的对象，可用于 s[slice(...)]', 'C', 'slice 只能用于列表，不能用于字符串', 'D', 'slice 会修改原始序列'), 
    2, 
    JSON_ARRAY('slice 是一个描述切片参数的内建类型。', '它本身不直接返回子串，需作为索引参数传入序列。', 'slice 既可用于字符串也可用于列表。'), 
    'slice(1,5,2) 返回一个切片对象，可在 s[slice(1,5,2)] 中使用。', 
    's = "abcdef"; s[slice(1,5,2)] → "bd"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    214, 
    15, 
    '切片与原字符串不可变性', 
    '关于对字符串切片赋值（如 s[1:3] = "X"），以下哪项正确？', 
    JSON_OBJECT('A', '可行，字符串会被修改', 'B', '不可行，会抛出 TypeError，因为字符串是不可变的', 'C', '只有在 Python2 中可行', 'D', '会把切片结果当作列表赋值'), 
    2, 
    JSON_ARRAY('字符串在 Python 中是不可变类型（immutable）。', '不能对其进行原地修改。', '尝试赋值会触发异常。'), 
    '字符串不可变，尝试对切片赋值会抛出 TypeError。', 
    's = "abc"; s[1] = "x" 会报错'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    215, 
    15, 
    '省略参数与默认行为', 
    's[:: -2] 与 s[::-2] 有何区别？', 
    JSON_OBJECT('A', '它们是等价的，都表示反向每隔一个字符取一个', 'B', 's[::-2] 会报错', 'C', 's[:: -2] 中的空格会导致语法错误', 'D', '前者从左到右，后者从右到左'), 
    1, 
    JSON_ARRAY('切片中多余的空格不会影响语法', '负步长表示反向', '两者表达相同含义'), 
    's[::-2] 与 s[:: -2] 等价，都会从末尾开始每隔一个字符取一个。', 
    '"abcdef"[::-2] → "fdb"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    216, 
    15, 
    '复杂切片的输出长度', 
    '若 s="0123456789"，s[1:9:3] 的长度是多少？', 
    JSON_OBJECT('A', '2', 'B', '3', 'C', '4', 'D', '5'), 
    2, 
    JSON_ARRAY('索引取 1,4,7。', '这些索引都小于 9 且按步长 3 取。', '计算元素个数。'), 
    '取索引 1、4、7 共 3 个字符。', 
    'len("0123456789"[1:9:3]) → 3'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    217, 
    15, 
    '切片与内存/性能提示', 
    '关于对大字符串做切片操作，哪项说法更准确？', 
    JSON_OBJECT('A', '切片总是原地修改字符串，不分配新内存', 'B', '切片返回新字符串，可能会分配新的内存', 'C', '切片会共享原字符串底层内存，不发生复制', 'D', '对短字符串切片会复制，对长字符串不会'), 
    2, 
    JSON_ARRAY('字符串是不可变对象，切片返回新对象。', '通常会发生内存分配以保存子串。', '并非原地修改或共享底层可变内存。'), 
    '字符串切片会创建并返回一个新的字符串对象，通常需要分配内存来保存结果。', 
    's2 = s[:1000] 会创建新的字符串 s2'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    218, 
    15, 
    '负步长的边界行为', 
    's = "abcd"，表达式 s[3:0:-1] 的结果是什么？', 
    JSON_OBJECT('A', '"dcba"', 'B', '"dcb"', 'C', '"cba"', 'D', '""'), 
    2, 
    JSON_ARRAY('起点 3 是 "d"。', '结束索引 0 不包含在结果中。', '步长 -1 会向左取。'), 
    's[3:0:-1] 取索引 3(d)、2(c)、1(b) → "dcb"。', 
    '"abcd"[3:0:-1] → "dcb"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    219, 
    15, 
    '切片与复制完整序列', 
    '如何用切片创建字符串 s 的完整拷贝？', 
    JSON_OBJECT('A', 's.copy()', 'B', 's[:] ', 'C', 's[0:len(s)-1]', 'D', 's[1:]'), 
    2, 
    JSON_ARRAY('复制整个序列的经典写法是什么？', '使用起始和结束都省略的切片。', '这种方式会得到与原字符串相同的新对象。'), 
    's[:] 会返回包含全部字符的新字符串（浅复制效果）。', 
    's2 = s[:]; s2 == s'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    220,
    15,
    '用 slice 对象切片',
    '使用 slice 对象取得 s 的 "bdf"（s = "abcdefg"）。',
    's = "abcdefg"',
    JSON_ARRAY('bdf'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "sl = slice("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(s[sl])"}]}]}',
    JSON_ARRAY('1,6,2', '1,6,2', '1,5,2', '0,7,3'),
    JSON_ARRAY(1),
    '需要 slice(1,6,2)，即从索引1到5（6 不包含），步长2 → "bdf"。',
    'slice(1,6,2) 可在 s[slice(1,6,2)] 中使用'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    221,
    15,
    '结合 len 计算后半段',
    '补全切片，取得字符串后半段（若长度为奇数，包含中位），例如 s="ABCDE" → "CDE"。',
    's = "ABCDE"',
    JSON_ARRAY('CDE'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "half = s[len(s)"}, {"type": "slot", "index": 0}, {"type": "code", "value": "]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(half)"}]}]}',
    JSON_ARRAY('//2:', '//2', '/2:', '//2-1', '-len(s)//2:', ':len(s)//2', 'len(s)//2:'),
    JSON_ARRAY(7),
    'len(s)//2 计算中间索引（整数除法），从该索引到末尾为后半段，故 s[len(s)//2:]。',
    '若 s="ABCD" len//2=2 → s[2:]="CD"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    222,
    15,
    '从字符串中提取扩展模式',
    '从 s="ab-cd-ef-gh" 提取每段的首字母，得到 "aceg"。',
    's = "ab-cd-ef-gh"',
    JSON_ARRAY('aceg'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "parts = s.split(\"-\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "joined = \"\".join(p[0] for p in parts)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(joined)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 请改用切片直接取得结果："}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('0::3', '0::4', '1::3', '::3', '::4', '2::3', '0::2'),
    JSON_ARRAY(4),
    '原字符串格式为 "ab-cd-ef-gh"，每段长度为2加一个连接符，总的规律是每隔 3 个字符取一个（索引0,3,6,9）→ s[::3] → "aceg"。',
    '"ab-cd-ef-gh"[::3] → "aceg"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    223,
    15,
    '利用负步长提取单词字符',
    '给定 s="hello_world"，用切片反向取得 "dlrow"（注意小写），并补全代码。',
    's = "hello_world"',
    JSON_ARRAY('dlrow'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('6:11:-1', '10:5:-1', '10:4:-1', '-1:-6:-1', '5:0:-1', '-1:-5:-1'),
    JSON_ARRAY(2),
    '要取得 "dlrow"（对应原字符串索引 10->6），切片写成 s[10:5:-1]（10 包含，5 不包含）。',
    '"hello_world"[10:5:-1] → "dlrow"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    224,
    15,
    '组合切片与步长',
    '给定 s="abcdefghij"，补全切片使其返回 "bdfhj"（从索引1开始每隔2取直到末尾）。',
    's = "abcdefghij"',
    JSON_ARRAY('bdfhj'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('1::2', '1:10:2', '1:11:2', '1:9:2', '2::2', '::2'),
    JSON_ARRAY(1),
    '要从索引1取到末尾并步长为2，写成 s[1:10:2]（10 为 len(s)），选项 1::2 也可，但题中更严谨指定结束索引为 10，因此选择 1:10:2。',
    '亦可写成 s[1::2]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    225,
    15,
    '多重切片思想演练',
    '将字符串先取出中间段再反转：先从 s="0123456789" 取得 "3456"，然后反转得到 "6543"。请补全两步操作。',
    's = "0123456789"',
    JSON_ARRAY('6543'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "mid = s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(mid["}, {"type": "slot", "index": 1}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('3:7', '3:6', '2:6', '-1:-5:-1', '::-1', '::1', '::-1', '3:7', '3:7', '3:7'),
    JSON_ARRAY(1, 5),
    '先用 s[3:7] 获取索引 3,4,5,6 对应 "3456"，然后用 [::-1] 反转得到 "6543"（所以 mid[::-1]）。',
    'mid = s[3:7]
print(mid[::-1])  # 6543'
);