USE `questions`;
-- Unit 76 | Start ID: 1126
-- Generated at 2025-12-24 23:21:32

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1126, 
    76, 
    '逐行读取', 
    '按行读取大文件推荐？', 
    JSON_OBJECT('A', 'for line in f', 'B', 'f.read() 一次性', 'C', 'f.readlines() 然后遍历', 'D', '用 eval'), 
    1, 
    JSON_ARRAY('按行迭代内存友好', '避免一次性载入全文件'), 
    '使用文件对象按行迭代可节省内存并便捷处理每行数据。', 
    'with open(path) as f:
  for line in f:'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1127, 
    76, 
    '写入模式', 
    '写入新文件覆盖原文件模式是？', 
    JSON_OBJECT('A', 'w', 'B', 'r', 'C', 'a', 'D', 'x'), 
    1, 
    JSON_ARRAY('w 会覆盖', 'a 是追加'), 
    '以 "w" 模式打开会覆盖原文件。', 
    'open("out.txt","w")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1128, 
    76, 
    '逐行处理', 
    '在循环中处理文件行时应注意？', 
    JSON_OBJECT('A', '使用 strip 清理换行', 'B', '保留 \n 不做任何处理', 'C', '用 eval 转换每行', 'D', '用 input 读取'), 
    1, 
    JSON_ARRAY('strip 可去除换行与两端空白', '便于后续解析'), 
    '常对读取行使用 strip() 去除尾部换行及空白。', 
    'line=line.strip()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1129,
    76,
    '统计行数',
    '补全：统计文件行数。',
    'a
b
c',
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import sys"}, {"type": "code_line", "value": "lines=sys.stdin.read().splitlines()"}, {"type": "code_line", "value": "print(len(lines))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '读取所有行并统计长度可得到行数。',
    'sum(1 for _ in open(file))'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1130,
    76,
    '过滤空行',
    '补全：打印非空行。',
    'a

 b',
    JSON_ARRAY('a', 'b'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import sys"}, {"type": "code_line", "value": "for line in sys.stdin:"}, {"type": "code_line", "value": "    s=line.strip()"}, {"type": "code_line", "value": "    if s:"}, {"type": "code_line", "value": "        print(s)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'strip 后判断是否为空字符串用于过滤空行。',
    'if line.strip():'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1131, 
    76, 
    '文件编码', 
    '打开包含非 ASCII 文本文件时推荐指定？', 
    JSON_OBJECT('A', 'encoding="utf-8"', 'B', 'binary 模式', 'C', 'rb 模式 必要', 'D', '不需关注'), 
    1, 
    JSON_ARRAY('指定编码避免乱码', 'utf-8 是常用编码'), 
    '指定 encoding 参数能确保正确解码文本。', 
    'open(path,encoding="utf-8")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1132, 
    76, 
    '追加写入', 
    '向文件追加内容应使用哪个模式？', 
    JSON_OBJECT('A', 'a', 'B', 'w', 'C', 'r', 'D', 'x'), 
    1, 
    JSON_ARRAY('a 模式追加写入', 'w 会覆盖'), 
    '使用 "a" 模式在文件末尾追加内容。', 
    'open(file,"a")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1133, 
    76, 
    '上下文管理', 
    '推荐使用 with 打开文件的理由是？', 
    JSON_OBJECT('A', '自动关闭文件', 'B', '更快', 'C', '不要关闭也行', 'D', '只能读不可写'), 
    1, 
    JSON_ARRAY('确保文件在异常时也被关闭', '管理资源更安全'), 
    'with 语句在块结束时自动关闭文件，避免资源泄漏。', 
    'with open(f) as fp:'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1134,
    76,
    '写入多行',
    '补全：把多行写入文件。',
    'a
b',
    JSON_ARRAY('(file contains lines)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lines=[input() for _ in range(2)]"}, {"type": "code_line", "value": "with open(\"out.txt\",\"w\",encoding=\"utf-8\") as f:"}, {"type": "code_line", "value": "    f.write(\"\\n\".join(lines))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'join 后一次写入多行数据。',
    'f.write("\n".join(lines))'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1135,
    76,
    '读取前 N 行',
    '补全：读取前 n 行并打印。',
    '3
a
b
c
d',
    JSON_ARRAY('a', 'b', 'c'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "n=int(input())"}, {"type": "code_line", "value": "for i,line in enumerate(__import__(\"sys\").stdin):"}, {"type": "code_line", "value": "    if i>=n: break"}, {"type": "code_line", "value": "    print(line.strip())"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '枚举并在达到 n 时退出。',
    'for i,line in enumerate(f): if i==n: break'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1136, 
    76, 
    '二进制读写', 
    '处理非文本文件如图片时应使用？', 
    JSON_OBJECT('A', 'rb/wb 模式', 'B', 'r/w 文本模式', 'C', '只用 text mode', 'D', '使用 json'), 
    1, 
    JSON_ARRAY('二进制模式避免解码错误', '适用于图片音频'), 
    '非文本数据需用二进制模式读写以保持数据完整。', 
    'open(img,"rb")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1137, 
    76, 
    '文件指针', 
    '读取后想重读文件从头应使用？', 
    JSON_OBJECT('A', 'f.seek(0)', 'B', '重新 open', 'C', 'f.reset()', 'D', '不可重读'), 
    1, 
    JSON_ARRAY('seek 可调整文件指针位置', '比重新打开更高效'), 
    '使用 seek(0) 可以把文件指针移到开头以便重读。', 
    'f.seek(0)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1138, 
    76, 
    '安全写入', 
    '写入重要文件时建议先写入临时文件再替换的原因是？', 
    JSON_OBJECT('A', '避免写入中断导致数据损坏', 'B', '更快', 'C', '简化代码', 'D', '不推荐'), 
    1, 
    JSON_ARRAY('原子替换降低出错风险', '写入失败不影响原文件'), 
    '先写临时文件然后原子替换可以减少文件损坏风险。', 
    'os.replace(tmp, dest)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1139,
    76,
    '统计单词',
    '补全：统计文件中某个单词出现次数。',
    'hello world hello
hello',
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import sys"}, {"type": "code_line", "value": "text=sys.stdin.read()"}, {"type": "code_line", "value": "print(text.split().count(\"hello\"))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '读取全文并按空白拆分后统计单词出现次数。',
    'text.split().count(w)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1140,
    76,
    '按条件写入',
    '补全：将包含关键字的行写入新文件。',
    'a
b key
c key',
    JSON_ARRAY('(file with lines containing key)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import sys"}, {"type": "code_line", "value": "with open(\"out.txt\",\"w\",encoding=\"utf-8\") as f:"}, {"type": "code_line", "value": "    for line in sys.stdin:"}, {"type": "code_line", "value": "        if \"key\" in line:"}, {"type": "code_line", "value": "            f.write(line)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '遍历并筛选写入新文件。',
    'if "key" in line: f.write(line)'
);