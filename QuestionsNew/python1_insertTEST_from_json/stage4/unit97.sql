USE `questions`;
-- Unit 97 | Start ID: 1441
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1441,
    97,
    'for 遍历',
    '下面哪个语句用于遍历列表元素？',
    JSON_OBJECT('A', 'for x in lst: ...', 'B', 'for i = 0; i < len(lst); i++', 'C', 'foreach(lst)', 'D', 'lst.each()'),
    1,
    JSON_ARRAY('提示1：Python 使用 for ... in 语法', '提示2：C/Java 风格 for 语句不可用', '提示3：列表没有 each 方法'),
    'Python 使用 for x in lst 来逐一访问列表元素。',
    'for x in [1,2]: print(x)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1442,
    97,
    '带索引遍历',
    '如果需要索引和元素同时使用，应选择哪种方式？',
    JSON_OBJECT('A', 'enumerate(lst)', 'B', 'range(len(lst)) 及索引', 'C', '两者皆可', 'D', '以上皆不可'),
    3,
    JSON_ARRAY('提示1：enumerate 更简洁', '提示2：range(len(lst)) 也可获取索引', '提示3：两者都能同时得到索引和值'),
    '两种方法都能获得索引和值，enumerate 更 Pythonic。',
    'for i, v in enumerate(lst): ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1443,
    97,
    '遍历副本修改',
    '在遍历列表并修改其内容时应避免什么？',
    JSON_OBJECT('A', '直接在遍历的列表上插入或删除', 'B', '使用新列表收集结果', 'C', '使用索引遍历并就地修改', 'D', '使用列表推导'),
    1,
    JSON_ARRAY('提示1：在遍历时改变列表会导致跳过或重复元素', '提示2：若要修改可先遍历副本', '提示3：或使用索引遍历以避免问题'),
    '遍历时修改原列表会产生不可预测结果，推荐遍历副本或使用索引。',
    'for x in lst[:]: if cond: lst.remove(x)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1444,
    97,
    '遍历求和（填空）',
    '计算输入列表元素之和并输出。',
    JSON_ARRAY('1 2 3'),
    JSON_ARRAY('6'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "s = 0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x in lst:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(s)"}]}]}',
    JSON_ARRAY('s+=x', 's=x', 's=s+x', 's.append(x)'),
    JSON_ARRAY(1, 3),
    '循环中累加元素值，使用 s += x 或 s = s + x。',
    's=0
