USE `questions`;
-- Unit 52 | Start ID: 1216
-- Generated at 2025-12-24 17:36:27

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1216, 
    52, 
    '登录验证顺序', 
    '进行登录验证时，通常先检查什么？', 
    JSON_OBJECT('A', '输入是否为空', 'B', '密码是否正确', 'C', '用户是否存在于数据库', 'D', '权限等级'), 
    1, 
    JSON_ARRAY('先做输入校验', '避免无意义的数据库查询'), 
    '先验证输入完整性可以快速拒绝明显错误请求。', 
    'if not username: error()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1217, 
    52, 
    '错误信息安全', 
    '返回错误时应避免透露？', 
    JSON_OBJECT('A', '用户名是否存在的细节', 'B', '通用错误信息', 'C', '提示重试', 'D', '记录日志'), 
    1, 
    JSON_ARRAY('避免泄露可用于枚举的信息'), 
    '不要明确指示用户名是否存在以免被利用进行用户枚举攻击。', 
    '返回 "用户名或密码错误"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1218, 
    52, 
    '密码校验', 
    '比较密码时应使用？', 
    JSON_OBJECT('A', '哈希比对而非明文比对', 'B', '明文直接比对', 'C', '发送回客户端比对', 'D', '只比较前几位'), 
    1, 
    JSON_ARRAY('存储哈希', '使用安全哈希函数'), 
    '应把密码哈希后存储并对比哈希值，避免明文存储泄露风险。', 
    'check_password_hash(stored, input)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1219, 
    52, 
    '错误次数限制', 
    '为了防止暴力破解，应如何处理多次错误登录？', 
    JSON_OBJECT('A', '限制尝试次数并临时封锁', 'B', '不限制', 'C', '每次都提示密码格式', 'D', '返回详细错误'), 
    1, 
    JSON_ARRAY('保护账户安全', '实现速率限制或锁定机制'), 
    '通过限制尝试次数并临时封锁可以有效降低暴力破解风险。', 
    'if attempts>5: lock_account()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1220, 
    52, 
    '验证码的使用', 
    '什么时候加入验证码更合适？', 
    JSON_OBJECT('A', '在检测到异常登录尝试时', 'B', '每次登录都强制', 'C', '从不使用', 'D', '仅在管理员登录时'), 
    1, 
    JSON_ARRAY('只在必要时增加用户负担', '用于防机器攻击'), 
    '在异常行为出现时动态加入验证码平衡安全与用户体验。', 
    'if suspicious: show_captcha()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1221, 
    52, 
    '返回信息处理', 
    '登录成功后不应包含什么？', 
    JSON_OBJECT('A', '明文密码回传', 'B', '会话令牌', 'C', '用户 ID', 'D', '登录时间'), 
    1, 
    JSON_ARRAY('不要回传敏感信息', '返回必要会话信息即可'), 
    '登录响应不应包含明文密码等敏感信息，应该发放会话令牌用于后续认证。', 
    'return {"token": token}'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1222, 
    52, 
    '敏感信息存储', 
    '密码应当如何存储？', 
    JSON_OBJECT('A', '哈希并加盐存储', 'B', '明文存储在数据库', 'C', '存到日志文件', 'D', '放在客户端'), 
    1, 
    JSON_ARRAY('使用安全哈希算法', '每个密码不同盐值'), 
    '哈希并加盐可以降低密码被泄露时的风险。', 
    'hashed = hash_password(p)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1223, 
    52, 
    '会话管理', 
    '登录后保持登录状态通常使用？', 
    JSON_OBJECT('A', '使用会话令牌或 cookie', 'B', '每次都要求重新登录', 'C', '把密码存在本地文件', 'D', '通过邮件验证每次请求'), 
    1, 
    JSON_ARRAY('令牌管理会话', '注意过期与刷新机制'), 
    '使用令牌或安全 cookie 可以维持会话并支持过期与刷新策略。', 
    'set_cookie("token", token)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1224, 
    52, 
    '多因素认证', 
    '提升登录安全的有效方式是？', 
    JSON_OBJECT('A', '启用多因素认证（MFA）', 'B', '只用更长密码', 'C', '隐藏登录按钮', 'D', '限制用户名长度'), 
    1, 
    JSON_ARRAY('第二因素增强安全', '常见为短信或 TOTP'), 
    '多因素认证在密码被泄露时仍能保护账户安全。', 
    'send_otp(phone)'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1225,
    52,
    '输入非空校验',
    '补全：若 username 为空则返回错误。',
    'username=""',
    JSON_ARRAY('error'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "username = input().strip()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if not username:"}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"error\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '先去除空白并判断是否为空字符串。',
    'if not s: print("empty")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1226,
    52,
    '简单密码判断',
    '补全：判断密码长度至少为 6。',
    'p="abc123"',
    JSON_ARRAY('ok'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "p = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if len(p) >= 6:"}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"ok\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\"short\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '基本密码策略要求最低长度，作为初级校验。',
    'if len(p)<6: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1227,
    52,
    '模拟登录函数',
    '补全：若用户名为 admin 且密码为 123456 则登录成功。',
    'u=admin p=123456',
    JSON_ARRAY('success'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "u = input().strip()"}, {"type": "code_line", "value": "p = input().strip()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if u==\"admin\" and p==\"123456\":"}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"success\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\"fail\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '简单明文示例用于练习逻辑判断（生产环境不可如此）。',
    'if u==user and check(p): ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1228,
    52,
    '防止空格问题',
    '补全：输入去除首尾空格后再比对。',
    's=" admin "',
    JSON_ARRAY('admin'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(s.strip())"}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 strip 去除首尾空白避免因空格导致匹配失败。',
    'username = username.strip()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1229,
    52,
    '登录成功返回',
    '补全：登录成功后返回 token。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if check(u,p):"}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"token_123\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '示例中直接打印 token，演示思路。',
    '返回 JSON 包含 token'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1230,
    52,
    '安全提示词',
    '补全：不要在错误信息中返回敏感细节。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(\"用户名或密码错误\")"}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用通用错误信息可以避免信息泄露。',
    '不要返回 "密码错误" 或 "用户不存在" 的区分性提示'
);