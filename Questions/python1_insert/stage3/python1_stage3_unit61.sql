USE `questions`;

--
-- Unit 61: while 循环基础
--

-- Question 1 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(1, 61, 'while 的基本功能', 'while 循环通常用于？', JSON_OBJECT('A', '在条件为真时重复执行', 'B', '只执行一次', 'C', '用来定义函数', 'D', '声明变量'), 1, 'while 根据条件判断是否继续执行循环体。', JSON_ARRAY('循环依赖条件', '常用于未知次数重复', '条件为假则不执行'), 'while i<5: i+=1');

-- Question 2 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(2, 61, '条件求值时机', 'while 在每次迭代什么时候判断条件？', JSON_OBJECT('A', '进入迭代前判断', 'B', '执行后判断', 'C', '只判断一次', 'D', '不判断'), 1, '每次迭代前都会先判断条件是否仍为真。', JSON_ARRAY('每次开始前检查条件', '类似门控', '迭代前求值'), 'while cond: ...');

-- Question 3 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(3, 61, '空循环体', '如果 while 条件初始为 False，循环体会怎样？', JSON_OBJECT('A', '一次也不执行', 'B', '执行一次', 'C', '无限执行', 'D', '抛出异常'), 1, '若条件初始为 False 则循环体一次也不执行。', JSON_ARRAY('条件为假不会进入循环体', '空循环不会执行', '迭代为零次'), 'while False: print(1)');

-- Question 4 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(4, 61, '写出最简单的 while', '补全：打印 1 到 3。', JSON_OBJECT('segments', JSON_ARRAY(JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
    JSON_OBJECT('type', 'code_line', 'value', 'i = 1'),
    JSON_OBJECT('type', 'code_line', 'value', 'while i <= 3:'),
    JSON_OBJECT('type', 'code_line', 'value', '    print(i)'),
    JSON_OBJECT('type', 'code_line', 'value', '    i += 1')
)))), JSON_ARRAY('示例已给出'), JSON_ARRAY(1), '', '1\n2\n3', '使用计数器控制循环次数。', NULL);

-- Question 5 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(5, 61, '改变循环变量', '补全：若不改变 i 会怎样？', JSON_OBJECT('segments', JSON_ARRAY(JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
    JSON_OBJECT('type', 'code_line', 'value', 'i = 0'),
    JSON_OBJECT('type', 'code_line', 'value', 'while i < 3:'),
    JSON_OBJECT('type', 'code_line', 'value', '    print(i)'),
    JSON_OBJECT('type', 'code_line', 'value', '    # missing i += 1')
)))), JSON_ARRAY('示例已给出'), JSON_ARRAY(1), '', '', '未改变循环变量会导致无限循环。', NULL);

-- Question 6 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(6, 61, '初始化重要性', '循环变量应在何处初始化？', JSON_OBJECT('A', '循环外部初始化', 'B', '循环内部每次初始化', 'C', '不需要初始化', 'D', '用函数返回'), 1, '循环变量通常在循环外初始化，以便在循环中更新状态。', JSON_ARRAY('外部初始化才能被循环体使用并更新', '避免每次重置', '变量需在循环外定义'), 'i = 0\nwhile i<3: ...');

-- Question 7 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(7, 61, 'while 用例', '哪种情形更适合用 while？', JSON_OBJECT('A', '未知迭代次数、基于条件停止', 'B', '已知固定次数', 'C', '只执行一次任务', 'D', '不需要循环'), 1, 'while 适合未知次数迭代，直到某个条件满足才停止。', JSON_ARRAY('例如等待输入达到某条件', '或等待外部事件', '适合条件驱动循环'), 'while not done: ...');

-- Question 8 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(8, 61, '资源消耗风险', '无条件 while 循环可能导致？', JSON_OBJECT('A', 'CPU 占用过高或冻结', 'B', '自动退出', 'C', '降低内存', 'D', '提高安全'), 1, '未妥善设置退出条件的 while 可能导致程序无法终止并消耗资源。', JSON_ARRAY('无限循环会持续消耗资源', '需注意退出条件', '避免 busy-waiting'), 'while True: pass');

