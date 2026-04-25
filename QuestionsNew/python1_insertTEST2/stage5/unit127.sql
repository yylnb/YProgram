USE `questions`;
-- Unit 127 | Start ID: 1891
-- Generated at 2025-12-24 23:37:44

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1891, 
    127, 
    '装饰器的作用', 
    '装饰器（decorator）通常用于什么场景？', 
    JSON_OBJECT('A', '在不修改原函数的前提下扩展函数功能', 'B', '替换模块导入机制', 'C', '定义类的属性', 'D', '优化循环性能'), 
    1, 
    JSON_ARRAY('提示1：常用于日志、权限检查', '提示2：装饰器返回包装函数', '提示3：语法糖为 @decorator'), 
    '装饰器用于在调用函数前后插入通用逻辑而不改动函数本身。', 
    '@timer
def f(): pass'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1892, 
    127, 
    '简单装饰器', 
    '下面哪一项是正确的简单装饰器写法？', 
    JSON_OBJECT('A', 'def deco(f):
    def wrapper(*a,**k):
        return f(*a,**k)
    return wrapper', 'B', 'def deco(): pass', 'C', '@deco def f(): pass', 'D', 'def deco(f): return f()'), 
    1, 
    JSON_ARRAY('提示1：decorator 接受函数并返回函数', '提示2：包装函数需接受任意参数', '提示3：通常使用 *args, **kwargs'), 
    '装饰器函数应接受被装饰函数并返回包装后的函数对象。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1893, 
    127, 
    '保留函数元信息', 
    '装饰器应如何保留被装饰函数的元信息（如 __name__）？', 
    JSON_OBJECT('A', '使用 functools.wraps', 'B', '不能保留', 'C', '用 global 覆盖', 'D', '手动复制字符串'), 
    1, 
    JSON_ARRAY('提示1：functools.wraps 是常用工具', '提示2：避免丢失文档字符串', '提示3：示例: @wraps(f)'), 
    '使用 functools.wraps 装饰包装函数可以保留被装饰函数的元信息。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1894,
    127,
    '带参数的装饰器（填空）',
    '若要让装饰器接受参数，外层应返回 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def deco_with_arg(x):"}, {"type": "code_line", "value": "    def _deco(f):"}, {"type": "code_line", "value": "        def wrapper(*a,**k):"}, {"type": "code_line", "value": "            return f(*a,**k)"}, {"type": "code_line", "value": "        return wrapper"}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}]}]}',
    JSON_ARRAY('return _deco', 'return wrapper', 'return f', 'return x'),
    JSON_ARRAY(1),
    '带参数的装饰器需要三层嵌套，外层返回真正的装饰器函数。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1895,
    127,
    '装饰器语法糖（填空）',
    '下面两种写法等价：@deco
def f(): pass 与 f = __1__(f)。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('deco', 'deco()', 'f', 'wrapper'),
    JSON_ARRAY(1),
    ' @deco 语法糖等价于 f = deco(f)。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1896, 
    127, 
    '多个装饰器顺序', 
    '当函数同时有多个装饰器 @a @b def f():，哪个先应用？', 
    JSON_OBJECT('A', '从下往上先应用 b 再 a', 'B', '从上往下先应用 a 再 b', 'C', '随机应用', 'D', '同时应用'), 
    1, 
    JSON_ARRAY('提示1：应用顺序与装饰器写法相关', '提示2：最内层是靠近函数的装饰器', '提示3：可以通过嵌套理解'), 
    '装饰器按从内到外的顺序应用，靠近函数定义的先执行包装。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1897, 
    127, 
    '方法装饰器', 
    '给类方法添加装饰器时应注意什么？', 
    JSON_OBJECT('A', '装饰器应保持 self 参数传递', 'B', '装饰器会自动绑定 self', 'C', '装饰器不能用于方法', 'D', '只能用于静态方法'), 
    1, 
    JSON_ARRAY('提示1：包装函数需接受 self 或 *args', '提示2：否则会破坏绑定', '提示3：使用 wraps 保留签名'), 
    '方法装饰器的包装函数要兼容实例方法的第一个参数 self。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1898, 
    127, 
    '性能考虑', 
    '装饰器会对被装饰函数性能产生怎样的影响？', 
    JSON_OBJECT('A', '会有轻微开销，因为多了一层函数调用', 'B', '完全没有影响', 'C', '会显著降低性能至不可用', 'D', '会提升性能'), 
    1, 
    JSON_ARRAY('提示1：包装增加一次调用开销', '提示2：通常可以忽略不计', '提示3：频繁调用的性能敏感路径需谨慎'), 
    '装饰器增加封装层，会带来一点调用开销，但多数场景可接受。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1899,
    127,
    '装饰器返回值（填空）',
    '装饰器函数必须返回一个可调用对象，通常返回 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def deco(f):"}, {"type": "code_line", "value": "    def wrapper(*a,**k):"}, {"type": "code_line", "value": "        return f(*a,**k)"}, {"type": "code_line", "value": "    "}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}]}]}',
    JSON_ARRAY('return wrapper', 'return f', 'return None', 'return 0'),
    JSON_ARRAY(1),
    '装饰器返回包装函数对象 wrapper。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1900,
    127,
    '装饰器示例（填空）',
    '完成下面装饰器，使其在函数执行前打印 "call"。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def log(f):"}, {"type": "code_line", "value": "    def wrapper(*a,**k):"}, {"type": "code_line", "value": "        print(\"call\")"}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}, {"type": "code_line", "value": "    return wrapper"}]}]}',
    JSON_ARRAY('return f(*a,**k)', 'f(*a,**k)', 'print(f)'),
    JSON_ARRAY(1),
    'wrapper 内应调用并返回原函数 f 的结果。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1901, 
    127, 
    '装饰器与参数', 
    '装饰器如何确保包装器函数接受任意参数？', 
    JSON_OBJECT('A', '使用 *args, **kwargs', 'B', '只接受固定参数', 'C', '只接受关键字参数', 'D', '只接受 self'), 
    1, 
    JSON_ARRAY('提示1：*args, **kwargs 提供通用签名', '提示2：避免限制被装饰函数参数', '提示3：结合 functools.wraps 使用更好'), 
    '包装器应使用 *args, **kwargs 来兼容任意被装饰函数签名。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1902, 
    127, 
    '类装饰器', 
    '类也可以作为装饰器，下面哪个是正确的类装饰器行为？', 
    JSON_OBJECT('A', '类接收一个函数并返回可调用对象', 'B', '类只能装饰类', 'C', '类装饰器会自动实例化', 'D', '类装饰器不支持参数'), 
    1, 
    JSON_ARRAY('提示1：类装饰器实现 __call__ 方法', '提示2：实例化后作为装饰器返回可调用对象', '提示3：示例可查阅'), 
    '类装饰器可通过定义 __init__ 和 __call__ 来实现装饰器功能。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1903, 
    127, 
    '常见装饰器用途', 
    '下列哪个不是装饰器常见用途？', 
    JSON_OBJECT('A', '性能计时', 'B', '缓存结果', 'C', '改变语法规则', 'D', '权限检查'), 
    3, 
    JSON_ARRAY('提示1：装饰器常用于横切关注点', '提示2：不用于编译期语法修改', '提示3：多用于运行期行为增强'), 
    '装饰器用于运行期增强函数行为，而非改变语言语法。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1904,
    127,
    'wraps 用法（填空）',
    '在包装函数上使用 __1__ 来保留原函数元信息。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from functools import wraps"}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "def deco(f):"}, {"type": "code_line", "value": "    @"}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": "(f)"}]}, {"type": "code_line", "value": "    def wrapper(*a,**k):"}, {"type": "code_line", "value": "        return f(*a,**k)"}, {"type": "code_line", "value": "    return wrapper"}]}]}',
    JSON_ARRAY('wraps', 'partial', 'decorator', 'cached'),
    JSON_ARRAY(1),
    '使用 functools.wraps(f) 可以复制函数名和文档字符串等元信息。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1905,
    127,
    '总结（填空）',
    '装饰器能在不改变原函数代码的情况下添加 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('行为', '注释', '变量', '格式'),
    JSON_ARRAY(1),
    '装饰器用于添加或替换函数的行为（如日志、缓存等）。',
    ''
);