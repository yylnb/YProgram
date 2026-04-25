USE `questions`;
-- Unit 126 | Start ID: 1876
-- Generated at 2025-12-25 17:41:15

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1876,
    126,
    '局部与全局作用域',
    '下列关于局部变量和全局变量的说法，正确的是？',
    JSON_OBJECT('A', '局部变量在函数内部有效，全局变量在模块级有效', 'B', '局部变量在模块内共享', 'C', '全局变量在函数内部默认不可读', 'D', '没有作用域概念'),
    1,
    JSON_ARRAY('提示1：函数内部定义的是局部变量', '提示2：global 可引用模块级变量', '提示3：注意命名冲突'),
    '局部变量仅在函数作用域内可见，全局变量在模块范围内可见。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1877,
    126,
    'global 关键字',
    '使用 global 的主要目的是？',
    JSON_OBJECT('A', '在函数内声明引用模块级变量以便赋值', 'B', '定义全局函数', 'C', '创建新的模块变量', 'D', '删除全局变量'),
    1,
    JSON_ARRAY('提示1：没有 global 不能赋值给全局变量', '提示2：读取全局变量通常不需要 global', '提示3：慎用以减少副作用'),
    'global 允许在函数中对模块级变量进行赋值。',
    'x=0
def f():
    global x
    x=1'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1878,
    126,
    '闭包定义',
    '闭包（closure）通常指什么？',
    JSON_OBJECT('A', '函数与其相关环境变量的组合', 'B', '仅指匿名函数', 'C', '一种类', 'D', '模块变量'),
    1,
    JSON_ARRAY('提示1：闭包可捕获外层作用域变量', '提示2：常见于工厂函数', '提示3：可用于封装状态'),
    '闭包是包含函数及其词法环境的对象，函数可访问外层变量。',
    'def outer():
    x=1
    def inner():
        return x
    return inner'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1879,
    126,
    'nonlocal（填空）',
    '在嵌套函数中若要修改外层（非全局）变量，应使用 __1__。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def outer():"}, {"type": "code_line", "value": "    x=0"}, {"type": "code_line", "value": "    def inner():"}, {"type": "code_inline", "parts": [{"type": "code", "value": "        "}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_line", "value": "        x+=1"}, {"type": "code_line", "value": "    return inner"}]}]}',
    JSON_ARRAY('nonlocal x', 'global x', 'local x', 'del x'),
    JSON_ARRAY(1),
    'nonlocal 用于声明外层（但非全局）变量以便赋值。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1880,
    126,
    '闭包保存状态（填空）',
    '闭包可以保存外层变量的值，若要返回一个函数对象，应使用 __1__。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def counter():"}, {"type": "code_line", "value": "    n=0"}, {"type": "code_line", "value": "    def inc():"}, {"type": "code_line", "value": "        nonlocal n"}, {"type": "code_line", "value": "        n += 1"}, {"type": "code_line", "value": "        return n"}, {"type": "code_inline", "parts": [{"type": "code", "value": "    "}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}]}]}',
    JSON_ARRAY('return inc', 'return inc()', 'print(inc)'),
    JSON_ARRAY(1),
    '返回函数对象 inc，本身是一个闭包，保存 n 的状态。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1881,
    126,
    '闭包与内存',
    '闭包会如何影响被捕获变量的生命周期？',
    JSON_OBJECT('A', '被捕获变量会被保留直到闭包被垃圾回收', 'B', '变量在函数返回后立即销毁', 'C', '闭包不会影响生命周期', 'D', '变量会复制一份到栈'),
    1,
    JSON_ARRAY('提示1：闭包保存引用', '提示2：垃圾回收会决定何时释放', '提示3：注意内存泄漏风险'),
    '闭包持有对外层变量的引用，从而延长这些变量的生命周期。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1882,
    126,
    '闭包常见用途',
    '下面哪个不是闭包常见用途？',
    JSON_OBJECT('A', '封装私有状态', 'B', '实现装饰器', 'C', '创建类的替代语法', 'D', '延迟计算'),
    3,
    JSON_ARRAY('提示1：闭包常用于装饰器', '提示2：类用于更复杂的状态封装', '提示3：闭包可做轻量级对象'),
    '闭包可用于私有状态和装饰器，但并不替代类的全部功能。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1883,
    126,
    '闭包与多次调用',
    '每次调用工厂函数返回闭包时，捕获的变量是怎样的？',
    JSON_OBJECT('A', '每次返回独立的闭包实例及其环境', 'B', '所有闭包共享同一环境', 'C', '只返回同一个函数对象', 'D', '捕获变量为全局变量'),
    1,
    JSON_ARRAY('提示1：每次调用都会创建新的外层作用域', '提示2：因此状态独立', '提示3：示例可验证'),
    '每次调用工厂函数会创建新的闭包和独立的环境。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1884,
    126,
    '闭包示例（填空）',
    '在下列代码中，outer 返回的是什么？',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def outer():"}, {"type": "code_line", "value": "    x=5"}, {"type": "code_line", "value": "    def inner():"}, {"type": "code_line", "value": "        return x"}, {"type": "code_inline", "parts": [{"type": "code", "value": "    "}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "# outer() 返回什么？"}]}]}',
    JSON_ARRAY('inner', 'inner()', 'None', 'x'),
    JSON_ARRAY(1),
    'outer 返回函数对象 inner，即闭包。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1885,
    126,
    '闭包与可变捕获（填空）',
    '若捕获的是可变对象，闭包内修改会反映到外层对象；示例用法写 return __1__。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def outer():"}, {"type": "code_line", "value": "    l=[]"}, {"type": "code_line", "value": "    def inner():"}, {"type": "code_line", "value": "        l.append(1)"}, {"type": "code_line", "value": "        return l"}, {"type": "code_inline", "parts": [{"type": "code", "value": "    "}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}]}]}',
    JSON_ARRAY('inner', 'inner()', 'l', '[]'),
    JSON_ARRAY(1),
    '返回 inner，闭包可修改并保持对可变对象的引用。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1886,
    126,
    '闭包与线程安全',
    '在多线程中使用闭包保存状态时应注意？',
    JSON_OBJECT('A', '需要同步以避免竞争条件', 'B', '闭包本身自动线程安全', 'C', '不能在多线程中使用闭包', 'D', '闭包会被复制到每个线程'),
    1,
    JSON_ARRAY('提示1：共享可变状态需要锁', '提示2：考虑使用线程安全的数据结构', '提示3：避免隐式共享状态'),
    '闭包保存的可变状态在多线程场景下可能产生竞争，需同步控制。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1887,
    126,
    '闭包调试',
    '要查看闭包捕获了哪些变量，可以使用哪种方式？',
    JSON_OBJECT('A', '查看函数的 __closure__ 属性', 'B', '查看 __globals__', 'C', '无法查看', 'D', '使用 print 语句只能'),
    1,
    JSON_ARRAY('提示1：函数对象有 __closure__ 属性', '提示2：其中包含被捕获变量的 cell', '提示3：可结合 inspect 模块使用'),
    '通过函数对象的 __closure__ 可以访问被捕获变量的引用信息。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1888,
    126,
    '避免闭包常见错误',
    '在循环中创建闭包捕获循环变量时常见错误是？',
    JSON_OBJECT('A', '所有闭包共享最终的循环变量值', 'B', '每个闭包按预期保存当时值', 'C', '闭包无法捕获循环变量', 'D', '代码会报错'),
    1,
    JSON_ARRAY('提示1：典型错误是 lambda i: i 直接捕获 i', '提示2：可用默认参数避免问题', '提示3：示例：[lambda: i for i in range(3)]'),
    '闭包在循环中直接捕获变量会导致所有闭包看到最后的值，解决方法是例如使用默认参数绑定当时的值。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1889,
    126,
    '绑定当前值（填空）',
    '在循环中创建闭包并绑定当时的 i，常用技巧： lambda i=i: i ，其中等号左侧是 __1__。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "funcs = [lambda i=i: i for i in range(3)]"}, {"type": "code_line", "value": "print(funcs[0]())  # 0"}]}]}',
    JSON_ARRAY('默认参数', '全局参数', '非本地参数', '注解'),
    JSON_ARRAY(1),
    '通过将循环变量作为默认参数传入，可以在闭包中绑定当时的值。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1890,
    126,
    '总结（填空）',
    '闭包是 __1__ 与 __2__ 的组合。',
    NULL,
    NULL,
    '{"segments": []}',
    JSON_ARRAY('函数', '其词法环境', '类', '模块'),
    JSON_ARRAY(1, 2),
    '闭包由函数和它所捕获的词法环境共同组成。',
    ''
);