USE `questions`;
-- Unit 103 | Start ID: 1531
-- Generated at 2025-12-24 23:30:49

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1531, 
    103, 
    '访问嵌套元素', 
    '要访问 matrix[1][2] 表示什么？', 
    JSON_OBJECT('A', '第二行第三列元素', 'B', '第一行第二列元素', 'C', '第三行第二列元素', 'D', '抛出异常'), 
    1, 
    JSON_ARRAY('提示1：索引从 0 开始', '提示2：matrix[1] 代表第二行', '提示3：matrix[1][2] 是该行的第三个元素'), 
    'matrix[1][2] 表示第 2 行第 3 列（索引从 0 开始）。', 
    'm = [[1,2],[3,4]]; m[1][0] == 3'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1532, 
    103, 
    '遍历矩阵', 
    '下列哪种方式可遍历矩阵中所有元素？', 
    JSON_OBJECT('A', 'for row in mat: for x in row: ...', 'B', 'for i in range(len(mat)): mat[i]', 'C', 'for x in mat: print(x)', 'D', 'for i in mat: for j in i: j++'), 
    1, 
    JSON_ARRAY('提示1：嵌套循环用于遍历二维结构', '提示2：第一层遍历行，第二层遍历行内元素', '提示3：注意元素访问和修改方法'), 
    '嵌套 for 循环可逐行逐元素访问矩阵。', 
    'for r in mat: for v in r: print(v)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1533, 
    103, 
    '浅拷贝陷阱', 
    '用 [[0]*3]*2 创建的嵌套列表有什么问题？', 
    JSON_OBJECT('A', '两行共享同一行引用，修改会互相影响', 'B', '创建空行', 'C', '语法错误', 'D', '内存不足'), 
    1, 
    JSON_ARRAY('提示1：乘法复制会重复引用同一对象', '提示2：修改其中一行会影响另一行', '提示3：应使用列表推导生成独立子列表'), 
    '[[0]*3]*2 会创建两行共享相同子列表引用，导致修改互相影响。', 
    'better = [[0]*3 for _ in range(2)]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1534,
    103,
    '访问元素（填空）',
    '打印第二行第一列的元素。',
    '1 2
3 4',
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "mat = [list(map(int, input().split())) for _ in range(2)]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(mat["}, {"type": "slot", "index": 0}, {"type": "code", "value": "]["}, {"type": "slot", "index": 1}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('1,0', '0,1', '1,1', '0,0'),
    JSON_ARRAY(1),
    '第二行索引为 1，第一列索引为 0，因此 mat[1][0]。',
    'm[1][0]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1535,
    103,
    '逐行遍历（填空）',
    '打印矩阵所有元素（行优先）。',
    '1 2
