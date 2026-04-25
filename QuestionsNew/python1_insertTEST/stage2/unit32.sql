USE `questions`;
-- Unit 32 | Start ID: 916
-- Generated at 2025-12-24 17:30:02

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    916, 
    32, 
    'else 的用途', 
    'when 会走 else 分支？', 
    JSON_OBJECT('A', '当 if 条件为真时', 'B', '当 if 条件为假时', 'C', 'else 总是执行', 'D', 'else 只能跟在循环后'), 
    2, 
    JSON_ARRAY('else 在 if 条件为假时执行', 'else 与 if 配套使用', 'else 不带条件'), 
    'else 分支在 if 条件为 False 时执行。', 
    'if x>0:
    ...
else:
    ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    917, 
    32, 
    'else 可以省略吗？', 
    '下面哪个说法正确？', 
    JSON_OBJECT('A', '不能省略', 'B', '可以省略，视情况而定', 'C', '只有在函数内可省略', 'D', '语法不允许省略 else'), 
    2, 
    JSON_ARRAY('else 是可选的', '很多情况下只需 if', 'else 用于提供替代路径'), 
    'else 是可选的，只有需要在条件不满足时执行代码才使用。', 
    'if x>0:
    print(x)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    918, 
    32, 
    'else 与缩进', 
    '下面哪个写法是合法的 if/else 结构？', 
    JSON_OBJECT('A', 'if a:
print(1)
else:
print(2)', 'B', 'if a:
    print(1)
else:
    print(2)', 'C', 'if a: print(1) else: print(2)', 'D', 'if a then print(1) else print(2)'), 
    2, 
    JSON_ARRAY('Python 用缩进表示代码块', '单行可以写成 if a: print(1)', '不能用 then'), 
    '正确的多行写法需要在 if/else 下面缩进代码块。', 
    'if x>0:
    print("pos")
else:
    print("non-pos")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    919, 
    32, 
    'else 与 elif 的区别', 
    '哪个选项描述是对的？', 
    JSON_OBJECT('A', 'elif 是带条件的 else', 'B', 'elif 必须放在 else 之前', 'C', 'else 可以带条件', 'D', 'elif 无法跟随 if'), 
    1, 
    JSON_ARRAY('elif 是 else if 的缩写', 'elif 带条件', 'else 无条件执行'), 
    'elif 提供带条件的后续分支，else 无条件执行。', 
    'if a: ...
elif b: ...
else: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    920, 
    32, 
    'if/else 的常见用途', 
    '下面哪个是 if/else 的合理用途？', 
    JSON_OBJECT('A', '控制流程分支', 'B', '定义函数', 'C', '导入模块', 'D', '创建类'), 
    1, 
    JSON_ARRAY('if/else 用于逻辑分支', '函数/类 定义不是其目的', '常用于输入校验'), 
    'if/else 用来根据条件选择不同执行路径，是控制流程的基本手段。', 
    'if logged_in:
    show_dashboard()
else:
    show_login()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    921, 
    32, 
    'else 的执行时机', 
    '下面哪个场景会触发 else？', 
    JSON_OBJECT('A', 'if 条件为真', 'B', 'if 条件为假', 'C', '无论如何都触发', 'D', '只有异常发生时触发'), 
    2, 
    JSON_ARRAY('else 是在条件为假执行', '不是异常处理的 else', '与 finally 不同'), 
    'else 在 if 条件为 False 时执行。', 
    'if success:
    ...
else:
    retry()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    922, 
    32, 
    '多分支选择', 
    'if/else 与多个 elif 混用会怎样？', 
    JSON_OBJECT('A', '语法错误', 'B', '可以实现多路分支', 'C', '只有两个分支', 'D', '只能用于循环内部'), 
    2, 
    JSON_ARRAY('elif 可用于多个分支', '顺序影响匹配', '适合互斥情形'), 
    'if/elif/else 组合用于实现多个互斥分支，按顺序判断。', 
    'if x>0: ...
elif x==0: ...
else: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    923, 
    32, 
    '单行条件的限制', 
    '单行写法 print(a) if cond else print(b) 有什么限制？', 
    JSON_OBJECT('A', '不能有复杂语句', 'B', '不能调用函数', 'C', '只能用于数字', 'D', '没有限制'), 
    1, 
    JSON_ARRAY('单行适合简单表达式', '复杂逻辑建议多行实现', '单行可读性较差时不推荐'), 
    '单行条件适合简单动作，复杂逻辑应使用多行以提高可读性。', 
    'x = 1 if cond else 0'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    924, 
    32, 
    'else 的常见误用', 
    '下面哪种写法是对 else 的误用？', 
    JSON_OBJECT('A', 'else: handle error', 'B', 'else: pass', 'C', 'else: if another', 'D', 'else: retry'), 
    3, 
    JSON_ARRAY('else 不能带条件', '带条件应使用 elif', '检查关键字用法'), 
    'else 不能直接跟条件表达式，若需条件应使用 elif。', 
    'if a:
    ...
elif b:
    ...
else:
    ...'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    925,
    32,
    '补全 else',
    '补全以输出对应结果。',
    'x = -1',
    JSON_ARRAY('negative'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = -1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if x >= 0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"non-negative\")"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"negative\")"}]}]}',
    JSON_ARRAY('else', 'elif', 'then', 'end'),
    JSON_ARRAY(1),
    'else 用于 if 条件不满足时的分支。',
    'if ok:
    ...
else:
    ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    926,
    32,
    '单行 if/else',
    '将下面两行改成单行条件式并打印结果。',
    'a=5',
    JSON_ARRAY('Big'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = 5"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"Big\") if a > 10 else print(\"Small\")"}]}]}',
    JSON_ARRAY('保持不变', '改为多行', '用三元表达式', '抛异常'),
    JSON_ARRAY(3),
    'Python 支持将 if/else 写为单行条件表达式的打印形式。',
    'print("yes") if cond else print("no")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    927,
    32,
    '判断奇偶并输出',
    '补全代码：根据输入输出 Odd/Even。',
    '输入: 4',
    JSON_ARRAY('Even'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "n = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if n % 2 == 0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"Even\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('"Odd"', '"Even"', '"0"', '"None"'),
    JSON_ARRAY(1),
    '否则为奇数应输出 Odd。',
    'n=3 → 输出 Odd'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    928,
    32,
    '错误分支提示',
    '补全使输入非正数时打印提示。',
    '输入: -2',
    JSON_ARRAY('请输入正数'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "n = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if n > 0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"OK\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('"请输入正数"', '"OK"', '"0"', '"正数"'),
    JSON_ARRAY(1),
    'else 分支用于提示错误或引导用户。',
    'if valid:
    proceed()
else:
    print("错误")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    929,
    32,
    '实例：登录示例',
    '补全代码：若已登录则显示 Welcome，否则显示 Login。',
    'logged = False',
    JSON_ARRAY('Login'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "logged = False"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if logged:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"Welcome\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('"Login"', '"Welcome"', '"Error"', '"None"'),
    JSON_ARRAY(1),
    '当未登录时应提示登录。',
    'if is_admin:
    show_admin()
else:
    show_user()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    930,
    32,
    '练习：范围判断',
    '补全：若分数及格输出 Pass，否则 Fail。',
    'score = 59',
    JSON_ARRAY('Fail'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "score = 59"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if score >= 60:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"Pass\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('"Fail"', '"Pass"', '"Unknown"', '"0"'),
    JSON_ARRAY(1),
    '59 < 60，应输出 Fail。',
    'if score >= 90: ...
elif ...'
);