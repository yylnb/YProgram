USE `questions`;
-- Unit 149 | Start ID: 2221
-- Generated at 2025-12-24 23:43:08

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2221, 
    149, 
    'unittest 框架', 
    'Python 标准库中用于单元测试的模块是？', 
    JSON_OBJECT('A', 'unittest', 'B', 'pytest', 'C', 'nose', 'D', 'doctest'), 
    1, 
    JSON_ARRAY('提示1：unittest 是标准库', '提示2：pytest 是第三方常用框架'), 
    'unittest 是内置的单元测试框架，提供 TestCase 等基础类。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2222, 
    149, 
    '测试隔离', 
    '单元测试应遵循哪个原则？', 
    JSON_OBJECT('A', '独立且可重复', 'B', '依赖执行顺序', 'C', '修改全局状态', 'D', '网络依赖'), 
    1, 
    JSON_ARRAY('提示1：测试应可任意顺序运行'), 
    '单元测试应独立、可重复且不依赖外部环境。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2223, 
    149, 
    '测试命名', 
    'unittest 自动发现测试文件通常匹配哪个模式？', 
    JSON_OBJECT('A', 'test*.py', 'B', '*.spec.py', 'C', 'spec_*.py', 'D', '*.unittest.py'), 
    1, 
    JSON_ARRAY('提示1：常见为 test_*.py 或 *_test.py'), 
    '默认测试发现匹配 test*.py，pytest 则更灵活。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2224,
    149,
    '断言方法（填空）',
    '在 unittest 中检查相等常用方法为 self.__1__(a, b).',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "self."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(a, b)."}]}]}',
    JSON_ARRAY('assertEqual', 'assertTrue', 'assertFalse', 'assertRaises'),
    JSON_ARRAY(1),
    'assertEqual 用于检查两个值是否相等。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2225,
    149,
    'mock 对象（填空）',
    '使用 unittest.mock 中的 __1__ 可以替换函数或对象以隔离依赖。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "使用 unittest.mock 中的 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 可以替换函数或对象以隔离依赖。"}]}]}',
    JSON_ARRAY('patch', 'MagicMock', 'Mock', 'sentinel'),
    JSON_ARRAY(1),
    'patch 用于临时替换模块或对象，便于隔离外部依赖。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2226, 
    149, 
    '断言异常', 
    '检查函数抛出异常常用哪个断言？', 
    JSON_OBJECT('A', 'assertRaises', 'B', 'assertEqual', 'C', 'assertTrue', 'D', 'assertIsNone'), 
    1, 
    JSON_ARRAY('提示1：可以作为上下文管理器使用'), 
    'assertRaises 用于断言特定异常会被抛出。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2227, 
    149, 
    'TDD 流程', 
    '测试驱动开发（TDD）的基本循环是？', 
    JSON_OBJECT('A', '写测试 → 实现 → 重构', 'B', '实现 → 写测试 → 部署', 'C', '部署 → 测试 → 修复', 'D', '验证 → 测试 → 重构'), 
    1, 
    JSON_ARRAY('提示1：先写失败的测试', '提示2：然后实现通过测试'), 
    'TDD 的循环是先写测试，再实现代码，最后重构。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2228, 
    149, 
    '集成测试', 
    '集成测试与单元测试的区别是？', 
    JSON_OBJECT('A', '集成测试关注多个组件协同工作', 'B', '集成测试比单元测试更小', 'C', '集成测试只测试 UI', 'D', '集成测试无需环境'), 
    1, 
    JSON_ARRAY('提示1：集成测试可能需要数据库或网络模拟'), 
    '集成测试验证组件间交互，而单元测试关注单个函数或类。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2229,
    149,
    '测试夹具（填空）',
    '在 unittest 中可使用 setUp 和 __1__ 来准备和清理测试环境。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "在 unittest 中可使用 setUp 和 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 来准备和清理测试环境。"}]}]}',
    JSON_ARRAY('tearDown', 'setUpClass', 'tearDownClass', 'setUpModule'),
    JSON_ARRAY(1),
    'tearDown 在每个测试后执行用于清理资源。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2230,
    149,
    '覆盖率（填空）',
    '衡量测试覆盖率常用工具是 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "衡量测试覆盖率常用工具是 "}, {"type": "slot", "index": 0}, {"type": "code", "value": "。"}]}]}',
    JSON_ARRAY('coverage', 'pytest', 'unittest', 'nose'),
    JSON_ARRAY(1),
    'coverage.py 可计算代码执行覆盖率，常与测试框架配合使用。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2231, 
    149, 
    '测试速率', 
    '哪种做法可加速大量测试执行？', 
    JSON_OBJECT('A', '并行执行测试或使用更快的测试框架', 'B', '在每个测试中启动数据库', 'C', '打印大量调试信息', 'D', '在测试中使用 sleep'), 
    1, 
    JSON_ARRAY('提示1：pytest-xdist 可并行执行测试'), 
    '并行化测试和使用高效框架是提高测试速度的常用做法。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2232,
    149,
    '断言消息（填空）',
    '在断言中提供自定义消息可帮助定位失败，assertEqual(a,b, "__1__").',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "在断言中提供自定义消息可帮助定位失败，assertEqual(a,b, \""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\")."}]}]}',
    JSON_ARRAY('描述信息', '代码', '数据', '日志'),
    JSON_ARRAY(1),
    '提供描述信息有助于在失败时快速定位问题。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2233,
    149,
    '断言真值（填空）',
    '检查值为真使用 self.__1__(expr).',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "self."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(expr)."}]}]}',
    JSON_ARRAY('assertTrue', 'assertFalse', 'assertIsNone', 'assertIn'),
    JSON_ARRAY(1),
    'assertTrue 用于断言表达式为真。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2234,
    149,
    '持续集成（填空）',
    '在 CI 中运行测试能早发现回归并保证 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "在 CI 中运行测试能早发现回归并保证 "}, {"type": "slot", "index": 0}, {"type": "code", "value": "。"}]}]}',
    JSON_ARRAY('代码质量', '速度', '样式', '个人偏好'),
    JSON_ARRAY(1),
    'CI 中运行测试可保证代码质量和及时发现问题。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2235,
    149,
    '总结（填空）',
    '良好的测试应覆盖关键路径并且 __1__ 可重复。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "良好的测试应覆盖关键路径并且 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 可重复。"}]}]}',
    JSON_ARRAY('可自动化', '手工', '随机', '不确定'),
    JSON_ARRAY(1),
    '测试应可自动执行并保持稳定与可重复性。',
    ''
);