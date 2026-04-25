USE `questions`;
-- Unit 104 | Start ID: 1546
-- Generated at 2025-12-24 18:13:42

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1546, 
    104, 
    '栈的实现', 
    '使用列表实现栈，入栈与出栈常用哪两个方法？', 
    JSON_OBJECT('A', 'append 和 pop', 'B', 'insert 和 remove', 'C', 'extend 和 pop', 'D', 'push 和 pop'), 
    1, 
    JSON_ARRAY('提示1：append 到末尾，pop 从末尾弹出', '提示2：列表没有 push 方法', '提示3：这是 LIFO 行为'), 
    '使用 append 和 pop 可把列表当作 LIFO 栈实现。', 
    'stack.append(x); x = stack.pop()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1547, 
    104, 
    '队列的低效实现', 
    '用列表实现队列并频繁在头部 pop(0) 会怎样？', 
    JSON_OBJECT('A', '性能低下，O(n) 每次操作', 'B', '性能很好，O(1)', 'C', '会抛出异常', 'D', '无法实现'), 
    1, 
    JSON_ARRAY('提示1：从头部删除会导致元素移动', '提示2: 应使用 collections.deque 更高效', '提示3: pop(0) 是线性时间'), 
    '从列表头部插入或删除会导致元素移动，效率为 O(n)，推荐使用 deque。', 
    'from collections import deque'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1548, 
    104, 
    'deque 优势', 
    'collections.deque 相比列表的优点是？', 
    JSON_OBJECT('A', '左右两端插入删除效率高', 'B', '更节省内存', 'C', '自动排序', 'D', '只能存放数字'), 
    1, 
    JSON_ARRAY('提示1：deque 为双向队列', '提示2: \'appendleft/pop left 操作是 O(1)', '提示3: \'适合实现队列'), 
    'deque 在两端插入和删除均为 O(1)，适合做队列或双端操作。', 
    'd = deque(); d.appendleft(1)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1549, 
    104, 
    'FIFO 与 LIFO', 
    '队列与栈的区别是？', 
    JSON_OBJECT('A', '队列是 FIFO，栈是 LIFO', 'B', '队列是 LIFO，栈是 FIFO', 'C', '两者相同', 'D', '与数据结构无关'), 
    1, 
    JSON_ARRAY('提示1：队列先进先出', '提示2：栈后进先出', '提示3: \'用法场景不同'), 
    '队列（FIFO）和栈（LIFO）是不同的抽象数据结构。', 
    'queue vs stack'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1550, 
    104, 
    'list insert 作为队列', 
    '若使用 lst.insert(0,x) 做入队，会有什么影响？', 
    JSON_OBJECT('A', '每次插入成本高，O(n)', 'B', '效率高，O(1)', 'C', '无法实现', 'D', '不改变列表'), 
    1, 
    JSON_ARRAY('提示1：插入头部会导致元素移动', '提示2: 推荐使用 deque', '提示3: insert(0,x) 是线性时间'), 
    'insert(0,x) 会把元素插入头部并移动后续元素，时间复杂度为 O(n)。', 
    'lst.insert(0,1)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1551, 
    104, 
    'deque 方法', 
    'deque 提供哪个方法可高效从左端弹出？', 
    JSON_OBJECT('A', 'popleft', 'B', 'popleft', 'C', 'pop', 'D', 'shift'), 
    1, 
    JSON_ARRAY('提示1：deque 有 popleft 和 appendleft', '提示2: \'popleft 为 O(1)', '提示3: \'pop 用于右端'), 
    'deque.popleft() 可在左端常数时间弹出元素。', 
    'd.popleft()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1552, 
    104, 
    'LRU 缓存与 deque', 
    '实现简单的 LRU 缓存时 deque 哪个操作有用？', 
    JSON_OBJECT('A', 'appendleft 与 pop', 'B', 'extend', 'C', 'clear', 'D', 'sort'), 
    1, 
    JSON_ARRAY('提示1：需要在左侧快速插入最新项', '提示2: 过期项从右侧弹出', '提示3: deque 支持两端操作'), 
    'LRU 常把最新项放在左端（或右端），使用 appendleft 和 pop 可高效维护顺序。', 
    'd.appendleft(item); d.pop()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1553, 
    104, 
    'list 作为栈的限制', 
    '列表作为栈的主要限制是什么？', 
    JSON_OBJECT('A', '当频繁从头部操作时效率低', 'B', '不能存放对象', 'C', '只能用于整数', 'D', '不支持并发'), 
    1, 
    JSON_ARRAY('提示1：列表尾部操作为 O(1)', '提示2: \'头部操作为 O(n)', '提示3: \'deque 更合适做双端队列'), 
    '列表用于栈（尾部操作）是高效的，但若需要头部插入/删除则效率下降。', 
    'stack.append/pop 高效'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1554, 
    104, 
    '性能建议', 
    '实现高性能队列应优先使用？', 
    JSON_OBJECT('A', 'collections.deque', 'B', 'list', 'C', 'tuple', 'D', 'set'), 
    1, 
    JSON_ARRAY('提示1：deque 提供 O(1) 两端操作', '提示2: list 的头部操作为 O(n)', '提示3: tuple 不支持修改'), 
    'deque 支持高效的两端插入与弹出，适合队列用途。', 
    'from collections import deque'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1555,
    104,
    '栈操作示例（填空）',
    '把输入的数字依次入栈后出栈并打印顺序。',
    '1 2 3',
    JSON_ARRAY('3 2 1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "stack = []"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x in lst:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    stack."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(x)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while stack:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(stack."}, {"type": "slot", "index": 1}, {"type": "code", "value": "(), end=\" \")"}]}]}',
    JSON_ARRAY('append', 'extend', 'pop', 'pop(0)'),
    JSON_ARRAY(1, 3),
    '用 append 入栈，用 pop 弹出最新元素实现 LIFO。',
    'stack.append(1); stack.pop()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1556,
    104,
    '队列操作（填空）',
    '用列表模拟队列，从头部取出元素并打印（示范低效方法）。',
    '1 2 3',
    JSON_ARRAY('1 2 3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while lst:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(lst."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(0), end=\" \")"}]}]}',
    JSON_ARRAY('pop', 'pop(0)', 'remove', 'append'),
    JSON_ARRAY(2),
    'pop(0) 从头部移除元素并返回，但对长列表效率低。',
    'lst.pop(0)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1557,
    104,
    'deque 示例（填空）',
    '用 deque 实现队列，左入右出并打印出队元素。',
    '1 2',
    JSON_ARRAY('1 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from collections import deque"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "d = deque()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x in map(int, input().split()):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    d.append(x)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while d:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(d."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(), end=\" \")"}]}]}',
    JSON_ARRAY('popleft', 'pop', 'appendleft', 'append'),
    JSON_ARRAY(1),
    '使用 popleft 实现从左端出队。',
    'd.popleft()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1558,
    104,
    '栈顶访问（填空）',
    '不弹出只查看栈顶元素并打印。',
    '5 6',
    JSON_ARRAY('6'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
    JSON_ARRAY('-1', '0', '1', 'len(s)'),
    JSON_ARRAY(1),
    '栈顶为列表末尾元素，可用 s[-1] 访问。',
    'top = stack[-1]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1559,
    104,
    '模拟队列（填空）',
    '用 deque 将输入按顺序出队并打印。',
    '7 8',
    JSON_ARRAY('7 8'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from collections import deque"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "d = deque(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while d:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(d."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(), end=\" \")"}]}]}',
    JSON_ARRAY('pop', 'popleft', 'append', 'appendleft'),
    JSON_ARRAY(2),
    'popleft 从左端出队，符合 FIFO 行为。',
    'd.popleft()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1560,
    104,
    '栈长度（填空）',
    '入栈 3 个元素后栈长度为多少？',
    '1 2 3',
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "stack = []"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x in input().split():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    stack.append(int(x))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(len(stack))"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(),
    'append 三次后 len 返回 3。',
    'len(stack)'
);