USE `questions`;
-- Unit 142 | Start ID: 2116
-- Generated at 2025-12-24 18:24:10

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2116, 
    142, 
    'JSON 基本类型', 
    'JSON 支持以下哪几种基本类型？', 
    JSON_OBJECT('A', '对象、数组、字符串、数值、布尔、null', 'B', '函数、类、模块', 'C', '二进制、日期', 'D', '仅字符串和数字'), 
    1, 
    JSON_ARRAY('提示1：JSON 是轻量数据交换格式', '提示2：没有函数或类', '提示3：null 表示空值'), 
    'JSON 支持对象（字典）、数组（列表）、字符串、数值、布尔和 null。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2117, 
    142, 
    'Python 与 JSON', 
    '在 Python 中将对象序列化为 JSON 常使用哪个模块？', 
    JSON_OBJECT('A', 'json', 'B', 'pickle', 'C', 'marshal', 'D', 'xml'), 
    1, 
    JSON_ARRAY('提示1：json 是标准库', '提示2：pickle 是 Python 专用序列化', '提示3：json 更通用'), 
    'json 模块用于将 Python 对象与 JSON 字符串互相转换。', 
    'import json
json.dumps({"a":1})'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2118, 
    142, 
    'pickle 与 json 区别', 
    '相对于 json，pickle 的优点或缺点是什么？', 
    JSON_OBJECT('A', 'pickle 可序列化任意 Python 对象但不安全用于不可信数据', 'B', 'pickle 更安全', 'C', 'json 支持函数序列化', 'D', '二者等价'), 
    1, 
    JSON_ARRAY('提示1：pickle 能保存对象结构', '提示2：不要反序列化不可信的 pickle 数据', '提示3：json 可跨语言互操作'), 
    'pickle 可序列化复杂对象，但对安全性和跨语言兼容性有限。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2119, 
    142, 
    '自定义序列化', 
    '当对象不能直接被 JSON 序列化时，通常如何处理？', 
    JSON_OBJECT('A', '提供 default 函数或先转换为可序列化类型', 'B', '直接跳过', 'C', '修改 json 模块源代码', 'D', '使用 eval'), 
    1, 
    JSON_ARRAY('提示1：json.dumps 支持 default 参数', '提示2：把对象转换为字典或基本类型', '提示3：也可实现 __json__ 方法'), 
    '提供 default 回调或先将对象转换为基本类型是常见做法。', 
    'json.dumps(obj, default=lambda o: o.__dict__)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2120, 
    142, 
    '文件写入 JSON', 
    '把对象写入文件可用哪个函数？', 
    JSON_OBJECT('A', 'json.dump', 'B', 'json.dumps', 'C', 'open.write', 'D', 'pickle.dump'), 
    1, 
    JSON_ARRAY('提示1：json.dump 接受文件对象', '提示2：dumps 返回字符串', '提示3：常与 with 一起使用'), 
    'json.dump(obj, f) 把对象序列化并写入打开的文件对象。', 
    'with open("a.json","w") as f:
    json.dump(obj, f)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2121, 
    142, 
    '编码细节', 
    'json.dumps 默认会如何处理非 ASCII 字符？', 
    JSON_OBJECT('A', '会将其转义为 \uXXXX，除非 ensure_ascii=False', 'B', '总是保留原字符', 'C', '抛出异常', 'D', '删除这些字符'), 
    1, 
    JSON_ARRAY('提示1：ensure_ascii 控制输出', '提示2：默认行为是转义', '提示3：设置 ensure_ascii=False 可输出 UTF-8 文本'), 
    '默认 ensure_ascii=True，会转义非 ASCII 字符；关闭该选项可输出原字符。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2122, 
    142, 
    '流式解析', 
    '当 JSON 数据非常大无法一次加载时，哪类工具或库适合流式解析？', 
    JSON_OBJECT('A', 'iterparse 或 ijson 等流式解析库', 'B', 'json.loads 一次性解析', 'C', 'pickle', 'D', 'xml.etree'), 
    1, 
    JSON_ARRAY('提示1：流式解析按需读取', '提示2：适合大文件', '提示3：ijson 提供迭代式解析'), 
    '流式解析库可逐步解析大型 JSON，降低内存占用。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2123, 
    142, 
    'JSON 安全', 
    '解析不可信 JSON 数据时应注意什么？', 
    JSON_OBJECT('A', 'json 本身较安全，但不要用 eval 解析', 'B', 'json.loads 会执行任意代码', 'C', '必须使用 pickle', 'D', '先使用 exec 处理'), 
    1, 
    JSON_ARRAY('提示1：不要用 eval 反序列化', '提示2：json.loads 仅解析数据结构', '提示3：关注字段验证'), 
    'json.loads 不会执行代码，但仍需对字段进行验证以防止业务逻辑问题。', 
    ''
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2124,
    142,
    '序列化到字符串（填空）',
    '将 Python 对象转换为 JSON 字符串使用 json.__1__().',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "import json\ns = json."}, {"type": "slot", "index": 0}, {"type": "code", "value": "({\"a\":1})"}]}]}',
    JSON_ARRAY('dumps', 'dump', 'loads', 'load'),
    JSON_ARRAY(1),
    'json.dumps 将对象编码为 JSON 字符串，json.dump 写入文件。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2125,
    142,
    '从字符串反序列化（填空）',
    '将 JSON 字符串解析为 Python 对象使用 json.__1__().',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "import json\nobj = json."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"{\\\"a\\\":1}\")"}]}]}',
    JSON_ARRAY('loads', 'load', 'dump', 'dumps'),
    JSON_ARRAY(1),
    'json.loads 将 JSON 字符串解析为 Python 对象，json.load 从文件读取并解析。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2126,
    142,
    '排序键（填空）',
    'json.dumps 支持通过 __1__ 参数对字典键进行排序，使输出稳定。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "json.dumps(obj, "}, {"type": "slot", "index": 0}, {"type": "code", "value": "=True)"}]}]}',
    JSON_ARRAY('sort_keys', 'ensure_ascii', 'indent', 'separators'),
    JSON_ARRAY(1),
    'sort_keys=True 会使输出按键排序，便于比较和测试。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2127,
    142,
    '美化输出（填空）',
    '为了可读性可以在 json.dumps 中使用 __1__ 参数设置缩进。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "s = json.dumps(obj, "}, {"type": "slot", "index": 0}, {"type": "code", "value": "=2)"}]}]}',
    JSON_ARRAY('indent', 'sort_keys', 'ensure_ascii', 'separators'),
    JSON_ARRAY(1),
    'indent 参数用于生成带缩进的可读 JSON 文本。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2128,
    142,
    '定制对象序列化（填空）',
    '在 json.dumps 中自定义序列化函数的参数名为 __1__.',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "json.dumps(obj, "}, {"type": "slot", "index": 0}, {"type": "code", "value": "=lambda o: o.__dict__)"}]}]}',
    JSON_ARRAY('default', 'indent', 'sort_keys', 'ensure_ascii'),
    JSON_ARRAY(1),
    'default 参数用于指定无法序列化对象的转换方法。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2129,
    142,
    '跨语言互操作（填空）',
    'JSON 的优势之一是 __1__，便于不同语言之间交换数据。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('可读且通用', '快速', '二进制', '专有'),
    JSON_ARRAY(1),
    'JSON 是一种通用的文本格式，便于跨语言和跨平台的数据交换。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2130,
    142,
    '总结（填空）',
    '使用 json 进行序列化适合 __1__ 数据交换；遇到复杂对象可用 __2__ 自定义处理。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('文本型', '二进制', 'default', 'pickle'),
    JSON_ARRAY(1, 3),
    'JSON 适合文本型数据交换，default 回调可用于自定义复杂对象序列化。',
    ''
);