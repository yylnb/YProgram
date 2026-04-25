USE `questions`;
-- Unit 146 | Start ID: 2176
-- Generated at 2025-12-24 23:42:49

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2176, 
    146, 
    'HTTP 方法', 
    '下列哪个不是常用的 HTTP 方法？', 
    JSON_OBJECT('A', 'FETCH', 'B', 'GET', 'C', 'POST', 'D', 'PUT'), 
    1, 
    JSON_ARRAY('提示1：标准方法包括 GET/POST/PUT/DELETE', '提示2：FETCH 不是 HTTP 方法名'), 
    'FETCH 不是标准的 HTTP 方法，通常使用 GET/POST/PUT/DELETE。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2177, 
    146, 
    'requests 库', 
    '在 Python 中发送 HTTP 请求常用哪个第三方库？', 
    JSON_OBJECT('A', 'requests', 'B', 'urllib3', 'C', 'http.client', 'D', 'socket'), 
    1, 
    JSON_ARRAY('提示1：requests API 简洁', '提示2：也可使用内置 urllib'), 
    'requests 是最常用且易用的第三方 HTTP 客户端库。', 
    'import requests
r = requests.get("https://example.com")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2178, 
    146, 
    '超时参数', 
    '使用 requests 时设置超时的参数名是？', 
    JSON_OBJECT('A', 'timeout', 'B', 'wait', 'C', 'delay', 'D', 'interval'), 
    1, 
    JSON_ARRAY('提示1：requests.get(..., timeout=5)'), 
    'timeout 参数用于限制等待响应的秒数，避免无限阻塞。', 
    'requests.get(url, timeout=5)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2179,
    146,
    '状态码（填空）',
    '表示请求成功的 HTTP 状态码通常是 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('200', '404', '500', '301'),
    JSON_ARRAY(1),
    '200 表示请求成功（OK）。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2180,
    146,
    'GET 与 POST（填空）',
    'GET 请求通常用于获取资源，而 POST 用于 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('提交或修改数据', '下载文件', '建立连接', '查询 DNS'),
    JSON_ARRAY(1),
    'POST 常用于提交或修改服务器端的数据。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2181, 
    146, 
    'JSON 响应', 
    'requests.Response 对象中获取 JSON 数据的方法是？', 
    JSON_OBJECT('A', 'response.json()', 'B', 'json.loads(response)', 'C', 'response.to_json()', 'D', 'response.data'), 
    1, 
    JSON_ARRAY('提示1：response.json() 解析响应体为 Python 对象'), 
    'response.json() 会把响应体解析为 Python 数据结构。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2182, 
    146, 
    '状态码分类', 
    'HTTP 的 4xx 类状态码表示什么？', 
    JSON_OBJECT('A', '客户端错误', 'B', '服务器错误', 'C', '重定向', 'D', '信息性响应'), 
    1, 
    JSON_ARRAY('提示1：5xx 是服务器错误', '提示2：404 是未找到'), 
    '4xx 表示客户端错误，例如 400/401/404。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2183, 
    146, 
    'SSL 验证', 
    'requests 默认会验证 HTTPS 证书，若要跳过验证可使用哪个参数？', 
    JSON_OBJECT('A', 'verify=False', 'B', 'ssl=False', 'C', 'cert=False', 'D', 'secure=False'), 
    1, 
    JSON_ARRAY('提示1：不建议在生产环境中禁用验证'), 
    'verify=False 会跳过证书验证，但存在安全风险。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2184,
    146,
    '请求头（填空）',
    '在 requests 中可传递 headers 参数，如 headers={"__1__":"application/json"}。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "headers={\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\":\"application/json\"}"}]}]}',
    JSON_ARRAY('Content-Type', 'Accept', 'Host', 'User-Agent'),
    JSON_ARRAY(1),
    'Content-Type 指定请求体的媒体类型，例如 application/json。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2185,
    146,
    '表单提交（填空）',
    '使用 requests.post 提交表单可传入参数 __1__ 来发送表单数据。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('data', 'json', 'params', 'files'),
    JSON_ARRAY(1),
    'data 参数用于提交表单编码的键值对。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2186, 
    146, 
    '会话对象', 
    'requests.Session 的作用是？', 
    JSON_OBJECT('A', '在多次请求中保持连接池和 cookies', 'B', '替代 socket', 'C', '用于异步请求', 'D', '解析 HTML'), 
    1, 
    JSON_ARRAY('提示1：session 可保持 cookies', '提示2：减少握手开销'), 
    'Session 对象可复用连接并保持状态，如 cookies。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2187, 
    146, 
    '幂等性', 
    '下列哪个 HTTP 方法通常被认为是幂等的？', 
    JSON_OBJECT('A', 'PUT', 'B', 'POST', 'C', 'CONNECT', 'D', 'TRACE'), 
    1, 
    JSON_ARRAY('提示1：幂等表示多次执行效果相同', '提示2：GET/PUT/DELETE 通常为幂等'), 
    'PUT 通常是幂等的，POST 通常不是。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2188,
    146,
    '查询参数（填空）',
    '要在 URL 中添加查询参数可使用 params={"q":"x"}，params 会被附加到 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('URL', 'headers', 'body', 'cookies'),
    JSON_ARRAY(1),
    'params 会被编码并附加到 URL 的查询字符串。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2189,
    146,
    '文件上传（填空）',
    'requests 上传文件时使用参数 __1__，如 files={"file": open("a","rb")}.',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "files={\"file\": open(\"a\",\"rb\")}"}]}]}',
    JSON_ARRAY('files', 'data', 'json', 'params'),
    JSON_ARRAY(1),
    'files 参数用于 multipart/form-data 文件上传。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2190,
    146,
    '总结（填空）',
    '网络请求应注意超时、重试和 __1__（如证书验证）。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('安全', '速度', '并发', '缓存'),
    JSON_ARRAY(1),
    '网络请求需兼顾安全性（例如证书验证）、超时与重试策略。',
    ''
);