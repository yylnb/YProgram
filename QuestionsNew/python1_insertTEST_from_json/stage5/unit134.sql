USE `questions`;
-- Unit 134 | Start ID: 1996
-- Generated at 2025-12-25 17:41:15

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1996,
    134,
    '__str__ 与 __repr__',
    '下面关于 __str__ 与 __repr__ 的说法，正确的是？',
    JSON_OBJECT('A', '__repr__ 更适合调试，__str__ 更适合用户展示', 'B', '两者完全相同', 'C', '只有 __str__ 被调用', 'D', '__repr__ 返回 HTML'),
    1,
    JSON_ARRAY('提示1: repr 常用于交互解释器', '提示2: str 用于 print', '提示3: 可让 repr 返回可 eval 的表达式'),
    '__repr__ 提供开发者视角，__str__ 提供用户友好视图。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1997,
    134,
    '__len__ 用途',
    '实现 __len__ 可以使对象支持哪个内置函数？',
    JSON_OBJECT('A', 'len()', 'B', 'str()', 'C', 'repr()', 'D', 'type()'),
    1,
    JSON_ARRAY('提示1: len(obj) 调用 obj.__len__', '提示2: 对容器类常实现该方法', '提示3: 返回整数表示元素数'),
    '实现 __len__ 可使对象对 len() 有响应。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1998,
    134,
    '__iter__ 与 __next__',
    '要使对象可迭代，通常需要实现？',
    JSON_OBJECT('A', '__iter__ 返回迭代器，迭代器实现 __next__', 'B', '只实现 __len__', 'C', '只实现 __repr__', 'D', '实现 __call__'),
    1,
    JSON_ARRAY('提示1: for 会调用 __iter__', '提示2: 迭代器维持状态并实现 __next__', '提示3: StopIteration 用于结束迭代'),
    '实现迭代协议需提供 __iter__ 和 __next__（或返回一个迭代器）。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1999,
    134,
    '加法重载（填空）',
    '要支持 obj1 + obj2，应实现 __1__ 方法。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}, {"type": "code_line", "value": "    def __add__(self, other):"}, {"type": "code_line", "value": "        return ..."}]}]}',
    JSON_ARRAY('__add__', '__radd__', '__iadd__', '__eq__'),
    JSON_ARRAY(1),
    '实现 __add__ 可定义加法行为，__radd__ 在右侧操作数中回退。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2000,
    134,
    '原地加法（填空）',
    '使用 += 时会优先调用 __1__（若定义）。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}, {"type": "code_line", "value": "    def __iadd__(self, other):"}, {"type": "code_line", "value": "        pass"}]}]}',
    JSON_ARRAY('__iadd__', '__add__', '__radd__', '__iter__'),
    JSON_ARRAY(1),
    '__iadd__ 用于原地加法，实现可提高性能并保持对象可变性。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2001,
    134,
    '比较方法',
    '实现 __eq__ 后，使用哪个函数可得到等价性比较？',
    JSON_OBJECT('A', '== 运算符', 'B', 'is 运算符', 'C', 'in 运算符', 'D', 'len 运算符'),
    1,
    JSON_ARRAY('提示1: == 调用 __eq__', '提示2: is 检查身份', '提示3: 可重写其他比较方法'),
    '== 会调用对象的 __eq__ 方法来判断等价性。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2002,
    134,
    '可调用对象',
    '若类实现 __call__，其实例可以怎样使用？',
    JSON_OBJECT('A', '像函数一样被调用', 'B', '作为模块导入', 'C', '自动成为 generator', 'D', '变为私有对象'),
    1,
    JSON_ARRAY('提示1: obj() 会触发 obj.__call__', '提示2: 常用于函数式接口对象', '提示3: 便于状态封装的可调用性'),
    '实现 __call__ 使对象可像函数一样被调用。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2003,
    134,
    '上下文管理协议',
    '要使对象可用于 with 语句，应实现哪两个魔法方法？',
    JSON_OBJECT('A', '__enter__ 和 __exit__', 'B', '__init__ 和 __del__', 'C', '__iter__ 和 __next__', 'D', '__call__ 和 __repr__'),
    1,
    JSON_ARRAY('提示1: __enter__ 进入上下文返回对象', '提示2: __exit__ 用于清理', '提示3: 常用于资源管理'),
    '上下文管理器需实现 __enter__ 和 __exit__ 方法。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2004,
    134,
    '属性访问（填空）',
    '自定义属性访问可通过实现 __1__ 方法来拦截访问。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}, {"type": "code_line", "value": "    def __getattribute__(self, name):"}, {"type": "code_line", "value": "        return ..."}]}]}',
    JSON_ARRAY('__getattr__', '__getattribute__', '__setattr__', '__delattr__'),
    JSON_ARRAY(2),
    '__getattribute__ 在所有属性访问时被调用，__getattr__ 仅在未找到属性时调用。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2005,
    134,
    '字符串表示（填空）',
    '使 print(obj) 更友好应实现 __1__。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}, {"type": "code_line", "value": "    def __str__(self):"}, {"type": "code_line", "value": "        return \\"A\\""}]}]}',
    JSON_ARRAY('__str__', '__repr__', '__len__', '__call__'),
    JSON_ARRAY(1),
    '__str__ 用于打印时的友好表示。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2006,
    134,
    '不可变对象的比较',
    '对于不可变对象，实现 __hash__ 的目的是？',
    JSON_OBJECT('A', '允许对象用作字典键或集合元素', 'B', '使对象可变', 'C', '防止比较', 'D', '提高 I/O 性能'),
    1,
    JSON_ARRAY('提示1: hash 与 eq 需要保持一致性', '提示2: 可作为字典键的对象必须不可变且可哈希', '提示3: 覆盖 eq 时应同时考虑 hash'),
    '实现 __hash__ 使对象可用于哈希结构如 dict 的键。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2007,
    134,
    '反射与魔法方法',
    '通过 getattr(obj, name) 会怎样？',
    JSON_OBJECT('A', '查找对象属性，触发相关魔法方法', 'B', '只能查找类属性', 'C', '仅用于模块操作', 'D', '无法查找私有属性'),
    1,
    JSON_ARRAY('提示1: getattr 会触发 __getattribute__/__getattr__', '提示2: 是动态访问属性的工具', '提示3: 可与 setattr/delattr 配合使用'),
    'getattr 会触发属性访问流程，与魔法方法互动。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2008,
    134,
    '运算优先级（填空）',
    '当 a + b 无法处理时，Python 会尝试调用 b.__1__。',
    NULL,
    NULL,
    '{"segments": []}',
    JSON_ARRAY('__radd__', '__add__', '__iadd__', '__mul__'),
    JSON_ARRAY(1),
    '当左侧对象不支持该操作，Python 会调用右侧对象的 __radd__ 回退实现。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2009,
    134,
    '增强可读性（填空）',
    '为自定义容器实现可迭代和长度支持，应实现 __1__ 与 __2__。',
    NULL,
    NULL,
    '{"segments": []}',
    JSON_ARRAY('__iter__', '__len__', '__call__', '__enter__'),
    JSON_ARRAY(1, 2),
    '实现 __iter__ 与 __len__ 有助于容器与内置函数兼容。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2010,
    134,
    '总结（填空）',
    '魔法方法用于自定义对象的 __1__ 与 __2__ 行为。',
    NULL,
    NULL,
    '{"segments": []}',
    JSON_ARRAY('运算', '协议', '文档', '文件系统'),
    JSON_ARRAY(1, 2),
    '魔法方法用于定制运算和协议（如迭代、上下文管理等）。',
    ''
);