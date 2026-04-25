USE `questions`;
-- Unit 75 | Start ID: 1111
-- Generated at 2025-12-24 23:21:36

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1111, 
    75, 
    '格式化插入', 
    '遍历数据并格式化输出推荐使用？', 
    JSON_OBJECT('A', 'f-string', 'B', '% 格式化', 'C', '字符串拼接', 'D', '仅 print 多次'), 
    1, 
    JSON_ARRAY('f-string 可读且高效', 'Python 3.6+ 推荐'), 
    'f-string 简洁且效率高，适合在循环中格式化输出。', 
    'for i in range(3):
  print(f"i={i}")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1112, 
    75, 
    '性能注意', 
    '在循环中每次格式化很慢时应？', 
    JSON_OBJECT('A', '预先格式化或批量拼接', 'B', '无法优化', 'C', '使用递归', 'D', '换语言'), 
    1, 
    JSON_ARRAY('尽量减少每次昂贵操作', '批量处理可降低开销'), 
    '将一些可重用格式准备好或使用 join 批量输出可提升性能。', 
    'buffer.append(f"{x}")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1113, 
    75, 
    '对齐显示', 
    '在循环中打印表格对齐常用？', 
    JSON_OBJECT('A', 'format 或 f-string 指定宽度', 'B', '手动空格数', 'C', '仅使用 tab', 'D', '不推荐'), 
    1, 
    JSON_ARRAY('格式化有宽度和对齐选项', '更易维护'), 
    '使用格式化语法可以控制列宽和对齐，便于输出表格。', 
    'print(f"{x:>5}")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1114,
    75,
    '编号输出',
    '补全：将输入每个单词编号并输出。',
    'a b c',
    JSON_ARRAY('1 a', '2 b', '3 c'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "words=input().split()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "for i,w in enumerate(words,"}, {"type": "slot", "index": 0}, {"type": "code", "value": "):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(i,w)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 enumerate 提供序号，便于编号输出。',
    'enumerate start=1'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1115,
    75,
    '格式化两位小数',
    '补全：遍历数列表并打印两位小数。',
    '3.14159 2.5',
    JSON_ARRAY('3.14', '2.50'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "nums=list(map(float,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x in nums:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(f\"{x:."}, {"type": "slot", "index": 0}, {"type": "code", "value": "f}\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用格式说明符控制小数位数。',
    '{x:.2f}'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1116, 
    75, 
    '换行控制', 
    '在循环中想在末尾不换行用？', 
    JSON_OBJECT('A', 'print(..., end="")', 'B', 'print no end', 'C', 'sys.stdout.write 不可用', 'D', '使用 ;'), 
    1, 
    JSON_ARRAY('end 参数控制结尾字符串', '常用空字符串阻止换行'), 
    'print 的 end 参数用于控制行尾，默认是换行。', 
    'print(x, end=" ")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1117, 
    75, 
    '连接大量字符串', 
    '在循环中多次拼接字符串应优先？', 
    JSON_OBJECT('A', '先 append 到列表再 join', 'B', '直接用 + 累加', 'C', '写到文件再读', 'D', '使用 float 转换'), 
    1, 
    JSON_ARRAY('+ 在循环频繁拼接性能差', 'join 在最后一次性拼接高效'), 
    '将片段收集在列表中，最后用 join 拼接更高效。', 
    '"".join(parts)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1118, 
    75, 
    '国际化', 
    '在循环中格式化涉及货币和本地化时应？', 
    JSON_OBJECT('A', '使用 locale 或 babel 库', 'B', '手动拼接字符串', 'C', '仅使用 f-string', 'D', '不可本地化'), 
    1, 
    JSON_ARRAY('本地化处理涉及千分位和货币符号', '使用专业库更安全'), 
    '使用专门库处理区域化格式更可靠。', 
    'import locale'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1119,
    75,
    '制表输出',
    '补全：输出两列对齐的表格。',
    'a 1
b 20',
    JSON_ARRAY('a   1', 'b  20'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lines=[input().split() for _ in range(2)]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for k,v in lines:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(f\"{k:<"}, {"type": "slot", "index": 0}, {"type": "code", "value": "}{v:>3}\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '利用格式说明符控制列宽和对齐。',
    '{k:<3}{v:>3}'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1120,
    75,
    '批量构建字符串',
    '补全：将多行结果合并为单一字符串返回。',
    'a
b',
    JSON_ARRAY('a
b'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "res=[]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for _ in range(2):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    res.append(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\".join(res))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 join 拼接多行字符串更高效。',
    '"\n".join(lines)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1121, 
    75, 
    '转义字符', 
    '在循环中打印带引号的字符串可用？', 
    JSON_OBJECT('A', '使用转义或不同引号', 'B', '无法打印', 'C', '使用 raw string 不行', 'D', '必须用 ascii'), 
    1, 
    JSON_ARRAY('选择合适的引号或转义内部引号'), 
    '通过不同类型的引号或 " 转义可包含引号字符。', 
    'print("He said \"hi\"")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1122, 
    75, 
    '效率权衡', 
    '在循环中频繁格式化与字符串拼接，怎样取舍？', 
    JSON_OBJECT('A', '优先可读性，性能成问题再优化', 'B', '永远追求最优性能', 'C', '总是用 +', 'D', '总是用 format'), 
    1, 
    JSON_ARRAY('先正确，再优化', '避免早期复杂优化'), 
    '先写清晰正确的代码，只有性能出现问题再进行优化处理。', 
    'profile before optimize'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1123, 
    75, 
    'f-string 表达式', 
    'f-string 中可以直接嵌入表达式吗？', 
    JSON_OBJECT('A', '可以', 'B', '不可以', 'C', '只限字面量', 'D', '仅 format 支持'), 
    1, 
    JSON_ARRAY('f-string 支持表达式求值', '注意性能开销'), 
    'f-string 可以直接包含表达式，如 f"{x+1}"。', 
    'f"{sum(nums)}"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1124,
    75,
    '日志格式输出',
    '补全：循环中按固定格式打印日志。',
    'ok error',
    JSON_ARRAY('INFO: ok', 'ERROR: error'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a,b=input().split()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\"INFO: {a}\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\"ERROR: {b}\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 f-string 按固定模式格式化日志。',
    'print(f"LEVEL: {msg}")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1125,
    75,
    '拼接 CSV 行',
    '补全：根据输入生成 CSV 一行。',
    'a b c',
    JSON_ARRAY('a,b,c'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\".join(input().split()))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 join 将字段合并为逗号分隔的行。',
    '",".join(fields)'
);