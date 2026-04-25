USE `questions`;
-- Unit 53 | Start ID: 781
-- Generated at 2025-12-24 23:15:33

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    781, 
    53, 
    '闭区间与开区间', 
    '表达 a<=x<=b 属于哪种区间表示？', 
    JSON_OBJECT('A', '闭区间', 'B', '开区间', 'C', '左开右闭', 'D', '左闭右开'), 
    1, 
    JSON_ARRAY('两端都包含', '使用 <= 表示包含'), 
    'a<=x<=b 两端包含，称为闭区间。', 
    'if a<=x<=b: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    782, 
    53, 
    '链式比较', 
    'Python 中链式比较 a < x < b 等价于？', 
    JSON_OBJECT('A', 'a < x and x < b', 'B', '(a<x) or (x<b)', 'C', 'a < b < x', 'D', '无法等价转换'), 
    1, 
    JSON_ARRAY('链式比较是语法糖', '等价与 and 组合'), 
    'a < x < b 在内部相当于 (a < x) and (x < b)。', 
    'if 0 < n < 10: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    783, 
    53, 
    '浮点比较注意', 
    '比较浮点数相等时应避免使用？', 
    JSON_OBJECT('A', '直接用 == 判断', 'B', '使用绝对误差阈值', 'C', '使用 math.isclose', 'D', '格式化再比较'), 
    1, 
    JSON_ARRAY('浮点有精度误差', '使用容差判断'), 
    '浮点直接用 == 容易出错，应使用容差或 math.isclose。', 
    'abs(a-b) < 1e-9'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    784,
    53,
    '判断是否在区间内',
    '补全：判断 x 是否在 [a,b]。',
    'a=1 b=5 x=3',
    JSON_ARRAY('yes'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "x = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if a <= x <= b:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"yes\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"no\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用链式比较直接检查区间包含关系。',
    'if 1<=x<=10: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    785,
    53,
    '端点特殊处理',
    '补全：若只包含左端 a<=x< b。',
    'a=0 b=3 x=3',
    JSON_ARRAY('no'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "x = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if a <= x < b:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"in\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"out\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用 <= 与 < 组合表示左闭右开区间。',
    'for i in range(a,b): ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    786, 
    53, 
    '整数范围校验', 
    '若要校验 0 到 100 的整数，推荐写法是？', 
    JSON_OBJECT('A', '0 <= x <= 100', 'B', 'x>=0 or x<=100', 'C', 'x in range(0,100)', 'D', 'x>0 and x<100'), 
    1, 
    JSON_ARRAY('包含边界时用 <=', '链式比较简洁'), 
    '0 <= x <= 100 表达包括两端的范围。', 
    'if 0<=score<=100: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    787, 
    53, 
    '使用 range', 
    'range(1,4) 包含哪些整数？', 
    JSON_OBJECT('A', '1,2,3', 'B', '1,2,3,4', 'C', '0,1,2,3', 'D', '仅 4'), 
    1, 
    JSON_ARRAY('range 的结束不包含在内', '常见 off-by-one 问题'), 
    'range(1,4) 生成 1,2,3。', 
    'for i in range(1,4): print(i)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    788, 
    53, 
    '边界判断顺序', 
    '若同时判断多段区间，应注意？', 
    JSON_OBJECT('A', '先判断更窄或更特殊的区间', 'B', '任意顺序都行', 'C', '总是从右到左', 'D', '只判断一个区间就够'), 
    1, 
    JSON_ARRAY('避免被宽泛区间先匹配', '优先处理例外情况'), 
    '先判断更狭窄或特殊的区间能避免被宽泛规则提前匹配。', 
    'if x==0: ...
elif x>0 and x<10: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    789,
    53,
    '判断是否为成年人',
    '补全：年龄>=18 判为成年人。',
    'age=17',
    JSON_ARRAY('minor'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "age = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if age >= 18:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"adult\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"minor\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 >= 判定包含边界的成年条件。',
    'if age>=18: print("adult")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    790,
    53,
    '判断评分等级',
    '补全：score 90+ 为 A，80-89 为 B，其他为 C。',
    'score=85',
    JSON_ARRAY('B'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "score = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if score >= 90:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"A\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "elif score >= 80:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"B\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"C\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '按从高到低顺序判断区间以免覆盖更高分段。',
    'if s>=90: ... elif s>=80: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    791, 
    53, 
    '区间交集', 
    '两个区间有交集的条件是什么？', 
    JSON_OBJECT('A', '左端小于对方右端且右端大于对方左端', 'B', '任意一端相等即可', 'C', '必须完全包含', 'D', '无交集时判断为真'), 
    1, 
    JSON_ARRAY('检查边界重叠', '常用逻辑表达式判断'), 
    '判断交集可用 a1<=b2 and a2<=b1 之类的逻辑。', 
    'if a1<=b2 and a2<=b1: overlap=True'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    792, 
    53, 
    '闭区间包含点', 
    '判断点 x 是否属于 (a,b] 应使用？', 
    JSON_OBJECT('A', 'a < x <= b', 'B', 'a <= x <= b', 'C', 'a < x < b', 'D', 'a <= x < b'), 
    1, 
    JSON_ARRAY('左开右闭', '注意比较运算符方向'), 
    '右端包含、左端不包含应使用 a < x <= b。', 
    'if 0 < x <= 1: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    793, 
    53, 
    '避免 off-by-one', 
    '循环遍历区间 [0,n] 时 range 的正确写法是？', 
    JSON_OBJECT('A', 'range(0, n+1)', 'B', 'range(0,n)', 'C', 'range(1,n)', 'D', 'range(n)'), 
    1, 
    JSON_ARRAY('range 右端不包含', '注意 +1'), 
    '要包含 n，需要在 range 的结束值 +1。', 
    'for i in range(0,n+1): ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    794,
    53,
    '范围长度计算',
    '补全：计算闭区间 [a,b] 的整数个数。',
    'a=3 b=7',
    JSON_ARRAY('5'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(b - a + 1)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '闭区间整数个数为 b-a+1。',
    '若 a==b，则为 1'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    795,
    53,
    '判断是否是周末',
    '补全：给定 weekday (0-6)，判断是否周末（5/6）。',
    'weekday=6',
    JSON_ARRAY('weekend'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "w = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if w == 5 or w == 6:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"weekend\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"weekday\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '直接判断是否等于周末编号即可。',
    'if day in (5,6): ...'
);