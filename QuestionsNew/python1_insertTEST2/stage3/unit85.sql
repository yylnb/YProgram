USE `questions`;
-- Unit 85 | Start ID: 1261
-- Generated at 2025-12-24 23:24:44

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1261, 
    85, 
    '栈 LIFO', 
    '栈的访问顺序是？', 
    JSON_OBJECT('A', '后进先出', 'B', '先进先出', 'C', '随机', 'D', '按优先级'), 
    1, 
    JSON_ARRAY('push/pop 的 LIFO 行为'), 
    '栈遵循后进先出（LIFO），最新入栈的元素最先被弹出。', 
    'stack.append(x); stack.pop()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1262, 
    85, 
    '队列 FIFO', 
    '队列的访问顺序是？', 
    JSON_OBJECT('A', '先进先出', 'B', '后进先出', 'C', '随机', 'D', '按索引'), 
    1, 
    JSON_ARRAY('队列用于按顺序处理任务'), 
    '队列遵循先进先出（FIFO），先入队的元素先被处理。', 
    'from collections import deque'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1263, 
    85, 
    'heap 用途', 
    'heapq 常用于实现？', 
    JSON_OBJECT('A', '优先队列', 'B', 'FIFO 队列', 'C', '栈', 'D', '字典'), 
    1, 
    JSON_ARRAY('heapq.top 返回最小值', '常用于取最小/最大k元素'), 
    'heapq 提供基于堆的数据结构，用于实现优先队列等操作。', 
    'import heapq'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1264,
    85,
    '栈示例',
    '补全：用列表模拟栈，入栈后弹出并打印。',
    '1 2',
    JSON_ARRAY('2 1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s=[]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x in input().split():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    s.append(int(x))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while s:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(s.pop(), end=\" \")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '列表的 append/pop 可方便模拟栈行为。',
    's.append(x)
s.pop()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1265,
    85,
    '队列示例',
    '补全：用 deque 实现队列并出队打印。',
    '1 2',
    JSON_ARRAY('1 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from collections import deque"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "q=deque(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while q:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(q.popleft(), end=\" \")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'deque 的 popleft 提供高效的队头出队操作。',
    'q.popleft()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1266, 
    85, 
    'heapq 最小堆', 
    'heapq 默认实现的是？', 
    JSON_OBJECT('A', '最小堆', 'B', '最大堆', 'C', '平衡树', 'D', '哈希堆'), 
    1, 
    JSON_ARRAY('heapq 返回最小元素'), 
    'heapq 是最小堆实现，push/pop 会维护最小元素在堆顶。', 
    'heapq.heappop(h)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1267, 
    85, 
    '适用场景', 
    '遇到需要快速取 top-k 元素时推荐使用？', 
    JSON_OBJECT('A', '堆（heapq）', 'B', 'list 排序每次取', 'C', '字典', 'D', 'set'), 
    1, 
    JSON_ARRAY('堆维护部分有序性更节省时间'), 
    '使用堆可以在 O(n log k) 时间内获取前 k 个元素，比全排序更高效。', 
    'heapq.nlargest(k, nums)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1268, 
    85, 
    'deque 优势', 
    'deque 与 list 在队头出队操作相比？', 
    JSON_OBJECT('A', 'deque 更高效', 'B', 'list 更高效', 'C', '两者相同', 'D', 'deque 无效'), 
    1, 
    JSON_ARRAY('list 在头部操作是 O(n) 而 deque 为 O(1)'), 
    'deque 在队头插入/弹出为 O(1)，适合实现队列操作。', 
    'from collections import deque'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1269,
    85,
    '堆取 top-k',
    '补全：用 heapq 取前三大值示例。',
    '1 5 3 4',
    JSON_ARRAY('5 4 3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import heapq"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "arr=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(heapq.nlargest(3, arr))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'heapq.nlargest 直接返回 top-k 元素，内部使用堆实现。',
    'heapq.nlargest(k, iterable)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1270,
    85,
    '模拟栈应用',
    '补全：判断括号匹配用栈示例。',
    '()[]',
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s=[]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for ch in input().strip():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if ch in \"([\": s.append(ch)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        if not s: print(False); break"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        s.pop()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(not s)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '括号匹配经典用栈保存左括号并匹配右括号。',
    'stack usage'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1271, 
    85, 
    '优先队列更新', 
    '要在优先队列中更新某元素优先级常用做法是？', 
    JSON_OBJECT('A', '推入新元组并忽略旧元组', 'B', '直接修改堆中元素', 'C', 'pop 所有并重建', 'D', 'heapq 提供 update'), 
    1, 
    JSON_ARRAY('常用惰性删除策略推入新元素并标记旧元素无效'), 
    'heapq 没有直接更新接口，常用方法是推入带更新优先级的新元组并用标志忽略旧元组。', 
    'push new, mark old as removed'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1272, 
    85, 
    '栈的应用场景', 
    '栈常用于实现哪类算法？', 
    JSON_OBJECT('A', '深度优先搜索、表达式求值', 'B', '广度优先搜索', 'C', '哈希查找', 'D', '排序'), 
    1, 
    JSON_ARRAY('DFS 天然用栈实现'), 
    '栈适合实现 DFS、括号匹配、表达式求值等后进先出场景。', 
    'DFS iterative'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1273, 
    85, 
    '队列的应用', 
    '队列常用于？', 
    JSON_OBJECT('A', '任务调度与 BFS', 'B', '深度优先搜索', 'C', '堆实现', 'D', '字符串拼接'), 
    1, 
    JSON_ARRAY('任务按顺序处理或 BFS 使用队列'), 
    '队列适合按顺序处理任务或实现广度优先搜索。', 
    'from collections import deque'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1274,
    85,
    '堆入堆出',
    '补全：初始化堆并弹出最小值。',
    '3 1 2',
    JSON_ARRAY('1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import heapq"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "arr=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "heapq.heapify(arr)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(heapq.heappop(arr))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'heapify 将列表转为堆结构，heappop 弹出最小元素。',
    'heapq.heapify(a)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1275,
    85,
    '队列处理',
    '补全：用 deque 实现宽度限制的缓存，超过限制则丢弃最旧元素。',
    '1 2 3 4',
    JSON_ARRAY('(depending on limit)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from collections import deque"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "q=deque(maxlen=3)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x in input().split():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    q.append(x)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*q)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'deque 支持 maxlen 自动丢弃最旧元素，方便做固定大小缓存。',
    'deque(maxlen=3)'
);