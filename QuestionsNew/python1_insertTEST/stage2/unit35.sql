USE `questions`;
-- Unit 35 | Start ID: 961
-- Generated at 2025-12-24 17:30:06

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    961, 
    35, 
    '什么是嵌套 if', 
    '下面哪个描述最贴切？', 
    JSON_OBJECT('A', '在 if 内再写一个 if', 'B', '在循环外写 if', 'C', '用 if 定义函数', 'D', '在 if 中使用 return'), 
    1, 
    JSON_ARRAY('嵌套即层级结构', '注意缩进', '合法且常用'), 
    '嵌套 if 是在一个 if 的代码块内部再写另一个 if，以实现更细粒度的分支。', 
    'if a:
    if b:
        ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    962, 
    35, 
    '缩进层级', 
    '嵌套 if 需要注意什么？', 
    JSON_OBJECT('A', '层级缩进正确', 'B', '缩进无关紧要', 'C', '只能缩进两个级别', 'D', '内部 if 必须有 elif'), 
    1, 
    JSON_ARRAY('缩进决定所属块', '错误缩进会改变逻辑或触发语法错误', '保持一致的缩进风格'), 
    '嵌套结构依赖缩进来区分不同层级，保持正确缩进是关键。', 
    'if a:
    if b:
        print("ok")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    963, 
    35, 
    '嵌套示例用途', 
    '嵌套 if 常用于下列哪种场景？', 
    JSON_OBJECT('A', '逐级校验复杂条件', 'B', '替代函数', 'C', '替代字典', 'D', '增加循环次数'), 
    1, 
    JSON_ARRAY('逐步校验更容易理解', '适合分层次检查输入', '避免一次写复杂条件'), 
    '嵌套 if 有助于分层验证不同条件，便于分步处理和早期返回。', 
    'if logged_in:
    if is_admin:
        show_admin()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    964, 
    35, 
    '多层嵌套问题', 
    '过深的嵌套可能导致？', 
    JSON_OBJECT('A', '更好可读', 'B', '降低可读性并难以维护', 'C', '提高性能', 'D', '自动优化'), 
    2, 
    JSON_ARRAY('深嵌套难以理解', '考虑重构为函数', '遵守单一职责原则'), 
    '过深嵌套会降低可读性并增加维护成本，建议提炼函数或简化逻辑。', 
    '把复杂条件拆成多个小函数'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    965, 
    35, 
    '嵌套与短路', 
    '嵌套 if 与逻辑短路相比的区别是什么？', 
    JSON_OBJECT('A', '嵌套会短路', 'B', '逻辑短路不会创建新的缩进层', 'C', '两者等价', 'D', '嵌套更快'), 
    2, 
    JSON_ARRAY('短路是表达式求值特性', '嵌套是语句结构', '二者用途不同'), 
    '逻辑短路发生在表达式中，而嵌套 if 是语句结构，短路不改变代码块层级。', 
    'if a and b: ... 与 if a:
    if b: ... 区别在形式但可能在副作用上有差别'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    966, 
    35, 
    '避免嵌套策略', 
    '若要减少嵌套层级，推荐做法是？', 
    JSON_OBJECT('A', '提炼函数', 'B', '增加更多嵌套', 'C', '使用全局变量', 'D', '在条件中硬编码常量'), 
    1, 
    JSON_ARRAY('提炼函数能抽离职责', '重构后更易测试', '保持函数短小'), 
    '把内部逻辑提炼为函数是常见的减少嵌套、提高可读性的做法。', 
    'def check():
    if a: ...
if check(): ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    967, 
    35, 
    '嵌套与早期返回', 
    '在函数中遇到深层嵌套时常见做法是？', 
    JSON_OBJECT('A', '继续嵌套', 'B', '使用早期返回减少嵌套', 'C', '用全局变量逃逸', 'D', '用异常控制流程'), 
    2, 
    JSON_ARRAY('早期返回能减少嵌套层级', '提高可读性', '避免大量缩进'), 
    '通过在不满足条件时立即返回，可以减少嵌套层数，使代码更平坦更易读。', 
    'if not valid: return
