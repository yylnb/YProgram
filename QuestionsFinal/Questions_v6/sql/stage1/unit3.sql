-- Generated SQL for global_unit=3 (stage=1 unit_local=3 unit_id=3)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  31,
  3,
  '变量是什么？',
  '阿强第一次学编程，他把‘变量’想象成一个什么东西？',
  '["一个永远不变的固定值。", "一个可以存放数据的储物盒，并且能换掉里面的东西。", "一段固定的程序代码。", "一个函数的名称。"]',
  2,
  '["变量的英文是‘variable’，意思是‘可变的’。", "在编程中，我们用它来暂时存储程序运行时的数据。", "就像购物车，你可以先放苹果，结账前也可以换成香蕉。"]',
  '变量是计算机内存中一个命名的存储位置，用于保存数据。其核心特性是‘可变’，即可以在程序运行过程中被赋予不同的值。',
  '例如：age = 18，之后可以改为 age = 19。'
),
(
  32,
  3,
  '合法的名字',
  '小美想给自己创建的游戏角色起个Python变量名，哪个名字是合法的？',
  '["1st_player", "player-name", "player_name", "for"]',
  3,
  '["变量名不能以数字开头哦！", "Python变量名里不能包含减号‘-’。", "‘for’是Python的保留字，不能当名字用。"]',
  'Python变量名规则：只能包含字母、数字和下划线；不能以数字开头；不能是Python关键字（如for, if）；区分大小写。player_name符合所有规则。',
  '类似合法的名字：user_name, score2, _temp。'
),
(
  33,
  3,
  '赋值操作',
  '食堂阿姨问：“你想给变量‘food’赋值为‘鸡腿’，正确的‘打饭’姿势是？”',
  '["food = ‘鸡腿’", "food: ‘鸡腿’", "food -> ‘鸡腿’", "‘鸡腿’ = food"]',
  1,
  '["赋值是把右边的值‘给’左边的变量。", "想想等号‘=’在编程里是什么意思。", "方向可不能反了，不然‘鸡腿’就变成变量名啦！"]',
  '在Python中，使用单个等号‘=’进行赋值操作，其方向是将等号右侧的值（或表达式结果）赋予左侧的变量名。',
  '赋值示例：price = 15.5，意思是把15.5这个数值存到名为price的变量里。'
),
(
  36,
  3,
  '命名风格辨识',
  '以下哪个变量名最符合Python社区推崇的命名风格（用于普通变量）？',
  '["userName", "User_Name", "user_name", "USERNAME"]',
  3,
  '["Python官方风格指南（PEP 8）有推荐。", "想想蛇是怎么爬行的？", "全大写的名字通常用于表示常量。"]',
  '根据PEP 8风格指南，普通变量、函数名、方法名推荐使用蛇形命名法（snake_case），即全部小写字母，单词间用下划线连接。',
  '例如：file_path、max_temperature、is_valid_input。'
),
(
  37,
  3,
  '避开关键字',
  '下列哪个选项试图用一个Python关键字来命名变量？',
  '["class_name", "true_value", "pass_word", "global"]',
  4,
  '["‘global’在Python里有特殊用途。", "想想定义变量或函数时用来跳过的那个词？", "‘if’, ‘for’, ‘while’等都是不能用的名字。"]',
  '‘global’是Python关键字，用于在函数内部声明使用全局变量。关键字有特殊语法含义，不能用作变量名、函数名等标识符。',
  '其他关键字示例：def, if, else, while, import。'
),
(
  38,
  3,
  '规则来找茬',
  '观察以下用于记录成绩的变量名，哪个违反了Python变量命名规则？',
  '["_average_score", "2nd_exam_score", "final_score", "Score2024"]',
  2,
  '["变量名的第一个字符有特殊限制。", "数字能不能打头阵？", "下划线开头是允许的，常用来表示特殊含义。"]',
  'Python变量名不能以数字开头。‘2nd_exam_score’以数字‘2’开头，是非法命名。以下划线开头是允许的，通常用于表示私有变量等特殊用途。',
  '非法命名示例：123go, 1st_place。合法命名示例：score_2, exam2_score。'
),
(
  41,
  3,
  '名字的意义',
  '为什么说‘user_age’比‘ua’是一个更好的变量名？',
  '["因为它更长，显得代码更专业。", "因为它使用了蛇形命名法。", "因为它能更清晰地描述所存储的数据内容。", "因为‘ua’可能是一个缩写，输入更快。"]',
  3,
  '["好的变量名应该让人一眼看懂。", "想想一个月后你自己回来看代码的情况。", "代码是写给人看的，其次才是给机器执行。"]',
  '优秀的变量名应具有描述性，能清晰表达其用途或存储的数据含义，从而提高代码的可读性和可维护性。‘user_age’比‘ua’明确得多。',
  '对比：t = 30 # 模糊 vs. temperature_celsius = 30 # 清晰。'
),
(
  42,
  3,
  '大小写敏感',
  '执行以下代码会输出什么？
Name = "Alice"
name = "Bob"
print(Name)',
  '["Alice", "Bob", "报错，因为变量名重复定义。", "什么都不输出"]',
  1,
  '["Python区分字母的大小写。", "‘Name’和‘name’是两个不同的变量吗？", "看看print函数里调用的是哪个名字。"]',
  'Python变量名是大小写敏感的，因此‘Name’和‘name’是两个完全不同的变量。代码中为‘Name’赋值“Alice”，打印的也是‘Name’，故输出“Alice”。',
  'myVar 和 myvar 在Python中是两个独立的变量。'
),
(
  43,
  3,
  '综合排错',
  '以下哪行代码存在错误（违反命名规则或语法）？',
  '["first_name = \\\"张\\\"", "99_balloons = 99", "is_ok = True", "totalAmount = 100.5"]',
  2,
  '["检查每一行变量名的第一个字符。", "‘99_balloons’这个名字看起来有点怪。", "变量名能像电话号码一样开头吗？"]',
  '选项B的变量名‘99_balloons’以数字开头，违反了Python变量命名规则。其他选项虽然风格不同（如D是驼峰命名），但语法上都是正确的。',
  '非法：3d_vision。合法但风格不佳：TotalAmount（应为total_amount）。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  34,
  3,
  '定义你的年龄',
  '帮小杰写一行代码，把他的年龄18存到变量里，然后打印出来。',
  NULL,
  '["18"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " = "}, {"type": "slot", "index": 1}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 2}, {"type": "code", "value": ")"}]}]}',
  '["age", "my_age", "yourAge", "18", "\\\"18\\\"", "age", "my_age"]',
  '[0, 3, 0]',
  '第一空需要一个合法的变量名（如age），第二空是赋给它的值（18），第三空是打印时传入的变量名（与第一空一致）。注意打印变量时不需要引号。',
  '类似操作：name = "Alice"; print(name) 会输出 Alice。'
),
(
  35,
  3,
  '购物车总价',
  '阿珍计算购物总价，她需要定义一个名为‘total_price’的变量。请补全代码。',
  NULL,
  '["100"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " = 50 + 50"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}]}',
  '["total-price", "totalPrice", "total_price", "1total", "total_price", "totalPrice", "\\\"total_price\\\""]',
  '[2, 2]',
  'Python推荐使用蛇形命名法（snake_case），即单词间用下划线连接，如total_price。两处填空应使用同一个合法的变量名。',
  '其他蛇形命名示例：student_count、final_score_avg。'
),
(
  39,
  3,
  '计算矩形',
  '补全代码，计算一个长为5、宽为3的矩形的面积和周长。',
  NULL,
  '["面积： 15", "周长： 16"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " = 5"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 1}, {"type": "code", "value": " = 3"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "area = "}, {"type": "slot", "index": 0}, {"type": "code", "value": " * "}, {"type": "slot", "index": 1}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "perimeter = 2 * ("}, {"type": "slot", "index": 0}, {"type": "code", "value": " + "}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"面积：\\\", area)"}, {"type": "code_line", "value": "print(\\\"周长：\\\", perimeter)"}]}]}',
  '["length", "width", "long", "wide", "L", "W", "height"]',
  '[0, 1]',
  '代码逻辑需要两个变量分别代表长和宽。使用描述清晰的变量名‘length’和‘width’有助于理解，并且在后续计算中被重复使用。',
  '类似应用：radius = 5; circumference = 2 * 3.14 * radius。'
),
(
  40,
  3,
  '生命值变化',
  '游戏角色的生命值初始为100，受到伤害后减少30，请补全过程。',
  NULL,
  '["当前生命值： 70"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " = 100"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 受到伤害"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " = "}, {"type": "slot", "index": 0}, {"type": "code", "value": " - 30"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\\\"当前生命值：\\\", "}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
  '["HP", "health_point", "life", "hp", "Health", "LIFE"]',
  '[3]',
  '变量‘hp’被定义并赋初值100，然后在同一作用域内，可以对其进行重新赋值（hp = hp - 30），更新它的值。前后应使用同一个变量名。',
  '类似更新：count = 10; count = count + 1; # count变为11'
),
(
  44,
  3,
  '温度转换器',
  '补全代码，将华氏温度变量‘f_temp’转换为摄氏温度并输出。公式：C = (F - 32) / 1.8',
  NULL,
  '["摄氏温度为： 25.0"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " = 77.0"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 1}, {"type": "code", "value": " = ("}, {"type": "slot", "index": 0}, {"type": "code", "value": " - 32) / 1.8"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\\\"摄氏温度为：\\\", "}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}]}',
  '["f_temp", "fahrenheit", "F", "c_temp", "celsius", "C", "result"]',
  '[0, 3]',
  '第一空根据题目要求，存放华氏温度的变量名应为‘f_temp’。第二空需要定义一个变量（如c_temp）来存储根据公式计算得到的摄氏温度结果。',
  '类似转换：km = 10; miles = km / 1.609; print(miles)。'
),
(
  45,
  3,
  '用户信息卡',
  '补全代码，从输入获取用户名和年龄，然后用变量存储并格式化输出一句问候。',
  '["Alice", "25"]',
  '["你好，Alice！ 你今年25岁了。"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " = input()"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 1}, {"type": "code", "value": " = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "greeting = \\\"你好，"}, {"type": "slot", "index": 0}, {"type": "code", "value": "！ 你今年"}, {"type": "slot", "index": 1}, {"type": "code", "value": "岁了。\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 2}, {"type": "code", "value": ")"}]}]}',
  '["user_name", "name", "age", "user_age", "greeting", "message", "user_name", "age"]',
  '[0, 3, 4]',
  '第一、二空用于存储输入值的变量名，需具有描述性（如user_name, user_age）。第三空是打印时传入的变量，即保存了格式化字符串的变量名‘greeting’。',
  '类似流程：city = input(); info = f"我来自{city}。"; print(info)。'
);