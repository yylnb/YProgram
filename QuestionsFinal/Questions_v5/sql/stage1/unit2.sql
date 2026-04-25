-- Generated SQL for global_unit=2 (stage=1 unit_local=2 unit_id=2)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  16,
  2,
  '单行注释的奥秘',
  '阿强想临时屏蔽一行代码`print(''秘密'')`，他应该在该行前面加什么符号？',
  '["//", "#", "--", "/*"]',
  2,
  '["想想Python里的‘悄悄话’是怎么写的？", "这个符号在Python中用来表示‘这行我不运行’。", "正确答案是井号#，这是Python的单行注释符号。"]',
  '在Python中，井号(#)用于单行注释，其后的内容会被解释器忽略，不会执行。//是其他语言的注释符，--是SQL的注释符，/* */是多行注释符但在Python中无效。',
  '例如：# 这是一个注释
print(''Hello'')  # 输出问候'
),
(
  17,
  2,
  '多行注释大挑战',
  '阿珍需要给一段复杂的算法写一个跨越多行的注释说明，她应该使用以下哪种方式？',
  '["在每一行前都加一个#", "用三个连续的单引号''''''将内容包起来", "用//开头写很多行", "使用三个井号### ###"]',
  2,
  '["虽然A也能实现，但有没有更省事的办法？", "三个连续的引号（单引或双引）在Python中有特殊用途。", "正确答案是三个单引号或双引号，可以作为多行字符串，常被用作多行注释。"]',
  'Python没有专门的多行注释语法，但可以用未赋值给任何变量的多行字符串（三引号包裹）来实现多行注释的效果，解释器会忽略它。A虽然可行但繁琐；C是其他语言语法；D不是有效语法。',
  '用法：
''''''
这是一个
多行注释
'''''''
),
(
  18,
  2,
  '缩进的艺术',
  '根据Python的PEP 8代码风格指南，推荐使用多少个空格来表示一级缩进？',
  '["2个空格", "4个空格", "8个空格", "1个Tab键"]',
  2,
  '["想想Python之禅里关于‘一致性’的原则。", "这是Python社区最广泛接受的标准。", "PEP 8明确推荐使用4个空格作为一个缩进级别。"]',
  'PEP 8是Python的官方代码风格指南，强烈建议使用4个空格作为每个缩进级别。这能保证代码清晰一致，并避免因混用Tab和空格导致的错误。',
  '例如：
if True:
    print(''缩进4个空格'')  # 这里前面有4个空格'
),
(
  21,
  2,
  '命名有规范',
  '根据PEP 8，以下哪个是Python函数或变量名的推荐命名风格？',
  '["CamelCase", "snake_case", "kebab-case", "UPPER_CASE"]',
  2,
  '["想想你常用的Python内置函数，比如`print`、`len`，它们长什么样？", "这种风格使用小写字母和下划线连接单词。", "PEP 8推荐函数和变量名使用小写字母加下划线的蛇形命名法(snake_case)。"]',
  'PEP 8规定，函数名和变量名应使用小写字母，单词间用下划线连接（snake_case）。CamelCase常用于类名；kebab-case在Python中无效；UPPER_CASE通常用于常量。',
  '例如：user_name, calculate_total, is_valid'
),
(
  22,
  2,
  '代码侦探',
  '哪一行代码最符合PEP 8关于空格使用的风格，看起来更舒服？',
  '["result=x+y*2", "result = x + y * 2", "result  =  x  +  y  *  2", "result = x+ y * 2"]',
  2,
  '["看看等号和操作符两边，是挤在一起还是留有呼吸空间？", "PEP 8建议在运算符（如=, +, *）两边加空格，但要注意优先级。", "正确答案在赋值和运算符两边都加了适当的空格，且考虑了运算优先级。"]',
  'PEP 8建议在赋值运算符（=）和二元运算符（如+，*）两边各加一个空格，以提高可读性。选项A无空格；选项C空格过多；选项D空格不均匀。选项B正确且`y*2`因优先级高可不加额外空格。',
  '符合风格：count = old_count + 1
price = base_price * discount'
),
(
  23,
  2,
  '注释的作用',
  '以下关于代码注释的说法，哪一个是最主要的、推荐的目的？',
  '["为了让自己看起来写了更多代码", "解释复杂的代码逻辑或代码的意图", "用来暂时删除没用的代码", "让程序运行得更快"]',
  2,
  '["注释是给人看的，不是给机器跑的。", "想想你过一个月再看自己的代码，最需要什么？", "注释的核心价值是解释‘为什么’这么做，而不仅仅是‘做什么’。"]',
  '注释的首要目的是提高代码的可读性和可维护性，解释那些不直观的代码逻辑、算法意图或重要决策原因。它不是增加代码量、删除代码的工具，也不会影响运行速度。',
  '好的注释：# 使用快速排序因为数据量可能很大，需要O(n log n)复杂度'
),
(
  26,
  2,
  '文档字符串的门面',
  '一个函数的正式文档字符串（docstring）应该被包裹在什么里面？',
  '["一对三引号 '''''' ... ''''''", "一对双引号 \\\" ... \\\"", "一对单引号 '' ... ''", "一堆井号 ###### ... ######"]',
  1,
  '["文档字符串通常需要跨越多行，描述参数、返回值等。", "PEP 257是关于文档字符串的规范。", "三重引号（单或双）是多行字符串的标准写法，最适合作为文档字符串。"]',
  'PEP 257规定，文档字符串应使用三重双引号`"""..."""`作为标准。虽然三重单引号`''''''...''''''`也有效，但双引号是约定俗成的首选，以保持一致性。B和C是单行字符串，D无效。',
  '标准格式：def func():
    """这是一个文档字符串。"""
    pass'
),
(
  27,
  2,
  '重构与注释',
  '当阿强重构（重写）了一段代码后，原来的注释应该怎么做？',
  '["删除所有旧注释，因为代码已经变了。", "保留旧注释，放在新代码旁边作为参考。", "更新注释，使其准确反映新代码的逻辑。", "把旧注释移到文件末尾存档。"]',
  3,
  '["注释是代码的说明书，说明书过时了会有什么后果？", "‘过时的注释比没有注释更糟糕’，想想为什么。", "代码和注释必须同步更新，以确保文档的准确性。"]',
  '过时或不准确的注释会误导阅读者，降低代码可维护性。因此，在修改代码时，必须同时检查并更新相关的注释，确保它们与代码逻辑一致。这是良好的编程习惯。',
  '重构前：# 计算列表总和（旧算法）
# 重构后：# 使用内置sum函数计算列表总和（更高效）'
),
(
  28,
  2,
  '一行的限度',
  '根据PEP 8，为了代码的可读性，一行代码的最大推荐长度是多少个字符？',
  '["79个字符", "99个字符", "120个字符", "没有限制，越长越好"]',
  1,
  '["想想在多个窗口并排或小屏幕上查看代码时。", "这个限制是为了避免需要水平滚动条。", "确切数字是79字符，这是PEP 8的明确建议。"]',
  'PEP 8建议将所有行限制在最多79个字符。这有助于在并排查看多个文件时无需水平滚动，也能适配大多数终端和编辑器的默认宽度，显著提升可读性。',
  '如果一行太长，可以使用括号、反斜杠或字符串连接符将其合理折行。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  19,
  2,
  '你好，世界与注释',
  '帮小菜鸟补全他的第一个Python程序：打印“Hello World”，并添加一行注释说明。',
  NULL,
  '["Hello World"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": " "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 打印问候语"}, {"type": "slot", "index": 1}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print("}, {"type": "code_line", "value": ""}, {"type": "slot", "index": 2}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": ")"}]}]}',
  '["#", "\\\"Hello World\\\"", "''Hello World''", "//", "# 打印问候语", "print", ":", "''''''Hello World''''''"]',
  '[0, 4, 2]',
  '第一空应为单行注释符号#；第二空是注释内容‘打印问候语’；第三空是要打印的字符串‘Hello World’，单双引号皆可，但需与code_segments中已有的引号结构匹配（已给出开头的print(和结尾的)），所以需要字符串本身。',
  '类似地：# 计算总和
print(100)'
),
(
  20,
  2,
  '风格初养成',
  '根据PEP 8风格，补全这个计算平方的函数定义，注意函数名、注释和空格。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "def "}, {"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": "):"}, {"type": "slot", "index": 2}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    \\\"\\\"\\\"计算一个数的平方。\\\"\\\"\\\""}, {"type": "code_line", "value": "    return "}, {"type": "slot", "index": 3}, {"type": "code", "value": " "}, {"type": "slot", "index": 4}, {"type": "code", "value": " "}, {"type": "slot", "index": 5}]}]}',
  '["calculate_square", "square", "num", "x", "n", "# 返回平方", "# 计算平方", "num", "**", "*", "* 2", "2", "return num ** 2", "return x * x"]',
  '[0, 2, 6, 2, 9, 11]',
  '函数名应使用蛇形命名法‘calculate_square’；参数名‘num’清晰；第一行函数体内是文档字符串注释；返回语句应为‘num ** 2’。答案序列依次填充这些部分。',
  '类似风格：def get_name(user_id):
    """根据ID获取用户名。"""
    return user_dict[user_id]'
),
(
  24,
  2,
  '条件判断与风格',
  '补全这段检查成绩是否及格的代码，注意条件语句的缩进、空格和注释。',
  NULL,
  '["及格"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "score = 60"}, {"type": "code_line", "value": ""}, {"type": "slot", "index": 0}, {"type": "code_line", "value": "score >= 60:"}, {"type": "slot", "index": 1}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    # 成绩合格"}, {"type": "code_line", "value": "    print("}, {"type": "slot", "index": 2}, {"type": "code_line", "value": ")"}, {"type": "slot", "index": 3}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print("}, {"type": "slot", "index": 4}, {"type": "code_line", "value": ")"}]}]}',
  '["if", "if (", "if  (", "):", ":", "    ", "\\\"及格\\\"", "''及格''", "# 成绩不合格", "\\\"不及格\\\"", "else:", "elif score < 60:"]',
  '[0, 4, 6, 10, 9]',
  '第一空是关键字`if`；第二空是条件后的冒号`:`；第三空是打印的字符串`"及格"`；第四空是`else:`语句；第五空是else分支打印的字符串`"不及格"`。注意缩进已体现在代码块中。',
  '类似结构：if temperature > 30:
    print(''炎热'')
else:
    print(''舒适'')'
),
(
  25,
  2,
  '循环风格',
  '补全这个循环打印数字的代码，注意for循环的结构、函数调用和空格。',
  NULL,
  '["0", "1", "2", "3", "4"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "# 打印0到4"}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for i in "}, {"type": "slot", "index": 1}, {"type": "code", "value": "("}, {"type": "slot", "index": 2}, {"type": "code", "value": "):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    "}, {"type": "slot", "index": 3}, {"type": "code", "value": "("}, {"type": "slot", "index": 4}, {"type": "code", "value": ")"}]}]}',
  '["\\n", ": 打印0到4", "range", "range", "5", "0, 5", "0,5", "print", "printf", "i", "\\\"i\\\"", "''i''", "str(i)"]',
  '[0, 2, 4, 7, 9]',
  '第一空是换行符`
`，将注释与代码分开；第二空是函数名`range`；第三空是参数`5`（表示生成0到4）；第四空是函数名`print`；第五空是变量`i`。',
  '类似地：# 遍历列表
for item in my_list:
    print(item)'
),
(
  29,
  2,
  '完整的函数文档',
  '补全这个计算面积的函数的文档字符串，使其符合良好的文档风格。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def rectangle_area(length, width):"}, {"type": "code_line", "value": "    "}, {"type": "slot", "index": 0}, {"type": "code_line", "value": "计算矩形的面积。"}, {"type": "slot", "index": 1}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    Args:"}, {"type": "slot", "index": 2}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        length (float): 矩形的长度。"}, {"type": "code_line", "value": "        width (float): 矩形的宽度。"}, {"type": "code_line", "value": ""}, {"type": "slot", "index": 3}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    Returns:"}, {"type": "code_line", "value": "        float: 矩形的面积，即 length * width。"}, {"type": "slot", "index": 4}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    \\\"\\\"\\\""}, {"type": "code_line", "value": "    return length * width"}]}]}',
  '["\\\"\\\"\\\"", "\\\"\\\"\\\"", "\\n", "\\n    ", "    \\\"\\\"\\\"", "    Example:", "    Example:\\n        >>> rectangle_area(5, 3)\\n        15.0", "    \\\"\\\"\\\"\\n    ", "    :param length: 矩形的长度\\n    :param width: 矩形的宽度", "\\n    Raises:\\n        ValueError: 如果参数为负。"]',
  '[0, 2, 2, 5, 7]',
  '第一、二空是文档字符串的开头`"""`和换行`
`；第三空是`Args:`节后的换行；第四空是`Returns:`节前的空行；第五空是示例节`Example:`及其内容，这是完整的文档字符串结尾前的一部分。',
  '一个完整的文档字符串通常包含摘要、参数说明、返回说明和可选的示例部分。'
),
(
  30,
  2,
  '类的风格',
  '补全这个简单的‘学生’类的定义，注意类名、方法、文档字符串和属性访问。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": ""}, {"type": "slot", "index": 0}, {"type": "code_line", "value": "Student:"}, {"type": "slot", "index": 1}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    \\\"\\\"\\\"表示一个学生。\\\"\\\"\\\""}, {"type": "slot", "index": 2}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    def __init__(self, name, score):"}, {"type": "slot", "index": 3}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        \\\"\\\"\\\"初始化学生实例。\\\"\\\"\\\""}, {"type": "slot", "index": 4}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        self.name = name"}, {"type": "code_line", "value": "        self.score = score"}, {"type": "slot", "index": 5}]}]}',
  '["class", "Class", "class ", "  ", "\\n", "\\n    ", "        ", "        self.name = name\\n        self.score = score", "    def get_name(self):\\n        return self.name", "# 初始化方法", "    def __init__(self):", "    def __init__(self, name, score):"]',
  '[2, 4, 4, 11, 4, 8]',
  '第一空是关键字`class`加空格；第二空是类定义后的换行；第三空是类文档字符串后的换行；第四空是`__init__`方法的正确签名；第五空是方法文档字符串后的换行；第六空是初始化属性后的空行（或结束）。注意缩进层级。',
  '类定义的通用风格：class MyClass:
    """类文档。"""
    def __init__(self, arg):
        self.arg = arg'
);