USE `questions`;
-- Unit 122 | Start ID: 1816
-- Generated at 2025-12-24 23:36:06

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1816, 
    122, 
    '无参函数', 
    '下面哪个函数定义表示一个无参数函数？', 
    JSON_OBJECT('A', 'def hello():', 'B', 'def hello(name):', 'C', 'def hello = ()', 'D', 'function hello()'), 
    1, 
    JSON_ARRAY('提示1：空的小括号表示无参数', '提示2：其他选项不是 Python 的合法定义', '提示3: 记住 def 与括号的组合'), 
    'def hello(): 是 Python 中无参数函数的标准写法。', 
    'def greet():
    print("hi")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1817, 
    122, 
    '调用无参函数', 
    '如何调用一个名为 ping 的无参函数？', 
    JSON_OBJECT('A', 'ping()', 'B', 'ping', 'C', 'call ping()', 'D', 'ping[]'), 
    1, 
    JSON_ARRAY('提示1：调用函数需加括号', '提示2：不加括号只是引用函数对象', '提示3: ping() 会执行函数体'), 
    '使用 ping() 执行函数，ping 表示函数对象本身。', 
    'def p():
    return 1
print(p())'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1818, 
    122, 
    '函数对象', 
    '把函数名赋值给变量 v，v 成为什么类型？', 
    JSON_OBJECT('A', '函数对象（callable）', 'B', '字符串', 'C', '整数', 'D', '布尔值'), 
    1, 
    JSON_ARRAY('提示1：在 Python 中函数是一等对象', '提示2：可以把函数赋值给变量', '提示3: 可以作为参数传递'), 
    '函数在 Python 中是对象，可以赋值、传参或返回。', 
    'v = greet
