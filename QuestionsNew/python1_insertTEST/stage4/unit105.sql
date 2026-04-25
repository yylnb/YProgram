USE `questions`;
-- Unit 105 | Start ID: 1561
-- Generated at 2025-12-24 18:13:52

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1561, 
    105, 
    '赋值与引用', 
    '执行 b = a 后，对 b 的修改会如何？', 
    JSON_OBJECT('A', '会影响 a，因为两者引用同一对象', 'B', '不会影响 a，b 是 a 的拷贝', 'C', '取决于元素类型', 'D', '抛出异常'), 
    1, 
    JSON_ARRAY('提示1：赋值不会复制对象', '提示2：两个变量指向同一对象', '提示3：修改可变对象会在所有引用处可见'), 
    '赋值只是绑定引用，b=a 后两者共享同一对象，修改通过引用可见。', 
    'a=[1]; b=a; b.append(2); print(a)  # [1,2]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1562, 
    105, 
    '浅拷贝方法', 
    '下面哪个操作会创建列表的浅拷贝？', 
    JSON_OBJECT('A', 'a[:]', 'B', 'a = a', 'C', 'a.copy() is None', 'D', 'del a'), 
    1, 
    JSON_ARRAY('提示1：切片会复制顶层列表', '提示2：copy() 也是浅拷贝', '提示3：浅拷贝不会递归复制子对象'), 
    'a[:] 或 a.copy() 都会生成浅拷贝，复制最外层列表对象。', 
    'b = a[:]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1563, 
    105, 
    '深拷贝场景', 
    '何时需要使用深拷贝？', 
    JSON_OBJECT('A', '当列表包含可变子对象且需要独立副本时', 'B', '当只是复制顶层元素时', 'C', '从不需要', 'D', '只有在字符串中需要'), 
    1, 
    JSON_ARRAY('提示1：深拷贝递归复制所有层级', '提示2：当内部包含列表/字典时常用', '提示3：使用 copy.deepcopy'), 
    '当嵌套可变对象需要独立拷贝时使用深拷贝以避免引用共享。', 
    'import copy; b = copy.deepcopy(a)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1564, 
    105, 
    '子列表共享', 
    '若使用 [[0]*3]*2 创建矩阵，修改其中一个子列表会怎样？', 
    JSON_OBJECT('A', '所有行会被同时修改', 'B', '只有该行修改', 'C', '抛出异常', 'D', '无影响'), 
    1, 
    JSON_ARRAY('提示1：乘法会复制引用', '提示2：修改子列表反映到所有共享引用', '提示3：应用推导避免此问题'), 
    '乘法复制同一子列表引用，修改会在所有行体现。', 
    'a=[[0]*3]*2; a[0][0]=1  # 同时影响 a[1][0]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1565, 
    105, 
    '浅拷贝与子对象', 
    '浅拷贝是否复制子对象？', 
    JSON_OBJECT('A', '否，仅复制顶层引用', 'B', '是，递归复制所有子对象', 'C', '有时会', 'D', '取决于 Python 版本'), 
    1, 
    JSON_ARRAY('提示1：浅拷贝只复制最外层容器', '提示2：子对象仍为同一引用', '提示3：需要 deepcopy 才能递归复制'), 
    '浅拷贝仅复制最外层容器，对子对象仍为引用。', 
    'b = a[:]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1566, 
    105, 
    '复制性能', 
    '复制大列表的成本通常是？', 
    JSON_OBJECT('A', 'O(n)', 'B', 'O(1)', 'C', 'O(n^2)', 'D', '恒定时间'), 
    1, 
    JSON_ARRAY('提示1：需要逐元素复制', '提示2：成本随元素数量线性增长', '提示3：深拷贝更昂贵'), 
    '复制列表需要逐元素复制（浅拷贝），时间复杂度为 O(n)。', 
    'b = a[:]
