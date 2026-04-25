USE `questions`;
-- Unit 132 | Start ID: 1966
-- Generated at 2025-12-24 23:39:03

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1966, 
    132, 
    '类属性与实例属性', 
    '类属性与实例属性的主要区别是？', 
    JSON_OBJECT('A', '类属性归类所有，实例属性归单个实例', 'B', '实例属性共享，类属性独立', 'C', '类属性只能是函数', 'D', '实例属性必须为私有'), 
    1, 
    JSON_ARRAY('提示1: 修改类属性会影响所有实例（除非被覆盖）', '提示2: 实例属性只属于该实例', '提示3: 可用类名访问类属性'), 
    '类属性存在于类对象上，实例属性是在实例字典中。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1967, 
    132, 
    '访问类属性', 
    '通过哪个方式访问类属性更合适？', 
    JSON_OBJECT('A', 'ClassName.attr', 'B', 'instance.attr 永远不行', 'C', '通过全局变量', 'D', '通过文件读取'), 
    1, 
    JSON_ARRAY('提示1: 虽然 instance.attr 可访问，但 ClassName.attr 更明确', '提示2: 使用类名可避免实例覆盖带来的歧义', '提示3: 清晰易读'), 
    '使用类名访问类属性更直观。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1968, 
    132, 
    '实例属性覆盖', 
    '当实例赋值与类同名属性时会如何？', 
    JSON_OBJECT('A', '在实例字典中创建新属性，覆盖查找', 'B', '修改类属性本身', 'C', '抛出异常', 'D', '创建全局变量'), 
    1, 
    JSON_ARRAY('提示1: 实例属性掩盖类属性', '提示2: 类属性仍在类上存在', '提示3: del instance.attr 可恢复'), 
    '赋值会在实例上创建实例属性，从而覆盖类属性查找。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1969,
    132,
    '默认值陷阱（填空）',
    '当把可变对象作为类属性时，多个实例共享该对象；避免方法是将其设为 __1__ 并在 __2__ 中创建实例副本。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    data = "}, {"type": "slot", "index": 0}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    def "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(self):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        self.data = []"}]}]}',
    JSON_ARRAY('None', '[]', '__init__', '__new__'),
    JSON_ARRAY(1, 3),
    '不要把可变默认放在类属性上，应在 __init__ 中为实例创建独立对象。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1970,
    132,
    '属性查找（填空）',
    '访问属性时，Python 首先在 __1__ 中查找，然后到 __2__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('实例字典', '类', '全局', '文件'),
    JSON_ARRAY(1, 2),
    '属性查找顺序：实例字典 -> 类 -> 父类链。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1971, 
    132, 
    '动态绑定属性', 
    'Python 允许在运行时给实例绑定新属性吗？', 
    JSON_OBJECT('A', '允许', 'B', '不允许', 'C', '仅在类定义中允许', 'D', '需要特殊关键字'), 
    1, 
    JSON_ARRAY('提示1: 可以直接赋值 instance.x = 1', '提示2: __slots__ 会限制绑定', '提示3: 动态特性强大但要节制'), 
    'Python 可以动态给对象绑定属性，除非使用 __slots__ 限制。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1972, 
    132, 
    '__slots__ 的作用', 
    '为类定义 __slots__ 的主要目的是？', 
    JSON_OBJECT('A', '节省内存并限制可绑定属性', 'B', '增加方法数量', 'C', '优化函数调用', 'D', '自动生成属性'), 
    1, 
    JSON_ARRAY('提示1: __slots__ 会省去实例字典', '提示2: 限制未经声明的属性绑定', '提示3: 可用于大量实例节约内存'), 
    '__slots__ 用于限制实例属性并减少内存占用。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1973, 
    132, 
    '属性描述符', 
    '描述符协议（__get__/__set__）常用于？', 
    JSON_OBJECT('A', '控制属性访问与赋值', 'B', '替代继承', 'C', '定义类方法', 'D', '管理模块导入'), 
    1, 
    JSON_ARRAY('提示1: property 基于描述符实现', '提示2: 可实现懒加载或验证', '提示3: 常见于属性封装'), 
    '描述符用于拦截属性访问以实现定制行为。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1974,
    132,
    'property 用法（填空）',
    '将方法变成只读属性常用装饰器为 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    @"}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    def x(self):"}, {"type": "code_line", "value": "        return 1"}]}]}',
    JSON_ARRAY('property', 'staticmethod', 'classmethod', 'descriptor'),
    JSON_ARRAY(1),
    '使用 @property 可把方法当作属性访问。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1975,
    132,
    '删除属性（填空）',
    '要删除实例属性，使用语句 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "del "}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('instance.attr', 'ClassName.attr', 'attr', 'self.attr'),
    JSON_ARRAY(1),
    '使用 del instance.attr 可以删除该实例的属性。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1976, 
    132, 
    '只读属性', 
    '如何实现属性只读？', 
    JSON_OBJECT('A', '使用 @property 只定义 getter 不定义 setter', 'B', '用 __slots__ 限制', 'C', '把属性设为私有就自动只读', 'D', '无法实现'), 
    1, 
    JSON_ARRAY('提示1: 不提供 setter 即为只读', '提示2: property 可定义 getter/setter/deleter', '提示3: 也可用描述符自定义'), 
    '通过 property 不提供 setter 可实现只读属性。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1977, 
    132, 
    '类变量修改', 
    '若需在类方法中修改类变量，应使用哪个参数引用类？', 
    JSON_OBJECT('A', 'cls', 'B', 'self', 'C', 'global', 'D', 'class'), 
    1, 
    JSON_ARRAY('提示1: classmethod 接受 cls', '提示2: cls 用于访问/修改类变量', '提示3: self 为实例引用'), 
    '在 classmethod 中使用 cls 访问或修改类变量是常见做法。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1978,
    132,
    '描述符示例（填空）',
    '实现属性访问控制可以定义类包含方法 __1__ 和 __2__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class D:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    def "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(self, instance, owner):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        pass"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    def "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(self, instance, value):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        pass"}]}]}',
    JSON_ARRAY('__get__', '__set__', '__init__', '__call__'),
    JSON_ARRAY(1, 2),
    '描述符协议包括 __get__ 和 __set__ 等方法。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1979,
    132,
    '访问限制（填空）',
    '把属性命名为 _x 常表示什么？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}, {"type": "code_line", "value": "    _x = 1"}]}]}',
    JSON_ARRAY('受保护的实现细节', '私有', '全局', '常量'),
    JSON_ARRAY(1),
    '单下划线表示受保护，提示外部不要直接访问。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1980,
    132,
    '总结（填空）',
    '类属性放在 __1__ 上，实例属性放在 __2__ 上。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('类对象', '实例对象', '模块', '全局命名空间'),
    JSON_ARRAY(1, 2),
    '类属性属于类对象，实例属性属于实例对象。',
    ''
);