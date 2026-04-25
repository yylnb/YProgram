USE `questions`;
-- Unit 73 | Start ID: 1081
-- Generated at 2025-12-24 23:21:19

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1081, 
    73, 
    '嵌套遍历', 
    '要遍历二维字符矩阵常用方法？', 
    JSON_OBJECT('A', '双重 for 循环', 'B', '单循环即可', 'C', '只用 while', 'D', 'zip 不可用'), 
    1, 
    JSON_ARRAY('行列两层循环', '外层行内层列'), 
    '二维结构通常使用嵌套循环遍历。', 
    'for row in mat:
  for ch in row:'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1082, 
    73, 
    '复杂度增加', 
    '嵌套循环的时间复杂度通常如何变化？', 
    JSON_OBJECT('A', '可能成平方级', 'B', '保持常数', 'C', '变为对数级', 'D', '不可确定'), 
    1, 
    JSON_ARRAY('每层乘积关系', '二重循环常为 O(n^2)'), 
    '两层 n 的循环经常导致 O(n^2) 时间复杂度。', 
    'for i in range(n):
 for j in range(n):'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1083, 
    73, 
    '字符串嵌套', 
    '遍历字符串列表并遍历每个字符串，正确写法？', 
    JSON_OBJECT('A', 'for s in lst:
 for ch in s', 'B', 'for i in range(len(s))', 'C', 'while True', 'D', '不能嵌套'), 
    1, 
    JSON_ARRAY('先遍历列表再遍历字符串', '顺序很重要'), 
    '先迭代外层容器再迭代内层字符串是正确方法。', 
    'for s in lst:
  for ch in s:'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1084,
    73,
    '矩阵求和',
    '补全：计算二维数字矩阵元素总和。',
    '[[1,2],[3,4]]',
    JSON_ARRAY('10'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "mat=[[int(x) for x in input().split()] for _ in range(2)]"}, {"type": "code_line", "value": "s=0"}, {"type": "code_line", "value": "for row in mat:"}, {"type": "code_line", "value": "    for v in row:"}, {"type": "code_line", "value": "        s+=v"}, {"type": "code_line", "value": "print(s)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '嵌套循环累加每个元素。',
    'sum of elements'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1085,
    73,
    '字符计数矩阵',
    '补全：统计每行中 a 的次数并打印。',
    'a b
aba',
    JSON_ARRAY('1', '2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lines=[input() for _ in range(2)]"}, {"type": "code_line", "value": "for line in lines:"}, {"type": "code_line", "value": "    cnt=0"}, {"type": "code_line", "value": "    for ch in line:"}, {"type": "code_line", "value": "        if ch==\"a\":"}, {"type": "code_line", "value": "            cnt+=1"}, {"type": "code_line", "value": "    print(cnt)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '对每行使用内层循环计数。',
    'line.count("a")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1086, 
    73, 
    '提前退出', 
    '嵌套循环中想跳出内层但继续外层应使用？', 
    JSON_OBJECT('A', 'break 仅退出内层', 'B', 'break 退出所有层', 'C', 'continue 结束所有循环', 'D', 'raise 终止程序'), 
    1, 
    JSON_ARRAY('break 作用域为当前循环', '外层循环仍会继续'), 
    'break 只退出当前循环层，外层继续执行。', 
    'break 在内层'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1087, 
    73, 
    '标签跳出', 
    'Python 原生是否支持标签式多层跳出？', 
    JSON_OBJECT('A', '不支持', 'B', '支持 label', 'C', '通过 goto', 'D', '仅在 C 中支持'), 
    1, 
    JSON_ARRAY('可用 flag 或 exception 实现多层跳出', '无标签语法'), 
    'Python 不支持标签跳出，可用标志位或抛出异常来中断多层循环。', 
    'use flag or raise'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1088, 
    73, 
    '内存与生成器', 
    '处理大嵌套数据集时建议使用？', 
    JSON_OBJECT('A', '生成器按需提供数据', 'B', '一次性读入全部并遍历', 'C', '优化为递归', 'D', '复制数据'), 
    1, 
    JSON_ARRAY('避免一次性载入大数据', '按需生成节省内存'), 
    '生成器或迭代器可以节省内存并支持流式处理。', 
    'for row in gen():'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1089,
    73,
    '方阵对角和',
    '补全：计算方阵主对角线之和。',
    '3
1 2 3
4 5 6
7 8 9',
    JSON_ARRAY('15'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "n=int(input())"}, {"type": "code_line", "value": "mat=[list(map(int,input().split())) for _ in range(n)]"}, {"type": "code_line", "value": "s=0"}, {"type": "code_line", "value": "for i in range(n):"}, {"type": "code_line", "value": "    s+=mat[i][i]"}, {"type": "code_line", "value": "print(s)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '主对角线元素索引相等。',
    'i==j'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1090,
    73,
    '计数出现位置',
    '补全：输出字符 x 在二维字符表中出现的总次数。',
    '2 2
aa
ab
a',
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "r,c=map(int,input().split())"}, {"type": "code_line", "value": "mat=[input().strip() for _ in range(r)]"}, {"type": "code_line", "value": "ch=input().strip()"}, {"type": "code_line", "value": "cnt=0"}, {"type": "code_line", "value": "for row in mat:"}, {"type": "code_line", "value": "    for c in row:"}, {"type": "code_line", "value": "        if c==ch:"}, {"type": "code_line", "value": "            cnt+=1"}, {"type": "code_line", "value": "print(cnt)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '遍历所有字符并计数。',
    'nested loops count'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1091, 
    73, 
    '生成器与嵌套', 
    '嵌套生成器表达式能用于？', 
    JSON_OBJECT('A', '构造扁平列表', 'B', '不可用', 'C', '只用于字符串', 'D', '只用于数字'), 
    1, 
    JSON_ARRAY('可用于扁平化嵌套结构', '注意可读性'), 
    '嵌套生成器可以用于扁平化并生成单一序列。', 
    '(x for row in mat for x in row)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1092, 
    73, 
    '索引错误', 
    '在嵌套循环中常见索引错误原因？', 
    JSON_OBJECT('A', '越界访问', 'B', '语法错误', 'C', '类型错误', 'D', '编译器缺陷'), 
    1, 
    JSON_ARRAY('下标不小心越界', '边界检查重要'), 
    '越界是嵌套索引中常见问题，注意循环边界。', 
    'range(len(row))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1093, 
    73, 
    '优化建议', 
    '若嵌套循环瓶颈出现在内层，常见优化方式是？', 
    JSON_OBJECT('A', '减少内层重复计算', 'B', '加更多循环', 'C', '增加嵌套层级', 'D', '改用递归'), 
    1, 
    JSON_ARRAY('缓存内层不变计算', '预处理数据'), 
    '将不变的计算移出内层循环或使用缓存能显著提升效率。', 
    'precompute values'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1094,
    73,
    '拼接每行字符串',
    '补全：把二维字符矩阵每行拼接为字符串并打印。',
    '2
ab
cd',
    JSON_ARRAY('ab', 'cd'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "n=int(input())"}, {"type": "code_line", "value": "for _ in range(n):"}, {"type": "code_line", "value": "    print(\"\".join(list(input().strip())))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 join 将字符列表或行拼接为字符串。',
    '"".join(chars)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1095,
    73,
    '转置矩阵',
    '补全：输出矩阵的转置。',
    '2 3
1 2 3
4 5 6',
    JSON_ARRAY('1 4', '2 5', '3 6'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "r,c=map(int,input().split())"}, {"type": "code_line", "value": "mat=[list(map(int,input().split())) for _ in range(r)]"}, {"type": "code_line", "value": "for j in range(c):"}, {"type": "code_line", "value": "    row=[]"}, {"type": "code_line", "value": "    for i in range(r):"}, {"type": "code_line", "value": "        row.append(str(mat[i][j]))"}, {"type": "code_line", "value": "    print(\" \".join(row))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '转置将行列互换。',
    'zip(*mat)'
);