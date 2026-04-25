USE `questions`;
-- Unit 44 | Start ID: 646
-- Generated at 2025-12-24 23:12:52

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    646, 
    44, 
    '含端点的区间判断', 
    '要判断 x 是否在区间 [1,10]（包含两端），最恰当的写法是：', 
    JSON_OBJECT('A', '1 <= x <= 10', 'B', '1 < x < 10', 'C', 'x >= 1 and x > 10', 'D', 'x in range(1,10)'), 
    1, 
    JSON_ARRAY('Python 支持链式比较', '注意包含端点', 'range 上限不包含'), 
    '1 <= x <= 10 使用链式比较并包含两端，清晰且高效。', 
    'if 0 <= n <= 100: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    647, 
    44, 
    '离散边界测试', 
    '测试整数边界时哪个测试用例最重要？', 
    JSON_OBJECT('A', '边界值及其相邻值', 'B', '只测试中间值', 'C', '随机大量值', 'D', '只测试最小值'), 
    1, 
    JSON_ARRAY('边界附近最容易出错', '测试要包含边界及相邻情况', '覆盖临界点有助发现 off-by-one'), 
    '边界值与其邻近值常露出 off-by-one 等错误，应重点测试。', 
    '测试 0,1,2 而非只测试 1'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    648, 
    44, 
    '浮点边界比较', 
    '比较浮点数是否等于某值时应注意什么？', 
    JSON_OBJECT('A', '使用近似比较（abs(a-b)<eps）', 'B', '直接用 ==', 'C', '用 is 判断', 'D', '转换为 str 比较'), 
    1, 
    JSON_ARRAY('浮点有精度误差', '不要直接用 ==', '用容差比较更稳健'), 
    '浮点计算有误差，应用 abs(a-b)<eps 等近似比较方法判断相等。', 
    'if abs(a-b) < 1e-9: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    649,
    44,
    '开区间判断',
    '补全：判断 x 在 (0,1) 开区间内。',
    'x=0.5',
    JSON_ARRAY('Inside'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = float(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if 0 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " x "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 1:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"Inside\")"}]}]}',
    JSON_ARRAY('<', '<=', '>', '>='),
    JSON_ARRAY(1, 1),
    '开区间用 0 < x < 1；注意端点不被包含。',
    'if 0 < r < 10: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    650,
    44,
    '索引边界检查',
    '补全：访问列表元素前做边界检查。',
    'lst=[1,2]; i=2',
    JSON_ARRAY('IndexError avoided'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if 0 <= i "}, {"type": "slot", "index": 0}, {"type": "code", "value": " len(lst):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(lst[i])"}]}]}',
    JSON_ARRAY('<', '<=', '>', '>='),
    JSON_ARRAY(1),
    '索引上限应使用 i < len(lst) 才是合法索引（0 到 len-1）。',
    'if 0 <= idx < len(arr): use arr[idx]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    651, 
    44, 
    '哨兵值使用', 
    '使用哨兵值（sentinel）通常用于？', 
    JSON_OBJECT('A', '表示特殊或终止状态', 'B', '替代所有 None', 'C', '避免使用循环', 'D', '增加全局变量'), 
    1, 
    JSON_ARRAY('哨兵表示特殊终止或缺失', '常用于循环或解析流式数据', '需选不冲突的值'), 
    '哨兵常作为特殊标记来终止循环或表示无有效值。', 
    'while True:
    line = f.readline()
    if line == "": break'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    652, 
    44, 
    '边界测试的自动化', 
    '写单元测试时边界值该如何组织？', 
    JSON_OBJECT('A', '包括最小、最大和相邻值', 'B', '只测试正常输入', 'C', '只测试极大输入', 'D', '只人工测试'), 
    1, 
    JSON_ARRAY('边界附近常见缺陷', '自动化覆盖可复现问题', '添加注释说明边界含义'), 
    '测试应覆盖边界及其相邻值以捕捉 off-by-one 等问题。', 
    'assert f(0) == ...
assert f(1) == ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    653, 
    44, 
    '错误示例识别', 
    '下面哪种写法在判断非负整数时可能出错？', 
    JSON_OBJECT('A', 'if n >= 0 and n < 10:', 'B', 'if 0 <= n < 10:', 'C', 'if n in range(0,10):', 'D', 'if 0 < n <= 10:'), 
    4, 
    JSON_ARRAY('注意不等号方向与包含端点', 'D 表示 0 < n <=10 会排除 0', '需根据需求选用'), 
    'D 排除了 0，不符合“非负整数”包含 0 的情形。', 
    '用 0 <= n <= 10 包含 0'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    654,
    44,
    '防止除零',
    '补全：在除法前确保分母非零。',
    'a=5;b=0',
    JSON_ARRAY('Cannot divide'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if b "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"Cannot divide\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(a / b)"}]}]}',
    JSON_ARRAY('==', '!=', '<', '>'),
    JSON_ARRAY(2),
    '判断 b != 0 再进行除法可避免 ZeroDivisionError。',
    'if denom != 0: result = num/denom'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    655,
    44,
    '处理空输入',
    '补全：读取输入并在空输入时提示。',
    '',
    JSON_ARRAY('Please input value'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if not s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"Please input value\")"}]}]}',
    JSON_ARRAY('strip', 'isdigit', 'lower', 'split'),
    JSON_ARRAY(1),
    '使用 s.strip() 去除空白后判断是否为空以检测空输入。',
    'if not s.strip(): ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    656, 
    44, 
    '边界条件的文档', 
    '为边界选择写文档说明有什么好处？', 
    JSON_OBJECT('A', '帮助未来维护者理解设计意图', 'B', '增加代码行数无意义', 'C', '仅在发布时才需要', 'D', '会泄露实现细节'), 
    1, 
    JSON_ARRAY('文档说明设计选择', '减少误用与 bug 引入', '便于代码审查'), 
    '记录边界行为可以帮助后续维护和测试设计。', 
    '注释中说明含不含端点'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    657, 
    44, 
    '使用 assert 的局限', 
    'assert 在生产环境用于边界校验有何风险？', 
    JSON_OBJECT('A', 'assert 可能被优化掉', 'B', 'assert 会永远生效', 'C', 'assert 自动抛出 ValueError', 'D', 'assert 会记录日志'), 
    1, 
    JSON_ARRAY('使用 -O 运行时 assert 会被移除', '不要用 assert 做关键运行时检查', '用于调试断言更合适'), 
    'assert 主要用于调试，生产不应依赖其做关键输入校验。', 
    'use explicit checks instead of assert'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    658, 
    44, 
    '边界值的可视化', 
    '调试边界问题时哪种方式最直观？', 
    JSON_OBJECT('A', '在失败用例打印临近值', 'B', '只看成功用例', 'C', '删除测试', 'D', '用随机数测试'), 
    1, 
    JSON_ARRAY('打印关键变量有助分析', '关注临近边界的值', '可结合断言与日志'), 
    '在失败场景打印临近值有助快速定位 off-by-one 等问题。', 
    'print("i", i, "len", len(arr))'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    659,
    44,
    '边界示例练习',
    '补全：判断 n 是否为有效索引（含 0 到 n-1）。',
    'n=3; arr=[1,2,3]',
    JSON_ARRAY('Valid'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "idx = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if 0 <= idx "}, {"type": "slot", "index": 0}, {"type": "code", "value": " len(arr):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"Valid\")"}]}]}',
    JSON_ARRAY('<', '<=', '>', '>='),
    JSON_ARRAY(1),
    '合法索引满足 0 <= idx < len(arr)。',
    'if 0 <= i < len(a): use a[i]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    660,
    44,
    '实践：端点检查',
    '补全：确保 x 在闭区间内才继续处理。',
    'x=10',
    JSON_ARRAY('OK'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if 1 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " x "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 10:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"OK\")"}]}]}',
    JSON_ARRAY('<', '<=', '>', '>='),
    JSON_ARRAY(2, 2),
    '闭区间使用 1 <= x <= 10。',
    'if 1 <= score <= 100: ...'
);