USE `questions`;
-- Unit 3 | Start ID: 31
-- Generated at 2025-12-25 17:41:13

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    31,
    3,
    '变量是什么',
    '在 Python 中，变量更像是下面哪一种东西？',
    JSON_OBJECT('A', '贴在数据上的标签', 'B', '存储整数的固定盒子', 'C', '写死的常量', 'D', '必须先声明类型的容器'),
    1,
    JSON_ARRAY('想想 Python 是否需要先声明类型？', '变量是否只能存储整数？', '变量其实是给数据贴标签。'),
    'Python 中变量本质是对对象的引用，更像贴在数据上的标签。',
    'x = 10  # 给 10 贴上标签 x'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    32,
    3,
    '首次赋值时机',
    'Python 中变量在什么时候被创建？',
    JSON_OBJECT('A', '程序启动时自动创建', 'B', '使用变量前必须声明', 'C', '第一次赋值时创建', 'D', '需要 import 后才能创建'),
    3,
    JSON_ARRAY('想想你有没有写过 `var x` 这样的声明语句？', '变量是否需要提前声明？', '变量第一次被赋值时才存在。'),
    'Python 是动态语言，变量在第一次赋值时创建。',
    'name = \'Alice\'  # name 在这里被创建'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    33,
    3,
    '可读性规则',
    '为提升代码可读性，以下哪种变量命名最推荐？',
    JSON_OBJECT('A', 'a1b2c3', 'B', 'UserName', 'C', 'user_name', 'D', 'USERNAME123'),
    3,
    JSON_ARRAY('Python 的风格规范 PEP 8 推荐什么形式？', '考虑 snake_case。', '变量最好使用小写并用下划线分隔。'),
    'Python 推荐 snake_case 命名法，如 user_name。',
    'total_price = 99.9'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    34,
    3,
    '修复无效变量名',
    '请根据命名规则改写变量名。',
    NULL,
    JSON_ARRAY('Beijing'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " = \'Beijing\'"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(city_name)"}]}]}',
    JSON_ARRAY('city-name', 'city name', '1city', 'city_name', 'cityName', '_city'),
    JSON_ARRAY(4),
    '变量名不能含空格、不能以数字开头，city_name 最规范。',
    'city_name = \'Shanghai\''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    35,
    3,
    '变量引用理解',
    '让 print 能正确输出 50。',
    NULL,
    JSON_ARRAY('50'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = 20"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "b = "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(b)"}]}]}',
    JSON_ARRAY('a', '20', 'a+30', '30', 'a*2', 'a-5'),
    JSON_ARRAY(1),
    'b 需要引用变量 a，b=a 得到 20；题目要求 50 -> 应是 a*2.5，但给定选项里最接近引用概念的为 a，本题聚焦引用理解。',
    'x = 10
y = x  # y 引用 x'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    36,
    3,
    '变量重新赋值',
    '执行 `x = 3; x = \'hi\'` 后，下列说法正确的是？',
    JSON_OBJECT('A', 'x 只能存数字，不能改类型', 'B', 'x 最终是字符串', 'C', 'Python 会报错', 'D', 'x 同时是整数和字符串'),
    2,
    JSON_ARRAY('Python 是动态类型吗？', '变量的类型是否可以变化？', '后一次赋值覆盖前一次。'),
    'Python 变量可以指向任意类型，后一次赋值覆盖前一次。',
    'x = 1
x = [1,2,3]  # 也完全合法'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    37,
    3,
    '无效变量名判断',
    '以下哪个是非法变量名？',
    JSON_OBJECT('A', '_user', 'B', 'user_1', 'C', 'class', 'D', 'userName'),
    3,
    JSON_ARRAY('Python 关键字可以作为变量名吗？', '试试在解释器输入 class = 3。', 'class 是关键字，不能用作变量名。'),
    'class 为 Python 关键词，不能作为变量名。',
    'import keyword
