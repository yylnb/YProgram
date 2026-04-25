USE `questions`;
-- Unit 19 | Start ID: 271
-- Generated at 2025-12-24 23:03:26

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    271, 
    19, 
    '判断关键词是否存在', 
    '你正在做一个搜索框功能，需要判断用户输入的关键词是否在商品标题中，应该使用哪种写法？', 
    JSON_OBJECT('A', 'title has keyword', 'B', 'keyword in title', 'C', 'keyword inside title', 'D', 'title.contains(keyword)'), 
    2, 
    JSON_ARRAY('Python 判断“是否包含”有固定语法。', '想想之前学过的字符串判断方式。', 'in 是 Python 判断包含关系的标准关键字。'), 
    '"keyword in title" 用于判断 keyword 是否出现在 title 中，是 Python 标准语法。', 
    '例如：if "apple" in product_name: print("找到苹果相关商品")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    272, 
    19, 
    'not in 的基本用途', 
    '小王想检查一个用户名里不能含有空格，应使用哪条判断语句？', 
    JSON_OBJECT('A', '" " out username', 'B', '" " not_in username', 'C', '" " not in username', 'D', 'username.exclude(" ")'), 
    3, 
    JSON_ARRAY('Python 中只有一个关键字表示“不是包含”。', '注意关键字之间是否有空格。', 'not in 是标准用法。'), 
    '" " not in username 用来判断字符串中不包含空格。', 
    '例如：if "@" not in email: print("邮箱格式错误")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    273, 
    19, 
    'in 判断返回结果类型', 
    '执行表达式 "py" in "python" 会返回什么类型？', 
    JSON_OBJECT('A', '字符串', 'B', '整数', 'C', '布尔值', 'D', 'None'), 
    3, 
    JSON_ARRAY('判断语句的结果一般用于条件判断。', '想想 in 最终是告诉你“是否包含”。', '是 True 或 False。'), 
    '"py" in "python" 会返回布尔值 True。', 
    '例如："cat" in "dogcat" → True'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    274,
    19,
    '判断文本是否包含标记',
    '小张想判断消息中是否包含警告标记。',
    'msg = "[Warning] Low Battery"',
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(\"Warning\" "}, {"type": "slot", "index": 0}, {"type": "code", "value": " msg)"}]}]}',
    JSON_ARRAY('in', 'not in', '==', '+', '-', 'and'),
    JSON_ARRAY(1),
    '判断某内容是否在字符串中，使用 in。',
    '例如：print("Hi" in "Hi Python")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    275,
    19,
    '判断禁用词',
    '以下代码用于判断评论中是否没有出现禁用词。',
    'text = "I love programming"',
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(\"badword\" "}, {"type": "slot", "index": 0}, {"type": "code", "value": " text)"}]}]}',
    JSON_ARRAY('in', 'not in', '==', '!=', 'or', 'and'),
    JSON_ARRAY(2),
    '不包含使用 not in。',
    '例如：print("error" not in "success message")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    276, 
    19, 
    'split 的分割结果', 
    '执行 "a,b,c".split(",") 会得到什么？', 
    JSON_OBJECT('A', '("a","b","c")', 'B', '["a","b","c"]', 'C', '"abc"', 'D', '{"a","b","c"}'), 
    2, 
    JSON_ARRAY('split 返回的不是字符串。', '也不是元组。', 'split 返回列表。'), 
    'split 会返回一个列表。', 
    '"1 2 3".split() → ["1","2","3"]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    277, 
    19, 
    'join 的核心作用', 
    '"-".join(["a","b","c"]) 的作用是什么？', 
    JSON_OBJECT('A', '删除所有 "-"', 'B', '把列表转成字符串并用 "-" 连接', 'C', '把字符串切成三部分', 'D', '生成列表'), 
    2, 
    JSON_ARRAY('join 的作用与 split 相反。', '它用某字符串作为“连接符”。', '连接后的结果是一个完整字符串。'), 
    'join 用连接符将列表元素合并成新的字符串。', 
    '" ".join(["Hello","World"]) → "Hello World"'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    278, 
    19, 
    'split 默认分隔符', 
    '执行 "hello world python".split() 默认按什么分割？', 
    JSON_OBJECT('A', '空格和制表符等空白字符', 'B', '逗号', 'C', '不分割', 'D', '下划线'), 
    1, 
    JSON_ARRAY('默认不是逗号。', '想想 split() 的常用默认行为。', '默认按“空白字符”分割。'), 
    '不传入参数时 split 会按照空白字符切割。', 
    '"a\tb c".split() → ["a","b","c"]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    279,
    19,
    '使用 split 提取单词',
    '补全代码，让程序将句子切分成单词列表。',
    's = "I love Python"',
    JSON_ARRAY('[\'I\',\'love\',\'Python\']'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "words = s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(words)"}]}]}',
    JSON_ARRAY('split', 'join', 'replace', 'find', 'upper', 'lower'),
    JSON_ARRAY(1),
    '无参数版 split 自动按空白分割。',
    '"good day".split()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    280,
    19,
    '使用 join 拼接路径',
    '补全代码，使列表中的路径段拼接成有效路径。',
    'parts = [\'usr\', \'local\', \'bin\']',
    JSON_ARRAY('usr/local/bin'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "path = \"/\"."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(parts)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(path)"}]}]}',
    JSON_ARRAY('join', 'split', 'replace', '+', 'upper', 'lower'),
    JSON_ARRAY(1),
    '使用 "/" 作为连接符并调用 join。',
    '":".join(["a","b","c"])'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    281, 
    19, 
    '判断子串前后大小写差异', 
    '执行 "Py" in "python" 会得到什么？', 
    JSON_OBJECT('A', 'True', 'B', 'False', 'C', '报错', 'D', '"py"'), 
    2, 
    JSON_ARRAY('in 是区分大小写的。', '"Py" 和 "py" 有区别。', '大小写不同则不会匹配。'), 
    '字符串比较严格区分大小写。', 
    '"AB" in "abc" → False'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    282, 
    19, 
    '检测用户黑名单', 
    '下列哪种写法能正确判断用户 "Tim" 是否在黑名单列表 black？', 
    JSON_OBJECT('A', '"Tim" in black', 'B', 'Tim in black', 'C', 'black in "Tim"', 'D', '"Tim" contains black'), 
    1, 
    JSON_ARRAY('判断某元素是否在某集合或列表中。', '注意字符串是否需要引号。', 'in 能用于列表判断。'), 
    '判断是否属于列表成员，使用元素 in 列表。', 
    '"Lucy" in ["Amy","Lucy","Tom"]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    283, 
    19, 
    'not in 的典型使用场景', 
    '如果你想检查密码中不能包含空格，应该用哪种写法？', 
    JSON_OBJECT('A', 'password not_in " "', 'B', '" " not in password', 'C', 'password not include " "', 'D', '" " out password'), 
    2, 
    JSON_ARRAY('注意 not in 的写法是否连写。', '字符串必须放在前或后。', 'not in 是唯一正确语法。'), 
    'not in 用于判断某元素不在对象中。', 
    '" " not in "HelloWorld"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    284,
    19,
    '邮箱格式简单判断',
    '补全代码，判断邮箱中是否包含 "@".',
    'email = "user@example.com"',
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(\"@\" "}, {"type": "slot", "index": 0}, {"type": "code", "value": " email)"}]}]}',
    JSON_ARRAY('in', 'not in', '==', '!=', '+', 'or', 'find'),
    JSON_ARRAY(1),
    'in 用于检查是否存在某字符。',
    '"@" in "abc@xyz"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    285,
    19,
    '判断文本不含敏感词',
    '补全代码，使程序输出 True。',
    'txt = "This is a normal message"',
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print(\"spam\" "}, {"type": "slot", "index": 0}, {"type": "code", "value": " txt)"}]}]}',
    JSON_ARRAY('in', 'not in', '==', '!=', '-', 'join'),
    JSON_ARRAY(2),
    'not in 用于检查“不包含”。',
    '"dog" not in "cat tree"'
);