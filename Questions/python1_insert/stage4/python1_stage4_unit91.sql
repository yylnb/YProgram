USE `questions`;

--
-- Unit 91: 列表的创建
--

-- Question 1 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(1, 91, '列表定义', '下列哪个语句用于创建一个空列表？', JSON_OBJECT('A', '[]', 'B', '()', 'C', '{}', 'D', 'set()'), 1, '在 Python 中，[] 用于创建列表对象。', JSON_ARRAY('[] 是列表字面量', '() 是元组'), 'lst = []');

-- Question 2 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(2, 91, '列表包含类型', '列表可以包含哪些类型？', JSON_OBJECT('A', '任意 Python 对象', 'B', '仅数字', 'C', '仅字符串', 'D', '仅同类型元素'), 1, 'Python 列表可以包含任意对象，不要求同类型。', JSON_ARRAY('列表是动态且可存不同类型元素', '例如 int 和 str 同时存在'), '[1, "a", 3.0]');

-- Question 3 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(3, 91, '列表构造', '使用 list() 可以从什么创建列表？', JSON_OBJECT('A', '可迭代对象', 'B', '仅字符串', 'C', '仅数字序列', 'D', '不可从别的创建'), 1, 'list() 会把可迭代对象的元素收集为列表。', JSON_ARRAY('list 可以接收迭代器或生成器'), 'list(range(3)) -> [0,1,2]');

-- Question 4 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(4, 91, '从输入创建列表', '补全：从空格分隔输入创建整数列表。', JSON_OBJECT('segments', JSON_ARRAY(JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
    JSON_OBJECT('type', 'code_line', 'value', 'lst = list(map(int, input().split()))'),
    JSON_OBJECT('type', 'code_line', 'value', 'print(lst)')
)))), JSON_ARRAY('map', 'int', 'split', 'list'), JSON_ARRAY(1, 2, 3, 4), '1 2 3', '[1,2,3]', '使用 split 切分并 map 转为 int，再用 list 收集。', NULL);

-- Question 5 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(5, 91, '快速构建', '补全：生成包含 0..4 的列表。', JSON_OBJECT('segments', JSON_ARRAY(JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
    JSON_OBJECT('type', 'code_line', 'value', 'lst = list(range(5))'),
    JSON_OBJECT('type', 'code_line', 'value', 'print(lst)')
)))), JSON_ARRAY('range', 'list', 'tuple', 'dict'), JSON_ARRAY(1, 2), '(none)', '[0,1,2,3,4]', 'range(5) 生成可迭代，list(range(5)) 产生列表。', NULL);

-- Question 6 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(6, 91, '空列表判断', '判断列表是否为空推荐写法？', JSON_OBJECT('A', 'if not lst:', 'B', 'if len(lst)==0:', 'C', 'if lst==[]:', 'D', '以上都可'), 4, '三种写法都有效，但 `if not lst` 更简洁常用。', JSON_ARRAY('多种写法可行', 'Pythonic 常用 if not lst'), 'if not lst: print("empty")');

-- Question 7 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(7, 91, '列表重复', '通过乘法构造重复元素列表如 3 个 0 的正确写法是？', JSON_OBJECT('A', '[0]*3', 'B', '[0,0,0]', 'C', 'repeat(0,3)', 'D', 'range(0,3)'), 1, '使用 [0]*3 可以快速得到 [0,0,0]。', JSON_ARRAY('乘法可缩写重复创建', '第二种写法等价但不简洁'), '[None]*n');

-- Question 8 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(8, 91, '列表与字符串转换', '把字符串 "abc" 转为列表结果是？', JSON_OBJECT('A', '["a","b","c"]', 'B', '["abc"]', 'C', '[a,b,c]', 'D', '不可转换'), 1, 'list("abc") 会按字符生成列表。', JSON_ARRAY('字符串是可迭代对象', 'list(s) 会把每个字符取出'), 'list("hello")');

