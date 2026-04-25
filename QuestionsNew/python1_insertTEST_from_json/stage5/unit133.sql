USE `questions`;
-- Unit 133 | Start ID: 1981
-- Generated at 2025-12-25 17:41:15

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1981,
    133,
    '单继承与多继承',
    'Python 支持哪种继承模型？',
    JSON_OBJECT('A', '单继承与多继承均支持', 'B', '仅单继承', 'C', '仅多继承', 'D', '不支持继承'),
    1,
    JSON_ARRAY('提示1: Python 支持多继承', '提示2: 需关注菱形继承问题', '提示3: 使用 MRO 解决方法解析顺序'),
    'Python 支持单继承和多继承，并使用 MRO 决定方法解析顺序。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1982,
    133,
    '方法解析顺序（MRO）',
    'MRO 的主要作用是？',
    JSON_OBJECT('A', '决定在多继承中方法查找顺序', 'B', '决定类的内存布局', 'C', '决定模块导入顺序', 'D', '决定异常处理顺序'),
    1,
    JSON_ARRAY('提示1: mro() 可查看顺序', '提示2: 避免菱形继承冲突', '提示3: C3 算法用于计算 MRO'),
    'MRO 决定在多继承中按何种顺序查找方法与属性。',
    'C.mro()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1983,
    133,
    '调用父类方法',
    '在子类中调用父类方法常用写法是？',
    JSON_OBJECT('A', 'super().method()', 'B', 'Parent.method(self)', 'C', '两者均可', 'D', '不能调用父类方法'),
    3,
    JSON_ARRAY('提示1: super 更推荐用于多继承', '提示2: 直接 Parent.method(self) 可绕过 MRO', '提示3: 注意参数传递'),
    '两种方式都可，super 更适合多继承场景。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1984,
    133,
    '覆盖父方法（填空）',
    '子类中重写父类方法称为 __1__。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class Parent:"}, {"type": "code_line", "value": "    def f(self): pass"}, {"type": "code_line", "value": "class Child(Parent):"}, {"type": "code_inline", "parts": [{"type": "code", "value": "    def "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(self): pass"}]}]}]}',
    JSON_ARRAY('override', 'overload', 'rewrite', 'extend'),
    JSON_ARRAY(1),
    '在子类中提供与父类相同签名的方法实现称为重写（override）。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1985,
    133,
    '抽象基类（填空）',
    '若要定义抽象方法并强制子类实现，可使用模块 __1__ 中的 ABC 类。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "from "}, {"type": "slot", "index": 0}, {"type": "code", "value": " import ABC, abstractmethod"}]}]}',
    JSON_ARRAY('abc', 'typing', 'inspect', 'functools'),
    JSON_ARRAY(1),
    'abc 模块提供抽象基类支持。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1986,
    133,
    '多态使用场景',
    '多态最常用的场景之一是？',
    JSON_OBJECT('A', '统一接口处理不同类型对象', 'B', '提高 I/O 性能', 'C', '静态类型检查', 'D', '模块打包'),
    1,
    JSON_ARRAY('提示1: 常见于实现插件或策略模式', '提示2: 通过接口调用不同实现', '提示3: 增强代码灵活性'),
    '多态允许通过统一接口对不同实现进行操作。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1987,
    133,
    'super() 的好处',
    '使用 super() 的优点是？',
    JSON_OBJECT('A', '遵循 MRO，适合多继承', 'B', '省去传入 self', 'C', '自动生成文档', 'D', '提高性能'),
    1,
    JSON_ARRAY('提示1: super() 返回代理对象', '提示2: 在多继承中避免重复调用父类', '提示3: 使用时通常写 super().method()'),
    'super() 按 MRO 寻找下一个方法实现，对于多继承很重要。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1988,
    133,
    'isinstance 与 issubclass',
    '要判断 B 是否为 A 的子类，应使用哪个函数？',
    JSON_OBJECT('A', 'issubclass(B, A)', 'B', 'isinstance(B, A)', 'C', 'type(B)==A', 'D', 'B in A'),
    1,
    JSON_ARRAY('提示1: issubclass 检查类与子类关系', '提示2: isinstance 检查实例'),
    'issubclass 用于判断类继承关系，isinstance 用于实例。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1989,
    133,
    '菱形继承问题（填空）',
    '为了解决菱形继承导致的重复调用，Python 使用 __1__ 算法计算 MRO。',
    NULL,
    NULL,
    '{"segments": []}',
    JSON_ARRAY('C3', 'BFS', 'DFS', 'LIFO'),
    JSON_ARRAY(1),
    'Python 使用 C3 线性化算法来计算 MRO。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1990,
    133,
    '接口替代（填空）',
    '虽然 Python 没有显式接口，通常使用抽象基类或约定（duck typing）来实现；鸭子类型的口号是 "__1__"。',
    NULL,
    NULL,
    '{"segments": []}',
    JSON_ARRAY('If it walks like a duck and quacks like a duck, it is a duck', 'Duck', 'Interface', 'Protocol'),
    JSON_ARRAY(1),
    '鸭子类型强调行为而不是显式接口。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1991,
    133,
    '复用 vs 组合',
    '在类设计中，推荐优先使用哪种以减少耦合？',
    JSON_OBJECT('A', '组合优于继承', 'B', '继承优于组合', 'C', '都不用', 'D', '直接复制代码'),
    1,
    JSON_ARRAY('提示1: 组合更灵活'),
    '组合比继承在许多场景下更灵活，减少耦合。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1992,
    133,
    '方法重载',
    'Python 是否支持基于参数签名的方法重载（overload）？',
    JSON_OBJECT('A', '不直接支持，通常通过可选参数或 functools.singledispatch 实现', 'B', '内建支持', 'C', '通过类装饰器自动实现', 'D', '仅在 Python2 支持'),
    1,
    JSON_ARRAY('提示1: 使用默认参数或 dispatch', '提示2: functools.singledispatch 可实现函数级别的多态', '提示3: 设计时注意接口一致性'),
    'Python 不基于签名进行方法重载，需用其它手段实现。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1993,
    133,
    '重写父类构造（填空）',
    '在子类 __1__ 中常需调用 super().__1__() 来初始化父类部分。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class Child(Parent):"}, {"type": "code_inline", "parts": [{"type": "code", "value": "    def "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(self, *a, **k):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        super()."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(*a, **k)"}]}]}]}',
    JSON_ARRAY('__init__', '__new__', 'construct', 'init'),
    JSON_ARRAY(1),
    '子类 __init__ 通常调用 super().__init__ 来初始化父类状态。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1994,
    133,
    '多态实例（填空）',
    '下面代码中，调用 obj.speak() 会调用子类还是父类实现？取决于 __1__。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}, {"type": "code_line", "value": "    def speak(self):"}, {"type": "code_line", "value": "        print(\\"A\\")"}, {"type": "code_line", "value": "class B(A):"}, {"type": "code_line", "value": "    def speak(self):"}, {"type": "code_line", "value": "        print(\\"B\\")"}, {"type": "code_line", "value": "obj = B()"}, {"type": "code_line", "value": "# obj.speak()"}]}]}',
    JSON_ARRAY('实例类型', '变量名', '函数名', '模块'),
    JSON_ARRAY(1),
    '方法调用基于对象的实际类型，故调用子类实现。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1995,
    133,
    '总结（填空）',
    '继承用于 __1__，多态用于 __2__。',
    NULL,
    NULL,
    '{"segments": []}',
    JSON_ARRAY('代码复用', '统一接口', '性能提升', '内存管理'),
    JSON_ARRAY(1, 2),
    '继承促进代码复用，多态支持使用统一接口处理不同对象。',
    ''
);