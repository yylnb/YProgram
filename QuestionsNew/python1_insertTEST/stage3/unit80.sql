USE `questions`;
-- Unit 80 | Start ID: 1186
-- Generated at 2025-12-24 18:05:56

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1186, 
    80, 
    'while vs for', 
    '当已知可迭代对象长度时通常使用？', 
    JSON_OBJECT('A', 'for', 'B', 'while', 'C', '两者等价', 'D', '不使用循环'), 
    1, 
    JSON_ARRAY('for 更简洁', '减少索引出错几率'), 
    '若对象可迭代且长度明确，for 循环通常更简洁和安全。', 
    'for x in lst:'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1187, 
    80, 
    'break 用途', 
    'break 在循环中用于？', 
    JSON_OBJECT('A', '退出当前循环', 'B', '跳出所有函数', 'C', '继续下一迭代', 'D', '抛出异常'), 
    1, 
    JSON_ARRAY('仅退出当前循环层'), 
    'break 语句退出当前循环，不会自动退出外层循环。', 
    'for...: if c: break'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1188, 
    80, 
    'continue 用途', 
    'continue 的作用是？', 
    JSON_OBJECT('A', '跳过当前迭代剩余动作', 'B', '退出循环', 'C', '报错', 'D', '无作用'), 
    1, 
    JSON_ARRAY('回到循环条件判断进入下一迭代'), 
    'continue 会跳过本次迭代剩余代码并开始下一次迭代。', 
    'if cond: continue'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1189, 
    80, 
    '生成器好处', 
    '生成器的优点是？', 
    JSON_OBJECT('A', '节省内存', 'B', '更快总是', 'C', '可索引', 'D', '可序列化'), 
    1, 
    JSON_ARRAY('惰性求值不一次性占用内存'), 
    '生成器按需产生元素，适合处理大数据流时节省内存。', 
    '(x for x in it)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1190, 
    80, 
    'join vs +', 
    '在大量字符串拼接中应使用？', 
    JSON_OBJECT('A', '"".join', 'B', '+ 连接', 'C', 'print 多次', 'D', 'format 每次'), 
    1, 
    JSON_ARRAY('join 在拼接大量片段时更高效'), 
    '收集片段后用 join 一次性拼接通常比在循环中频繁用 + 更高效。', 
    '" ".join(parts)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1191, 
    80, 
    '列表修改', 
    '遍历列表同时删除元素安全做法是？', 
    JSON_OBJECT('A', '遍历副本或反向遍历', 'B', '边遍历边删除', 'C', '用 enumerate 修改长度', 'D', '不可删除'), 
    1, 
    JSON_ARRAY('副本或反向遍历避免跳过元素'), 
    '遍历副本或使用反向索引可以安全删除元素而不跳过。', 
    'for x in lst[:]:'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1192, 
    80, 
    '性能优先', 
    '要对百万级数据做简单处理应优先考虑？', 
    JSON_OBJECT('A', '使用生成器和内建函数', 'B', '用列表保存所有数据', 'C', '用递归', 'D', '打印每项'), 
    1, 
    JSON_ARRAY('内存与速度权衡优先使用流式处理'), 
    '对于大数据集应优先使用流式处理和内建优化函数以降低内存和提高速度。', 
    'sum(gen) instead of list'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1193, 
    80, 
    '异常处理位置', 
    '循环中处理单项可能异常时应放在哪？', 
    JSON_OBJECT('A', '局部 try/except', 'B', '外层 try 捕获所有', 'C', '删除异常项', 'D', '不处理'), 
    1, 
    JSON_ARRAY('局部处理便于跳过出错项并继续'), 
    '在循环内局部处理异常可以保证其他项仍被处理。', 
    'try: do(x) except: continue'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1194, 
    80, 
    '文件读取方式', 
    '处理大文本文件逐行查找应使用？', 
    JSON_OBJECT('A', 'for line in open(file)', 'B', 'f.read() 然后 split', 'C', 'readlines()', 'D', 'load 到数据库'), 
    1, 
    JSON_ARRAY('按行迭代更节省内存'), 
    '按行迭代不会一次性读取整个文件，更适合大文件。', 
    'with open(file) as f: for line in f:'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1195,
    80,
    'enumerate 使用',
    '补全：输出每个元素及其索引。',
    'a b',
    JSON_ARRAY('0 a', '1 b'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "for i,v in enumerate(input().split()):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(i, v)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'enumerate 同时返回索引和值，常用于需要索引的遍历。',
    'enumerate(iterable)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1196,
    80,
    '循环计数器',
    '补全：用循环统计满足条件的元素数目。',
    '1 2 3 4',
    JSON_ARRAY('2'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "cnt=0"}, {"type": "code_line", "value": "for x in lst:"}, {"type": "code_line", "value": "    if x%2==0:"}, {"type": "code_line", "value": "        cnt+=1"}, {"type": "code_line", "value": "print(cnt)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用计数器累加符合条件的元素数。',
    'cnt += 1'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1197,
    80,
    'while 循环',
    '补全：使用 while 累加直到达到阈值。',
    '10',
    JSON_ARRAY('1..n'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "n=int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "s=0"}, {"type": "code_line", "value": "i=0"}, {"type": "code_line", "value": "while s<n:"}, {"type": "code_line", "value": "    i+=1"}, {"type": "code_line", "value": "    s+=i"}, {"type": "code_line", "value": "print(i)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'while 可用于不知道确切迭代次数的累加场景。',
    'while condition:'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1198,
    80,
    '嵌套循环练习',
    '补全：从二维列表中打印所有元素。',
    'a b
c d',
    JSON_ARRAY('a b c d'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "lines=[input().split() for _ in range(2)]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for row in lines:"}, {"type": "code_line", "value": "    for x in row:"}, {"type": "code_line", "value": "        print(x, end=\" \")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '嵌套循环可遍历二维结构的所有元素。',
    'for row in mat: for x in row:'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1199,
    80,
    '组合操作',
    '补全：将两个列表交叉输出。',
    'a b
1 2',
    JSON_ARRAY('a 1 b 2'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "a=input().split()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b=input().split()"}, {"type": "code_line", "value": "for x,y in zip(a,b):"}, {"type": "code_line", "value": "    print(x, y, end=\" \")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'zip 可以并行迭代多个可迭代对象。',
    'for x,y in zip(a,b):'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1200,
    80,
    '调试技巧',
    '补全：在循环中临时打印变量用于调试并继续。',
    '1 2',
    JSON_ARRAY('(prints)', '1 2'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "for x in input().split():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"dbg\", x)"}, {"type": "code_line", "value": "    # rest of logic"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '调试时可短暂加入 print，生产代码使用 logging。',
    'print("debug", var)'
);