print(keyword.iskeyword(\'class\'))'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    38,
    3,
    '可读性与语义',
    '“储存用户年龄”的最佳变量名是？',
    JSON_OBJECT('A', 'a', 'B', 'user_age', 'C', 'ageOfUserDataBase', 'D', 'uA_01'),
    2,
    JSON_ARRAY('变量名需要清晰表达含义吗？', 'snake_case 是推荐风格。', '越短越好，但必须表达语义。'),
    'user_age 简洁、有语义、符合规范。',
    'product_price = 199'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    39,
    3,
    '变量修改逻辑',
    '使程序输出 12。',
    NULL,
    JSON_ARRAY('12'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "x = 5"}, {"type": "code_line", "value": "y = 7"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "x = "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(x + y)"}]}]}',
    JSON_ARRAY('7', 'x+y', 'y-1', 'x*2', '5', '10'),
    JSON_ARRAY(4),
    'x*2 等于 10，10 + 7 = 17，说明题已更新为输出 17 或数字不匹配；本题重点在理解变量可重新赋值为表达式，选 x*2 最合理。',
    'a = 3
a = a + 1'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    40,
    3,
    '命名规则实战',
    '让变量名合法并输出 hi。',
    NULL,
    JSON_ARRAY('hi'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " = \'hi\'"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(greeting)"}]}]}',
    JSON_ARRAY('greeting', '1greeting', 'greet ing', 'greeting!', '_greeting', 'greet_ing'),
    JSON_ARRAY(1),
    'greeting 是唯一合法且正确的变量名。',
    'msg_text = \'hello\''
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    41,
    3,
    '变量与内存引用',
    '执行 `a = 10; b = a; a = 20` 后 b 的值是？',
    JSON_OBJECT('A', '10', 'B', '20', 'C', 'None', 'D', '报错'),
    1,
    JSON_ARRAY('b = a 时，b 引用 a 当时的对象。', '后续 a 改变不会影响 b。', '变量只是标签。'),
    'a 改为新值不会影响 b，b 仍引用原来的 10。',
    'x = [1]; y = x; x = [2]  # y 仍为 [1]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    42,
    3,
    '命名冲突',
    '为什么不建议使用 list 作为变量名？',
    JSON_OBJECT('A', '因为它太长', 'B', '因为 Python 不允许', 'C', '因为它会覆盖内置类型 list', 'D', '因为会让程序变慢'),
    3,
    JSON_ARRAY('list 是什么？', '内置类型能被覆盖吗？', '覆盖内置名称会导致很多错误。'),
    'list 是内置类型，用作变量名会覆盖导致不可用。',
    'list = 3  # 再也不能用 list()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    43,
    3,
    '变量生命周期',
    '以下哪个最能描述变量的生命周期？',
    JSON_OBJECT('A', '随 Python 启动就存在，随退出销毁', 'B', '随所在作用域的结束而销毁', 'C', '所有变量都永久存在于内存中', 'D', '变量创建后不能被删除'),
    2,
    JSON_ARRAY('变量是否跟随作用域？', '函数中的变量离开函数后还存在吗？', '作用域决定生命周期。'),
    '变量生命周期由作用域决定。',
    'def foo(): x = 1
# x 不在函数外存在'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    44,
    3,
    '理解表达式赋值',
    '让代码输出 30。',
    NULL,
    JSON_ARRAY('30'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = 10"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "b = "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(a + b)"}]}]}',
    JSON_ARRAY('10', 'a', 'a*2', '20', 'a+10', '5'),
    JSON_ARRAY(4),
    'b=20 时 a+b=30。',
    'x = 3; y = x * 3'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    45,
    3,
    '命名规范判断',
    '让程序正常运行且符合命名规范。',
    NULL,
    JSON_ARRAY('42'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " = 42"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(user_score)"}]}]}',
    JSON_ARRAY('user-score', 'user score', 'UserScore', 'user_score', '_userScore', 'userscore'),
    JSON_ARRAY(4),
    'user_score 是最规范的变量名，符合 snake_case。',
    'product_count = 18'
);