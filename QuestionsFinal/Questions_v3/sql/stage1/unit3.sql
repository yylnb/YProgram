-- Generated SQL for global_unit=3 (stage=1 unit_local=3 unit_id=3)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  31,
  3,
  '变量是什么？',
  '小美想用Python记住她的青春（18岁），她应该用什么魔法盒子？',
  '["一个永远写着18的石头", "一个名为age的变量", "直接对着屏幕喊‘18岁’", "一个画着‘18’的纸箱"]',
  2,
  '["想想看，如果明年小美19岁了，石头上的数字能改吗？", "在编程中，我们需要一个可以存放数据并且能随时修改的‘容器’。", "这个‘容器’有一个名字，里面可以放数字、文字等各种数据，它的值是可以改变的。"]',
  '变量是程序中用于存储数据的命名容器。它的值可以在程序运行过程中被改变。选项A和D是固定不变的，选项C不是有效的Python语法。',
  '例如：age = 18，之后可以改为 age = 19。'
),
(
  32,
  3,
  '起名需谨慎',
  '阿强想给存储游戏‘最终得分’的变量起名，哪个名字会让Python编译器皱眉？',
  '["score", "2nd_score", "final-score", "_score"]',
  3,
  '["变量名里可以出现减号‘-’吗？", "回忆一下，变量名允许的字符有哪些？", "Python变量名只能包含字母、数字和下划线，且不能以数字开头。连字符‘-’是特殊符号，不被允许。"]',
  'Python变量命名规则：只能包含字母（a-z, A-Z）、数字（0-9）和下划线（_），且不能以数字开头。‘final-score’中的连字符‘-’是非法字符。选项B以数字开头也不合法，但题目问的是‘让Python皱眉’，通常非法字符错误更直接。选项A和D是合法的。',
  '合法变量名：high_score， total_amount。非法变量名：2pac（数字开头）， first-name（含连字符）。'
),
(
  33,
  3,
  '关键字禁区',
  '机器人小P想用Python的关键字作为变量名来耍酷，以下哪个名字会立刻引发‘语法错误’警报？',
  '["class", "city", "country", "code"]',
  1,
  '["Python有一些具有特殊功能的保留字，它们不能用作普通变量名。", "想想定义一个新类时会用到哪个词？", "‘class’是用于定义类的关键字，如同‘if’、‘for’一样，不能作为变量名。"]',
  '‘class’是Python的关键字（保留字），用于定义类。关键字具有特殊的语法含义，不能用作标识符（如变量名、函数名）。',
  '其他常见关键字：def, if, else, while, for, import。'
),
(
  36,
  3,
  '大小写之争',
  '在Python的世界里，变量‘Name’和‘name’会被认为是同一个变量吗？',
  '["是，Python很随和", "不是，Python对大小写很挑剔", "只有在函数内部才不是", "取决于代码的书写时间"]',
  2,
  '["尝试在代码里写 Name = ‘Alice’ 和 name = ‘Bob’，然后分别打印看看。", "Python的变量名是区分大小写的，这是许多编程语言的共同规则。", "大写‘N’和小写‘n’在计算机看来是完全不同的两个字符。"]',
  'Python是区分大小写的语言。这意味着‘Name’、‘name’、‘NAME’会被视为三个完全不同的变量标识符。',
  'age, Age, AGE 是三个不同的变量。'
),
(
  37,
  3,
  '优雅的命名',
  'Python社区推崇哪种命名风格，让代码看起来像优雅的蛇形文字？',
  '["驼峰式，如‘userName’", "下划线式（蛇形），如‘user_name’", "匈牙利式，如‘strUserName’", "全部大写式，如‘USER_NAME’"]',
  2,
  '[]',
  '根据Python的PEP 8风格指南，对于变量和函数名，推荐使用小写字母和下划线分隔单词的‘蛇形命名法’，以提高可读性。全部大写通常用于常量。',
  '推荐：student_count, file_path。不推荐：studentCount, FilePath（后者常用于类名）。'
),
(
  38,
  3,
  '起个好名字',
  '以下哪个变量名能最清晰地告诉其他程序员，它存储的是‘学生数量’？',
  '["n", "a", "stu", "student_count"]',
  4,
  '["单字母变量名在简单的循环中可能可以，但在这里含义模糊。", "‘stu’是缩写，可能被理解为‘student’或‘study’。", "一个好的变量名应该具有描述性，让人一眼就能理解其用途。"]',
  '变量名‘student_count’清晰、具有描述性，且符合Python的蛇形命名惯例，是最好的选择。它明确表示了存储的是学生的数量。',
  '用‘email_address’而不是‘ea’或‘addr’来存储电子邮件地址。'
),
(
  41,
  3,
  '里外有别',
  '在函数内部定义的一个变量（比如 local_var），在函数外部可以直接访问它吗？',
  '["当然可以，变量是全局的", "不行，它有‘社交恐惧症’", "可以，但需要先导入函数", "只有用global声明后才可以"]',
  2,
  '["想想‘局部’和‘全局’这两个词的含义。", "函数就像一个有围墙的花园，里面种的花（变量）外面不一定能看到。", "在函数内部创建的变量默认作用域是局部的，只在函数内部有效。"]',
  '在函数内部定义的变量默认拥有局部作用域，只能在定义它的函数内部被访问。在函数外部直接访问会导致NameError。',
  'def my_func(): x = 10 
print(x) # 这里会报错，x未定义'
),
(
  42,
  3,
  '不变的约定',
  '在Python中，虽然没有真正的常量，但如何约定俗成地表示一个值不应被改变？',
  '["使用const关键字", "变量名全部采用大写字母", "变量名以‘k’开头", "在变量名后加‘_const’"]',
  2,
  '["观察一些Python配置文件或模块顶部的设置。", "这是一种编程约定，提醒开发者‘请勿修改’。", "全大写的名字通常看起来很‘正式’且‘恒定’。"]',
  'Python的惯例是使用全大写字母和下划线来命名常量，例如 MAX_SIZE， PI。这只是一个约定，并不能从语法上阻止修改，但它向其他程序员清晰地表明了意图。',
  '常见的约定常量：PI = 3.14159， DATABASE_URL = ‘...’。'
),
(
  43,
  3,
  '变身达人',
  '一个Python变量可以先存储数字100，然后又去存储字符串‘一百’吗？',
  '["可以，Python变量是‘动态类型’的", "不可以，一旦确定类型就不能改变", "需要先使用str()函数转换", "只有在重新启动程序后才可以"]',
  1,
  '["试试运行代码 x = 100; x = ‘一百’，看看会报错吗？", "Python关注的是变量引用的值是什么类型，而不是变量本身有固定类型。", "这就是‘动态类型’语言的特点。"]',
  'Python是动态类型语言。变量本身没有类型，它只是指向一个对象的引用。你可以随时让一个变量引用不同类型的对象。',
  'x = 42 # x引用一个整数 
x = ‘答案’ # 现在x引用一个字符串'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  34,
  3,
  '帮变量安家',
  '帮小新完成代码，将他的名字“Shin”存入一个叫‘my_name’的变量中，然后打印出来。',
  NULL,
  '["Shin"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " = \\\""}, {"type": "slot", "index": 1}, {"type": "code", "value": "\\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(my_name)"}]}]}',
  '["my_name", "name", "Shin", "shin", "myName", "MY_NAME"]',
  '[0, 2]',
  '第一个空应填入变量名‘my_name’，第二个空应填入字符串内容‘Shin’。变量名需要符合命名规则且与打印语句中的一致，字符串内容需要与期望输出匹配。',
  '类似地，存储年龄：age = 18'
),
(
  35,
  3,
  '购物小计算',
  '苹果5元，香蕉3元，请用变量计算总价并打印结果。',
  NULL,
  '["8"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "apple = 5"}, {"type": "code_line", "value": "banana = 3"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "total = apple "}, {"type": "slot", "index": 0}, {"type": "code", "value": " banana"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}]}',
  '["+", "-", "*", "/", "total", "sum", "price"]',
  '[0, 4]',
  '第一个空需要加法运算符‘+’来计算总价。第二个空需要打印存储总价的变量名‘total’。',
  '计算差值：diff = a - b'
),
(
  39,
  3,
  '交换魔术',
  '不借助第三个变量，施展Python的‘同时赋值’魔法，交换变量a和b的值。',
  NULL,
  '["20 10"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = 10"}, {"type": "code_line", "value": "b = 20"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "a, b = "}, {"type": "slot", "index": 0}, {"type": "code", "value": ", "}, {"type": "slot", "index": 1}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(a, b)"}]}]}',
  '["a", "b", "10", "20"]',
  '[1, 0]',
  'Python支持多变量同时赋值。要交换a和b的值，只需将a, b同时赋值为b, a。因此第一个空填‘b’，第二个空填‘a’。',
  '交换x和y：x, y = y, x'
),
(
  40,
  3,
  '个性化问候',
  '使用变量name和字符串拼接，创造一句热情的问候语‘Hello, World!’。',
  NULL,
  '["Hello, World!"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "name = \\\"World\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "message = \\\"Hello, \\\" "}, {"type": "slot", "index": 0}, {"type": "code", "value": " name "}, {"type": "slot", "index": 1}, {"type": "code", "value": " \\\"!\\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(message)"}]}]}',
  '["+", ",", "*", "&"]',
  '[0, 0]',
  '在Python中，字符串拼接使用加号‘+’运算符。因此两个空都需要填入‘+’，将字符串字面量、变量和另一个字符串字面量连接起来。',
  '拼接用户名：greeting = "Welcome, " + username + "!"'
),
(
  44,
  3,
  '分数评级',
  '根据变量score中的分数判断是否及格（>=60为及格），并打印结果。',
  NULL,
  '["及格"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "score = 75"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if score "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 60:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"及格\\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\\"不及格\\\")"}]}]}',
  '[">", "<", ">=", "<=", "==", "!="]',
  '[2]',
  '判断是否及格的条件是分数大于等于60分，因此需要使用大于等于运算符‘>=’。',
  '判断是否成年：if age >= 18:'
),
(
  45,
  3,
  '累加求和',
  '使用循环和变量total，计算1到5这五个数字的和。',
  NULL,
  '["15"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "total = 0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for i in range(1, 6):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    total "}, {"type": "slot", "index": 0}, {"type": "code", "value": " i"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(total)"}]}]}',
  '["=", "+=", "-=", "*="]',
  '[1]',
  '在循环中，需要将每个数字i累加到变量total上，应该使用复合赋值运算符‘+=’，它等价于 total = total + i。',
  '计数：count = 0 
count += 1 # 每次增加1'
);