USE `questions`;
-- Unit 49 | Start ID: 1171
-- Generated at 2025-12-24 17:35:14

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1171, 
    49, 
    '字符串与条件结合', 
    '判定字符串非空通常使用哪个条件？', 
    JSON_OBJECT('A', 'if s:', 'B', 'if s != "":', 'C', 'if len(s) > 0:', 'D', '以上都可以'), 
    4, 
    JSON_ARRAY('Python 中空字符串为 False', '多种写法均可', '首选简洁写法'), 
    '三种写法都能判定非空，其中 if s 更简洁直观。', 
    'if name: print(name)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1172, 
    49, 
    'strip 与空白判断', 
    '要判断用户输入是否只包含空白，应先用？', 
    JSON_OBJECT('A', 'strip', 'B', 'lower', 'C', 'split', 'D', 'replace'), 
    1, 
    JSON_ARRAY('strip 去除两端空白', '之后可判断空字符串', '避免只用输入直接判断'), 
    '先用 strip 去除空白后判断是否为空可以识别只有空白的输入。', 
    'if not s.strip(): print("empty")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1173, 
    49, 
    'contains 检查', 
    '检查子串存在应使用哪个操作？', 
    JSON_OBJECT('A', 'in', 'B', 'find==-1', 'C', 'index', 'D', 'count'), 
    1, 
    JSON_ARRAY('in 返回布尔最直观', 'find 或 index 可返回位置或异常', 'count 可用于计数'), 
    '使用 in 可直接判断子串存在性，表达清晰。', 
    'if "py" in s: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1174, 
    49, 
    '判断是否为数字串', 
    '判断字符串是否为数字串（不含小数点）可用？', 
    JSON_OBJECT('A', 's.isdigit()', 'B', 'int(s)', 'C', 'float(s)', 'D', 'eval(s)'), 
    1, 
    JSON_ARRAY('isdigit 适合纯数字字符', '转换方法需要异常处理'), 
    's.isdigit() 是检测纯数字串的直接方法。', 
    'if s.isdigit(): n=int(s)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1175, 
    49, 
    '拼接与 join', 
    '将单词列表拼接为字符串推荐使用？', 
    JSON_OBJECT('A', '" ".join(words)', 'B', '" "+" ".join(words)', 'C', 'for 循环拼接', 'D', 'sum(words)'), 
    1, 
    JSON_ARRAY('join 高效且语义明确', '避免在循环内多次拼接字符串'), 
    'join 是拼接字符串列表的推荐方法，性能较好且易读。', 
    '"-".join(parts)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1176, 
    49, 
    '大小写统一', 
    '忽略大小写比较两字符串应先调用？', 
    JSON_OBJECT('A', 'lower或upper', 'B', 'strip', 'C', 'replace', 'D', 'split'), 
    1, 
    JSON_ARRAY('统一大小写后比较更稳健', 'lower 常用且直观'), 
    '先把两个字符串都 lower() 或 upper() 再比较可忽略大小写。', 
    'if a.lower() == b.lower():'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1177, 
    49, 
    '正则 vs 简单方法', 
    '简单字符串判断应优先使用？', 
    JSON_OBJECT('A', '内建方法如 in、split、find', 'B', '正则表达式', 'C', '使用 eval', 'D', '用数据库查询'), 
    1, 
    JSON_ARRAY('简单任务用简单方法更快更易维护', '正则适合复杂匹配'), 
    '优先使用内建字符串方法，复杂匹配再考虑正则。', 
    'if "," in s: parts = s.split(\',\')'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1178, 
    49, 
    '避免链式 replace', 
    '连续多次 replace 可能会怎样？', 
    JSON_OBJECT('A', '效率低且可能相互影响', 'B', '总是更优', 'C', '会改变原对象', 'D', '只能用于数字'), 
    1, 
    JSON_ARRAY('字符串不可变每次替换都会造新对象', '替换顺序可能影响结果'), 
    '多次 replace 在性能和语义上都可能带来问题，必要时应谨慎或用正则一次完成。', 
    's.replace("a","b").replace("b","c")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1179, 
    49, 
    '用户输入清洗', 
    '在处理用户名输入时，应至少做什么？', 
    JSON_OBJECT('A', 'strip 去掉首尾空白', 'B', 'lower 并保存原始大小写', 'C', '直接存储不处理', 'D', '用 eval 检查'), 
    1, 
    JSON_ARRAY('先去首尾空白', '再根据需要统一大小写或校验长度'), 
    '至少去除首尾空白避免误判空输入或多余空白。', 
    'username = input().strip()'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1180,
    49,
    '常见输入格式判断',
    '补全：判断是否为简单邮箱格式（包含 @）。',
    's="a@b"',
    JSON_ARRAY('Valid'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if \"@\" "}, {"type": "slot", "index": 0}, {"type": "code", "value": " s:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"Valid\")"}]}]}',
    JSON_ARRAY('in', 'not in', '==', 'is'),
    JSON_ARRAY(1),
    '可以简单用 in 检查是否含有 @，尽管不是严格邮箱验证。',
    'if "@" in email: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1181,
    49,
    '分割并取首段',
    '补全：按空格取第一单词。',
    's="hello world"',
    JSON_ARRAY('hello'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()[0])"}]}]}',
    JSON_ARRAY('split', 'strip', 'lower', 'replace'),
    JSON_ARRAY(1),
    'split() 将字符串拆分为单词列表，再取第一个元素。',
    's.split()[0]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1182,
    49,
    '统计子串出现次数',
    '补全：统计子串出现次数并打印。',
    's="aba"; sub="a"',
    JSON_ARRAY('2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "sub = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(sub))"}]}]}',
    JSON_ARRAY('count', 'find', 'index', 'replace'),
    JSON_ARRAY(1),
    'count 方法统计子串在字符串中出现的次数。',
    's.count("a")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1183,
    49,
    '去除换行并比较',
    '补全：读取输入并去除末尾换行后比较。',
    's="ok\n"',
    JSON_ARRAY('Good'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "s = input()."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if s == \"ok\":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"Good\")"}]}]}',
    JSON_ARRAY('strip', 'rstrip', 'lstrip', 'replace'),
    JSON_ARRAY(2),
    'rstrip() 可以去除右侧换行符，strip 也可但更通用。',
    's = input().rstrip()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1184,
    49,
    '练习：提取域名',
    '补全：从 URL 中提取主机名（简单示例）。',
    'url="http://example.com/path"',
    JSON_ARRAY('example.com'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "url = input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "host = url.split(\"//\")[1].split(\"/\")[0]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(host)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    '用 split 的链式调用可简单提取主机名（不保证完备）。',
    's.split("@")[-1].split(":")[0]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1185,
    49,
    '综合练习：检查并格式化输入',
    '补全：如果输入为空则输出 "n/a"，否则输出大写文本。',
    's="hello"',
    JSON_ARRAY('HELLO'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print((s or \"n/a\")."}, {"type": "slot", "index": 0}, {"type": "code", "value": "())"}]}]}',
    JSON_ARRAY('upper', 'lower', 'strip', 'title'),
    JSON_ARRAY(1),
    '先使用 or 提供默认，再调用 upper() 将文本转为大写。',
    'print((name or "guest").title())'
);