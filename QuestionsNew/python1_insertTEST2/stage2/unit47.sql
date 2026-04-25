USE `questions`;
-- Unit 47 | Start ID: 691
-- Generated at 2025-12-24 23:13:40

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    691, 
    47, 
    '局部变量与全局变量', 
    '在函数内部赋值一个变量会默认创建什么？', 
    JSON_OBJECT('A', '局部变量', 'B', '全局变量', 'C', '常量', 'D', '静态变量'), 
    1, 
    JSON_ARRAY('函数内部赋值通常不影响外部', '用 global 可以修改全局变量', '局部变量只在函数内有效'), 
    '函数内部赋值会创建局部变量，除非使用 global 声明。', 
    'def f():
    x = 1  # 局部'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    692, 
    47, 
    'global 的作用', 
    '在函数内使用 `global x` 会怎样？', 
    JSON_OBJECT('A', '引用并修改模块级的 x', 'B', '创建局部变量 x', 'C', '删除 x', 'D', '让 x 成为常量'), 
    1, 
    JSON_ARRAY('global 用于声明要在函数中使用全局变量', '可修改模块级变量'), 
    'global 声明使得函数内对 x 的赋值作用于模块作用域的变量。', 
    'global counter
counter += 1'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    693, 
    47, 
    '闭包中变量绑定', 
    '闭包（closure）捕获外层变量时通常会发生什么？', 
    JSON_OBJECT('A', '捕获变量引用而非值', 'B', '捕获变量的拷贝', 'C', '创建全局变量', 'D', '立即评估为常量'), 
    1, 
    JSON_ARRAY('闭包保存对变量的引用', '在循环中常见绑定陷阱', '使用默认参数可规避'), 
    '闭包捕获的是变量引用，循环中常见所有闭包最终引用同一变量的情况。', 
    'def make(i):
    return lambda: i'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    694,
    47,
    'nonlocal 的用途',
    '补全：在嵌套函数中修改外层非全局变量需用到。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def outer():"}, {"type": "code_line", "value": "    x = 0"}, {"type": "code_line", "value": "    def inner():"}, {"type": "code_line", "value": "        nonlocal ___"}, {"type": "code_line", "value": "        x += 1"}, {"type": "code_line", "value": "    inner()"}]}]}',
    JSON_ARRAY('x', 'global', 'outer', 'inner'),
    JSON_ARRAY(1),
    'nonlocal 声明能让 inner 修改 outer 中的 x（非全局）。',
    '使用 nonlocal 管理闭包状态'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    695,
    47,
    '访问模块变量',
    '补全：在函数中读取模块级变量无需声明。',
    'x=5',
    JSON_ARRAY('5'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 5"}, {"type": "code_line", "value": "def f():"}, {"type": "code_line", "value": "    print(___)"}]}]}',
    JSON_ARRAY('x', 'global x', 'local x', 'None'),
    JSON_ARRAY(1),
    '读取模块级变量不需要 global，只有赋值时需要。',
    'def f():
    print(config)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    696, 
    47, 
    '名前遮蔽', 
    '下列情形称为“变量遮蔽（shadowing）”？', 
    JSON_OBJECT('A', '局部变量名与外层同名', 'B', '变量被垃圾回收', 'C', '变量未初始化', 'D', '变量值被改变'), 
    1, 
    JSON_ARRAY('同名会遮蔽外层变量', '可能导致混淆', '最好避免同名'), 
    '局部同名变量会遮蔽外层变量，导致对外层变量不可见。', 
    'x = 1
def f():
    x = 2  # 遮蔽'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    697, 
    47, 
    '模块作用域', 
    '模块级变量在哪个作用域内？', 
    JSON_OBJECT('A', '模块作用域', 'B', '函数作用域', 'C', '类作用域', 'D', '全局操作系统'), 
    1, 
    JSON_ARRAY('模块作用域是文件级别', '导入时会执行模块顶层代码', '模块变量以模块名访问'), 
    '模块变量属于模块作用域，通过 module.var 访问或在模块内直接使用。', 
    'import m
print(m.CONST)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    698, 
    47, 
    '动态作用域？', 
    'Python 使用静态（词法）作用域还是动态作用域？', 
    JSON_OBJECT('A', '静态（词法）作用域', 'B', '动态作用域', 'C', '两者皆是', 'D', '取决于函数类型'), 
    1, 
    JSON_ARRAY('作用域由代码位置决定', '闭包依赖于词法作用域', '不是调用栈决定'), 
    'Python 使用词法作用域，变量绑定由定义位置决定。', 
    '闭包示例说明词法作用域'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    699,
    47,
    '避免全局可变状态',
    '补全：若需要共享可变对象，推荐做法是通过参数传入，而不是直接修改全局。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def add_item(lst, item):"}, {"type": "code_line", "value": "    lst.append(item)"}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "mylist = []"}, {"type": "code_line", "value": "add_item(mylist, 1)"}, {"type": "code_line", "value": "print(mylist)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    '通过函数参数传递可变对象比在函数内直接修改全局变量更安全。',
    'def push(stack, v): stack.append(v)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    700,
    47,
    '捕获循环变量的常见坑',
    '补全：用默认参数固定当前循环变量。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "funcs = []"}, {"type": "code_line", "value": "for i in range(3):"}, {"type": "code_line", "value": "    funcs.append(lambda i=i: i)"}, {"type": "code_line", "value": "print([f() for f in funcs])"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    '在 lambda 中使用默认参数 i=i 可以捕获当时的值，避免闭包引用同一变量导致的陷阱。',
    'lambda x=x: x'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    701, 
    47, 
    '模块级常量命名', 
    '模块级常量通常使用什么命名约定？', 
    JSON_OBJECT('A', '全部大写', 'B', '全部小写', 'C', '驼峰命名', 'D', '随机命名'), 
    1, 
    JSON_ARRAY('常量使用大写以示意', 'PEP8 建议常量为大写', '不是语言强制'), 
    '模块常量通常用大写命名以表示不可变约定。', 
    'MAX_RETRIES = 3'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    702, 
    47, 
    '作用域排查技巧', 
    '调试变量不可见问题时，哪个方法有用？', 
    JSON_OBJECT('A', '打印 locals() 与 globals()', 'B', '删除变量', 'C', '重命名文件', 'D', '强制重新启动解释器'), 
    1, 
    JSON_ARRAY('locals()/globals() 可查看当前作用域变量', '有助于定位变量在哪个命名空间'), 
    '打印 locals() 和 globals() 可以帮助定位变量的实际位置和名称。', 
    'print(globals().get("x"))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    703, 
    47, 
    '命名冲突避免', 
    '为避免命名冲突，推荐做法是？', 
    JSON_OBJECT('A', '使用明确的模块或类名前缀', 'B', '使用单字母变量名', 'C', '随意命名', 'D', '把所有变量放到全局'), 
    1, 
    JSON_ARRAY('模块名前缀能避免冲突', '提高语义清晰度', '别用过短的名字'), 
    '使用模块名前缀或命名空间可以减少命名冲突，提高可读性。', 
    'config.DEFAULT_TIMEOUT'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    704,
    47,
    '实践：查看变量作用域',
    '补全：在函数中打印局部变量列表。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def f():"}, {"type": "code_line", "value": "    a=1"}, {"type": "code_line", "value": "    b=2"}, {"type": "code_line", "value": "    print(___())"}, {"type": "code_line", "value": "f()"}]}]}',
    JSON_ARRAY('locals', 'globals', 'dir', 'vars'),
    JSON_ARRAY(1),
    'locals() 返回当前局部命名空间的字典。',
    'print(locals())'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    705,
    47,
    '实践：避免全局修改',
    '补全：如果需要修改全局列表，推荐通过参数返回新列表而非直接在函数中赋值。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def add(lst, v):"}, {"type": "code_line", "value": "    new = lst + [v]"}, {"type": "code_line", "value": "    return new"}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "L = [1]"}, {"type": "code_line", "value": "L = add(L, 2)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(1),
    '函数返回新对象并在外层赋值能避免不必要的全局副作用。',
    's = append(s, x)'
);