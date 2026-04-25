USE `questions`;
-- Unit 55 | Start ID: 811
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    811,
    55,
    '输入健壮性',
    '处理用户输入时第一步通常是？',
    JSON_OBJECT('A', '验证并清洗输入', 'B', '直接使用输入', 'C', '将输入写入日志', 'D', '忽略所有输入'),
    1,
    JSON_ARRAY('去除空白', '检查类型与范围'),
    '首先验证并清洗输入能避免后续错误与安全问题。',
    's = s.strip()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    812,
    55,
    '异常捕获',
    '当输入可能导致 ValueError，应使用？',
    JSON_OBJECT('A', 'try/except 捕获并处理', 'B', '让异常冒泡导致程序崩溃', 'C', '忽略异常', 'D', '提前退出程序'),
    1,
    JSON_ARRAY('捕获特定异常', '提供友好提示或默认值'),
    '捕获并处理异常可以提升程序健壮性并给用户反馈。',
    'try: int(s) except ValueError: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    813,
    55,
    '默认值策略',
    '当输入缺失时优先使用什么？',
    JSON_OBJECT('A', '合理的默认值或提示', 'B', '随机值', 'C', '空字符串写入数据库', 'D', '直接抛出异常'),
    1,
    JSON_ARRAY('为流程保留默认分支', '避免产生后续错误'),
    '提供合理默认值或提示可以使流程继续并便于用户修正。',
    'name = input() or "guest"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    814,
    55,
    '数值解析',
    '补全：解析整数并在错误时打印 invalid。',
    JSON_ARRAY('s=abc'),
    JSON_ARRAY('invalid'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "try:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    n = int("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "except ValueError:"}, {"type": "code_line", "value": "    print(\\"invalid\\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 try/except 处理转换错误。',
    'except: print("bad")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    815,
    55,
    '安全读取文件名',
    '补全：避免空文件名导致异常。',
    JSON_ARRAY('name=""'),
    JSON_ARRAY('invalid'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "name = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if not name:"}, {"type": "code_line", "value": "    print(\\"invalid\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    open(name)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '先校验文件名避免 open 抛出 FileNotFoundError 或安全问题。',
    'if not filename: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    816,
    55,
    '异常日志',
    '记录异常信息时应注意？',
    JSON_OBJECT('A', '记录堆栈和上下文但避开敏感数据', 'B', '把所有用户数据写日志', 'C', '只记录错误代码', 'D', '从不记录'),
    1,
    JSON_ARRAY('平衡排查与隐私', '避免日志泄露敏感信息'),
    '记录有用上下文便于排查，同时避免泄露敏感用户数据。',
    'log.exception(e)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    817,
    55,
    '回退与重试',
    '对暂时性错误的推荐处理方式是？',
    JSON_OBJECT('A', '自动重试若合理并记录失败', 'B', '立即放弃不记录', 'C', '无限重试不限制', 'D', '抛出致命错误'),
    1,
    JSON_ARRAY('短时间重试可恢复临时故障', '需要限制次数与间隔'),
    '对临时错误有限重试通常能提高鲁棒性，同时要避免无限重试带来问题。',
    'for i in range(3): try: ... except: sleep(1)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    818,
    55,
    '忽略与处理',
    '对于非关键字段的解析错误，常见做法是？',
    JSON_OBJECT('A', '记录并使用默认值', 'B', '中断整个流程', 'C', '抛出未处理异常', 'D', '忽视且不记录'),
    1,
    JSON_ARRAY('非关键字段用默认值', '记录以便追踪'),
    '对非关键字段使用默认值并记录可以保证流程继续且便于调试。',
    'age = int(s) if s else 0'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    819,
    55,
    '限制输入长度',
    '补全：若输入长度超过 100 则截断。',
    JSON_ARRAY('s="a\'*150+\'"'),
    JSON_ARRAY(''),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "s = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if len(s) > 100:"}, {"type": "code_line", "value": "    s = s[:100]"}, {"type": "code_line", "value": "print(s)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '对超长输入进行截断以防止资源耗尽或注入问题。',
    's = s[:max_len]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    820,
    55,
    '白名单校验',
    '补全：只接受特定值集合内的输入。',
    JSON_ARRAY('c="yes"'),
    JSON_ARRAY('accepted'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "c = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if c in (\\"yes\\",\\"no\\"):"}, {"type": "code_line", "value": "    print(\\"accepted\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\"rejected\\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '白名单可以避免非法或意外输入导致问题。',
    'if choice in options: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    821,
    55,
    '异常优先级',
    '当多个异常类型可能出现时应当？',
    JSON_OBJECT('A', '按从具体到通用顺序捕获', 'B', '只捕获通用异常', 'C', '不捕获任何异常', 'D', '随机捕获'),
    1,
    JSON_ARRAY('具体异常先捕获', '通用异常放最后'),
    '先捕获具体异常有助于针对性处理，再用通用异常兜底。',
    'except FileNotFoundError: ...
except Exception: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    822,
    55,
    '用户提示与开发提示',
    '对于用户应展示何种错误信息？',
    JSON_OBJECT('A', '友好且不泄露内部细节', 'B', '详细堆栈信息', 'C', '数据库内容', 'D', '原始请求报文'),
    1,
    JSON_ARRAY('保护系统内部信息', '同时给出可操作提示'),
    '向用户显示友好信息，内部日志记录详细错误信息用于排查。',
    'print("操作失败，请稍后重试")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    823,
    55,
    '容错设计',
    '系统应尽量做到哪种容错方式？',
    JSON_OBJECT('A', '降级服务或返回默认结果', 'B', '全部停止服务', 'C', '抛弃请求并不记录', 'D', '返回随机数据'),
    1,
    JSON_ARRAY('降级保证可用性', '记录问题便于修复'),
    '在异常时通过降级保持核心功能能提高可用性。',
    '返回缓存数据代替实时计算'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    824,
    55,
    '安全默认值示例',
    '补全：当未提供 locale 时设为 "en"。',
    NULL,
    JSON_ARRAY('en'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "locale = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "() or \\"en\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(locale)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 or 提供默认值是常见简洁写法。',
    'value = x or default'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    825,
    55,
    '错误码返回',
    '补全：遇到错误返回状态码 400。',
    NULL,
    JSON_ARRAY('400'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(\\"400 Bad Request\\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用规范状态码表达客户端错误便于前端处理。',
    'HTTP 400 表示错误请求'
);