USE `questions`;
-- Unit 131 | Start ID: 1951
-- Generated at 2025-12-24 18:21:14

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1951, 
    131, 
    '类与对象', 
    '下列哪项最准确描述类与对象的关系？', 
    JSON_OBJECT('A', '类是模板，对象是实例化后的实体', 'B', '对象是模板，类是实例', 'C', '两者没有关系', 'D', '类只能有一个对象'), 
    1, 
    JSON_ARRAY('提示1: 类定义属性和方法', '提示2: 对象是类的实例', '提示3: 实例可以有独立状态'), 
    '类是抽象模板，对象是根据类创建的具体实例。', 
    'class A: pass
a = A()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1952, 
    131, 
    '封装', 
    '面向对象中“封装”主要指什么？', 
    JSON_OBJECT('A', '将数据和操作封装在对象中', 'B', '把所有函数放进模块', 'C', '把程序封存在文件里', 'D', '禁止访问对象'), 
    1, 
    JSON_ARRAY('提示1: 限制直接访问内部状态', '提示2: 提供方法操作内部数据', '提示3: 有助于模块化'), 
    '封装是把数据和操作组合并通过接口控制访问。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1953, 
    131, 
    '继承', 
    '继承可以带来什么好处？', 
    JSON_OBJECT('A', '代码复用和行为扩展', 'B', '提高运行速度', 'C', '消除所有 bug', 'D', '让函数更短'), 
    1, 
    JSON_ARRAY('提示1: 子类继承父类属性和方法', '提示2: 可重用逻辑', '提示3: 简化设计'), 
    '继承用于重用和扩展已有类的功能。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1954, 
    131, 
    '类方法与静态方法', 
    '下列关于 @classmethod 与 @staticmethod 的描述，正确的是？', 
    JSON_OBJECT('A', 'classmethod 接受类作为第一个参数，staticmethod 不接受隐含参数', 'B', '两者等价', 'C', 'staticmethod 自动传入对象', 'D', 'classmethod 只能在类外调用'), 
    1, 
    JSON_ARRAY('提示1: classmethod 第一个参数为 cls', '提示2: staticmethod 类似普通函数放在类命名空间', '提示3: 用途不同'), 
    'classmethod 接受类对象，staticmethod 不接收实例或类。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1955, 
    131, 
    '私有属性', 
    '在 Python 中用双下划线前缀（如 __x）的主要目的是？', 
    JSON_OBJECT('A', '触发名称重整以限制外部访问', 'B', '使变量不可变', 'C', '让变量变为全局', 'D', '提高性能'), 
    1, 
    JSON_ARRAY('提示1: 是名称改写（name mangling）', '提示2: 不是绝对私有', '提示3: 仍可通过 _ClassName__x 访问'), 
    '双下划线触发名称改写，使外部访问不便以实现封装。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1956, 
    131, 
    '对象的属性查找顺序', 
    '访问 obj.attr 时，Python 首先在哪查找？', 
    JSON_OBJECT('A', '实例字典，然后类及其父类', 'B', '全局命名空间', 'C', '只在类中', 'D', '文件系统'), 
    1, 
    JSON_ARRAY('提示1: 实例属性优先', '提示2: 否则在类属性查找', '提示3: 继承链会被搜索'), 
    '属性查找遵循实例->类->父类的顺序。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1957, 
    131, 
    '面向对象优势', 
    '面向对象的一个常见优势是？', 
    JSON_OBJECT('A', '提高可维护性与复用性', 'B', '自动并行化代码', 'C', '减少内存占用', 'D', '使程序更短'), 
    1, 
    JSON_ARRAY('提示1: OOP 有助于设计复杂系统', '提示2: 用抽象封装细节', '提示3: 支持继承与多态'), 
    'OOP 有助于组织代码，提升可维护性与复用。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1958, 
    131, 
    '多态', 
    '多态（polymorphism）指的是什么？', 
    JSON_OBJECT('A', '不同类型的对象以统一接口被使用', 'B', '对象变为多线程', 'C', '类有多个父类', 'D', '变量可以变类型'), 
    1, 
    JSON_ARRAY('提示1: 同一接口不同实现', '提示2: 常见于方法重写', '提示3: 支持灵活替换对象'), 
    '多态允许不同类型通过相同接口工作。', 
    ''
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1959,
    131,
    '实例化（填空）',
    '创建类实例应使用 __1__ 运算符。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A: pass"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "a = "}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('A()', 'A', 'new A()', 'create(A)'),
    JSON_ARRAY(1),
    '通过调用类名（如 A()）来实例化对象。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1960,
    131,
    'self 的含义（填空）',
    '在实例方法中，第一个参数通常命名为 __1__，代表实例本身。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    def f("}, {"type": "slot", "index": 0}, {"type": "code", "value": "):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        pass"}]}]}',
    JSON_ARRAY('self', 'cls', 'this', 'me'),
    JSON_ARRAY(1),
    '习惯上使用 self 作为实例方法的第一个参数。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1961,
    131,
    '构造器（填空）',
    '在类中用于初始化实例的特殊方法名为 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    def "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(self):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        pass"}]}]}',
    JSON_ARRAY('__init__', '__new__', 'construct', 'init'),
    JSON_ARRAY(1),
    '__init__ 用于实例初始化。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1962,
    131,
    '替换对象（填空）',
    '要返回类的新实例通常在 __1__ 中实现。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    def "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(cls):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        return object.__new__(cls)"}]}]}',
    JSON_ARRAY('__new__', '__init__', '__call__', '__del__'),
    JSON_ARRAY(1),
    '__new__ 负责创建实例，__init__ 进行初始化。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1963,
    131,
    '方法重写（填空）',
    '子类中重新定义父类方法称为 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class Parent:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    def f(self): pass"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "class Child(Parent):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    def "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(self): pass"}]}]}',
    JSON_ARRAY('override', 'overload', 'rewrite', 'redefine'),
    JSON_ARRAY(1),
    '重写（override）是子类提供不同实现的术语。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1964,
    131,
    'isinstance 用法（填空）',
    '检查 obj 是否为 A 类或其子类，应使用 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    pass"}]}]}',
    JSON_ARRAY('isinstance(obj, A)', 'type(obj)==A', 'obj.__class__==A', 'isinstance(obj, (A,))'),
    JSON_ARRAY(1),
    'isinstance 可检查继承关系，推荐使用。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1965,
    131,
    '总结（填空）',
    '类是 __1__，对象是 __2__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('模板', '实例', '函数', '模块'),
    JSON_ARRAY(1, 2),
    '类作为模板，实例是具体的对象。',
    ''
);