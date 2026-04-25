USE `questions`;
-- Unit 129 | Start ID: 1921
-- Generated at 2025-12-24 23:37:35

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1921, 
    129, 
    '打开文件模式', 
    '以写入模式打开文件应使用哪个模式字符串？', 
    JSON_OBJECT('A', 'w', 'B', 'r', 'C', 'a', 'D', 'x'), 
    1, 
    JSON_ARRAY('提示1：w 会覆盖文件', '提示2：a 为追加', '提示3：r 为只读'), 
    '使用 "w" 模式打开文件会覆盖或创建新文件以供写入。', 
    'open("f.txt","w")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1922, 
    129, 
    'with 上下文管理', 
    '使用 with open(...) as f 的好处是？', 
    JSON_OBJECT('A', '自动关闭文件并管理资源', 'B', '提高文件读写速度', 'C', '使文件变为只读', 'D', '文件永不关闭'), 
    1, 
    JSON_ARRAY('提示1：上下文管理器自动处理清理', '提示2：避免忘记 close', '提示3：推荐用于文件操作'), 
    'with 语句确保退出上下文时文件被正确关闭，避免资源泄漏。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1923, 
    129, 
    '读取整文件', 
    '要一次性读取整个文件文本，应使用哪个方法？', 
    JSON_OBJECT('A', 'read()', 'B', 'readline()', 'C', 'readlines()', 'D', 'iterfile()'), 
    1, 
    JSON_ARRAY('提示1：read 返回整个字符串', '提示2：readline 返回一行', '提示3：readlines 返回行列表'), 
    'f.read() 会返回文件全部内容的字符串。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1924,
    129,
    '写入文件（填空）',
    '向文件写入字符串应调用 f.__1__(s)。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "with open(\"a.txt\",\"w\") as f:"}, {"type": "code_line", "value": "    f.__1__(\"hello\")"}]}]}',
    JSON_ARRAY('write', 'writelines', 'read', 'readline'),
    JSON_ARRAY(1),
    '使用 write 方法向文件写入字符串。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1925,
    129,
    '二进制模式（填空）',
    '若要以二进制方式读取文件，应使用模式 "__1__"。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "with open(\"b.bin\",\"__1__\") as f:"}, {"type": "code_line", "value": "    data = f.read()"}]}]}',
    JSON_ARRAY('rb', 'r', 'wb', 'w'),
    JSON_ARRAY(1),
    '在模式中加入 b 表示二进制读写，例如 "rb"。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1926, 
    129, 
    '文件指针', 
    'f.seek(0) 的作用是什么？', 
    JSON_OBJECT('A', '将文件指针移动到开头', 'B', '关闭文件', 'C', '清空文件内容', 'D', '追加数据'), 
    1, 
    JSON_ARRAY('提示1：seek 可移动指针', '提示2：seek(0) 回到开头', '提示3：read 从指针处开始读'), 
    'seek(0) 将文件指针移动到文件开头位置。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1927, 
    129, 
    '文本编码', 
    '打开文件并指定 UTF-8 编码应写成？', 
    JSON_OBJECT('A', 'open("f.txt","r", encoding="utf-8")', 'B', 'open("f.txt","r",encode="utf-8")', 'C', 'open("f.txt","rb")', 'D', 'open("f.txt","r", mode="utf-8")'), 
    1, 
    JSON_ARRAY('提示1：参数名为 encoding', '提示2：二进制模式不使用 encoding', '提示3：推荐显式指定编码'), 
    '使用 encoding 参数可指定文本编码，如 UTF-8。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1928, 
    129, 
    '异常处理', 
    '在文件操作中，为了确保文件关闭，除了 with 还可以在 finally 中做什么？', 
    JSON_OBJECT('A', '调用 f.close()', 'B', '抛出异常', 'C', '调用 exit()', 'D', '递归调用函数'), 
    1, 
    JSON_ARRAY('提示1：finally 块用于清理', '提示2：在异常路径也会执行', '提示3：close 释放资源'), 
    '在 finally 中调用 close() 可确保文件资源被释放。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1929,
    129,
    '逐行读取（填空）',
    '遍历文件对象 for line in f: 可以逐行读取，等价于使用 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "with open(\"f.txt\") as f:"}, {"type": "code_line", "value": "    for line in f:"}, {"type": "code_line", "value": "        print(line)"}]}]}',
    JSON_ARRAY('readline', 'read', 'readlines', 'seek'),
    JSON_ARRAY(1),
    '文件迭代器内部使用 readline 来逐行读取。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1930,
    129,
    '写入多行（填空）',
    '将行列表写入文件可使用 f.__1__(lines)。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lines = [\"a\\n\",\"b\\n\"]"}, {"type": "code_line", "value": "with open(\"out.txt\",\"w\") as f:"}, {"type": "code_line", "value": "    f.__1__(lines)"}]}]}',
    JSON_ARRAY('writelines', 'write', 'writeall', 'writeline'),
    JSON_ARRAY(1),
    'writelines 接受一个字符串序列并写入文件(不自动加换行)。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1931, 
    129, 
    '二进制读写', 
    '读取二进制文件时返回的类型是？', 
    JSON_OBJECT('A', 'bytes', 'B', 'str', 'C', 'list', 'D', 'bytearray'), 
    1, 
    JSON_ARRAY('提示1：rb 返回 bytes', '提示2：wb 接受 bytes', '提示3：可用 bytearray 转换'), 
    '以二进制模式读取文件会返回 bytes 对象。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1932, 
    129, 
    'JSON 文件', 
    '要读写 JSON 文件通常使用哪个模块？', 
    JSON_OBJECT('A', 'json', 'B', 'csv', 'C', 'pickle', 'D', 'xml'), 
    1, 
    JSON_ARRAY('提示1：json.load 和 json.dump', '提示2：csv 用于逗号分隔数据', '提示3：pickle 用于 Python 特有序列化'), 
    'json 模块用于序列化和反序列化 JSON 数据到文件。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1933, 
    129, 
    '临时文件', 
    '创建临时文件应使用哪个模块？', 
    JSON_OBJECT('A', 'tempfile', 'B', 'os', 'C', 'sys', 'D', 'shutil'), 
    1, 
    JSON_ARRAY('提示1：tempfile 提供安全的临时文件/目录', '提示2：避免在根目录手动创建临时文件', '提示3：常用 TemporaryFile, NamedTemporaryFile'), 
    'tempfile 模块用于创建安全的临时文件或目录。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1934,
    129,
    '权限错误（填空）',
    '尝试写入只读文件会抛出 __1__ 异常。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('PermissionError', 'FileNotFoundError', 'ValueError', 'TypeError'),
    JSON_ARRAY(1),
    '写入受限文件通常会抛出 PermissionError。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1935,
    129,
    '总结（填空）',
    '文本模式读写返回 __1__，二进制模式返回 __2__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('str', 'bytes', 'list', 'dict'),
    JSON_ARRAY(1, 2),
    '文本模式读写返回字符串，二进制模式返回字节序列。',
    ''
);