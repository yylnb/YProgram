-- Generated SQL for global_unit=2 (stage=1 unit_local=2 unit_id=2)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  16,
  2,
  '单行注释奇遇记',
  '程序员阿强想在一行代码后添加注释“这里有一个错误”，但他忘记了正确语法。请问哪一行是他的正确选择？',
  '["print(\\\"Hello\\\") // 这里有一个错误", "print(\\\"Hello\\\") # 这里有一个错误", "print(\\\"Hello\\\") <!-- 这里有一个错误 -->", "print(\\\"Hello\\\") \\\\\\\\\ 这里有一个错误"]',
  2,
  '["想想看，Python里的单行注释符号是什么？", "它来自一个非常“尖锐”的符号家族。", "在Python中，使用井号(#)来开始单行注释。"]',
  'Python中使用井号(#)来标记单行注释，其后的内容会被解释器忽略。其他选项是其他语言（如C、HTML）或无效的语法。',
  '例如：x = 10  # 初始化变量x为10'
),
(
  17,
  2,
  '多行注释大搜索',
  '阿珍写了一个函数，想用多行注释来描述它的功能。下面哪个是Python中多行注释（文档字符串）的正确语法？',
  '["/* 这是一个多行注释 */", "# 这是一个多行注释 #", "''''''这是一个多行注释''''''", "== 这是一个多行注释 =="]',
  3,
  '["Python没有像C那样的/* */语法。", "想想如何表示一个多行的字符串。", "Python通常使用成对的三个单引号或双引号来包裹多行注释。"]',
  'Python中通常使用成对的三个单引号('''''')或三个双引号(""")来创建多行字符串，常用作函数或模块的文档字符串（docstring），起到多行注释的作用。',
  '例如：def func():
    """这是一个函数的文档字符串，描述了函数的功能。"""'
),
(
  18,
  2,
  '命名风格初体验',
  '根据PEP 8规范，下面哪个变量名符合Python推荐的命名风格（snake_case）？',
  '["userAge", "UserAge", "user_age", "USER_AGE"]',
  3,
  '["PEP 8推荐变量名使用小写字母。", "想想单词之间用什么连接最像“蛇”。", "蛇形命名法（snake_case）使用下划线连接单词，且全小写。"]',
  'PEP 8是Python的官方代码风格指南，规定变量和函数名应使用全小写字母，并用下划线(_)连接单词，这种风格称为snake_case。',
  '例如：file_name, total_score, is_valid_input'
),
(
  21,
  2,
  '文档字符串的位置',
  '阿强想为他写的`greet()`函数添加一个文档字符串来说明功能。根据惯例，他应该把文档字符串放在哪里？',
  '["文件的最开头，在任何代码之前", "函数定义语句`def greet():`的同一行末尾", "函数定义语句`def greet():`的下一行，并且缩进", "在调用这个函数的代码前面"]',
  3,
  '["文档字符串是用来解释函数本身的。", "它应该紧跟着被解释的对象。", "在Python中，文档字符串是函数体的一部分，所以需要缩进。"]',
  '按照PEP 257约定，模块、类或函数的文档字符串应作为其定义后的第一个语句出现，并保持与定义体相同的缩进级别。',
  '例如：def add(a, b):
    """返回两个数字的和。"""
    return a + b'
),
(
  22,
  2,
  '运算符的空格战争',
  '根据PEP 8，下面哪一行代码的写法符合运算符周围的空格规范？',
  '["y=x*2+5", "y = x * 2 + 5", "y = x*2+5", "y = x * 2+5"]',
  2,
  '["PEP 8建议在大多数二元运算符两边加空格。", "但注意优先级不同的运算符之间有时不加空格。", "`*`和`+`都是二元运算符，通常两边都应加空格。"]',
  'PEP 8建议在大多数二元运算符（如赋值=、比较==、算术+ - * /）两边各加一个空格，以增强可读性。但幂运算符`**`和切片冒号`:`等有特殊规则。',
  '规范：sum = a + b * c  # 乘法和加法运算符两侧都有空格。'
),
(
  23,
  2,
  '注释的时效性',
  '阿珍修改了代码逻辑，但忘记更新相关的注释。现在注释说“这里计算平方”，但代码实际在计算立方。下列哪种做法最符合良好的代码风格？',
  '["忽略注释，只要代码正确就行", "删除所有注释，因为它们总是会过时", "更新注释，使其准确描述当前的代码逻辑", "在错误注释旁边添加新的注释说明“之前写错了”"]',
  3,
  '["过时的注释比没有注释更糟糕。", "代码风格不仅关乎格式，也关乎可维护性。", "代码和注释应该保持同步，共同反映真实意图。"]',
  '良好的代码风格要求注释与代码同步更新。过时的注释会误导阅读者，降低代码可维护性。准确的注释是代码文档的重要组成部分。',
  '修改前：result = x ** 2  # 计算x的平方
修改后：result = x ** 3  # 计算x的立方'
),
(
  26,
  2,
  '注释与代码行的爱恨情仇',
  '关于在代码行内（与代码同一行）添加注释，下列哪种说法符合PEP 8的风格建议？',
  '["行内注释非常推荐，应尽可能多使用", "行内注释应该少用，并且与代码至少间隔两个空格", "行内注释必须紧跟在代码后面，不能有空格", "禁止使用行内注释，所有注释必须独占一行"]',
  2,
  '["PEP 8对行内注释的使用持谨慎态度。", "它建议如果要写，需要和代码保持一定距离。", "这个距离是至少两个空格。"]',
  'PEP 8建议行内注释应谨慎使用，因为它们会分散注意力。如果使用，应与语句至少间隔两个空格，并且以`#`和一个空格开始。',
  '示例：x = x + 1  # 补偿边界情况'
),
(
  27,
  2,
  'TODO注释的秘密',
  '在代码注释中看到`# TODO: 优化算法效率`，这通常表示什么意思？',
  '["这是一个已经完成的优化任务的记录", "这是一个标记，说明此处代码需要后续完善或添加功能", "这是一个错误提示，说明算法有bug", "这是一个给其他程序员的私人留言，无需处理"]',
  2,
  '["TODO在英文中是“待办事项”的意思。", "它是一种特殊的注释标记。", "用于提醒开发者未来需要做的工作。"]',
  '`# TODO:`是一种常见的约定注释，用于标记代码中需要将来完成、改进或修复的部分。它本身不影响程序运行，但有助于项目管理。',
  '其他类似标记还有`# FIXME:`（需要修复）、`# NOTE:`（重要说明）、`# HACK:`（临时解决方案）。'
),
(
  28,
  2,
  '自动化风格检查',
  '以下哪个工具可以自动检查Python代码是否符合PEP 8风格规范，并指出不符合的地方？',
  '["pylint", "pyinstaller", "numpy", "matplotlib"]',
  1,
  '["这个工具的名字里包含了“lint”，这是代码检查的术语。", "它是一个静态代码分析工具。", "它可以帮助发现代码中的错误、不良风格和复杂度问题。"]',
  '`pylint`是一个强大的Python代码静态分析工具，它可以检查代码是否符合PEP 8风格指南，并检测各种编程错误、不良代码味道和过于复杂的代码。',
  '类似工具还有`flake8`、`black`（自动格式化）、`autopep8`（自动修复PEP 8问题）。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  19,
  2,
  '格式化打印',
  '下面的代码意图打印“价格：99元”，但写得很乱，不符合代码风格。请从选项中挑选合适的片段，按顺序填入，使其变得整洁。',
  NULL,
  '["价格：99元"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": " "}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\\""}, {"type": "slot", "index": 1}, {"type": "code", "value": "\\\""}, {"type": "slot", "index": 2}]}]}',
  '["print(", "价格：", "99元", ")", " # 打印价格", "price:", "99yuan", "    ", "  ", "\\n"]',
  '[0, 1, 4]',
  '正确组合为`print("价格：99元") # 打印价格`。print是函数名，字符串内容为“价格：99元”，并在行尾添加了清晰的单行注释。',
  '规范的代码：print("总计：", total)  # 输出计算结果'
),
(
  20,
  2,
  '代码风格大改造',
  '这段代码计算圆的面积，但缩进、空格和注释都很糟糕。请用选项修复它，使其符合PEP 8规范。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "# 计算圆面积"}, {"type": "code_line", "value": "def calc_area(radius):"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": "pi"}, {"type": "slot", "index": 1}, {"type": "code", "value": "3.14159"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 2}, {"type": "code", "value": "area"}, {"type": "slot", "index": 3}, {"type": "code", "value": "pi"}, {"type": "slot", "index": 4}, {"type": "code", "value": "radius"}, {"type": "slot", "index": 5}, {"type": "code", "value": "*"}, {"type": "slot", "index": 6}, {"type": "code", "value": "radius"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 7}, {"type": "code", "value": "area"}]}]}',
  '["    ", " = ", "    ", " = ", " * ", " ** 2", "    return ", "    ", "\\t", "==", "==", "  ", "   "]',
  '[0, 1, 2, 3, 4, 5, 6, 7]',
  '修复后代码应正确缩进（4个空格），运算符两侧有空格，并清晰定义了变量和返回语句。核心是`area = pi * radius ** 2`。',
  '规范写法：result = (a + b) * factor  # 注意运算符周围的空格'
),
(
  24,
  2,
  '完善函数文档',
  '请为以下函数框架选择合适的片段，为其添加一个清晰的多行文档字符串（docstring）和符合PEP 8规范的函数体。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def calculate_discount(price, discount_rate):"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": "计算折后价格。\\n    "}, {"type": "slot", "index": 1}, {"type": "code", "value": "    price: 原价\\n    discount_rate: 折扣率，例如0.1表示九折\\n    "}, {"type": "slot", "index": 2}, {"type": "code", "value": "返回折后价格。\\n    "}, {"type": "slot", "index": 3}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 4}, {"type": "code", "value": "final_price"}, {"type": "slot", "index": 5}, {"type": "code", "value": "price"}, {"type": "slot", "index": 6}, {"type": "code", "value": "(1 - discount_rate)"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 7}, {"type": "code", "value": "final_price"}]}]}',
  '["    \\\"\\\"\\\"", "\\\"\\\"\\\"", "    :param ", ":return: ", "    \\\"\\\"\\\"", "    ", " = ", " * ", "    return ", "        ", "# ", "    # ", "\\n"]',
  '[0, 1, 2, 3, 4, 5, 6, 7]',
  '完整代码应包含缩进的文档字符串，清晰说明参数和返回值，以及符合PEP 8规范的计算和返回语句。关键行：`final_price = price * (1 - discount_rate)`。',
  '规范示例：def area(r):
    """计算圆面积。"""
    return 3.14 * r ** 2'
),
(
  25,
  2,
  '重构条件判断',
  '下面这段条件判断代码可读性很差。请用选项中的片段重构它，使其符合PEP 8的缩进、空格和换行建议。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if age>18 and score>=60:"}, {"type": "slot", "index": 0}, {"type": "code", "value": "print(\\\"合格\\\")"}, {"type": "slot", "index": 1}, {"type": "code", "value": "elif age<=18:"}, {"type": "slot", "index": 2}, {"type": "code", "value": "print(\\\"未成年\\\")"}, {"type": "slot", "index": 3}, {"type": "code", "value": "else:"}, {"type": "slot", "index": 4}, {"type": "code", "value": "print(\\\"不合格\\\")"}]}]}',
  '[" ", "    ", "\\n    ", "\\n", " # 成年且及格", " # 未成年人", " # 成年但不及格", "    # 成年且及格", "    # 未成年人", "    # 成年但不及格"]',
  '[0, 1, 2, 3, 4]',
  '重构后应在运算符和关键字后加空格，每个分支代码块缩进4个空格，并根据需要添加换行和缩进的注释以增强可读性。',
  '规范写法：if x > 0 and y < 10:
    print("条件成立")  # 当x为正且y小于10时'
),
(
  29,
  2,
  '综合风格审查',
  '这段代码在命名、缩进、空格和注释方面有多处违反PEP 8。请选择正确的片段依次修复它。',
  NULL,
  '["Alice的年龄是： 30"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": "UserName"}, {"type": "slot", "index": 1}, {"type": "code", "value": "\\\"Alice\\\""}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 2}, {"type": "code", "value": "userAge"}, {"type": "slot", "index": 3}, {"type": "code", "value": "30"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "#打印信息"}, {"type": "slot", "index": 4}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 5}, {"type": "code", "value": "print(\\\""}, {"type": "slot", "index": 6}, {"type": "code", "value": "的年龄是： \\\","}, {"type": "slot", "index": 7}, {"type": "code", "value": "userAge"}, {"type": "slot", "index": 8}, {"type": "code", "value": ")"}]}]}',
  '["user_name = ", "USER_NAME = ", "userName = ", " = ", "    ", "\\n", "\\n    ", "    # 打印信息", " # 打印信息", "user_name", "userAge", ", "]',
  '[0, 2, 4, 6, 7, 5, 6, 7, 8]',
  '修复后应使用snake_case变量名，赋值运算符两侧有空格，注释独占一行并正确缩进，print语句中变量与字符串用逗号分隔并加空格。',
  '规范示例：user_name = "Bob"
user_score = 95
print(user_name, "的得分是：", user_score)'
),
(
  30,
  2,
  '模块文档头',
  '为一个新建的Python工具模块编写规范的模块级文档字符串（docstring）。请从选项中挑选内容完成它。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "#!/usr/bin/env python3"}, {"type": "code_line", "value": "# -*- coding: utf-8 -*-"}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "\\\"\\\"\\\""}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": "数据格式化工具模块。\\n"}, {"type": "slot", "index": 1}, {"type": "code", "value": "提供用于清洗、转换和输出数据的实用函数。\\n"}, {"type": "slot", "index": 2}, {"type": "code", "value": "作者：DevTeam\\n版本：1.0.0\\n创建日期：2023-10-27"}, {"type": "slot", "index": 3}]}]}',
  '["    ", "", "    ", "\\n    ", "\\\"\\\"\\\"", "\\\"\\\"\\\"\\n", "    ", "\\n"]',
  '[0, 1, 2, 4]',
  '模块文档字符串应紧跟在模块注释之后，简要说明模块功能。多行文档字符串的每行通常无需特殊缩进（与开头引号对齐），但结尾的`"""`应单独成行。',
  '通用格式："""
模块简要描述。
更详细的说明...
"""'
);