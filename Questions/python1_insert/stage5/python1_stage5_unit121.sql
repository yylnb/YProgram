USE `questions`;

--
-- Unit 121: 函数的意义与简单定义
--

-- Question 1 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(1, 121, '为什么使用函数', '小华写了很多重复的代码片段，老师建议将重复逻辑封装为函数，主要原因是？', JSON_OBJECT('A', '提高代码复用与可维护性', 'B', '让程序运行更慢', 'C', '隐藏所有变量', 'D', '避免使用注释'), 1, '函数将重复代码封装为可重用单元，提高可读性和维护性，也便于测试。', JSON_ARRAY('提示1：函数能把重复逻辑集中管理', '提示2：便于测试和修改', '提示3: 更清晰的程序结构有助于团队协作'), '例如将计算税费的逻辑封装成 calc_tax(amount)');

-- Question 2 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(2, 121, '函数定义关键字', '在 Python 中定义函数应使用哪个关键字？', JSON_OBJECT('A', 'def', 'B', 'function', 'C', 'func', 'D', 'define'), 1, 'Python 使用 def 来定义函数，例如 def greet(name):', JSON_ARRAY('提示1：Python 用一个简短的关键字开始函数定义', '提示2：许多语言使用 function 或 func，但 Python 使用不同的词', '提示3: 记住 def 即可'), 'def add(a, b):\n    return a + b');

-- Question 3 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(3, 121, '函数体缩进', '定义函数时函数体应该如何书写？', JSON_OBJECT('A', '函数体需缩进表示属于函数', 'B', '函数体不需要缩进', 'C', '函数体必须用大括号', 'D', '函数体写在同一行即可'), 1, '在 Python 中，函数体通过缩进表示属于该函数，常用 4 个空格缩进。', JSON_ARRAY('提示1：Python 通过缩进表示代码块', '提示2：函数定义下一行应缩进', '提示3: 缩进一致性很重要'), 'def f():\n    print("hello")');

-- Question 4 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(4, 121, '补全简单函数（填空）', '请补全下列函数，使其返回参数 x 与 y 的和（按序填写选项编号）。', JSON_OBJECT('segments', JSON_ARRAY(
    JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(JSON_OBJECT('type', 'code_line', 'value', 'def add(x, y):'))),
    JSON_OBJECT('type', 'code_inline', 'parts', JSON_ARRAY(
        JSON_OBJECT('type', 'code', 'value', '    '),
        JSON_OBJECT('type', 'slot', 'index', 0)
    )),
    JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(JSON_OBJECT('type', 'code_line', 'value', '\n\nprint(add(2,3))  # 输出 5')))
)), JSON_ARRAY('return x + y', 'x + y', 'print(x+y)', 'yield x + y'), JSON_ARRAY(1), '', '', '函数应使用 return 返回值，选项 1 为正确的返回语句。', NULL);

-- Question 5 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(5, 121, '补全调用（填空）', '调用函数并把结果赋值给变量 result，补全下列空。', JSON_OBJECT('segments', JSON_ARRAY(
    JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
        JSON_OBJECT('type', 'code_line', 'value', 'def greet(name):'),
        JSON_OBJECT('type', 'code_line', 'value', '    return "Hello " + name'),
        JSON_OBJECT('type', 'code_line', 'value', '')
    )),
    JSON_OBJECT('type', 'code_inline', 'parts', JSON_ARRAY(
        JSON_OBJECT('type', 'code', 'value', 'result = '),
        JSON_OBJECT('type', 'slot', 'index', 0),
        JSON_OBJECT('type', 'code', 'value', '("Amy")')
    )),
    JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(JSON_OBJECT('type', 'code_line', 'value', 'print(result)  # Hello Amy')))
)), JSON_ARRAY('greet', 'print', 'say', 'call'), JSON_ARRAY(1), '', '', '调用函数应使用其函数名并传参，选项 greet 是正确的调用。', NULL);

-- Question 6 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(6, 121, '参数与实参', '下列哪项正确描述了“参数（parameter）”与“实参（argument）”的区别？', JSON_OBJECT('A', '参数是函数定义处的占位符，实参是调用时提供的具体值', 'B', '两者完全相同', 'C', '实参只能是数字', 'D', '参数在调用时才出现'), 1, '参数出现在函数定义处，实参是调用函数时传入的具体值或表达式。', JSON_ARRAY('提示1：定义处写的是参数', '提示2：调用时传的具体数据是实参', '提示3: 记住“定义 vs 调用”的区分'), 'def f(x): ...  # x 为参数; f(2) 中 2 为实参');

-- Question 7 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(7, 121, '默认参数', '下面哪种写法为函数设置了默认参数？', JSON_OBJECT('A', 'def greet(name="Guest"):', 'B', 'def greet(name):', 'C', 'def greet(): name = "Guest"', 'D', 'def greet = lambda name: name'), 1, '在函数定义处为参数赋默认值即可，调用时若省略则使用默认值。', JSON_ARRAY('提示1：默认参数在定义时通过等号赋值', '提示2：调用时可以省略该参数', '提示3: 注意默认参数的可变性问题'), 'def connect(host="localhost"):');

-- Question 8 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(8, 121, '返回值缺省', '如果函数没有 return 语句，调用后会得到什么？', JSON_OBJECT('A', 'None', 'B', '0', 'C', '空字符串', 'D', '抛出异常'), 1, '在没有显式 return 的情况下，函数会返回 None。', JSON_ARRAY('提示1：Python 对未返回值的函数有默认行为', '提示2：使用 print 不等于 return', '提示3: None 是 Python 的空值'), 'def f():\n    pass\nprint(f())  # 输出 None');

