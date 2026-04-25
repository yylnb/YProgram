USE `questions`;
-- Unit 139 | Start ID: 2071
-- Generated at 2025-12-25 17:41:15

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2071,
    139,
    '单元测试目的',
    '编写单元测试的主要目的是？',
    JSON_OBJECT('A', '验证小单元代码正确性并防止回归', 'B', '提高运行速度', 'C', '替代代码审查', 'D', '自动生成文档'),
    1,
    JSON_ARRAY('提示1: 捕捉回归问题', '提示2: 小粒度测试便于定位错误', '提示3: 与 CI 集成提升质量'),
    '单元测试用于验证函数或类在各种输入下的行为是否符合预期，从而防止回归。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2072,
    139,
    'unittest 框架',
    'unittest 框架中，测试用例类通常继承自哪个基类？',
    JSON_OBJECT('A', 'unittest.TestCase', 'B', 'object', 'C', 'pytest.TestCase', 'D', 'Test'),
    1,
    JSON_ARRAY('提示1: 使用 assertEqual 等断言方法', '提示2: setUp/tearDown 提供资源准备与清理', '提示3: 是标准库提供的框架'),
    'unittest.TestCase 提供测试断言及生命周期方法。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2073,
    139,
    'pytest 优势',
    'pytest 相较 unittest 的常见优势包括？',
    JSON_OBJECT('A', '写法更简洁且插件生态丰富', 'B', '速度更慢', 'C', '不能运行 unittest 测试', 'D', '没有断言'),
    1,
    JSON_ARRAY('提示1: 直接用 assert 语句编写测试', '提示2: fixture 提供灵活资源管理', '提示3: 广泛社区支持'),
    'pytest 提供更简洁的测试写法与丰富的插件，适合现代 Python 项目。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2074,
    139,
    '断言示例（填空）',
    '使用 pytest，可直接写断言例如 assert __1__ == 3。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "def test_add():"}, {"type": "slot", "index": 0}, {"type": "code", "value": "    assert "}, {"type": "slot", "index": 1}, {"type": "code", "value": " == 3"}]}]}',
    JSON_ARRAY('add(1,2)', '1+1', 'f(3)', 'None'),
    JSON_ARRAY(1),
    '直接断言函数返回值以简洁表达测试预期。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2075,
    139,
    'fixture 用途（填空）',
    'pytest 中 fixture 常用于 __1__。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "@pytest.fixture"}, {"type": "code_line", "value": "def db():"}, {"type": "code_line", "value": "    return connect()"}]}]}',
    JSON_ARRAY('资源准备', '运行测试', '打印日志', '结束测试'),
    JSON_ARRAY(1),
    'fixture 用于准备和清理测试所需的资源，如数据库连接、临时目录等。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2076,
    139,
    '测试覆盖率',
    '测量代码被测试的比例通常使用哪个工具？',
    JSON_OBJECT('A', 'coverage.py', 'B', 'pytest-cov, coverage.py 都可', 'C', 'flake8', 'D', 'mypy'),
    2,
    JSON_ARRAY('提示1: coverage.py 是核心工具', '提示2: pytest-cov 提供集成插件', '提示3: 覆盖率帮助找出未测路径'),
    'coverage.py 与 pytest-cov 常用于计算测试覆盖率并生成报告。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2077,
    139,
    '测试命名约定',
    'pytest 中测试函数通常以什么前缀命名？',
    JSON_OBJECT('A', 'test_', 'B', 'should_', 'C', 'case_', 'D', 'check_'),
    1,
    JSON_ARRAY('提示1: pytest 识别以 test_ 开头的函数与文件', '提示2: 有助于自动发现测试', '提示3: 文件名也以 test_ 开始'),
    'pytest 自动发现以 test_ 前缀的测试函数和模块。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2078,
    139,
    '跳过测试',
    '要在 pytest 中跳过某个测试，应使用哪个标记？',
    JSON_OBJECT('A', '@pytest.mark.skip', 'B', '@pytest.skipif', 'C', '@unittest.skip', 'D', '@skipall'),
    1,
    JSON_ARRAY('提示1: skip 可跳过无条件测试', '提示2: skipif 可基于条件跳过', '提示3: 两者皆可用于管理测试执行'),
    '@pytest.mark.skip 用于标记测试跳过，skipif 基于条件跳过。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2079,
    139,
    '断言异常（填空）',
    '要断言某段代码抛出异常，可用 pytest.raises(Exception) 作为上下文管理器： with pytest.raises(__1__):',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "with pytest.raises("}, {"type": "slot", "index": 0}, {"type": "code", "value": "):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    f()"}]}]}',
    JSON_ARRAY('ValueError', 'None', 'Exception', '0'),
    JSON_ARRAY(3),
    '将期望的异常类型传给 pytest.raises 以断言抛出相应异常。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2080,
    139,
    '模拟（填空）',
    '在单元测试中常用 unittest.mock 的 __1__ 来替换依赖对象。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "from unittest.mock import "}, {"type": "slot", "index": 0}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "with "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(module, \\"name\\") as m:"}]}]}',
    JSON_ARRAY('patch', 'Mock', 'MagicMock', 'create_autospec'),
    JSON_ARRAY(1),
    'patch 可临时替换对象或函数以隔离测试环境。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2081,
    139,
    '测试顺序依赖',
    '为什么应避免测试间相互依赖？',
    JSON_OBJECT('A', '会导致难以定位失败且不可重现', 'B', '可提升性能', 'C', '仅在 CI 中发生', 'D', '提高可读性'),
    1,
    JSON_ARRAY('提示1: 每个测试应独立', '提示2: 独立性有利于并行执行', '提示3: 使用 fixture 管理共享资源'),
    '测试应当独立，避免顺序依赖以确保可重复和可并行运行。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2082,
    139,
    '集成 CI',
    '将测试集成到 CI 的好处是？',
    JSON_OBJECT('A', '自动化回归检测，及时发现问题', 'B', '减少代码审查需求', 'C', '避免任何 bug', 'D', '替代代码风格检查'),
    1,
    JSON_ARRAY('提示1: CI 在提交或 PR 时跑测试', '提示2: 可与覆盖率和 lint 集成', '提示3: 提升交付质量'),
    'CI 自动化执行测试有助于早期发现问题并保证代码质量。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2083,
    139,
    '断言信息（填空）',
    '在断言失败时提供有意义的信息可帮助调试，例如 assert x==y, "__1__"。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "assert x==y, \\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\""}]}]}',
    JSON_ARRAY('mismatch', 'ok', 'pass', 'done'),
    JSON_ARRAY(1),
    '在断言中添加有意义的信息有助于快速定位失败原因。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2084,
    139,
    '清理资源（填空）',
    '在 unittest 中用于测试后清理的方法名为 __1__。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "class T(unittest.TestCase):"}, {"type": "slot", "index": 0}, {"type": "code", "value": "    def "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(self):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        pass"}]}]}',
    JSON_ARRAY('tearDown', 'setUp', 'cleanup', 'finish'),
    JSON_ARRAY(1),
    'tearDown 在每个测试方法后执行用于清理资源。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2085,
    139,
    '总结（填空）',
    '单元测试有助于防止 __1__，pytest 提供 __2__ 风格的断言写法。',
    NULL,
    NULL,
    '{"segments": []}',
    JSON_ARRAY('回归', '简洁', '性能', '文档'),
    JSON_ARRAY(1, 2),
    '测试帮助防止回归，pytest 提供简洁的断言语法。',
    ''
);