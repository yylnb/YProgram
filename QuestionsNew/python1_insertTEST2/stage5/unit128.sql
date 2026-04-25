USE `questions`;
-- Unit 128 | Start ID: 1906
-- Generated at 2025-12-24 23:37:33

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1906, 
    128, 
    '模块的定义', 
    'Python 模块通常指什么？', 
    JSON_OBJECT('A', '单个 .py 文件', 'B', '目录', 'C', '二进制文件', 'D', '虚拟环境'), 
    1, 
    JSON_ARRAY('提示1：模块是可导入的 Python 文件', '提示2：包是包含 __init__.py 的目录', '提示3：模块提供函数和类'), 
    '模块通常是一个 .py 文件，包含可复用的代码。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1907, 
    128, 
    '包的含义', 
    '什么是包（package）？', 
    JSON_OBJECT('A', '含有 __init__.py 的目录', 'B', '一个模块的别名', 'C', '虚拟环境的一部分', 'D', '只包含二进制扩展'), 
    1, 
    JSON_ARRAY('提示1：包用于组织模块', '提示2：可以有子包', '提示3: 早期需要 __init__.py'), 
    '包是一个包含模块和子包的目录，传统上带有 __init__.py 文件。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1908, 
    128, 
    '相对导入', 
    '在包内使用相对导入时，单个点（.）表示什么？', 
    JSON_OBJECT('A', '当前包', 'B', '父包', 'C', '根包', 'D', '模块本身'), 
    1, 
    JSON_ARRAY('提示1：.. 表示父包', '提示2：相对导入依赖包结构', '提示3：仅在包内有效'), 
    '单个点表示当前包，两个点表示父包。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1909,
    128,
    '模块别名（填空）',
    '导入模块并使用别名，可以写成 import math as __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "import math as "}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(__1__.pi)"}]}]}',
    JSON_ARRAY('m', 'math', 'pi', 'mathpi'),
    JSON_ARRAY(1),
    '可以用短别名（例如 m）来引用模块。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1910,
    128,
    '__all__ 用法（填空）',
    '在模块中定义 __all__ 可以控制 from module import * 时导入的 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "__all__ = ["}, {"type": "slot", "index": 0}, {"type": "code", "value": "]"}]}]}',
    JSON_ARRAY('"names"', '"__all__"', '"*"', '"module"'),
    JSON_ARRAY(1),
    '__all__ 列表控制 star 导入时哪些名字会被导入。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1911, 
    128, 
    '避免循环导入', 
    '下面哪种做法可以减少循环导入问题？', 
    JSON_OBJECT('A', '延迟导入（放在函数内部）', 'B', '在模块顶层相互导入', 'C', '使用 from module import *', 'D', '删除 __init__.py'), 
    1, 
    JSON_ARRAY('提示1：延迟导入仅在需要时导入', '提示2：重构公共依赖到独立模块', '提示3：循环导入常见错误来源'), 
    '延迟导入或重构模块可以避免或缓解循环依赖问题。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1912, 
    128, 
    '包初始化', 
    '早期的 Python 包需要哪个文件来标识包目录？', 
    JSON_OBJECT('A', '__init__.py', 'B', 'setup.py', 'C', 'requirements.txt', 'D', 'pyproject.toml'), 
    1, 
    JSON_ARRAY('提示1：__init__.py 可包含包初始化代码', '提示2：现代导包机制有所演进', '提示3：仍可使用 __init__.py 来暴露接口'), 
    '__init__.py 用于初始化包并在导入时执行相关代码。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1913, 
    128, 
    '模块搜索路径', 
    'Python 在导入模块时从哪里查找模块？', 
    JSON_OBJECT('A', 'sys.path 列表所列路径', 'B', '操作系统 PATH 环境变量', 'C', '当前用户主目录', 'D', '随机路径'), 
    1, 
    JSON_ARRAY('提示1：sys.path 包含脚本目录和 site-packages', '提示2：可以在运行时修改 sys.path', '提示3：虚拟环境影响路径'), 
    '导入时 Python 会按 sys.path 顺序查找模块。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1914,
    128,
    '模块别名导入（填空）',
    '从模块导入特定名称: from math import __1__',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "from math import "}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(__1__)"}]}]}',
    JSON_ARRAY('pi', 'math', 'sin', '*'),
    JSON_ARRAY(1),
    'from math import pi 可以直接使用 pi 名称。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1915,
    128,
    '相对导入语法（填空）',
    '在包内部，要导入当前包的 sibling 模块，用法示例: from . import __1__',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "from . import "}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}]}',
    JSON_ARRAY('sibling', 'parent', 'module', 'package'),
    JSON_ARRAY(1),
    '使用 . 表示当前包，从而导入同一包的其他模块。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1916, 
    128, 
    '动态导入', 
    '若需在运行时按名字导入模块，应使用哪个函数？', 
    JSON_OBJECT('A', '__import__ 或 importlib.import_module', 'B', 'execfile', 'C', 'open', 'D', 'eval'), 
    1, 
    JSON_ARRAY('提示1：importlib.import_module 是推荐方式', '提示2：__import__ 是内建函数', '提示3：避免使用 exec 导入代码'), 
    '可以使用 importlib.import_module 按字符串导入模块。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1917, 
    128, 
    '包的相对导入限制', 
    '相对导入在下列哪种情况下不可用？', 
    JSON_OBJECT('A', '直接以脚本方式运行包内部模块', 'B', '作为包被导入时', 'C', '在测试环境中', 'D', '在虚拟环境中'), 
    1, 
    JSON_ARRAY('提示1：直接运行模块会使其 __name__ 为 "__main__"', '提示2：相对导入依赖包上下文', '提示3：将包作为模块运行更合适'), 
    '直接以脚本运行包内模块导致包上下文丢失，从而无法使用相对导入。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1918, 
    128, 
    '包的组织', 
    '推荐如何组织大型项目的模块与包？', 
    JSON_OBJECT('A', '按功能拆分成清晰的包和子包', 'B', '把所有代码放在一个模块里', 'C', '每个文件只放一个函数', 'D', '随意放置无结构'), 
    1, 
    JSON_ARRAY('提示1：按功能分组有助于可维护性', '提示2：明确接口导出', '提示3：使用 __init__.py 暴露 API'), 
    '按功能组织包有利于扩展和维护，避免耦合过高。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1919,
    128,
    '安装包（填空）',
    '要发布 Python 包，常用工具之一是 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('setuptools', 'pip', 'git', 'docker'),
    JSON_ARRAY(1),
    'setuptools 是常见的打包工具，现代可配合 pyproject.toml 使用。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1920,
    128,
    '总结（填空）',
    '模块是一份 __1__，包是 __2__ 的集合。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('py 文件', '模块', '目录', '包'),
    JSON_ARRAY(1, 2),
    '模块通常是单个 .py 文件，包是模块或子包的组织结构。',
    ''
);