print(callable(v))'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1819,
    122,
    '写一个打印函数（填空）',
    '补全函数，使其打印字符串 "Hello World"。',
    NULL,
    JSON_ARRAY('Hello World'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def say():"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}, {"type": "code_line", "value": "say()  # 输出 Hello World"}]}]}',
    JSON_ARRAY('print("Hello World")', 'return "Hello World"', 'echo "Hello World"'),
    JSON_ARRAY(1),
    '要打印字符串应使用 print 函数。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1820,
    122,
    '返回 None（填空）',
    '若函数只打印不返回值，函数调用的返回值为？',
    NULL,
    JSON_ARRAY('1', 'None'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def f():"}, {"type": "code_line", "value": "    print(1)"}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "print(f())  # 输出 1 并打印 "}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('None', '0', '""', 'False'),
    JSON_ARRAY(1),
    '没有 return 的函数返回 None。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1821, 
    122, 
    '无参函数的用途', 
    '下面哪个场景适合使用无参函数？', 
    JSON_OBJECT('A', '执行不依赖外部输入的操作（如打印欢迎语）', 'B', '需要不同参数处理不同数据', 'C', '作为数学运算函数', 'D', '进行带参转换'), 
    1, 
    JSON_ARRAY('提示1：无参函数通常用于固定行为', '提示2：如初始化打印、配置加载等', '提示3: 非参数化的任务适合无参函数'), 
    '无参函数适合执行与外部输入无关的固定任务，例如显示帮助信息。', 
    'def show_help():
    print("Usage: ...")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1822, 
    122, 
    '函数引用', 
    '下列哪一项会把函数对象传入另一个函数？', 
    JSON_OBJECT('A', 'map(func, items)', 'B', 'func(items)', 'C', 'def func(): pass', 'D', 'lambda x: x'), 
    1, 
    JSON_ARRAY('提示1：map 的第一个参数是函数对象', '提示2：传入函数对象而不调用时不加括号', '提示3: callable 对象都可传'), 
    'map 将函数对象作为参数传入以在集合上应用该函数。', 
    'list(map(str, [1,2,3]))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1823, 
    122, 
    'lambda 与 def', 
    '下面关于 lambda 与 def 的描述哪个更准确？', 
    JSON_OBJECT('A', 'lambda 适合定义短小匿名函数，def 用于复杂函数', 'B', 'lambda 创建复杂多行函数', 'C', 'def 只能定义匿名函数', 'D', '两者完全等价且可互换'), 
    1, 
    JSON_ARRAY('提示1：lambda 一般用于短表达式', '提示2：复杂逻辑应使用 def', '提示3: lambda 受限于单表达式'), 
    'lambda 用于创建短小匿名函数，def 更适合包含多行逻辑的函数。', 
    'f = lambda x: x+1
def f(x):
    return x+1'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1824,
    122,
    '函数对象调用（填空）',
    '下面代码中要调用被赋值的函数，填入正确序号。',
    NULL,
    JSON_ARRAY('Hi'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def say():"}, {"type": "code_line", "value": "    print(\"Hi\")"}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "v = say"}, {"type": "code_line", "value": "# 调用 v"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}]}]}',
    JSON_ARRAY('v()', 'say()', 'print(v)', 'v'),
    JSON_ARRAY(1),
    'v 是函数对象，调用时需加括号 v()，因此填选项 1。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1825,
    122,
    '函数别名（填空）',
    '给函数创建别名后，下面语句哪个可以显示别名也是可调用的？',
    NULL,
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def f():"}, {"type": "code_line", "value": "    return 1"}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "g = f"}, {"type": "code_line", "value": "print("}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('callable(g)', 'g()', 'f', 'g'),
    JSON_ARRAY(1),
    'callable(g) 会返回 True 表示 g 是可调用的函数对象。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1826, 
    122, 
    '函数的模块化', 
    '将无参数函数放入模块并在多处调用能带来什么好处？', 
    JSON_OBJECT('A', '避免重复代码并统一管理', 'B', '让程序更难阅读', 'C', '自动并行执行', 'D', '降低执行速度'), 
    1, 
    JSON_ARRAY('提示1：模块化有利于复用', '提示2: 便于维护与测试', '提示3: 将功能分文件更清晰'), 
    '把功能封装到模块 / 函数并复用可以减少重复并集中维护。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1827, 
    122, 
    '调用顺序', 
    '如果函数 A 内调用函数 B，调用顺序是怎样的？', 
    JSON_OBJECT('A', '先执行 B 的内容，然后返回 A 继续执行', 'B', '先执行 A 剩余部分，再执行 B', 'C', '并行执行 A 与 B', 'D', '无法在函数内调用另一个函数'), 
    1, 
    JSON_ARRAY('提示1：函数调用会转到被调用函数执行', '提示2: 被调用函数执行完毕后返回控制', '提示3: 这与堆栈调用有关'), 
    '调用 B 时程序会进入 B 执行其代码，返回后继续执行 A 中剩余部分。', 
    'def a():
    b()
    print("back")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1828, 
    122, 
    '函数声明顺序', 
    '在同一模块中，调用函数时定义的先后顺序有何限制？', 
    JSON_OBJECT('A', '只要在调用前定义即可，顺序无严格限制', 'B', '必须按定义顺序调用', 'C', '先定义的函数不能调用后定义的函数', 'D', '函数必须在主函数之后定义'), 
    1, 
    JSON_ARRAY('提示1：Python 在执行到调用时才需要已定义对象', '提示2: 模块加载过程中函数并非立即执行', '提示3: 只要函数存在于命名空间即可调用'), 
    '在模块执行流中，只要在调用之前函数已被定义并存在于当前命名空间，即可调用。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1829,
    122,
    '函数体为空（填空）',
    '若暂时占位一个函数体但不实现内容，常用哪条语句？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def todo():"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    "}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('pass', 'return', 'None', '...'),
    JSON_ARRAY(1),
    'pass 用作占位语句表示空操作，适合占位函数体。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1830,
    122,
    '总结（填空）',
    '无参函数常用于 __1__、__2__，并可以被传递为 __3__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('初始化动作', '固定行为', '可调用对象', '字符串'),
    JSON_ARRAY(1, 2, 3),
    '无参函数适合初始化或固定行为，函数本身是可调用对象可以被传递给其它函数。',
    ''
);