-- Question 9 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(9, 61, '等待输入示例', '补全：循环直到用户输入 quit。', JSON_OBJECT('segments', JSON_ARRAY(JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
    JSON_OBJECT('type', 'code_line', 'value', 'while True:'),
    JSON_OBJECT('type', 'code_line', 'value', '    s = input()'),
    JSON_OBJECT('type', 'code_line', 'value', '    if s == "quit":'),
    JSON_OBJECT('type', 'code_line', 'value', '        break')
)))), JSON_ARRAY('示例已给出'), JSON_ARRAY(1), 'quit', '', '通过判断输入并 break 退出循环。', NULL);

-- Question 10 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(10, 61, '防止无限循环', '补全：在循环中加入安全计数。', JSON_OBJECT('segments', JSON_ARRAY(JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
    JSON_OBJECT('type', 'code_line', 'value', 'i = 0'),
    JSON_OBJECT('type', 'code_line', 'value', 'while cond:'),
    JSON_OBJECT('type', 'code_line', 'value', '    do_work()'),
    JSON_OBJECT('type', 'code_line', 'value', '    i += 1'),
    JSON_OBJECT('type', 'code_line', 'value', '    if i > 1000:'),
    JSON_OBJECT('type', 'code_line', 'value', '        break')
)))), JSON_ARRAY('示例已给出'), JSON_ARRAY(1), '', '', '安全计数可防止意外的长期运行。', NULL);

-- Question 11 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(11, 61, '循环退出方式', '除了条件变为 False 外，还可用什么退出 while？', JSON_OBJECT('A', '使用 break', 'B', '只有条件能退出', 'C', '使用 continue', 'D', '无法退出'), 1, 'break 可立即退出循环体并跳到循环外。', JSON_ARRAY('break 强制退出循环', '常用于中间终止', '跳出循环并继续后续代码'), 'if found: break');

-- Question 12 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(12, 61, 'continue 的作用', '在 while 中使用 continue 会怎样？', JSON_OBJECT('A', '跳过本次余下语句并进入下一次判断', 'B', '退出循环', 'C', '终止程序', 'D', '回到函数开头'), 1, 'continue 会立即开始下一次循环判断，跳过本次后续语句。', JSON_ARRAY('跳过后续语句', '直接重新判断条件', '用于略过当前迭代'), 'if bad: continue');

-- Question 13 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(13, 61, 'while 与 for 对比', '下面关于 while vs for 的说法正确的是？', JSON_OBJECT('A', 'while 适合未知次数循环，for 适合遍历序列', 'B', 'for 只能用在列表上', 'C', 'while 更简洁遍历序列', 'D', '两者完全相同'), 1, '一般用 while 做条件循环，用 for 遍历序列。', JSON_ARRAY('用途侧重点不同', '选择语义更清晰的一种', '遍历用 for，条件用 while'), 'while cond vs for x in seq');

-- Question 14 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(14, 61, '循环内打印计数', '补全：在循环中打印每次 i 的值。', JSON_OBJECT('segments', JSON_ARRAY(JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
    JSON_OBJECT('type', 'code_line', 'value', 'i = 0'),
    JSON_OBJECT('type', 'code_line', 'value', 'while i < 3:'),
    JSON_OBJECT('type', 'code_line', 'value', '    print(i)'),
    JSON_OBJECT('type', 'code_line', 'value', '    i += 1')
)))), JSON_ARRAY('示例已给出'), JSON_ARRAY(1), '', '0\n1\n2', '打印计数器并在每次迭代更新。', NULL);

-- Question 15 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(15, 61, '循环与布尔变量', '补全：使用 flag 控制循环。', JSON_OBJECT('segments', JSON_ARRAY(JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
    JSON_OBJECT('type', 'code_line', 'value', 'running = True'),
    JSON_OBJECT('type', 'code_line', 'value', 'while running:'),
    JSON_OBJECT('type', 'code_line', 'value', '    cmd = input()'),
    JSON_OBJECT('type', 'code_line', 'value', '    if cmd == "exit":'),
    JSON_OBJECT('type', 'code_line', 'value', '        running = False')
)))), JSON_ARRAY('示例已给出'), JSON_ARRAY(1), '', '', '用布尔变量控制循环状态是常见模式。', NULL);
