USE `questions`;
-- Unit 46 | Start ID: 676
-- Generated at 2025-12-24 23:13:02

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    676, 
    46, 
    '去除两端空白', 
    '下面哪个方法可以去除字符串两端空白？', 
    JSON_OBJECT('A', 'strip', 'B', 'split', 'C', 'replace', 'D', 'find'), 
    1, 
    JSON_ARRAY('strip 移除两端空白', 'split 拆分', 'replace 替换子串'), 
    'strip 用于去除字符串两端的空白字符。', 
    's.strip()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    677, 
    46, 
    '格式化与条件', 
    '根据布尔值选择输出格式，推荐使用？', 
    JSON_OBJECT('A', '三元表达式配合 f-string', 'B', '字符串拼接 with +', 'C', '使用 print 多次', 'D', '使用全局变量'), 
    1, 
    JSON_ARRAY('简洁且可读', 'f-string 支持内联表达式', '三元适合短条件'), 
    '三元与 f-string 配合可写出简洁且可读的条件格式化。', 
    'print(f"{val if ok else 0}")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    678, 
    46, 
    'startswith 的用途', 
    '判断字符串是否以某前缀开头应使用？', 
    JSON_OBJECT('A', 'startswith', 'B', 'in', 'C', 'find', 'D', 'index'), 
    1, 
    JSON_ARRAY('startswith 专门用于前缀检测', '比 in 更表达意图', '返回布尔'), 
    'startswith 能直观地判断前缀并返回布尔值。', 
    'if s.startswith("http"):'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    679,
    46,
    '条件与大小写无关比较',
    '补全：忽略大小写比较两个字符串。',
    'a="Yes"; b="yes"',
    JSON_ARRAY('Equal'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if a."}, {"type": "slot", "index": 0}, {"type": "code", "value": "() == b."}, {"type": "slot", "index": 1}, {"type": "code", "value": "():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"Equal\")"}]}]}',
    JSON_ARRAY('lower', 'upper', 'strip', 'title'),
    JSON_ARRAY(1, 1),
    '统一使用 lower() 或 upper() 可忽略大小写差异。',
    'if s1.lower() == s2.lower():'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    680,
    46,
    '去除内部空白',
    '补全：把字符串中间的空格去掉。',
    's="a b c"',
    JSON_ARRAY('abc'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "s = s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\" \", \"\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(s)"}]}]}',
    JSON_ARRAY('replace', 'strip', 'split', 'join'),
    JSON_ARRAY(1),
    'replace 可以替换中间空格为无，达到去除内部空白效果。',
    's.replace(" ", "")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    681, 
    46, 
    '分割与连接', 
    '把句子按空格拆成单词列表该用？', 
    JSON_OBJECT('A', 'split', 'B', 'join', 'C', 'replace', 'D', 'strip'), 
    1, 
    JSON_ARRAY('split 根据分隔符拆分', '常与 join 配合使用', '返回列表'), 
    'split 用于拆分字符串为列表，join 用于把列表拼回字符串。', 
    'words = s.split()
" ".join(words)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    682, 
    46, 
    '检测子串位置', 
    '要获取子串第一次出现的索引，使用？', 
    JSON_OBJECT('A', 'find', 'B', 'in', 'C', 'startswith', 'D', 'count'), 
    1, 
    JSON_ARRAY('find 返回索引或 -1', 'in 只返回布尔', 'index 找不到抛异常'), 
    'find 返回首次出现的索引，找不到返回 -1，适合位置检测。', 
    'pos = s.find("py")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    683, 
    46, 
    '格式化字符串安全', 
    '使用 f-string 时应避免？', 
    JSON_OBJECT('A', '将不受信任的表达式直接插入', 'B', '把变量放入花括号', 'C', '用表达式格式化数值', 'D', '用于调试输出'), 
    1, 
    JSON_ARRAY('f-string 会求值表达式', '不要在 f-string 中执行不受信任的代码', '用于格式化数据'), 
    '避免把不受信任的表达式直接插入 f-string，会带来安全风险。', 
    'print(f"{user_input}") 前先清洗'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    684,
    46,
    '限制输出长度',
    '补全：只输出字符串前 10 个字符。',
    's="abcdefghijk"',
    JSON_ARRAY('abcdefghij'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('0:10', ':10', '0:9', '1:10'),
    JSON_ARRAY(2),
    '切片 s[:10] 返回前 10 个字符（包含索引 0 到 9）。',
    's[:5]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    685,
    46,
    '检测含有数字的字符串',
    '补全：判断字符串是否包含数字字符。',
    's="a1b"',
    JSON_ARRAY('Has digit'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"Has digit\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '任何字符的 isdigit 返回 True 则表示字符串包含数字。',
    'if any(c.isalpha() for c in s): ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    686, 
    46, 
    'strip 的参数用法', 
    'strip 可以带参数用于去除特定字符吗？', 
    JSON_OBJECT('A', '可以，strip("x") 去除两端的 x', 'B', '不可以，必须为空', 'C', '只接受 None', 'D', 'strip 会删除所有中间字符'), 
    1, 
    JSON_ARRAY('strip 可接受参数', '只去除两端而非中间', '参数为字符串，按字符集合处理'), 
    'strip("ab") 会去除两端的 a 或 b 字符。', 
    's.strip("\n")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    687, 
    46, 
    'split 默认行为', 
    'str.split() 默认按什么拆分？', 
    JSON_OBJECT('A', '任意空白字符并去重连续空白', 'B', '仅按单个空格', 'C', '按逗号', 'D', '按换行符'), 
    1, 
    JSON_ARRAY('默认 split 无参数时按任意空白', '连续空白被视为一个分隔', '常用于拆单词'), 
    'str.split() 无参数时会按任意空白分隔并忽略首尾空白。', 
    's.split()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    688, 
    46, 
    '字符串不可变', 
    '在 Python 中字符串是可变还是不可变的？', 
    JSON_OBJECT('A', '不可变', 'B', '可变', 'C', '取决于实现', 'D', '在某些版本可变'), 
    1, 
    JSON_ARRAY('字符串操作产生新对象', '不能原地修改单个字符', '赋值会创建新字符串'), 
    '字符串不可变，对字符串的修改会生成新对象。', 
    's = s.replace("a","b")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    689,
    46,
    '字符替换练习',
    '补全：把字符串中的 a 替换为 b 并打印。',
    's="aab"',
    JSON_ARRAY('bbb'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"a\",\"b\"))"}]}]}',
    JSON_ARRAY('replace', 'strip', 'split', 'join'),
    JSON_ARRAY(1),
    'replace 用于替换子串。',
    's.replace(" ", "")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    690,
    46,
    '综合练习：格式化输出',
    '补全：输出姓名与年龄的 f-string。',
    'name="Tom"; age=18',
    JSON_ARRAY('Tom is 18'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(f\"{"}, {"type": "slot", "index": 0}, {"type": "code", "value": "} is {"}, {"type": "slot", "index": 1}, {"type": "code", "value": "}\")"}]}]}',
    JSON_ARRAY('name', 'age', '"name"', '"age"'),
    JSON_ARRAY(1, 2),
    '在 f-string 中直接放变量名来格式化输出。',
    'print(f"{user} has {n} items")'
);