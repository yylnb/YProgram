USE `questions`;
-- Unit 135 | Start ID: 2011
-- Generated at 2025-12-24 18:21:57

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2011, 
    135, 
    'dataclass 用途', 
    '使用 @dataclass 的主要好处是？', 
    JSON_OBJECT('A', '自动生成 __init__/__repr__ 等实用方法', 'B', '使类变为不可变', 'C', '禁止继承', 'D', '自动并行化'), 
    1, 
    JSON_ARRAY('提示1: dataclass 可减少样板代码', '提示2: 支持默认值与类型注解', '提示3: 可配置为不可变 frozen'), 
    'dataclass 自动为类生成常用方法，减少样板代码。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2012, 
    135, 
    'frozen 参数', 
    '在 dataclass 中设置 frozen=True 会怎样？', 
    JSON_OBJECT('A', '实例变为不可变（冻结）', 'B', '禁止实例化', 'C', '提升性能', 'D', '自动加锁'), 
    1, 
    JSON_ARRAY('提示1: frozen 会阻止属性赋值', '提示2: 仍可用 replace 创建新实例', '提示3: 有助于哈希性'), 
    'frozen=True 会使生成的实例属性不可变。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2013, 
    135, 
    '属性装饰器 property', 
    '使用 @property 的主要作用是？', 
    JSON_OBJECT('A', '把方法当属性访问以实现访问控制', 'B', '自动生成 setter', 'C', '让方法变成静态方法', 'D', '替换构造函数'), 
    1, 
    JSON_ARRAY('提示1: 提供 getter、setter、deleter', '提示2: 可用于延迟计算或校验', '提示3: 保持调用方接口'), 
    'property 将方法变成属性访问接口，便于封装与校验。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2014, 
    135, 
    'dataclass 比较', 
    'dataclass 默认是否实现比较方法（如 __eq__）？', 
    JSON_OBJECT('A', '实现 __eq__ 等比较方法', 'B', '不实现任何比较', 'C', '只实现 __lt__', 'D', '只实现 __hash__'), 
    1, 
    JSON_ARRAY('提示1: dataclass 可自动实现 eq', '提示2: 可以通过参数调整比较行为', '提示3: frozen 与 hash 有交互影响'), 
    'dataclass 默认生成 __eq__，可用参数调整 hash 与比较行为。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2015, 
    135, 
    '属性验证', 
    '要在设置属性时做验证，常见做法是？', 
    JSON_OBJECT('A', '使用 property setter 来校验并抛出异常', 'B', '在外部直接修改实例字典', 'C', '使用全局函数', 'D', '使用注释'), 
    1, 
    JSON_ARRAY('提示1: setter 可拦截赋值', '提示2: dataclass 支持 post_init 进行验证', '提示3: 验证有助于保证不变式'), 
    '通过 property 的 setter 可以在赋值时进行验证并抛出错误。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2016, 
    135, 
    'post_init', 
    'dataclass 提供的 __post_init__ 方法用于什么？', 
    JSON_OBJECT('A', '在默认 __init__ 之后做额外初始化或验证', 'B', '替代 __init__', 'C', '在类定义时调用', 'D', '自动生成文档'), 
    1, 
    JSON_ARRAY('提示1: 用于基于字段值做进一步处理', '提示2: 常用来校验组合字段', '提示3: __post_init__ 在实例创建后执行'), 
    '__post_init__ 可用于在 dataclass 自动生成的 __init__ 之后执行额外逻辑。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2017, 
    135, 
    '属性缓存', 
    '要对属性进行缓存，可以在 property 中结合哪个模块的 lru_cache？', 
    JSON_OBJECT('A', 'functools.lru_cache（需在方法外包装）', 'B', 'os', 'C', 'sys', 'D', 'json'), 
    1, 
    JSON_ARRAY('提示1: 直接对 property 使用 lru_cache 有限制', '提示2: 可用 cached_property 或自定义 descriptor', '提示3: functools 提供缓存工具'), 
    'functools 提供缓存工具，可用于提升属性计算性能或使用 cached_property。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2018, 
    135, 
    'dataclass 与继承', 
    'dataclass 支持继承吗？', 
    JSON_OBJECT('A', '支持，可继承字段与方法', 'B', '不支持', 'C', '仅支持单继承', 'D', '仅支持接口继承'), 
    1, 
    JSON_ARRAY('提示1: 子类可继承父类的字段', '提示2: 字段顺序与默认值规则需注意', '提示3: 可混合普通类与 dataclass'), 
    'dataclass 支持继承，但字段继承与默认值需留意顺序。', 
    ''
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2019,
    135,
    'dataclass 字段默认（填空）',
    '若字段默认为可变对象，应使用 field(default_factory=__1__) 来避免共享默认值。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from dataclasses import dataclass, field"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "@dataclass"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    items: list = field(default_factory="}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('list', 'list()', 'lambda: []', 'dict', 'None'),
    JSON_ARRAY(1),
    'default_factory 应传入可调用对象以返回新实例，例如 list 或 lambda: []。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2020,
    135,
    'setter 用法（填空）',
    '定义属性 setter 时，应在 getter 上使用 @__1__.setter 装饰器。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    @property"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    def x(self):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        return self._x"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    @"}, {"type": "slot", "index": 0}, {"type": "code", "value": ".setter"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    def x(self, v):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        self._x = v"}]}]}',
    JSON_ARRAY('x', 'property', 'setter', 'getter'),
    JSON_ARRAY(1),
    '使用 @x.setter 将对应的 setter 绑定到 property x。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2021,
    135,
    '只读 dataclass（填空）',
    '要让 dataclass 生成不可变实例，可设置 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "@dataclass("}, {"type": "slot", "index": 0}, {"type": "code", "value": "=True)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "class A: pass"}]}]}',
    JSON_ARRAY('frozen', 'eq', 'order', 'unsafe_hash'),
    JSON_ARRAY(1),
    '使用 frozen=True 使实例不可变。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2022,
    135,
    '默认比较（填空）',
    '要禁用 dataclass 自动生成的比较方法，可在装饰器中设置 __1__=False。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "@dataclass("}, {"type": "slot", "index": 0}, {"type": "code", "value": "=False)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "class A: pass"}]}]}',
    JSON_ARRAY('eq', 'frozen', 'order', 'init'),
    JSON_ARRAY(1),
    '设置 eq=False 可以禁用 __eq__ 等比较方法的生成。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2023,
    135,
    'cached_property（填空）',
    '在 Python 3.8+ 中，可通过 functools.__1__ 便捷地实现属性缓存。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "from functools import "}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('cached_property', 'lru_cache', 'wraps', 'partial'),
    JSON_ARRAY(1),
    'functools.cached_property 可将方法变为按需计算并缓存的属性。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2024,
    135,
    '属性删除（填空）',
    '在 property 中定义 deleter 使用装饰器形式 @x.__1__.deleter。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "class A:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    @property"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    def x(self): return self._x"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    @x."}, {"type": "slot", "index": 0}, {"type": "code", "value": ".deleter"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    def x(self): pass"}]}]}',
    JSON_ARRAY('setter', 'getter', 'property', 'delete'),
    JSON_ARRAY(1),
    '使用 @x.deleter 可定义属性删除行为。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2025,
    135,
    '总结（填空）',
    'dataclass 用于减少 __1__，property 用于实现 __2__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('样板代码', '访问控制', '性能', '网络通信'),
    JSON_ARRAY(1, 2),
    'dataclass 减少样板代码，property 用于访问控制与封装。',
    ''
);