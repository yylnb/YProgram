USE `questions`;
-- Unit 42 | Start ID: 616
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    616,
    42,
    '字符串比较与大小写',
    '在实现登录验证时，想要忽略用户名的大小写差异，哪种做法最合适？',
    JSON_OBJECT('A', '把输入和存储的用户名都转换为同一大小写再比较', 'B', '使用 is 运算符比较两个字符串是否相等', 'C', '只比较字符串的长度是否相同', 'D', '把用户名转换为数字后比较'),
    1,
    JSON_ARRAY('字符串大小写会影响 == 比较的结果。', 'Python 中 is 用于对象标识，不用于字符串内容比较。', '把两边都统一到 lower() 或 upper() 通常能解决大小写问题。'),
    '将输入和存储的用户名都用 .lower()（或 .upper()）标准化后再用 == 比较，可以忽略大小写差异。',
    '例如：if input_name.strip().lower() == stored_name.lower():'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    617,
    42,
    '空字符串的布尔值',
    '在检查用户是否输入了密码时，下列哪条判断能正确检测空密码（用户直接按回车）？',
    JSON_OBJECT('A', 'if password:  # 密码存在', 'B', 'if password == None:', 'C', 'if len(password) > 100:', 'D', 'if password is True:'),
    1,
    JSON_ARRAY('空字符串在布尔上下文中为假（False）。', 'None 与空字符串是不同类型和值。', '直接使用 if password 能区分空字符串和非空字符串。'),
    'if password 会在 password 为非空字符串时为真，空字符串（""）为假，适合检测用户是否输入了内容。',
    '例如：if not password: print("请输入密码")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    618,
    42,
    '比较密码正确性',
    '判断用户输入的密码与已存密码是否匹配时，下面哪项是常见且安全的（逻辑版）做法？',
    JSON_OBJECT('A', '直接用 == 比较两个字符串（注意不要打印明文密码）', 'B', '把正确密码打印出来以便调试再比较', 'C', '用用户名替代密码进行比较', 'D', '比较两个密码变量的 id（内存地址）'),
    1,
    JSON_ARRAY('开发时不要输出用户明文密码到日志或终端。', '字符串内容相等用 ==，id 或 is 用于对象身份比较。', '实际生产中应使用哈希，但本单元聚焦逻辑判断。'),
    '在逻辑练习中直接使用 == 比较输入密码与存储密码的字符串值是正确的做法（但生产要用哈希比对）。',
    'if input_password == stored_password:
    print("登录成功")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    619,
    42,
    '基础登录判断模板',
    '补全代码：根据输入的 username 和 password，若两者同时匹配则打印 "登录成功"，否则 "登录失败"。',
    JSON_ARRAY('stored_user = "Alice"
stored_pass = "p@ss123"
username = input()
password = input()'),
    JSON_ARRAY('登录成功', '登录失败'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(username.strip(), stored_user):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    if "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(password, stored_pass):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        print(\\"登录成功\\")"}, {"type": "code_line", "value": "    else:"}, {"type": "code_line", "value": "        print(\\"登录失败\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\"登录失败\\")"}]}]}',
    JSON_ARRAY('equal', '==', 'compare', 'matches', 'username.lower()==', '==', 'is', 'str.equals'),
    JSON_ARRAY(2, 2),
    '需要用 == 比较字符串：先比较 username.strip() 与 stored_user（题中简单匹配），再比较 password 与 stored_pass，故两处都应使用 ==。',
    '例如将 username.strip().lower() 与 stored_user.lower() 比较可以忽略大小写。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    620,
    42,
    '同时检查用户名非空且密码长度合法',
    '补全代码：要求用户名不为空且密码长度至少为 6，符合则继续登录判断，否则提示不合规。',
    JSON_ARRAY('username = input()
password = input()'),
    JSON_ARRAY('输入格式通过', '用户名或密码格式不正确'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": " and "}, {"type": "slot", "index": 1}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    # 继续登录流程"}, {"type": "code_line", "value": "    print(\\"输入格式通过\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\"用户名或密码格式不正确\\")"}]}]}',
    JSON_ARRAY('username', 'username != ""', 'len(password) >= 6', 'password', 'username.strip()', 'password > 6', 'bool(username)', 'password.strip()'),
    JSON_ARRAY(3, 5),
    '需要判断用户名非空（username.strip() 或 username != ""，这里用 strip() 可以去除空白）和密码长度（len(password) >= 6）。',
    'if username.strip() and len(password) >= 6:'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    621,
    42,
    '短路求值的好处',
    '在 if username and password == stored_pass: 这样的复合判断中，短路求值有什么用？',
    JSON_OBJECT('A', '可以避免在 username 为空时仍去计算 password 的比较，从而节省时间或避免错误', 'B', '能自动修正空用户名为默认用户名', 'C', '会把两个字符串拼接起来再比较', 'D', '会把变量转换为相同类型再比较'),
    1,
    JSON_ARRAY('短路求值会在第一个条件为 False 时跳过后续条件。', '这有助于避免在后续条件中对空或 None 值进行不安全的操作。', '短路与自动类型转换无关。'),
    '短路求值（short-circuit）会在左边条件为 False 时不再计算右边表达式，避免不必要或危险的计算。',
    '例如 if user and user.is_active: 当 user 为 None 或空时不会调用 is_active。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    622,
    42,
    'and 与 or 的优先级与结合',
    '下面哪句关于 and/or 的说法是正确的（用于登录逻辑的组合判断）？',
    JSON_OBJECT('A', 'and 的优先级高于 or，表达式会先计算 and 再计算 or', 'B', 'or 的优先级高于 and', 'C', 'and 与 or 优先级相同，从左到右计算', 'D', 'Python 里不能把 and 和 or 混合使用'),
    1,
    JSON_ARRAY('逻辑运算符有优先级规则。', '在需要混合使用时，常用括号明确意图。', 'Python 允许混合使用 and 和 or。'),
    '在 Python 中，and 的优先级高于 or，混合表达式会先计算 and 子表达式，使用括号可以避免歧义。',
    '例如 a or b and c 等价于 a or (b and c)。'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    623,
    42,
    '使用 not 检测失败情况',
    '想在登录失败时执行某段代码，下列哪种写法最清楚地表达“如果登录不成功就…”？',
    JSON_OBJECT('A', 'if not (username == stored and password == stored_pass):', 'B', 'if username == stored and password == stored_pass:', 'C', 'if username != stored or password != stored_pass:', 'D', 'A 或 C 都可以'),
    4,
    JSON_ARRAY('逻辑否定（not）与 De Morgan 定律有关。', 'not (A and B) 等价于 (not A) or (not B)。', '选择写法时考虑可读性。'),
    'not (A and B) 与 (not A) or (not B) 等价；两种写法都能在登录不成功时触发，因此都可接受，视可读性选择。',
    'if not (user_ok and pass_ok):
    print("登录失败")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    624,
    42,
    '忽略两端空白再比对',
    '补全代码：要求在比对用户名时忽略输入两端的空白字符。',
    JSON_ARRAY('stored = "bob"
username = input()'),
    JSON_ARRAY('匹配', '不匹配'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(username) == "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(stored):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"匹配\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\"不匹配\\")"}]}]}',
    JSON_ARRAY('username.strip()', 'strip', 'username.lower()', 'stored.strip()', 'stored.lower()', 'username.rstrip()', 'username.lstrip()', 'trim'),
    JSON_ARRAY(1, 4),
    '调用 .strip() 去掉两端空白后再比较：username.strip() == stored.strip()（此处 stored 可直接是存储值，或也使用 strip() 保持一致）。',
    'if username.strip().lower() == stored.strip().lower():  # 忽略空白和大小写'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    625,
    42,
    '一次性判断用户名或邮箱登录',
    '补全代码：支持用户可以使用用户名或邮箱登录，只要任意一个匹配即可。',
    JSON_ARRAY('stored_user = "amy"
stored_email = "amy@example.com"
input_str = input()'),
    JSON_ARRAY('登录成功', '登录失败'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(input_str, stored_user) or "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(input_str, stored_email):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"登录成功\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\"登录失败\\")"}]}]}',
    JSON_ARRAY('input_str ==', 'input_str is', 'input_str.lower() ==', 'input_str.strip() ==', 'equals', 'matches', 'in', '=='),
    JSON_ARRAY(4, 1),
    '先去除可能的空白（input_str.strip()）再与存储的用户名或邮箱用 == 比较，两个条件之间用 or。',
    'if input_str.strip() == stored_user or input_str.strip() == stored_email:'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    626,
    42,
    '顺序与先决条件',
    '在实现登录时，先检查用户名是否存在再检查密码，主要目的是？',
    JSON_OBJECT('A', '避免对不存在的用户执行密码比较或额外的查库操作', 'B', '提高密码的安全强度', 'C', '减少用户名的输入框长度', 'D', '让登录总是更慢以防暴力破解'),
    1,
    JSON_ARRAY('如果用户不存在，再去查密码可能没有意义或会浪费资源。', '先决条件可以避免错误或异常。', '提高安全强度不是通过改变检查顺序实现的。'),
    '先判断用户名是否存在可以避免对不存在用户进行无效的密码验证或数据库查询，节省资源并减少错误路径。',
    'if user_exists(username):
    check_password()
else:
    print("用户不存在")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    627,
    42,
    '避免信息泄露的提示策略',
    '为防止泄露账户是否存在，登录失败时的友好提示应该怎样写？',
    JSON_OBJECT('A', '统一提示 "用户名或密码不正确"，不说明是哪一项错误', 'B', '分别提示 "用户名不存在" 或 "密码错误" 以便用户修正', 'C', '把正确的用户名打印出来帮助用户', 'D', '在提示中包含用户的注册邮箱'),
    1,
    JSON_ARRAY('过于具体的错误信息可能被用于探测系统中的账号。', '友好提示要兼顾安全与用户体验。', '泄露注册邮箱或用户名是危险的做法。'),
    '为防止恶意探测，登录失败时最好使用模糊的统一提示，如 "用户名或密码不正确"。',
    'print("用户名或密码不正确，请重试")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    628,
    42,
    '连续失败次数的逻辑处理',
    '如果要在登录失败三次后锁定一段时间，下列哪种伪逻辑最合适？',
    JSON_OBJECT('A', '记录失败计数，达到阈值后设置锁定标志并记录时间戳', 'B', '每次失败时重置整个用户数据库', 'C', '在客户端无限制地弹出密码提示直到正确', 'D', '把所有用户的密码重置为相同默认密码'),
    1,
    JSON_ARRAY('需要有计数器和时间戳来实现简单的锁定策略。', '不要在客户端实现安全关键逻辑。', '重置用户数据库或密码是危险且不合理的。'),
    '常见做法是记录失败次数，超过阈值后设置 lock=True 和 lock_time，然后在一定时间后允许重试或需要人工解锁。',
    'if attempts >= 3:
    locked = True
    lock_time = time.time()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    629,
    42,
    '用逻辑运算符合并多条件',
    '补全代码：要求用户名非空且密码既不为空又长度至少为 6 才视为有效输入。',
    JSON_ARRAY('username = input()
password = input()'),
    JSON_ARRAY('格式有效', '格式无效'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "valid = ("}, {"type": "slot", "index": 0}, {"type": "code", "value": ") and ("}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if valid:"}, {"type": "code_line", "value": "    print(\\"格式有效\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\"格式无效\\")"}]}]}',
    JSON_ARRAY('username', 'username.strip() != ""', 'username.strip()', 'len(password) >= 6', 'password', 'password.strip() != ""', 'bool(password)', 'password and len(password) >= 6'),
    JSON_ARRAY(2, 4),
    '左侧判断 username.strip() != "" 用于检测非空，右侧判断 len(password) >= 6 检查密码长度；两边用 and 组合。',
    'valid = username.strip() != "" and len(password) >= 6'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    630,
    42,
    '实现简单的逻辑版登录流程',
    '补全代码：如果用户名和密码都正确则打印 "欢迎"，否则打印 "登录失败"。请补全下划线处。',
    JSON_ARRAY('stored_user = "jarvis"
stored_pass = "openSesame"
user = input()
pw = input()'),
    JSON_ARRAY('欢迎', '登录失败'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(user.strip()) and "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(pw) and "}, {"type": "slot", "index": 2}, {"type": "code", "value": "(user.strip(), stored_user) and "}, {"type": "slot", "index": 3}, {"type": "code", "value": "(pw, stored_pass):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"欢迎\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\"登录失败\\")"}]}]}',
    JSON_ARRAY('user', 'user.strip()', 'bool(user)', 'user ==', '==', 'pw ==', 'len(pw) > 0', 'pw.strip()'),
    JSON_ARRAY(2, 6, 4, 5),
    '先用 user.strip() 检查用户名非空（或转换后再用），再用 pw == stored_pass 检查密码相等，同时用 user.strip() == stored_user 检查用户名相等；选项顺序分别填入相应位置。',
    'if user.strip() and (pw == stored_pass) and (user.strip() == stored_user):
    print("欢迎")'
);