3 4',
    JSON_ARRAY('1 2 3 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "mat = [list(map(int, input().split())) for _ in range(2)]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for row in mat:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    for x in row:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        "}, {"type": "slot", "index": 0}]}]}',
    JSON_ARRAY('print(x, end=" ")', 'print(row)', 'print(*row)', 'pass'),
    JSON_ARRAY(1),
    '使用 print(x, end=" ") 可按顺序打印每个元素并用空格分隔。',
    'for r in m: for v in r: print(v, end=" ")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1536, 
    103, 
    '创建矩阵的正确方法', 
    '下面哪个方法可以创建 3x3 的独立嵌套列表？', 
    JSON_OBJECT('A', '[[0]*3 for _ in range(3)]', 'B', '[[0]*3]*3', 'C', 'list([0]*3)*3', 'D', '[[0 for _ in range(3)]]*3'), 
    1, 
    JSON_ARRAY('提示1：列表推导为每行创建独立对象', '提示2：乘法会重复引用同一对象', '提示3：推荐使用推导'), 
    '使用推导 [[0]*3 for _ in range(3)] 会生成独立的子列表，避免共享引用问题。', 
    'm = [[0]*3 for _ in range(3)]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1537, 
    103, 
    '访问越界', 
    '访问 matrix[2][0] 在 2x2 矩阵中会怎样？', 
    JSON_OBJECT('A', '抛出 IndexError', 'B', '返回 None', 'C', '返回 0', 'D', '返回空列表'), 
    1, 
    JSON_ARRAY('提示1：索引越界会抛异常', '提示2：二维索引遵循行和列边界', '提示3：应检查长度后再访问'), 
    '若行索引或列索引超出范围会抛 IndexError。', 
    'm[2][0]  # IndexError'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1538, 
    103, 
    '深拷贝', 
    '要复制嵌套列表使内部列表不共享引用，应使用？', 
    JSON_OBJECT('A', 'copy.deepcopy', 'B', '切片复制', 'C', '浅拷贝', 'D', '直接赋值'), 
    1, 
    JSON_ARRAY('提示1：深拷贝递归复制子对象', '提示2：浅拷贝仅复制最外层', '提示3：需要导入 copy 模块'), 
    'copy.deepcopy 可以递归复制所有层次，避免内部共享引用。', 
    'import copy; b = copy.deepcopy(a)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1539,
    103,
    '矩阵转置（填空）',
    '将 2x2 矩阵转置并打印。',
    '1 2
3 4',
    JSON_ARRAY('1 3', '2 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "mat = [list(map(int, input().split())) for _ in range(2)]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "trans = [[mat[j][i] for j in range(2)] for i in range(2)]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for row in trans:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(*row)"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(),
    '转置通过交换行列索引实现。',
    'zip(*mat) 也可用于转置'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1540,
    103,
    '修改子元素（填空）',
    '把 matrix[0][1] 设为 9 并打印第一行。',
    '1 2
3 4',
    JSON_ARRAY('1 9'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "mat = [list(map(int, input().split())) for _ in range(2)]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "mat["}, {"type": "slot", "index": 0}, {"type": "code", "value": "]["}, {"type": "slot", "index": 1}, {"type": "code", "value": "] = 9"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*mat[0])"}]}]}',
    JSON_ARRAY('0,1', '1,0', '0,0', '1,1'),
    JSON_ARRAY(1),
    '第一行第二列对应 mat[0][1]。',
    'mat[0][1] = 9'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1541, 
    103, 
    'zip 与矩阵', 
    '使用 zip(*mat) 可实现什么？', 
    JSON_OBJECT('A', '矩阵转置', 'B', '矩阵拷贝', 'C', '按行连接', 'D', '按列删除'), 
    1, 
    JSON_ARRAY('提示1：zip(*mat) 把每一列打包成行', '提示2：常用于转置矩阵', '提示3：配合 map/list 可得到列表形式'), 
    'zip(*mat) 把矩阵按列组合，常用于实现转置。', 
    'list(zip(*mat))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1542, 
    103, 
    '嵌套列表索引顺序', 
    '访问 a[i][j] 时先索引哪一层？', 
    JSON_OBJECT('A', '先取第 i 行再取第 j 列', 'B', '先取第 j 列再取第 i 行', 'C', '同时取', 'D', '随机'), 
    1, 
    JSON_ARRAY('提示1：a[i] 返回某行对象', '提示2：接着在该行上用 [j] 取得元素', '提示3：顺序是确定的'), 
    '表达式 a[i][j] 先取 a[i]（第 i 行），然后对结果取第 j 元素。', 
    'm[0][1]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1543, 
    103, 
    '多维列表可变性', 
    '修改嵌套列表的子列表会怎样影响原结构？', 
    JSON_OBJECT('A', '会直接影响包含该子列表的原列表', 'B', '不会影响', 'C', '只影响拷贝', 'D', '引发异常'), 
    1, 
    JSON_ARRAY('提示1：子列表是对象引用', '提示2：修改子列表会在所有引用处体现', '提示3：若想避免可用 deepcopy'), 
    '子列表是原对象的一部分，修改会反映在包含它的结构上。', 
    'a[0].append(1)  # 改变 a'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1544,
    103,
    '生成空矩阵（填空）',
    '生成 3x2 的零矩阵并打印。',
    NULL,
    JSON_ARRAY('0 0', '0 0', '0 0'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "mat = [[0]*2 for _ in range(3)]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for r in mat:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(*r)"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(),
    '使用推导生成每行独立的子列表。',
    '[[0]*2 for _ in range(3)]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1545,
    103,
    '矩阵元素求和（填空）',
    '计算并打印 2x2 矩阵所有元素之和。',
    '1 2
3 4',
    JSON_ARRAY('10'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "mat = [list(map(int, input().split())) for _ in range(2)]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(sum(sum(row) for row in mat))"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(),
    '可用内层 sum 求行和，外层 sum 计算总和。',
    'sum(sum(r) for r in mat)'
);