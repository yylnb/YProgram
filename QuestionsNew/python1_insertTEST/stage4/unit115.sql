USE `questions`;
-- Unit 115 | Start ID: 1711
-- Generated at 2025-12-24 18:16:23

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1711, 
    115, 
    '逐行读取效率', 
    '使用 for line in open(file) 逐行读取大文件的优点是？', 
    JSON_OBJECT('A', '惰性读取，节省内存', 'B', '一次性载入全部文件', 'C', '随机访问更快', 'D', '自动并行读取'), 
    1, 
    JSON_ARRAY('提示1：迭代器按需读取', '提示2: 适合大文件流式处理', '提示3: 减少内存占用'), 
    '文件对象是迭代器，按行读取能避免一次性将整个文件加载到内存。', 
    'for line in open(\'big.txt\'): process(line)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1712, 
    115, 
    '缓冲区大小影响', 
    '增大文件读取缓冲区通常会怎样？', 
    JSON_OBJECT('A', '减少系统调用次数，提高吞吐量', 'B', '增加系统调用', 'C', '降低吞吐量', 'D', '无法影响性能'), 
    1, 
    JSON_ARRAY('提示1：每次系统调用有开销', '提示2: 较大缓冲区可减少调用次数', '提示3: 但过大会增大内存占用'), 
    '合理增大缓冲区能减少 I/O 系统调用次数，提高读取性能，但需权衡内存使用。', 
    'open(\'f\',\'r\', buffering=8192)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1713, 
    115, 
    '写入缓冲', 
    '频繁小块写入文件时，哪种做法更高效？', 
    JSON_OBJECT('A', '将数据积累到内存缓冲后一次写入', 'B', '每次都调用 write 并 flush', 'C', '打开多个文件并并行写入', 'D', '使用 print 每次换行'), 
    1, 
    JSON_ARRAY('提示1：减少系统调用次数', '提示2: flush 每次都会触发写操作', '提示3: 批量写入更高效'), 
    '缓冲并批量写入可减少系统调用，提高写入吞吐量。', 
    'buf.append(chunk)\nout.write(\'\'.join(buf))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1714, 
    115, 
    '二进制块读写', 
    '处理二进制大文件（如图像或视频）应优先采用哪种读写方式？', 
    JSON_OBJECT('A', '以二进制模式并使用合适的块大小读取', 'B', '以文本模式逐字符读取', 'C', '使用 json', 'D', '逐个字节写入'), 
    1, 
    JSON_ARRAY('提示1：二进制模式避免解码开销', '提示2: 合理块大小减少系统调用', '提示3: 文本模式不适合二进制'), 
    '以二进制模式按块读写能提高 I/O 效率并避免不必要的解码/编码。', 
    'with open(\'v\',\'rb\') as f:\n  while True:\n    b = f.read(8192)\n    if not b: break'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1715, 
    115, 
    '使用 mmap', 
    '对于超大文件但需要随机访问的场景，哪种技术可减少内存复制并加速访问？', 
    JSON_OBJECT('A', 'mmap（内存映射文件）', 'B', '全部读入内存', 'C', '逐行读', 'D', '复制到数据库'), 
    1, 
    JSON_ARRAY('提示1：mmap 将文件映射到内存页', '提示2: 操作系统负责页面调度', '提示3: 减少显式复制'), 
    'mmap 可将文件映射为内存区域，实现高效随机访问且减少复制开销。', 
    'import mmap\nwith open(\'f\',\'rb\') as f:\n  m = mmap.mmap(f.fileno(),0)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1716, 
    115, 
    '压缩 I/O', 
    '在写入大文本并节省磁盘时，使用压缩库（如 gzip）通常会怎样影响性能？', 
    JSON_OBJECT('A', '降低磁盘占用但增加 CPU 开销', 'B', '提高磁盘占用', 'C', '完全无额外开销', 'D', '减少 CPU 使用'), 
    1, 
    JSON_ARRAY('提示1：压缩需要 CPU 处理', '提示2: 可减少 I/O 量', '提示3: 综合权衡 CPU 与 I/O'), 
    '压缩写入能减少磁盘与传输数据量，但会增加压缩/解压缩的 CPU 成本。', 
    'import gzip\nwith gzip.open(\'f.gz\',\'wt\') as g: g.write(text)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1717, 
    115, 
    '异步 I/O', 
    '当处理大量并发文件 I/O 时，使用异步 I/O 的优势是？', 
    JSON_OBJECT('A', '提高并发吞吐量，减少线程开销', 'B', '自动加速 CPU 运算', 'C', '降低 I/O 延迟到 0', 'D', '消除磁盘瓶颈'), 
    1, 
    JSON_ARRAY('提示1：异步 I/O 能在等待 I/O 时切换任务', '提示2: 减少线程上下文切换成本', '提示3: 适合大量并发 I/O'), 
    '异步 I/O 可在高并发 I/O 场景下提高吞吐，但仍受底层设备限制。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1718, 
    115, 
    '临时文件', 
    '当需要中间存储大数据但内存不足时应优先使用？', 
    JSON_OBJECT('A', '临时文件（tempfile）并按需读写', 'B', '全部保存在内存', 'C', '多次网络传输', 'D', '嵌入数据库'), 
    1, 
    JSON_ARRAY('提示1：临时文件可使用磁盘空间作为备用', '提示2: 注意清理与性能', '提示3: 适合溢出保护'), 
    '使用临时文件可以在内存不足时将中间数据持久化到磁盘，作为可控的折中方案。', 
    'import tempfile\nwith tempfile.TemporaryFile() as tf: pass'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1719,
    115,
    '文本 vs 二进制（填空）',
    '以文本模式打开文件与二进制模式在性能上通常的差别是什么？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"二进制略快，文本需解码\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '文本模式需进行字符解码/换行转换，二进制模式通常略快且更直接。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1720,
    115,
    'seek 成本（填空）',
    '在文件中频繁随机 seek 的成本通常为？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"高，取决于存储设备的寻道时间\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '随机 seek 在磁盘上代价显著（机械驱动），在 SSD 上较好但仍有开销。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1721,
    115,
    '文本编码（填空）',
    '写入文本文件时指定正确编码的好处是什么？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"避免编码错误并保证跨平台一致性\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '指定编码可避免不同平台或默认编码导致的兼容性与错误问题。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1722,
    115,
    'flush 调用（填空）',
    '频繁调用 flush() 有何影响？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"增加系统调用，降低写入效率\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '每次 flush 会触发底层写操作，频繁调用会降低吞吐量。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1723,
    115,
    '二进制拼接（填空）',
    '拼接大量二进制块时应优先使用？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"先收集到 list 再 b\'\'.join(list)\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '多次小写入会导致多次系统调用，先收集再 join 更高效。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1724,
    115,
    '总结（填空）',
    '读写大文件的常见优化点包括？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"合理缓冲、按块读写、使用二进制或 mmap\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '优化策略包括合适缓冲、避免小而频繁的系统调用、优先二进制或 mmap 等。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1725,
    115,
    '实践建议（填空）',
    '在文件 I/O 优化前应先做什么？',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"进行基准测试并定位瓶颈\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '在优化前应通过基准测试和测量定位真实瓶颈，避免盲目优化。',
    ''
);