for x in lst: s += x'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1445,
    97,
    '带索引遍历（填空）',
    '打印每个元素的索引和值，格式 “索引:值”。',
    JSON_ARRAY('10 20'),
    JSON_ARRAY('0:10 1:20'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "for i, v in "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(f\\"{i}:{v}\\", end=\\" \\")"}]}]}',
    JSON_ARRAY('enumerate(lst)', 'range(len(lst))', 'zip(range(len(lst)), lst)', 'lst'),
    JSON_ARRAY(1, 3),
    '使用 enumerate(lst) 或 zip(range(len(lst)), lst) 都可同时获得索引和值。',
    'for i,v in enumerate(lst): print(i,v)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1446,
    97,
    '遍历顺序',
    '默认的 for in 列表遍历顺序是？',
    JSON_OBJECT('A', '从前到后', 'B', '从后到前', 'C', '随机', 'D', '按值大小'),
    1,
    JSON_ARRAY('提示1：顺序与索引一致', '提示2：若要反向遍历可用 reversed()', '提示3：默认不是随机或按值排序'),
    'for in 默认按索引从前到后遍历列表元素。',
    'for x in [1,2,3]: print(x)  # 1 2 3'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1447,
    97,
    '使用 iter',
    '下面关于列表迭代器的说法正确的是？',
    JSON_OBJECT('A', 'iter(lst) 返回一个迭代器对象', 'B', 'iter(lst) 直接返回列表副本', 'C', '无法手动获取下一个元素', 'D', 'iter 与 for 无法互换'),
    1,
    JSON_ARRAY('提示1：iter(lst) 可与 next() 配合使用', '提示2：iter 不会复制列表', '提示3：for 本质上使用迭代器'),
    'iter(lst) 返回迭代器，可用 next() 获取下一个元素或在 for 中使用。',
    'it = iter([1,2]); next(it)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1448,
    97,
    '遍历效率',
    '在 Python 中，哪种方式遍历并累加列表元素效率更高？',
    JSON_OBJECT('A', 'sum(lst)', 'B', 'for 循环累加', 'C', '列表推导并 sum', 'D', 'map + reduce'),
    1,
    JSON_ARRAY('提示1：内置函数通常用 C 实现更快', '提示2：sum 是专用的累加函数', '提示3：列表推导会创建临时列表'),
    '使用内置 sum(lst) 性能最好且简洁。',
    'total = sum(lst)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1449,
    97,
    '过滤遍历（填空）',
    '打印输入中大于 0 的元素，保持原顺序。',
    JSON_ARRAY('-1 2 -3 4'),
    JSON_ARRAY('2 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x in lst:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        print(x, end=\\" \\")"}]}]}',
    JSON_ARRAY('x>0', 'x>=0', 'x!=0', 'x<0'),
    JSON_ARRAY(1),
    '判断元素是否大于 0，然后打印。',
    'for x in lst: if x>0: print(x)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1450,
    97,
    '跳过与停止（填空）',
    '遍历时遇到负数跳过，遇到 0 则停止。',
    JSON_ARRAY('1 -1 2 0 3'),
    JSON_ARRAY('1 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x in lst:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        continue"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    if "}, {"type": "slot", "index": 1}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        break"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(x, end=\\" \\")"}]}]}',
    JSON_ARRAY('x<0', 'x==0', 'x>0', 'x!=0'),
    JSON_ARRAY(1, 2),
    '先判断负数并 continue，遇到 0 则 break。',
    'if x<0: continue
if x==0: break'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1451,
    97,
    '可变迭代行为',
    '使用 for x in lst 时在循环内修改 lst 会如何？',
    JSON_OBJECT('A', '可能导致跳过元素或重复处理', 'B', 'for 会自动调整以适应修改', 'C', '抛出运行时错误', 'D', '不会有任何影响'),
    1,
    JSON_ARRAY('提示1：迭代器基于内部索引/状态', '提示2：在迭代时删除元素常见问题会出现', '提示3：用副本遍历是安全的做法'),
    '在遍历时修改列表会影响迭代器的后续行为，通常会跳过或重复元素。',
    'for x in lst: if cond: lst.remove(x)  # 不推荐'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1452,
    97,
    '反向遍历',
    '要反向遍历列表应使用哪个函数？',
    JSON_OBJECT('A', 'reversed(lst)', 'B', 'lst.reverse()', 'C', 'lst[::-1]', 'D', '以上都可以'),
    4,
    JSON_ARRAY('提示1：reversed 返回迭代器', '提示2：lst[::-1] 创建反向副本', '提示3：lst.reverse() 就地反转列表'),
    '三种方法都能实现反向遍历或反向序列，区别在于是否生成副本或就地修改。',
    'for x in reversed(lst): print(x)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1453,
    97,
    '并行遍历',
    '若要并行遍历两个列表并同时访问对应元素，应使用？',
    JSON_OBJECT('A', 'zip(lst1, lst2)', 'B', 'enumerate(lst1, lst2)', 'C', 'map(lst1, lst2)', 'D', 'concat 然后遍历'),
    1,
    JSON_ARRAY('提示1：zip 将对应位置元素配对', '提示2：enumerate 只针对一个可迭代对象', '提示3：map 接受函数和可迭代对象'),
    'zip(lst1, lst2) 把两个列表对应元素打包为元组，便于并行遍历。',
    'for a,b in zip(x,y): ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1454,
    97,
    '遍历计数（填空）',
    '统计列表中正数的个数并输出。',
    JSON_ARRAY('1 -2 3'),
    JSON_ARRAY('2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "c = 0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x in lst:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        c += 1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(c)"}]}]}',
    JSON_ARRAY('x>0', 'x>=0', 'x!=0', 'x<0'),
    JSON_ARRAY(1),
    '判断正数（x>0）并计数。',
    'c = sum(1 for x in lst if x>0)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1455,
    97,
    '遍历构造新列表（填空）',
    '遍历并把所有偶数放入新列表打印。',
    JSON_ARRAY('1 2 3 4'),
    JSON_ARRAY('2 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "res = []"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x in lst:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        res.append(x)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*res)"}]}]}',
    JSON_ARRAY('x%2==0', 'x%2==1', 'x>0', 'x<0'),
    JSON_ARRAY(1),
    '判断是否为偶数（x%2==0），并 append 到新列表。',
    'res = [x for x in lst if x%2==0]'
);