USE `questions`;
-- Unit 141 | Start ID: 2101
-- Generated at 2025-12-25 17:41:15

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2101,
    141,
    'SQLite 的特点',
    '关于 SQLite，下列哪项描述更准确？',
    JSON_OBJECT('A', '轻量级的嵌入式数据库，适合单进程应用', 'B', '分布式数据库，适合集群部署', 'C', '只能用于内存数据库', 'D', '需要独立服务器进程'),
    1,
    JSON_ARRAY('提示1：SQLite 是文件型数据库', '提示2：无需单独服务进程', '提示3：适合小型项目和测试'),
    'SQLite 是嵌入式、文件型数据库，适合单进程或小型应用。',
    'import sqlite3
conn = sqlite3.connect("db.sqlite")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2102,
    141,
    '连接与游标',
    '在使用 sqlite3 时，通常通过哪个对象执行 SQL？',
    JSON_OBJECT('A', 'cursor', 'B', 'engine', 'C', 'session', 'D', 'connector'),
    1,
    JSON_ARRAY('提示1：先 conn.cursor()', '提示2：cursor.execute 执行 SQL', '提示3：fetchone/fetchall 获取结果'),
    '使用 conn.cursor() 获取游标，通过 cursor.execute 执行 SQL。',
    'c = conn.cursor()
c.execute("SELECT 1")
print(c.fetchone())'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2103,
    141,
    '参数化查询',
    '为了避免 SQL 注入，应使用哪种方式传递参数？',
    JSON_OBJECT('A', '参数化查询（占位符和参数）', 'B', '字符串拼接', 'C', '格式化 SQL 文件', 'D', '动态 eval'),
    1,
    JSON_ARRAY('提示1：不要直接拼接用户输入', '提示2：sqlite3 支持 ? 占位符', '提示3：参数化可自动转义'),
    '使用参数化查询可以防止注入并正确转换参数类型。',
    'c.execute("SELECT * FROM t WHERE id=?", (id_val,))'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2104,
    141,
    '提交事务（填空）',
    '对数据库修改后需要调用 __1__ 提交事务以保存更改。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "conn = sqlite3.connect(\\"db.sqlite\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "c = conn.cursor()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "c.execute(\\"INSERT INTO t VALUES (1)\\")"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('conn.commit()', 'conn.close()', 'c.commit()', 'conn.rollback()'),
    JSON_ARRAY(1),
    'conn.commit() 用于提交事务，保存对数据库的修改。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2105,
    141,
    '关闭连接（填空）',
    '完成数据库操作后应调用 __1__ 释放资源。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "conn = sqlite3.connect(\\"db.sqlite\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# ..."}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('conn.close()', 'conn.commit()', 'c.close()', 'del conn'),
    JSON_ARRAY(1),
    'conn.close() 用于关闭连接并释放资源。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2106,
    141,
    '事务回滚',
    '当执行 SQL 过程中出现异常时，为了回退更改应调用？',
    JSON_OBJECT('A', 'conn.rollback()', 'B', 'conn.commit()', 'C', 'conn.close()', 'D', 'raise'),
    1,
    JSON_ARRAY('提示1：rollback 恢复到上次提交状态', '提示2：通常在 except 块中调用', '提示3：避免部分提交导致不一致'),
    'conn.rollback() 用于回滚事务以撤销未提交的更改。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2107,
    141,
    'schema 定义',
    '创建表结构通常使用哪个 SQL 语句？',
    JSON_OBJECT('A', 'CREATE TABLE', 'B', 'INSERT INTO', 'C', 'UPDATE', 'D', 'SELECT'),
    1,
    JSON_ARRAY('提示1：CREATE TABLE 定义列与类型', '提示2：首次建立数据库需要建表', '提示3：可添加 PRIMARY KEY'),
    '使用 CREATE TABLE 来定义表和列的结构。',
    'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2108,
    141,
    'SQLite 类型系统',
    'SQLite 的列类型系统最显著的特点是？',
    JSON_OBJECT('A', '类型亲和性（type affinity）较宽松', 'B', '强类型严格匹配', 'C', '不支持字符串', 'D', '仅支持二进制'),
    1,
    JSON_ARRAY('提示1：可将任意类型写入列', '提示2：SQLite 会尝试做类型转换', '提示3：适合快速开发'),
    'SQLite 使用类型亲和性模型，类型约束比关系型数据库宽松。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2109,
    141,
    '参数占位符（填空）',
    'sqlite3 模块中参数占位符通常使用字符 __1__。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "c.execute(\\"SELECT * FROM t WHERE id="}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\", (1,))"}]}]}',
    JSON_ARRAY('?', '%s', ':1', '{}'),
    JSON_ARRAY(1),
    'sqlite3 使用 ? 占位符来参数化查询。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2110,
    141,
    '行游标读取（填空）',
    '执行查询后使用 cursor.__1__() 获取所有行。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "c.execute(\\"SELECT * FROM t\\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "rows = c."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}]}',
    JSON_ARRAY('fetchall', 'fetchone', 'fetchmany', 'read'),
    JSON_ARRAY(1),
    'fetchall 返回所有结果行的列表。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2111,
    141,
    '持久化存储',
    'SQLite 数据库文件通常存放在哪里？',
    JSON_OBJECT('A', '磁盘文件', 'B', '仅内存', 'C', '远程服务器', 'D', '浏览器本地存储'),
    1,
    JSON_ARRAY('提示1：通过文件路径连接', '提示2：可为 ":memory:" 使用内存数据库', '提示3：文件易于备份'),
    'SQLite 使用磁盘文件来持久化数据，或通过特殊路径使用内存数据库。',
    ''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2112,
    141,
    '并发写入限制',
    'SQLite 在高并发写入场景下一般会如何表现？',
    JSON_OBJECT('A', '写操作会被串行化，可能成为瓶颈', 'B', '写入自动分片', 'C', '无限并发写入', 'D', '拒绝写入'),
    1,
    JSON_ARRAY('提示1：SQLite 在写锁时串行化写操作', '提示2：适合读多写少场景', '提示3：可通过 WAL 提高并发读写'),
    'SQLite 在写操作上会串行化，适合读多写少的用例。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2113,
    141,
    '内存数据库（填空）',
    '创建内存 SQLite 数据库可使用连接字符串 "__1__"。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "conn = sqlite3.connect(\\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\")"}]}]}',
    JSON_ARRAY(':memory:', 'memory:', '/tmp/db', 'memory'),
    JSON_ARRAY(1),
    '使用 ":memory:" 可创建仅内存的 SQLite 数据库实例。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2114,
    141,
    '备份数据库（填空）',
    '要制作 SQLite 数据库的在线备份，可使用 connection.__1__() API（或 sqlite3 的 backup 方法）。',
    NULL,
    NULL,
    '{"segments": []}',
    JSON_ARRAY('backup', 'copy', 'dump', 'export'),
    JSON_ARRAY(1),
    'sqlite3 提供 backup 方法来增量或完整备份数据库。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2115,
    141,
    '总结（填空）',
    'SQLite 适合 __1__ 场景，但在高并发写场景应考虑 __2__。',
    NULL,
    NULL,
    '{"segments": []}',
    JSON_ARRAY('嵌入式/轻量', '分布式数据库', '高吞吐', '实时流处理'),
    JSON_ARRAY(1, 2),
    'SQLite 适合嵌入式或轻量场景；高并发写场景可考虑服务器型数据库或分片方案。',
    ''
);