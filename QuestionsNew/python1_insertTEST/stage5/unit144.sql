USE `questions`;
-- Unit 144 | Start ID: 2146
-- Generated at 2025-12-24 18:24:16

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2146, 
    144, 
    '打开文件模式', 
    '在 open() 中使用 "r" 表示什么？', 
    JSON_OBJECT('A', '只读模式', 'B', '写入模式', 'C', '追加模式', 'D', '二进制模式'), 
    1, 
    JSON_ARRAY('提示1：默认是文本模式只读', '提示2：写入为 w', '提示3：追加为 a'), 
    '"r" 表示以只读模式打开文件。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2147, 
    144, 
    '上下文管理', 
    '使用 with open(...) as f 的优点是？', 
    JSON_OBJECT('A', '自动关闭文件并处理异常', 'B', '提高写入速度', 'C', '加密文件', 'D', '延迟打开'), 
    1, 
    JSON_ARRAY('提示1：确保资源释放', '提示2：with 是上下文管理', '提示3：常用于文件读写'), 
    'with 上下文可在块结束时自动关闭文件，避免资源泄露。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2148, 
    144, 
    '写入文本', 
    '要写入文本到文件应使用哪种模式？', 
    JSON_OBJECT('A', 'w 或 a', 'B', 'r', 'C', 'rb', 'D', 'rt'), 
    1, 
    JSON_ARRAY('提示1：w 会覆盖原文件', '提示2：a 追加内容', '提示3：二进制使用 b'), 
    '写入使用 w（覆盖）或 a（追加），可结合 b 指定二进制。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2149, 
    144, 
    'seek 与 tell', 
    '文件对象的 tell() 用于？', 
    JSON_OBJECT('A', '返回当前文件指针位置', 'B', '移动文件指针', 'C', '关闭文件', 'D', '读取下一行'), 
    1, 
    JSON_ARRAY('提示1：seek 用于移动', '提示2：tell 返回偏移量', '提示3：常与 seek 配合使用'), 
    'tell 返回当前字节偏移位置，seek 用于移动指针。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2150, 
    144, 
    '临时文件', 
    '创建临时文件常用哪个模块？', 
    JSON_OBJECT('A', 'tempfile', 'B', 'os', 'C', 'shutil', 'D', 'glob'), 
    1, 
    JSON_ARRAY('提示1：tempfile.NamedTemporaryFile', '提示2：提供安全临时文件', '提示3：适合测试用例'), 
    'tempfile 模块用于创建安全的临时文件和临时目录。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2151, 
    144, 
    '大文件处理', 
    '处理大文件时推荐的做法是？', 
    JSON_OBJECT('A', '逐行处理或按块读取以节省内存', 'B', '一次性读入内存', 'C', '把文件拆成单个字符处理', 'D', '使用 eval 解析'), 
    1, 
    JSON_ARRAY('提示1：流式处理可降低内存', '提示2：使用 for line in f', '提示3：可用 read(size) 分块读'), 
    '对于大文件，应使用迭代或分块读取避免 OOM。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2152, 
    144, 
    '二进制读写', 
    '读取图片或二进制文件应使用哪种模式？', 
    JSON_OBJECT('A', 'rb', 'B', 'r', 'C', 'rt', 'D', 'w'), 
    1, 
    JSON_ARRAY('提示1：二进制模式避免字符解码', '提示2：写入二进制使用 wb', '提示3：文本模式可能导致数据损坏'), 
    '二进制文件需使用 rb/wb 模式以免编码转换。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2153, 
    144, 
    '临时目录', 
    '创建临时目录可使用哪个函数？', 
    JSON_OBJECT('A', 'tempfile.mkdtemp', 'B', 'os.mkdir', 'C', 'shutil.rmtree', 'D', 'open'), 
    1, 
    JSON_ARRAY('提示1：mkdtemp 返回目录路径', '提示2：适合需要临时目录的场景', '提示3：需要手动清理'), 
    'tempfile.mkdtemp 创建唯一的临时目录，返回路径。', 
    ''
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2154,
    144,
    '读取整文件（填空）',
    '要读取整个文件内容可使用 f.__1__()',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "with open(\"a.txt\") as f:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    data = f."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}]}',
    JSON_ARRAY('read', 'readline', 'readlines', 'iter'),
    JSON_ARRAY(1),
    'f.read() 返回整个文件的内容字符串。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2155,
    144,
    '逐行迭代（填空）',
    '在文件对象上直接使用 for line in f 将按 __1__ 读取行。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "with open(\"a.txt\") as f:"}, {"type": "code_line", "value": "    for line in f:"}, {"type": "code_line", "value": "        print(line)"}]}]}',
    JSON_ARRAY('逐行', '整体', '二进制', '固定块'),
    JSON_ARRAY(1),
    '文件对象是可迭代的，按行返回，适合大文件流式处理。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2156,
    144,
    '二进制模式（填空）',
    '打开二进制文件需在模式中包含 __1__ 字母，如 "rb" 或 "wb"。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "with open(\"a.bin\", \""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\") as f:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    b = f.read()"}]}]}',
    JSON_ARRAY('b', 't', 'r', 'w'),
    JSON_ARRAY(1),
    'b 表示二进制模式，t 表示文本（默认）。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2157,
    144,
    '文件编码（填空）',
    '打开文本文件时常用参数 encoding="__1__" 指定编码。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "with open(\"a.txt\",\"r\", encoding=\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\") as f:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    data = f.read()"}]}]}',
    JSON_ARRAY('utf-8', 'gbk', 'ascii', 'latin-1'),
    JSON_ARRAY(1),
    'utf-8 是常用的文本编码，跨平台兼容性好。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2158,
    144,
    '写入并刷新（填空）',
    '写入后若需立刻把缓冲区内容写入磁盘可调用 f.__1__().',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "f.write(\"a\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "f."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}]}',
    JSON_ARRAY('flush', 'close', 'sync', 'commit'),
    JSON_ARRAY(1),
    'f.flush() 会把缓冲区内容刷新到底层文件描述符，但并不保证同步到物理磁盘。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2159,
    144,
    'shutil 复制（填空）',
    '复制文件可以使用 shutil.__1__(src, dst)。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import shutil"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "shutil."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"a.txt\",\"b.txt\")"}]}]}',
    JSON_ARRAY('copy', 'move', 'rmtree', 'copytree'),
    JSON_ARRAY(1),
    'shutil.copy 可以把文件从 src 复制到 dst。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2160,
    144,
    '总结（填空）',
    '处理文件时要注意 __1__、编码和资源释放。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('异常处理', '速度', '颜色', '样式'),
    JSON_ARRAY(1),
    '异常处理、指定编码与正确关闭文件是文件 I/O 的关键。',
    ''
);