-- Question 9 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(9, 121, '位置参数与关键字参数（填空）', '下面调用中，使用关键字参数的正确写法是？', JSON_OBJECT('segments', JSON_ARRAY(
    JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
        JSON_OBJECT('type', 'code_line', 'value', 'def point(x, y):'),
        JSON_OBJECT('type', 'code_line', 'value', '    return x, y'),
        JSON_OBJECT('type', 'code_line', 'value', ''),
        JSON_OBJECT('type', 'code_line', 'value', '# 调用示例')
    )),
    JSON_OBJECT('type', 'code_inline', 'parts', JSON_ARRAY(
        JSON_OBJECT('type', 'code', 'value', 'print(point('),
        JSON_OBJECT('type', 'slot', 'index', 0),
        JSON_OBJECT('type', 'code', 'value', '))')
    ))
)), JSON_ARRAY('1,2', 'x=1, y=2', '(1,2)', 'x:1,y:2'), JSON_ARRAY(2), '', '', '关键字参数写法为 x=1, y=2，按顺序填写两个选项编号。', NULL);

-- Question 10 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(10, 121, '可变参数（填空）', '将任意多个位置实参收集为元组的语法是什么？', JSON_OBJECT('segments', JSON_ARRAY(
    JSON_OBJECT('type', 'code_inline', 'parts', JSON_ARRAY(
        JSON_OBJECT('type', 'code', 'value', 'def all_args('),
        JSON_OBJECT('type', 'slot', 'index', 0),
        JSON_OBJECT('type', 'code', 'value', '):')
    )),
    JSON_OBJECT('type', 'code_inline', 'parts', JSON_ARRAY(
        JSON_OBJECT('type', 'code', 'value', '    return '),
        JSON_OBJECT('type', 'slot', 'index', 1)
    )),
    JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
        JSON_OBJECT('type', 'code_line', 'value', ''),
        JSON_OBJECT('type', 'code_line', 'value', 'print(all_args(1,2,3))  # (1, 2, 3)')
    ))
)), JSON_ARRAY('*args', 'args', '**kwargs', '*items'), JSON_ARRAY(1, 2), '', '', '使用 *args 收集位置参数，函数体中 args 为对应元组。', NULL);

-- Question 11 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(11, 121, '命名参数顺序', '在函数调用中，哪种参数顺序是合法的？', JSON_OBJECT('A', '位置参数在前，关键字参数在后', 'B', '关键字参数在前，位置参数在后', 'C', '任意混合顺序都合法', 'D', '所有关键字参数必须单独调用'), 1, '调用时位置参数需放在关键字参数前面，否则解释器会报错。', JSON_ARRAY('提示1：位置参数必须出现在关键字参数之前', '提示2: 否则会出现语法错误', '提示3: 保持位置在前更直观'), 'f(1, y=2) 合法，f(x=1, 2) 非法');

-- Question 12 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(12, 121, '文档字符串实践', '下列哪项是写函数文档字符串的好习惯？', JSON_OBJECT('A', '说明用途、参数与返回值的含义', 'B', '只写作者名字', 'C', '使用单个字母描述', 'D', '随意写注释即可'), 1, '清晰的 docstring 能帮助他人及未来的自己快速理解函数用途与输入输出。', JSON_ARRAY('提示1：文档字符串应帮助使用者理解函数', '提示2: 包含参数说明和返回值更完整', '提示3: 不要留空或写无意义内容'), 'def add(a,b):\n    """返回 a 与 b 的和"""');

-- Question 13 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(13, 121, '单元测试引导', '将函数拆分为小单元有助于什么？', JSON_OBJECT('A', '更容易为其编写单元测试', 'B', '增加运行时错误', 'C', '使代码不可重用', 'D', '减少可读性'), 1, '单一职责函数更容易被单元测试覆盖，从而提高代码可靠性。', JSON_ARRAY('提示1：小函数职责单一更容易验证', '提示2：便于写针对性的测试用例', '提示3': 有助于定位错误'), '');

-- Question 14 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(14, 121, '简单递归（填空）', '补全下面递归函数，使其返回 n 的阶乘（按序填写选项编号）。', JSON_OBJECT('segments', JSON_ARRAY(
    JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
        JSON_OBJECT('type', 'code_line', 'value', 'def fact(n):'),
        JSON_OBJECT('type', 'code_line', 'value', '    if n == 0:'),
        JSON_OBJECT('type', 'code_line', 'value', '        return 1'),
        JSON_OBJECT('type', 'code_line', 'value', '    else:')
    )),
    JSON_OBJECT('type', 'code_inline', 'parts', JSON_ARRAY(
        JSON_OBJECT('type', 'code', 'value', '        return '),
        JSON_OBJECT('type', 'slot', 'index', 0),
        JSON_OBJECT('type', 'code', 'value', ' * '),
        JSON_OBJECT('type', 'slot', 'index', 1)
    )),
    JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
        JSON_OBJECT('type', 'code_line', 'value', ''),
        JSON_OBJECT('type', 'code_line', 'value', 'print(fact(5))  # 120')
    ))
)), JSON_ARRAY('n', 'fact(n-1)', 'n-1', 'fact(n)'), JSON_ARRAY(1, 2), '', '', '阶乘定义为 n * fact(n-1)，因此填入 n 与 fact(n-1)。', NULL);

-- Question 15 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(15, 121, '总结（填空）', '函数的主要好处包括：__1__、__2__ 和 __3__。', '{}', JSON_ARRAY('复用', '可维护性', '隐藏所有细节', '可读性', '提高运行速度'), JSON_ARRAY(1, 2, 4), '', '', '函数的主要好处是代码复用、提高可维护性与可读性。', NULL);