# 之后逻辑不需再缩进'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    968, 
    35, 
    '嵌套中的变量作用域', 
    '内层 if 创建的新变量在外层是否可见？', 
    JSON_OBJECT('A', '不可见', 'B', '可见（同一函数内）', 'C', '仅在 if 内可见', 'D', '创建新作用域'), 
    2, 
    JSON_ARRAY('Python 仅函数/类/模块创建作用域', 'if/for 不创建新作用域', '内层变量可在外层访问'), 
    'if 语句不会创建新的作用域，内层定义的变量在同一函数内可见。', 
    'if True:
    x=1
print(x)  # 可见'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    969, 
    35, 
    '嵌套与可测试性', 
    '为何深嵌套会降低可测试性？', 
    JSON_OBJECT('A', '更难覆盖所有路径', 'B', '提高性能', 'C', '减少代码行', 'D', '增强可读性'), 
    1, 
    JSON_ARRAY('路径数随嵌套指数增长', '难以编写全面测试用例', '建议重构'), 
    '嵌套会增加可能的执行路径，导致测试需要覆盖更多组合，降低可测试性。', 
    '把复杂逻辑拆成小函数并分别测试'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    970,
    35,
    '嵌套判断示例',
    '补全：当用户已登录且为管理员时打印 Admin。',
    'logged=True; is_admin=True',
    JSON_ARRAY('Admin'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "logged = True"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "is_admin = True"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if logged:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if is_admin:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('"Admin"', '"User"', '"Guest"', '"None"'),
    JSON_ARRAY(1),
    '内层 if 用于判断管理员身份并输出 Admin。',
    'if logged:
    if premium:
        show_premium()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    971,
    35,
    '缩进错误修复',
    '修复缩进使嵌套 if 合法。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if a:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if b:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"ok\")"}]}]}',
    JSON_ARRAY('给第二行缩进', '删除一行', '加 else', '改为 while'),
    JSON_ARRAY(1),
    '内层 if 需要缩进以在外层 if 的代码块内。',
    'if a:
    if b:
        print("ok")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    972,
    35,
    '多层嵌套判断',
    '补全行使其只在所有条件都满足时打印 Yes。',
    'a=True;b=True;c=True',
    JSON_ARRAY('Yes'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a=True"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b=True"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "c=True"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if a:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if b:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        if c:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "            print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('"Yes"', '"No"', '"OK"', '"None"'),
    JSON_ARRAY(1),
    '只有当 a,b,c 都为 True 才打印 Yes。',
    '逐级检查多个权限标志。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    973,
    35,
    '缩进演练',
    '将缺少缩进的代码修复为嵌套 if。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if x>0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if y>0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"both\")"}]}]}',
    JSON_ARRAY('给第二行缩进', '删除第二行', '改为 elif', '改为 while'),
    JSON_ARRAY(1),
    '内层 if 需要缩进以表示属于外层分支。',
    'if x>0:
    if y>0:
        print("both")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    974,
    35,
    '练习：权限判断',
    '补全：登陆 且 (管理员或 VIP) 时允许。',
    'logged=True; is_admin=False; is_vip=True',
    JSON_ARRAY('Allowed'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "logged=True"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "is_admin=False"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "is_vip=True"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if logged:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if is_admin or is_vip:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('"Allowed"', '"Denied"', '"Login"', '"None"'),
    JSON_ARRAY(1),
    '只要 is_admin 或 is_vip 为真且已登录即允许。',
    '嵌套和逻辑组合常用于权限判断。'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    975,
    35,
    '实战：复合条件',
    '补全：需要满足两层条件才通过。',
    'a=True; b=False',
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a=True"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b=False"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if a:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if b:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        print(\"Pass\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    else:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('"Fail"', '"Pass"', '"OK"', '"None"'),
    JSON_ARRAY(1),
    'a 为真但 b 为假，内层 else 应输出 Fail。',
    '分层判断结果处理常见于表单校验。'
);