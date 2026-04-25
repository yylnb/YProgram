USE `questions`;
-- Unit 138 | Start ID: 2056
-- Generated at 2025-12-24 18:22:49

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2056, 
    138, 
    'socket 基本', 
    '在 Python 中进行低级网络通信常用哪个模块？', 
    JSON_OBJECT('A', 'socket', 'B', 'http', 'C', 'os', 'D', 'json'), 
    1, 
    JSON_ARRAY('提示1: socket 提供 TCP/UDP 接口', '提示2: 需要理解地址与端口', '提示3: 适合自定义协议'), 
    'socket 模块提供底层网络通信能力。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2057, 
    138, 
    'TCP vs UDP', 
    'TCP 与 UDP 的主要区别是？', 
    JSON_OBJECT('A', 'TCP 面向连接且可靠，UDP 无连接且不保证可靠性', 'B', 'UDP 更适合文件传输', 'C', 'TCP 无序传输', 'D', '两者相同'), 
    1, 
    JSON_ARRAY('提示1: TCP 提供重传与顺序保证', '提示2: UDP 更轻量适合实时应用', '提示3: 选择取决于场景需求'), 
    'TCP 提供可靠传输，UDP 速度更快但不保证交付顺序或可靠性。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2058, 
    138, 
    'requests 用途', 
    '对于 HTTP 客户端请求，哪个第三方库常用且更高层？', 
    JSON_OBJECT('A', 'requests', 'B', 'socket', 'C', 'asyncio', 'D', 'xml'), 
    1, 
    JSON_ARRAY('提示1: requests 简化 HTTP 请求', '提示2: 支持会话、重试、证书等', '提示3: 适用于同步 HTTP 客户端'), 
    'requests 是常用的同步 HTTP 客户端库，封装复杂度低。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2059, 
    138, 
    '非阻塞模式', 
    '将 socket 设为非阻塞会怎样？', 
    JSON_OBJECT('A', '操作在没有数据时会抛出异常而不是阻塞', 'B', '自动转为异步协程', 'C', '增加可靠性', 'D', '禁止发送数据'), 
    1, 
    JSON_ARRAY('提示1: 非阻塞模式需轮询或使用 select', '提示2: 与事件循环结合可实现高性能 I/O', '提示3: 需处理异常 EWOULDBLOCK'), 
    '非阻塞 socket 在无数据情况下会立即返回或抛出异常，适合事件驱动模型。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2060, 
    138, 
    'http.server 用途', 
    '要快速启动一个本地静态文件 HTTP 服务器，可使用哪个模块？', 
    JSON_OBJECT('A', 'http.server', 'B', 'socketserver', 'C', 'requests', 'D', 'xmlrpc'), 
    1, 
    JSON_ARRAY('提示1: python -m http.server 方便调试静态文件', '提示2: 仅用于开发环境', '提示3: 不适合生产'), 
    'http.server 可快速启动简易 HTTP 服务用于调试与开发。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2061, 
    138, 
    'TLS/SSL', 
    '要在 socket 上启用加密通信应使用哪个模块包装套接字？', 
    JSON_OBJECT('A', 'ssl', 'B', 'crypt', 'C', 'hashlib', 'D', 'sslsocket'), 
    1, 
    JSON_ARRAY('提示1: ssl.wrap_socket 或 SSLContext', '提示2: 需证书与密钥', '提示3: 推荐使用高层库处理 HTTPS'), 
    'ssl 模块提供 TLS 支持，可对 socket 进行加密通信。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2062, 
    138, 
    'REST 客户端', 
    '使用 requests.post 发送 JSON 数据应如何传参？', 
    JSON_OBJECT('A', '使用 json= 参数', 'B', '使用 data= 参数', 'C', '写在 URL 中', 'D', '必须手工序列化并放在 headers'), 
    1, 
    JSON_ARRAY('提示1: requests 会自动设置 Content-Type', '提示2: 简化使用方式', '提示3: data 可用于表单'), 
    '使用 json= 参数会自动把对象序列化并设置合适头部。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2063, 
    138, 
    '高层异步 HTTP', 
    '进行异步 HTTP 请求常用哪个库？', 
    JSON_OBJECT('A', 'aiohttp', 'B', 'requests-async', 'C', 'http.client', 'D', 'urllib'), 
    1, 
    JSON_ARRAY('提示1: aiohttp 基于 asyncio', '提示2: 适合大量并发 HTTP 请求', '提示3: 需在事件循环中使用'), 
    'aiohttp 是常用的异步 HTTP 客户端/服务器库，配合 asyncio 使用。', 
    ''
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2064,
    138,
    '绑定监听（填空）',
    '创建 TCP 服务器通常要先 s.bind((host, port)) 然后 __1__ 进入监听状态。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import socket"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "s = socket.socket()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "s.bind((\"0.0.0.0\", 8000))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}]}',
    JSON_ARRAY('listen', 'accept', 'connect', 'send'),
    JSON_ARRAY(1),
    '调用 listen 将套接字设为监听，以接受连接。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2065,
    138,
    '接受连接（填空）',
    '监听套接字上等待客户端连接的方法是 __1__，返回 (conn, addr)。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "conn, addr = s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}]}',
    JSON_ARRAY('accept', 'recv', 'send', 'bind'),
    JSON_ARRAY(1),
    'accept 接受一个客户端连接并返回新的连接套接字与地址。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2066,
    138,
    '请求超时（填空）',
    '使用 requests.get 时设置超时参数写为 requests.get(url, __1__=5)。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import requests"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "requests.get(\"http://example.com\", "}, {"type": "slot", "index": 0}, {"type": "code", "value": "=5)"}]}]}',
    JSON_ARRAY('timeout', 'wait', 'delay', 'sleep'),
    JSON_ARRAY(1),
    'timeout 参数用于控制请求超时，避免长时间阻塞。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2067,
    138,
    '发送数据（填空）',
    'TCP 连接上发送字节数据常用 conn.__1__(b"data")。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "conn."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(b\"hi\")"}]}]}',
    JSON_ARRAY('send', 'sendall', 'write', 'writeall'),
    JSON_ARRAY(2),
    'sendall 会尽力发送全部字节，常用于确保完整发送。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2068,
    138,
    '端口范围（填空）',
    '非特权端口通常大于 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('1024', '80', '0', '65535'),
    JSON_ARRAY(1),
    '端口号 <1024 为特权端口，通常需管理员权限；常用非特权端口从 1024 开始。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2069,
    138,
    '绑定地址（填空）',
    '0.0.0.0 常用于绑定到 __1__ 地址以接受任意网络接口的连接。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s.bind((\"0.0.0.0\", 8000))"}]}]}',
    JSON_ARRAY('所有', '本地', '外部', '私有'),
    JSON_ARRAY(1),
    '0.0.0.0 表示绑定到所有可用网络接口。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2070,
    138,
    '总结（填空）',
    '低级网络用 __1__，高层 HTTP 推荐 __2__ 或 __3__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('socket', 'requests', 'aiohttp', 'json'),
    JSON_ARRAY(1, 2, 3),
    'socket 用于底层网络，高层 HTTP 可用 requests（同步）或 aiohttp（异步）。',
    ''
);