'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1567, 
    105, 
    '浅拷贝函数', 
    '下列哪个函数用于浅拷贝？', 
    JSON_OBJECT('A', 'copy.copy', 'B', 'copy.deepcopy', 'C', 'deepcopy.copy', 'D', 'list.deep'), 
    1, 
    JSON_ARRAY('提示1：copy.copy 为浅拷贝', '提示2：deepcopy 为深拷贝', '提示3：需 import copy'), 
    'copy.copy 做浅拷贝，copy.deepcopy 做深拷贝。', 
    'import copy; b = copy.copy(a)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1568, 
    105, 
    '推荐复制方式', 
    '若只需复制顶层并保持子对象共享，应使用？', 
    JSON_OBJECT('A', '浅拷贝（切片或 copy()）', 'B', '深拷贝', 'C', '直接赋值', 'D', '序列化再反序列化'), 
    1, 
    JSON_ARRAY('提示1：浅拷贝复制顶层容器而保持子对象共享', '提示2：深拷贝更昂贵', '提示3：直接赋值不会创建新对象'), 
    '浅拷贝复制顶层容器而保持子对象共享，适用于无需独立子对象时。', 
    'b = a.copy()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1569, 
    105, 
    '复制后修改顶层', 
    '对浅拷贝后的新列表直接重新赋值某个索引会怎样？', 
    JSON_OBJECT('A', '只影响新列表的该索引', 'B', '也会影响原列表', 'C', '抛出异常', 'D', '同时删除原列表'), 
    1, 
    JSON_ARRAY('提示1：顶层容器是独立的', '提示2：修改索引会改变新列表绑定', '提示3：子对象仍然共享'), 
    '浅拷贝后顶层容器是独立对象，对新列表索引赋值不会改变原列表。', 
    'b = a[:]; b[0] = 9'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1570,
    105,
    '切片复制（填空）',
    '用切片复制列表并打印两个 id 是否相等（应为 False）。',
    NULL,
    JSON_ARRAY('False'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = [1,2]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "b = a["}, {"type": "slot", "index": 0}, {"type": "code", "value": "]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(id(a) == id(b))"}]}]}',
    JSON_ARRAY(':', ':1', '1:', '::', '::2'),
    JSON_ARRAY(1),
    'a[:] 生成浅拷贝，id 不相等。',
    'b = a[:]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1571,
    105,
    'copy 方法（填空）',
    '使用列表的 copy() 方法复制并打印是否为不同对象。',
    NULL,
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = [1]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "b = a."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(id(a) != id(b))"}]}]}',
    JSON_ARRAY('copy', 'clone', 'deepcopy', 'slice'),
    JSON_ARRAY(1),
    'a.copy() 返回浅拷贝，id 值不同。',
    'b = a.copy()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1572,
    105,
    '浅拷贝示例（填空）',
    '对包含子列表的列表做浅拷贝并修改子列表，观察原列表变化。',
    NULL,
    JSON_ARRAY('[[1, 2]]'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = [[1]]"}, {"type": "code_line", "value": "b = a[:]"}, {"type": "code_line", "value": "b[0].append(2)"}, {"type": "code_line", "value": "print(a)"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(),
    '浅拷贝后修改子列表会影响原列表，因为子列表引用相同。',
    '输出 [[1,2]]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1573,
    105,
    '深拷贝导入（填空）',
    '使用 deepcopy 需要先导入哪个模块？',
    NULL,
    JSON_ARRAY('ok'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"ok\")"}]}]}',
    JSON_ARRAY('import copy', 'from copy import deepcopy', 'import deepcopy', 'import copy.deepcopy'),
    JSON_ARRAY(1, 2),
    '可用 import copy 然后 copy.deepcopy 或直接 from copy import deepcopy。',
    'import copy; b = copy.deepcopy(a)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1574,
    105,
    '拷贝 id 对比（填空）',
    '验证 a.copy() 后 id 不相等并打印布尔值。',
    NULL,
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = [1]"}, {"type": "code_line", "value": "b = a.copy()"}, {"type": "code_line", "value": "print(id(a) != id(b))"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(),
    '浅拷贝会生成新对象，id 不相等。',
    'b = a.copy()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1575,
    105,
    '深拷贝示例（填空）',
    '使用 deepcopy 复制后修改子列表不会影响原列表。',
    NULL,
    JSON_ARRAY('[[1]]'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import copy"}, {"type": "code_line", "value": "a = [[1]]"}, {"type": "code_line", "value": "b = copy.deepcopy(a)"}, {"type": "code_line", "value": "b[0].append(2)"}, {"type": "code_line", "value": "print(a)"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(),
    '深拷贝递归复制，不共享子对象，故原列表不受影响。',
    'a remains [[1]]'
);