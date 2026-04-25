USE `questions`;
-- Unit 60 | Start ID: 1336
-- Generated at 2025-12-24 17:38:25

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1336, 
    60, 
    '复习：规则优先级', 
    '当多个分类规则同时匹配时应优先？', 
    JSON_OBJECT('A', '更具体或更严格的规则', 'B', '随机一个规则', 'C', '总是最后一个规则', 'D', '删除规则'), 
    1, 
    JSON_ARRAY('具体优先以避免被宽泛规则覆盖'), 
    '优先更具体或更严格的规则可以保证预期分类结果。', 
    '先判断特殊 case 再判断一般 case'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1337, 
    60, 
    '复习：登录安全', 
    '登录流程中不应在响应中返回？', 
    JSON_OBJECT('A', '明文密码', 'B', 'session token', 'C', '用户 id', 'D', '登录时间'), 
    1, 
    JSON_ARRAY('敏感信息勿回传'), 
    '明文密码绝对不应返回或存储于响应中。', 
    '返回 token 而不是密码'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1338, 
    60, 
    '复习：区间判断', 
    '链式比较 a < x <= b 等价于？', 
    JSON_OBJECT('A', 'a < x and x <= b', 'B', 'a < x or x <= b', 'C', '(a<x)<=b', 'D', 'a<=x<=b'), 
    1, 
    JSON_ARRAY('链式比较由 and 连接'), 
    '链式比较等价于并列比较的 and 组合。', 
    'if 0<x<=10: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1339, 
    60, 
    '复习：日志与隐私', 
    '记录异常时应避免记录？', 
    JSON_OBJECT('A', '敏感用户数据', 'B', '错误栈信息', 'C', '错误时间', 'D', '错误上下文摘要'), 
    1, 
    JSON_ARRAY('保护用户隐私', '记录有用而非敏感信息'), 
    '日志应避免记录敏感信息但保留足够上下文便于排查。', 
    'log.info("action failed for uid=%s", mask(uid))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1340, 
    60, 
    '复习：短路求值', 
    '表达式 a and b or c 的风险是什么？', 
    JSON_OBJECT('A', '当 b 为假的非布尔值时结果可能异常', 'B', '总是安全', 'C', '没有短路', 'D', '不可运行'), 
    1, 
    JSON_ARRAY('and/or 返回实际操作数', '谨慎使用复合简写'), 
    '复合简写在 b 为假但非布尔值时可能导致不预期的返回值，建议用括号或三元表达式。', 
    '用 (a and b) or c 时注意 b 的类型'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1341, 
    60, 
    '复习：菜单循环', 
    '实现循环菜单时应确保？', 
    JSON_OBJECT('A', '提供退出并校验输入', 'B', '无限循环无退出', 'C', '每次都重启程序', 'D', '不处理异常'), 
    1, 
    JSON_ARRAY('用户体验与健壮性并重'), 
    '循环菜单应允许退出并处理无效输入以提升稳定性。', 
    'while True: ch=input(); if ch=="q": break'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1342, 
    60, 
    '复习：重构策略', 
    '重构长分支链时应优先？', 
    JSON_OBJECT('A', '提取公共逻辑并用映射替代', 'B', '增加更多注释而不改代码', 'C', '复制粘贴以节省时间', 'D', '删除测试'), 
    1, 
    JSON_ARRAY('减少重复', '增加可测试性'), 
    '提取公共逻辑和映射表是常见且有效的重构手段。', 
    '使用 helper 函数'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1343, 
    60, 
    '复习：异常恢复', 
    '对暂时性失败更推荐的处理是？', 
    JSON_OBJECT('A', '有限重试并记录', 'B', '直接放弃且不记录', 'C', '无限重试', 'D', '终止服务'), 
    1, 
    JSON_ARRAY('有限重试减少失败几率', '避免无限循环'), 
    '有限重试可在短暂故障恢复后继续流程，同时记录便于以后分析。', 
    'retry 3 times with delay'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1344, 
    60, 
    '复习：日志粒度', 
    '调试阶段日志粒度通常应如何选择？', 
    JSON_OBJECT('A', '较详细以便排查问题', 'B', '完全不记录', 'C', '仅记录成功日志', 'D', '只记录用户输入'), 
    1, 
    JSON_ARRAY('调试阶段多记录', '生产阶段注意简化与隐私'), 
    '调试阶段适当增加日志有助于快速定位问题，生产环境需平衡性能与隐私。', 
    'logger.debug("state=%s", state)'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1345,
    60,
    '复习：异常处理模板',
    '补全：捕获并记录 ValueError。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "try:"}, {"type": "code_line", "value": "    x = int(input())"}, {"type": "code_line", "value": "except ValueError as e:"}, {"type": "code_line", "value": "    print(\"invalid\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '捕获特定异常并作出友好提示是良好实践。',
    'except KeyError: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1346,
    60,
    '复习：映射表用法',
    '补全：用 dict 选择处理函数。',
    'cmd="a"',
    JSON_ARRAY('A'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "fmap = {\"a\": lambda: print(\"A\"), \"b\": lambda: print(\"B\")}"}, {"type": "code_line", "value": "fmap.get(cmd, lambda: print(\"invalid\"))()"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用字典将命令映射到行为是替代长分支的常用方法。',
    'actions[opt]()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1347,
    60,
    '复习：三元表达式',
    '补全：用三元表达式返回最大值。',
    'a=3 b=5',
    JSON_ARRAY('5'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = int(input())"}, {"type": "code_line", "value": "b = int(input())"}, {"type": "code_line", "value": "print(a if a>=b else b)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '三元表达式可用于简单条件的返回值选择。',
    'res = x if cond else y'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1348,
    60,
    '复习：白名单校验',
    '补全：只接受 "yes" 或 "no"。',
    's=yes',
    JSON_ARRAY('accepted'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input().strip()"}, {"type": "code_line", "value": "if s in (\"yes\",\"no\"):"}, {"type": "code_line", "value": "    print(\"accepted\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\"rejected\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '白名单可以有效控制输入范围。',
    'if choice in options: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1349,
    60,
    '复习：map 用法',
    '补全：将函数应用到列表并输出结果。',
    'lst=1,2,3',
    JSON_ARRAY('2 3 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = [1,2,3]"}, {"type": "code_line", "value": "print(*map(lambda x: x+1, lst))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'map 可用于把同一操作批量应用到序列元素。',
    'list(map(str, lst))'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1350,
    60,
    '复习：小结写法',
    '补全：在函数开头写明函数用途示例。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def f(x):"}, {"type": "code_line", "value": "    \"\"\"返回 x 的平方\"\"\""}, {"type": "code_line", "value": "    return x*x"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '在函数加入 docstring 能帮助他人快速理解用途。',
    'def add(a,b): """返回 a+b"""'
);