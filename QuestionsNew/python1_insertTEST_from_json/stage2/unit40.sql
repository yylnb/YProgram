USE `questions`;
-- Unit 40 | Start ID: 586
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    586,
    40,
    '输入类型检查',
    '下列哪种方式可以安全把输入转换为整数？',
    JSON_OBJECT('A', '使用 try/except 捕获 ValueError', 'B', '直接 int(input()) 不捕获', 'C', '用 float 转换再 int', 'D', '用 eval 解析'),
    1,
    JSON_ARRAY('用户输入可能无效', '异常处理是常见方法', 'ValueError 会被抛出'),
    '用 try/except 捕获 ValueError 可以避免程序崩溃并做友好提示。',
    'try:
    n = int(input())
except ValueError:
    print("invalid")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    587,
    40,
    'isnumeric 与 isnumeric',
    '哪个方法可用于判断字符串是否只包含数字字符？',
    JSON_OBJECT('A', 'str.isdigit() 或 str.isnumeric()', 'B', 'str.isalpha()', 'C', 'len(s)>0', 'D', 's == int(s)'),
    1,
    JSON_ARRAY('有专用方法检测数字', '注意 Unicode 数字字符', '不是万能转换方法'),
    'str.isdigit() 与 str.isnumeric() 可用于检测字符串是否为数字形式。',
    'if s.isdigit(): n=int(s)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    588,
    40,
    '避免 crash 的策略',
    '当用户输入错误时最佳策略是？',
    JSON_OBJECT('A', '提示并要求重新输入', 'B', '直接退出程序', 'C', '忽略并继续使用默认值', 'D', '抛出未捕获异常'),
    1,
    JSON_ARRAY('用户体验优先', '保持程序健壮', '给予友好提示'),
    '提示用户并要求重新输入通常更友好且可靠。',
    'while True:
    try: ...
    except: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    589,
    40,
    '基本输入验证',
    '补全：检查输入是否非空再转换为整数。',
    JSON_ARRAY('s="42"'),
    JSON_ARRAY('42'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    n = int(s)"}, {"type": "code_line", "value": "    print(n)"}]}]}',
    JSON_ARRAY('strip', 'isdigit', 'lower', 'split'),
    JSON_ARRAY(2),
    '使用 isdigit 检查是否为数字字符串再转换。',
    'if s.isdigit(): n=int(s)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    590,
    40,
    '异常处理写法',
    '补全：捕获 int 转换的异常并提示。',
    JSON_ARRAY('s="abc"'),
    JSON_ARRAY('invalid'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "try:"}, {"type": "code_line", "value": "    n = int(s)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "except "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"invalid\\")"}]}]}',
    JSON_ARRAY('ValueError', 'TypeError', 'Exception', 'KeyError'),
    JSON_ARRAY(1),
    'int() 转换失败会抛出 ValueError。',
    'except ValueError:
    ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    591,
    40,
    '防御式编程思想',
    '以下哪项最符合防御式编程？',
    JSON_OBJECT('A', '对外部输入进行验证', 'B', '假设输入总是正确', 'C', '不做任何检查以提高速度', 'D', '在崩溃后重启程序'),
    1,
    JSON_ARRAY('对输入验证是防御式编程常见做法', '可以提高健壮性', '避免未定义行为'),
    '防御式编程强调对不可信输入进行验证和容错处理。',
    'validate(user_input)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    592,
    40,
    '用户提示友好性',
    '提示用户输入错误时应如何做？',
    JSON_OBJECT('A', '告诉错误并给出示例格式', 'B', '只显示技术异常信息', 'C', '静默忽略错误', 'D', '终止程序'),
    1,
    JSON_ARRAY('友好提示提升体验', '给出示例格式帮助用户纠错', '避免泄露内部堆栈信息'),
    '对用户显示可理解的错误和示例输入通常更好。',
    '请输入整数，例如 42'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    593,
    40,
    '异常捕获范围',
    '应尽量捕获哪种范围的异常？',
    JSON_OBJECT('A', '尽可能具体的异常类型', 'B', '使用 broad except 捕获所有', 'C', '只捕获 BaseException', 'D', '不捕获任何异常'),
    1,
    JSON_ARRAY('具体异常更易调试', '避免吞掉程序错误', '保持错误可追踪'),
    '捕获具体异常更安全，避免掩盖真问题。',
    'except ValueError: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    594,
    40,
    '循环重试输入',
    '补全：在输入无效时要求继续输入。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "while True:"}, {"type": "code_line", "value": "    s = input()"}, {"type": "code_line", "value": "    try:"}, {"type": "code_line", "value": "        n = int(s)"}, {"type": "code_line", "value": "        break"}, {"type": "code_line", "value": "    except ValueError:"}, {"type": "code_line", "value": "        print(\\"Please input an integer\\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    '用循环和异常处理实现重试输入。',
    '见上方代码'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    595,
    40,
    '去除空白再判断',
    '补全：剔除两端空白后判断是否为空。',
    JSON_ARRAY('s="  "'),
    JSON_ARRAY('Empty'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if not s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\"Empty\\")"}]}]}',
    JSON_ARRAY('strip', 'isdigit', 'lower', 'split'),
    JSON_ARRAY(1),
    'strip() 去除两端空白后可判断是否为空字符串。',
    'if not s.strip(): ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    596,
    40,
    '用断言检查',
    '断言（assert）常用于？',
    JSON_OBJECT('A', '开发时检查假设', 'B', '替代运行时输入验证', 'C', '在生产中处理用户错误', 'D', '捕获异常'),
    1,
    JSON_ARRAY('assert 在开发或测试有用', '它可能被优化掉', '不建议用作用户输入验证'),
    'assert 用于开发时断言条件，生产环境中不应依赖它做输入校验。',
    'assert x >= 0'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    597,
    40,
    '异常信息的显示',
    '向用户显示异常堆栈信息好吗？',
    JSON_OBJECT('A', '通常不显示，给友好提示', 'B', '总是显示完整堆栈', 'C', '只显示文件名', 'D', '显示仅第一行'),
    1,
    JSON_ARRAY('避免泄露内部实现', '显示易懂的错误说明', '日志中可记录堆栈供开发者查看'),
    '对用户显示友好错误信息，堆栈写入日志以便排查。',
    'print("输入无效，请输入数字")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    598,
    40,
    '防止输入阻塞',
    '在命令行程序中处理输入超时常用？',
    JSON_OBJECT('A', '使用线程或 select 处理', 'B', 'input() 本身支持超时', 'C', '用 int() 设置超时', 'D', '用 try/except 捕获 TimeoutError'),
    1,
    JSON_ARRAY('标准 input() 无超时参数', '需借助系统调用或线程', '跨平台实现有差异'),
    'input() 无内建超时，可通过线程或 select 等机制处理。',
    '使用 signal.alarm 在 Unix 下实现超时'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    599,
    40,
    '记录错误日志',
    '补全：在 except 中记录异常信息到日志。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import logging"}, {"type": "code_line", "value": "try:"}, {"type": "code_line", "value": "    n = int(s)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "except ValueError as e:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    logging."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\\"invalid input %s\\", e)"}]}]}',
    JSON_ARRAY('error', 'warn', 'info', 'debug'),
    JSON_ARRAY(1),
    '在 except 中调用 logging.error 将错误记录下来便于排查。',
    'logging.error("failed: %s", e)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    600,
    40,
    '实践：稳定的转换',
    '补全：写一个安全转换函数，失败返回 None。',
    JSON_ARRAY('s="abc"'),
    JSON_ARRAY('None'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def safe_int(s):"}, {"type": "code_line", "value": "    try:"}, {"type": "code_line", "value": "        return int(s)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    except "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        return None"}]}]}',
    JSON_ARRAY('ValueError', 'TypeError', 'Exception', 'KeyError'),
    JSON_ARRAY(1),
    '捕获 ValueError 并返回 None 表示转换失败。',
    'if safe_int(s) is None: ...'
);