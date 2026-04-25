USE `questions`;
-- Unit 54 | Start ID: 1246
-- Generated at 2025-12-24 17:36:54

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1246, 
    54, 
    '显示菜单的基本步骤', 
    '实现命令行菜单通常需要先做什么？', 
    JSON_OBJECT('A', '打印选项并读取用户输入', 'B', '直接执行默认操作', 'C', '等待网络请求', 'D', '关闭程序'), 
    1, 
    JSON_ARRAY('展示选项', '获取用户选择'), 
    '先展示选项并读取输入，然后根据选择分支处理。', 
    'print("1. A\n2. B")\nchoice = input()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1247, 
    54, 
    '输入校验', 
    '读取菜单选择后应当做什么？', 
    JSON_OBJECT('A', '校验输入是否在合法范围内', 'B', '忽略输入直接继续', 'C', '只接受文本输入', 'D', '每次重启程序'), 
    1, 
    JSON_ARRAY('避免无效选项', '提示用户重试'), 
    '需要校验输入以避免非法分支并提示用户重新输入。', 
    'if choice not in ("1","2"): ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1248, 
    54, 
    '循环菜单', 
    '要让用户反复选择应使用？', 
    JSON_OBJECT('A', '循环 (while) 展示菜单', 'B', '只展示一次', 'C', '用递归不断调用', 'D', '退出程序'), 
    1, 
    JSON_ARRAY('使用 while True', '提供退出选项'), 
    '循环展示菜单并在合适时退出可以提高用户体验。', 
    'while True: show_menu() if choice=="q": break'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1249, 
    54, 
    '退出处理', 
    '菜单中加入退出选项的常见符号是？', 
    JSON_OBJECT('A', 'q 或 0', 'B', '无退出', 'C', '-1', 'D', '空格'), 
    1, 
    JSON_ARRAY('常用 q 或 0 为退出标记'), 
    '常用 q 或 0 作为退出命令，便于用户识别。', 
    'if ch=="q": break'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1250, 
    54, 
    '命令映射', 
    '将命令映射到函数的好处是？', 
    JSON_OBJECT('A', '代码更简洁且易扩展', 'B', '减慢程序速度', 'C', '难以维护', 'D', '无法测试'), 
    1, 
    JSON_ARRAY('使用字典把选项映射到函数'), 
    '映射函数便于新增或修改命令并使代码更清晰。', 
    'actions = {"1": func1, "2": func2}\nactions[ch]()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1251, 
    54, 
    '友好提示', 
    '当用户输入无效时应如何处理？', 
    JSON_OBJECT('A', '提示并允许重试', 'B', '直接崩溃', 'C', '忽略并继续', 'D', '清除屏幕'), 
    1, 
    JSON_ARRAY('友好提示提升体验', '允许用户纠正错误'), 
    '给出友好错误提示并允许重试是良好交互设计。', 
    'print("无效输入，请重试")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1252, 
    54, 
    '提示信息', 
    '菜单提示应简洁且包含什么？', 
    JSON_OBJECT('A', '可选项与退出提示', 'B', '详细实现代码', 'C', '日志内容', 'D', '用户密码'), 
    1, 
    JSON_ARRAY('告诉用户如何退出和选择'), 
    '提示应清楚列出选项及如何退出或返回上级菜单。', 
    'print("输入 q 退出")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1253, 
    54, 
    '避免死循环', 
    '循环菜单时防止死循环的方式是？', 
    JSON_OBJECT('A', '提供退出条件并正确处理输入', 'B', '无限循环不处理', 'C', '关闭程序线程', 'D', '让用户等待很久'), 
    1, 
    JSON_ARRAY('正确判断退出', '处理异常中断'), 
    '提供明确的退出条件并处理异常可以避免程序无法结束。', 
    'try: ... except KeyboardInterrupt: break'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1254, 
    54, 
    '菜单层级', 
    '设计多级菜单时应如何组织？', 
    JSON_OBJECT('A', '每个子菜单有返回上级选项', 'B', '跳转没有返回', 'C', '所有选项写在一起', 'D', '用递归但不提供返回'), 
    1, 
    JSON_ARRAY('用户可返回上级', '清晰层级结构更友好'), 
    '多级菜单应允许用户方便地返回上级并导航。', 
    '在子菜单加入 "b: back"'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1255,
    54,
    '实现简单菜单',
    '补全：显示 1/2/3 选项并读取选择。',
    '2',
    JSON_ARRAY('selected 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"1. a\\n2. b\\n3. c\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "ch = input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"selected\", ch)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '打印菜单并读取用户输入后处理选择。',
    'if ch=="1": ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1256,
    54,
    '处理无效输入',
    '补全：若输入不在选项中提示错误。',
    '9',
    JSON_ARRAY('invalid'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "ch = input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if ch not in (\"1\",\"2\",\"3\"):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"invalid\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '校验输入并及时反馈不合法选择。',
    'print("请选择 1-3")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1257,
    54,
    '循环菜单实现',
    '补全：用 while 循环实现可重复菜单。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "while True:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"1. a\\nq. quit\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    ch = input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if ch == \"q\":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        break"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用循环不断显示菜单并在 q 时退出。',
    'while True: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1258,
    54,
    '函数映射示例',
    '补全：把选项映射到函数并调用。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def a():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"A\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "def b():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"B\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "map = {\"1\": a, \"2\": b}"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "ch = input()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "map.get(ch, lambda: print(\"invalid\"))()"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用字典映射可以直接根据输入调用对应函数。',
    'actions[ch]()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1259,
    54,
    '显示带序号的列表',
    '补全：根据 items 列表打印序号菜单。',
    'items=["a","b"]',
    JSON_ARRAY('1. a', '2. b'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "items = [\"a\",\"b\"]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for i, it in enumerate(items, 1):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(f\"{i}. {it}\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 enumerate 可以便捷打印带序号的列表。',
    'for i,v in enumerate(lst,1): print(i,v)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1260,
    54,
    '读取数字选择并转换',
    '补全：将输入转换为整数并处理异常。',
    'ch="2"',
    JSON_ARRAY('2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "try:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    n = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(n)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "except ValueError:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"invalid\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '转换前做异常捕获以防止程序崩溃。',
    'try: n=int(s) except: ...'
);