-- Question 9 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(9, 91, '列表表达式', '补全：用列表推导生成 1..5 的平方。', JSON_OBJECT('segments', JSON_ARRAY(JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
    JSON_OBJECT('type', 'code_line', 'value', 'lst = [x*x for x in range(1,6)]'),
    JSON_OBJECT('type', 'code_line', 'value', 'print(lst)')
)))), JSON_ARRAY('[ ]', 'for', 'x*x', 'range'), JSON_ARRAY(1, 2, 3, 4), '(none)', '[1,4,9,16,25]', '列表推导可以紧凑地生成基于规则的新列表。', NULL);

-- Question 10 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(10, 91, '字符串分割', '补全：把逗号分隔的字符串转为列表并去空', JSON_OBJECT('segments', JSON_ARRAY(JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
    JSON_OBJECT('type', 'code_line', 'value', 's=input().strip()'),
    JSON_OBJECT('type', 'code_line', 'value', 'print([x for x in s.split(",") if x])')
)))), JSON_ARRAY('split', 'strip', 'join', 'replace'), JSON_ARRAY(1, 2), 'a,b,', '["a","b"]', 'split 得到所有片段，可用列表推导过滤空字符串。', NULL);

-- Question 11 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(11, 91, '列表是可变对象', '列表是否可变（mutable）？', JSON_OBJECT('A', '是', 'B', '否', 'C', '仅在函数内', 'D', '取决于实现'), 1, '列表是可变对象，方法如 append 会修改原列表。', JSON_ARRAY('可用索引修改元素', 'append 等方法会改变列表'), 'lst[0]=1');

-- Question 12 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(12, 91, '浅拷贝', '下列哪种操作会创建列表的浅拷贝？', JSON_OBJECT('A', 'lst.copy()', 'B', 'lst', 'C', 'for x in lst: new.append(x)', 'D', 'list(lst)'), 1, 'lst.copy() 和 list(lst) 都会创建浅拷贝。', JSON_ARRAY('list(lst) 也会创建新列表', 'C 也间接创建新列表'), 'b = a.copy()');

-- Question 13 (Choice)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `hints`, `example`)
VALUES
(13, 91, 'list 转 tuple', '把列表转换为元组用什么函数？', JSON_OBJECT('A', 'tuple', 'B', 'list', 'C', 'set', 'D', 'dict'), 1, '使用 tuple(lst) 可以得到对应的元组。', JSON_ARRAY('tuple(lst) 将返回不可变的元组表示'), 'tuple([1,2])');

-- Question 14 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(14, 91, '延展列表', '补全：合并两个列表为一个', JSON_OBJECT('segments', JSON_ARRAY(JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
    JSON_OBJECT('type', 'code_line', 'value', 'a=list(map(int,input().split()))'),
    JSON_OBJECT('type', 'code_line', 'value', 'b=list(map(int,input().split()))'),
    JSON_OBJECT('type', 'code_line', 'value', 'print(a + b)')
)))), JSON_ARRAY('+', 'extend', 'append', 'insert'), JSON_ARRAY(1, 2), '1 2\n3 4', '[1,2,3,4]', '使用 + 或 extend 都可合并两个列表，+ 返回新列表，extend 就地扩展。', NULL);

-- Question 15 (Fill)
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `code`, `options`, `answer`, `input`, `output`, `explanation`, `hints`)
VALUES
(15, 91, '列表长度', '补全：打印输入列表长度', JSON_OBJECT('segments', JSON_ARRAY(JSON_OBJECT('type', 'code_block', 'lines', JSON_ARRAY(
    JSON_OBJECT('type', 'code_line', 'value', 'print(len(list(map(int,input().split()))))')
)))), JSON_ARRAY('len', 'list', 'map', 'input', 'split'), JSON_ARRAY(1, 2, 3, 4, 5), '1 2 3', '3', 'len 可返回容器元素个数。', NULL);
