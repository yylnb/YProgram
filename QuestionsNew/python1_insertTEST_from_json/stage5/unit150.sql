USE `questions`;
-- Unit 150 | Start ID: 2236
-- Generated at 2025-12-25 17:41:15

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2236,
    150,
    '虚拟环境',
    '创建隔离 Python 环境常用哪个工具？',
    JSON_OBJECT('A', 'venv', 'B', 'pip', 'C', 'virtualenvwrapper', 'D', 'easy_install'),
    1,
    JSON_ARRAY('提示1：venv 是标准库提供', '提示2：virtualenv 也是常用工具'),
    'venv 可创建项目级别虚拟环境以隔离依赖。',
    'python -m venv venv'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2237,
    150,
    'pip freeze',
    'pip freeze 的典型用途是？',
    JSON_OBJECT('A', '生成当前环境依赖清单', 'B', '卸载包', 'C', '搜索包', 'D', '升级 pip'),
    1,
    JSON_ARRAY('提示1：常与 requirements.txt 配合使用'),
    'pip freeze 列出已安装包及版本，常写入 requirements.txt。',
    'pip freeze > requirements.txt'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2238,
    150,
    '隔离原因',
    '为什么使用虚拟环境？',
    JSON_OBJECT('A', '避免不同项目依赖冲突', 'B', '提高代码速度', 'C', '安全备份', 'D', '更好打印日志'),
    1,
    JSON_ARRAY('提示1：每个项目有独立依赖版本'),
    '虚拟环境确保项目依赖互不干扰，便于管理和部署。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2239,
    150,
    '安装包（填空）',
    '使用 pip 安装依赖的命令为 pip __1__ package_name。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "pip "}, {"type": "slot", "index": 0}, {"type": "code", "value": " package_name"}]}]}',
    JSON_ARRAY('install', 'remove', 'update', 'list'),
    JSON_ARRAY(1),
    'pip install 用于安装包。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2240,
    150,
    'requirements（填空）',
    '常用文件 __1__ 用来记录项目依赖以便重现环境。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "常用文件 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 用来记录项目依赖以便重现环境。"}]}]}',
    JSON_ARRAY('requirements.txt', 'Pipfile', 'pyproject.toml', 'setup.cfg'),
    JSON_ARRAY(1),
    'requirements.txt 是传统的依赖清单文件。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2241,
    150,
    'pyproject.toml',
    'pyproject.toml 的作用是？',
    JSON_OBJECT('A', '声明构建系统和项目元数据', 'B', '运行测试', 'C', '发布 Docker 镜像', 'D', '管理数据库'),
    1,
    JSON_ARRAY('提示1：PEP 518 定义该文件用途'),
    'pyproject.toml 用于描述构建依赖、打包与项目元数据，逐渐成为标准。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2242,
    150,
    '版本约束',
    '在 requirements.txt 中使用 == 表示什么？',
    JSON_OBJECT('A', '精确版本匹配', 'B', '最低版本', 'C', '排除版本', 'D', '任意版本'),
    1,
    JSON_ARRAY('提示1：推荐对部署使用精确版本或锁文件'),
    '== 表示需要精确某个版本号。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2243,
    150,
    '锁文件',
    'lock 文件（如 Pipfile.lock 或 poetry.lock）用于？',
    JSON_OBJECT('A', '锁定确切依赖版本以保证可重复安装', 'B', '记录项目许可证', 'C', '运行单元测试', 'D', '生成文档'),
    1,
    JSON_ARRAY('提示1：锁文件有助于在不同环境重现依赖树'),
    '锁文件记录确切版本，保证不同环境中安装一致。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2244,
    150,
    '本地安装（填空）',
    '使用 pip install -r __1__ 可按文件安装全部依赖。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "使用 pip install -r "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 可按文件安装全部依赖。"}]}]}',
    JSON_ARRAY('requirements.txt', 'Pipfile', 'setup.py', 'pyproject.toml'),
    JSON_ARRAY(1),
    'pip install -r requirements.txt 会逐行安装依赖。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2245,
    150,
    '本地安装用户目录（填空）',
    'pip install --user 会把包安装到用户的 __1__ 目录。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "pip install --user 会把包安装到用户的 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 目录。"}]}]}',
    JSON_ARRAY('site-packages', 'temp', 'etc', 'bin'),
    JSON_ARRAY(1),
    '安装到用户级别的 site-packages 而不是全局环境。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2246,
    150,
    '镜像源',
    '在中国大陆环境，常用哪个方式加速 pip 安装？',
    JSON_OBJECT('A', '使用镜像源（如清华/阿里）', 'B', '关闭网络', 'C', '使用 FTP', 'D', '编译 pip'),
    1,
    JSON_ARRAY('提示1：镜像源能显著加速下载'),
    '使用国内镜像源可提高下载速度和稳定性。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2247,
    150,
    '升级 pip（填空）',
    '升级 pip 常用命令 python -m pip __1__ pip. ',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "升级 pip 常用命令 python -m pip "}, {"type": "slot", "index": 0}, {"type": "code", "value": " pip. "}]}]}',
    JSON_ARRAY('install --upgrade', 'uninstall', 'list', 'show'),
    JSON_ARRAY(1),
    'python -m pip install --upgrade pip 用于升级 pip 工具。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2248,
    150,
    '卸载包（填空）',
    '卸载包使用 pip __1__ package_name.',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "卸载包使用 pip "}, {"type": "slot", "index": 0}, {"type": "code", "value": " package_name."}]}]}',
    JSON_ARRAY('uninstall', 'remove', 'delete', 'purge'),
    JSON_ARRAY(1),
    'pip uninstall 用于移除已安装的包。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2249,
    150,
    '打包分发（填空）',
    '现代 Python 打包常用工具包括 setuptools 和 __1__.',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "现代 Python 打包常用工具包括 setuptools 和 "}, {"type": "slot", "index": 0}, {"type": "code", "value": "."}]}]}',
    JSON_ARRAY('poetry', 'pipenv', 'virtualenv', 'distutils'),
    JSON_ARRAY(1),
    'poetry 提供依赖管理与打包发布一体化的现代工具链。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2250,
    150,
    '总结（填空）',
    '使用虚拟环境可以避免 __1__ 并保证依赖可控。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "使用虚拟环境可以避免 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 并保证依赖可控。"}]}]}',
    JSON_ARRAY('冲突', '速度', '存储', '权限'),
    JSON_ARRAY(1),
    '虚拟环境主要用于隔离依赖，避免不同项目间版本冲突。',
    ''
);