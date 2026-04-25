-- Generated SQL for global_unit=2 (stage=1 unit_local=2 unit_id=2)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  16,
  2,
  '注释魔法棒',
  '阿强想给他的代码加个说明，比如‘这是计算总价的代码’，他应该用什么符号来施展注释魔法呢？',
  '["// 这是计算总价的代码", "# 这是计算总价的代码", "<!-- 这是计算总价的代码 -->", "% 这是计算总价的代码"]',
  2,
  '["想想Python里给单行施魔法（加注释）的特殊符号。", "不是双斜杠，也不是百分号，更不是HTML的标签哦。", "这个符号在键盘数字键3上面，常用来表示‘编号’。"]',
  '在Python中，单行注释以井号（#）开头，其后的内容会被解释器忽略，不会执行。其他选项是其他编程语言（如C、HTML、Matlab）的注释语法。',
  '示例：# 打印问候语， print(''Hello'') 这行会被执行，但注释不会。'
),
(
  17,
  2,
  '缩进大冒险',
  '大雄写了个‘if’判断，发现代码不按他的想法运行。问题出在‘print’语句前面少了什么？',
  '["少了中文说明", "少了井号注释", "少了英文冒号", "少了空格缩进"]',
  4,
  '["想想看，哪些属于代码的‘语法’，哪些属于代码的‘结构’。", "在Python中，结构（如哪些代码属于if块）是通过什么来定义的？", "许多语言用花括号，Python用一种独特的视觉方式：缩进。"]',
  'Python使用缩进（空格或制表符）来定义代码块的结构。if语句后的代码块必须保持一致的缩进，否则会导致逻辑错误或IndentationError。',
  '正确：if x>0:↵    print("正数")。错误：if x>0:↵print("正数")（缺少缩进）。'
),
(
  18,
  2,
  '变量名侦探',
  '以下哪个是符合PEP 8规范的Python变量名？（PEP 8是Python官方的代码风格指南）',
  '["MyVariable", "my_variable", "myVariable", "MYVARIABLE"]',
  2,
  '["想想蛇是怎么走路的？它的身体形状是不是一个很好的比喻？", "PEP 8推荐函数和变量名使用这种命名法。", "它既不是大写的驼峰式，也不是全部大写（那是常量的风格）。"]',
  'PEP 8建议函数名和变量名使用小写字母，并用下划线分隔单词（snake_case）。驼峰命名法通常用于类名，全大写常用于常量。',
  '推荐：user_name， total_count。不推荐：userName， TotalCount。'
),
(
  21,
  2,
  '注释结界',
  '胖虎想把一大段代码（比如一个失败的函数）暂时‘封印’起来不执行，用多行注释最安全的方式是什么？',
  '["在每一行前面都加一个#", "用三个连续的单引号 '''''' 把代码包起来", "用三个连续的双引号 \\"\\"\\" 把代码包起来", "选项B和C都可以"]',
  4,
  '["多行注释就是可以跨越多行的注释。", "Python官方文档怎么说多行注释的？", "虽然没有专用的多行注释语法，但用成对的三引号是普遍做法。"]',
  'Python没有专门的多行注释语法。通常使用成对的三个单引号（''''''）或三个双引号（"""）来包裹多行文本，解释器会将其视为一个字符串（如果不赋值给变量，则什么也不做），从而实现多行注释的效果。',
  '''''''这行被注释
这行也被注释
'''''' 或者 """同样有效"""。'
),
(
  22,
  2,
  '缩进陷阱',
  '观察下面两段代码，它们唯一的区别是第2行的缩进。哪段代码会打印两次‘Hello’？',
  '["代码A：for i in range(2):\\n    print(\\"Hello\\")\\nprint(\\"Done\\")", "代码B：for i in range(2):\\nprint(\\"Hello\\")\\n    print(\\"Done\\")", "两段都会打印两次Hello", "两段都不会打印两次Hello"]',
  1,
  '["在Python中，循环体由什么来界定？", "看看‘print(\\"Hello\\")’和‘print(\\"Done\\")’分别和谁对齐。", "代码B的‘print(\\"Hello\\")’没有缩进，它还在循环体内吗？"]',
  'Python使用缩进来定义代码块。在代码A中，第一个print与for语句有缩进，属于循环体，执行2次；第二个print没有缩进，在循环结束后执行1次。代码B的第一个print没有缩进，导致语法错误（IndentationError）。',
  '正确缩进示例：if True:↵    print("Yes")。错误示例：if True:↵print("Yes")（会报错）。'
),
(
  23,
  2,
  '命名大挑战',
  '以下哪个变量名是有效的且符合PEP 8风格？（有效指语法正确，PEP 8指风格推荐）',
  '["2nd_place", "user-name", "global", "calculate_average"]',
  4,
  '["变量名不能以数字开头，也不能包含连字符。", "有些单词是Python的保留关键字（如if, for），不能用作变量名。", "calculate_average这个命名，既有效（字母开头，用下划线），又描述了用途。"]',
  '变量名必须以字母或下划线开头，可包含字母、数字和下划线，且不能是关键字。‘2nd_place’以数字开头；‘user-name’包含连字符；‘global’是关键字；‘calculate_average’符合所有规则且描述清晰。',
  '有效且符合风格：max_score， is_valid。无效：3point（数字开头），my-score（连字符），class（关键字）。'
),
(
  26,
  2,
  '文档字符串初探',
  '静香写了一个函数，想在最开始用三引号添加一段说明，这个说明在Python里有个专门的名字叫？',
  '["多行注释", "版权声明", "文档字符串（Docstring）", "代码签名"]',
  3,
  '["它虽然看起来像注释，但有特殊用途。", "它常用于解释函数、类或模块是做什么的。", "使用`help(函数名)`时看到的内容就是它。"]',
  '在函数、类或模块定义之后，用三引号包裹的字符串称为文档字符串（Docstring）。它不仅可作为注释，更能被Python的help()函数或文档生成工具提取，是官方推荐的代码文档化方式。',
  'def greet(name):↵    """向指定的人打招呼。"""↵    print(f"Hello, {name}!")'
),
(
  27,
  2,
  '风格综合判断',
  '根据PEP 8，以下关于代码风格的描述，哪一项是正确的？',
  '["导入语句（import）应该放在文件末尾。", "每行代码的长度最好限制在79个字符以内。", "类名应该使用snake_case命名法。", "函数定义和其上的注释之间不需要空行。"]',
  2,
  '["想想代码在窄屏幕或并排视图下的可读性。", "PEP 8对行长有明确建议，以避免水平滚动。", "检查其他选项：导入通常在最前面，类名用驼峰法，函数定义前通常有空行。"]',
  'PEP 8建议每行最大长度限制在79个字符，以提高代码在多种设备和编辑器中的可读性。导入语句应放在文件顶部；类名使用驼峰命名法（CapWords）；函数定义前后通常各空两行。',
  '过长的行：result = very_long_function_name(parameter1, parameter2, parameter3, parameter4)。应尝试换行。'
),
(
  28,
  2,
  '注释的误区',
  '下面哪种关于Python注释的说法是错误的？',
  '["注释不会影响程序的执行速度。", "好的注释应该解释“为什么”这么做，而不是“做什么”。", "单行注释可以写在一行代码的后面。", "注释可以用来暂时禁用一行代码。"]',
  2,
  '["注释是给人看的，解释代码意图。", "“做什么”通常能从代码本身看出，“为什么”则需要额外说明。", "但注释也需要解释复杂的“做什么”，尤其是当代码逻辑不直观时。"]',
  '说法B过于绝对。好的注释确实应该着重解释“为什么”（意图、原因），但当代码本身不清晰或复杂时，解释“做什么”也同样重要。A、C、D都是正确的描述：注释不影响性能；可以尾随；可以临时禁用代码。',
  '好注释：# 使用快速排序因为数据基本无序，且对稳定性无要求。 必要的‘做什么’注释：# 交换两个变量的值。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  19,
  2,
  '代码美容院',
  '帮这段有点乱的代码做个‘美容’，添加缺失的单行注释和多行注释符号，并修正一个关键的错误，让它计算圆的面积。',
  NULL,
  '["圆的半径是： 5", "圆的面积是： 78.53981633974483"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " 计算圆的面积"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "radius = 5"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 1}, {"type": "code", "value": "圆的半径是："}, {"type": "slot", "index": 2}, {"type": "code", "value": " radius"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 3}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "本程序使用公式：面积 = π * r^2"}, {"type": "code_line", "value": "π的值约为3.14159"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 4}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "area = 3.14159 * radius ** 2"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 5}, {"type": "code", "value": "圆的面积是："}, {"type": "slot", "index": 6}, {"type": "code", "value": " area"}]}]}',
  '["''''''", "''''''", "#", "print", "print(", ")", "''''''", "\\"\\"\\"", "//", "<!--", "-->", "printf", "echo"]',
  '[2, 4, 5, 0, 7, 4, 5]',
  '第一个空是单行注释符号#。第二、三个空是print函数调用，对应print(和)。第四、七个空是三引号（单或双皆可），包裹多行注释。顺序是第一个‘开’，第二个‘关’。',
  '类似地：# 这是一个单行注释。 ''''''这是
多行
注释'''''''
),
(
  20,
  2,
  'PEP 8诊所',
  '这段代码‘生病’了，有几处不符合PEP 8风格规范。请开出‘处方’，选择正确的选项来修复它（变量命名和运算符间距）。',
  NULL,
  '["商品总价: 150"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "商品单价 = 50"}, {"type": "code_line", "value": "购买数量=3"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " = "}, {"type": "slot", "index": 1}, {"type": "code", "value": " * "}, {"type": "slot", "index": 2}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"商品总价:\\", TotalPrice)"}]}]}',
  '["total_price", "TotalPrice", "product_price", "product_quantity", "商品单价", "购买数量", "product_price", "product_quantity", "+", "-", "**"]',
  '[0, 6, 7]',
  '根据PEP 8，变量名应使用snake_case（小写+下划线），因此‘商品单价’和‘购买数量’应改为英文名，如product_price, product_quantity。同时，赋值运算符‘=’和乘法运算符‘*’两边推荐各加一个空格。',
  '规范：price = 10。不规范：price=10 或 price =10。'
),
(
  24,
  2,
  '重构果汁摊',
  '小夫的果汁摊代码逻辑正确但风格不佳，请帮他重构：将变量名改为snake_case，并为关键步骤添加单行注释。',
  NULL,
  '["苹果汁单价: 8", "购买杯数: 5", "总费用: 40"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": " = 8  "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 每杯价格"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "NumberOfCups = 5"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 2}, {"type": "code", "value": " = "}, {"type": "slot", "index": 0}, {"type": "code", "value": " * NumberOfCups  "}, {"type": "slot", "index": 3}, {"type": "code", "value": " 计算总价"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\"苹果汁单价:\\", AppleJuicePrice)"}, {"type": "code_line", "value": "print(\\"购买杯数:\\", NumberOfCups)"}, {"type": "code_line", "value": "print(\\"总费用:\\", TotalCost)"}]}]}',
  '["apple_juice_price", "AppleJuicePrice", "price_per_cup", "number_of_cups", "NumberOfCups", "total_cost", "TotalCost", "#", "//", "--"]',
  '[0, 7, 5, 7]',
  '首先，变量名应遵循snake_case：AppleJuicePrice改为apple_juice_price，NumberOfCups改为number_of_cups，TotalCost改为total_cost。其次，在关键赋值语句后，使用#添加单行注释来解释代码目的。',
  '重构前：Total=Price*Qty。重构后：total = price * quantity  # 计算商品总额。'
),
(
  25,
  2,
  '代码风格手术',
  '这是一个简单的登录检查代码，但存在多处风格问题（运算符间距、逗号后空格、行长）。请选择正确的选项进行‘手术’修复。',
  '["admin", "123456"]',
  '["用户名: admin", "密码长度: 6", "登录成功!"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "username=input(\\"请输入用户名:\\")"}, {"type": "code_line", "value": "password=input(\\"请输入密码:\\")"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}, {"type": "code", "value": "username"}, {"type": "slot", "index": 1}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 2}, {"type": "code", "value": "密码长度:"}, {"type": "slot", "index": 3}, {"type": "code", "value": "len(password)"}, {"type": "slot", "index": 4}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if username==\\"admin\\" and len(password)>=6:"}, {"type": "code_line", "value": "    print(\\"登录成功!\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\"用户名或密码错误。\\")"}]}]}',
  '["print(\\"用户名:\\",", "print(\\"用户名:\\"", ")", "print(", "\\"密码长度:\\",", "\\"密码长度:\\"", ")", " ", "", "username == \\"admin\\"", "username==\\"admin\\""]',
  '[0, 8, 3, 4, 8, 6, 8]',
  '修复点：1. 运算符（如==， >=， =）两边加空格。2. 函数调用时，逗号后加一个空格。3. 过长的行（如if条件）可以保持，但确保运算符间距规范。具体是print函数调用内参数间的空格和比较运算符旁的空格。',
  '规范：if x == 10:。不规范：if x==10:。规范：print("A", b)。不规范：print("A",b)。'
),
(
  29,
  2,
  '完整风格改造',
  '请对这段学生成绩处理代码进行一次完整的PEP 8风格改造：修正命名、添加空行、添加文档字符串和关键注释。',
  NULL,
  '["平均分是: 85.0"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "计算学生成绩列表的平均分。"}, {"type": "code_line", "value": "参数 scores: 一个包含成绩数字的列表。"}, {"type": "code_line", "value": "返回: 平均分（浮点数）。"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 1}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "def calc_avg(Scores):"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 2}, {"type": "code", "value": "计算总和"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    total=0"}, {"type": "code_line", "value": "    for s in Scores:"}, {"type": "code_line", "value": "        total+=s"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 3}, {"type": "code", "value": "避免除零错误并返回"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if len(Scores)==0:"}, {"type": "code_line", "value": "        return 0.0"}, {"type": "code_line", "value": "    return total/len(Scores)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "my_grades=[90,80,85]"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 4}, {"type": "code", "value": "calc_avg(my_grades)"}]}]}',
  '["\\"\\"\\"", "\\"\\"\\"", "#", "#", "print(\\"平均分是:\\",", "average = ", "''''''", "''''''", "//"]',
  '[0, 6, 2, 2, 5, 4]',
  '第一、七个空添加三引号作为文档字符串。第三、四个空添加单行注释符号#。第五个空添加变量赋值`average = `以存储结果并遵循“显式优于隐式”。第六个空补全print函数调用。',
  '完整风格示例："""函数说明"""↵def func(param):↵    # 步骤说明↵    result = param * 2↵    return result'
),
(
  30,
  2,
  '项目级风格规范',
  '假设你开始一个Python小项目。请按照良好的实践，选择正确的选项来安排这个‘main.py’文件开头的典型结构顺序。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "#!/usr/bin/env python3"}, {"type": "code_line", "value": "# -*- coding: utf-8 -*-"}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "\\"\\"\\""}, {"type": "code_line", "value": "这是一个示例项目的主模块。"}, {"type": "code_line", "value": "主要功能是..."}, {"type": "code_line", "value": "\\"\\"\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 1}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "__author__ = \\"你的名字\\""}, {"type": "code_line", "value": "__version__ = \\"1.0.0\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 2}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "import sys"}, {"type": "code_line", "value": "import os"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 3}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "from my_module import helper"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 4}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "def main():"}, {"type": "code_line", "value": "    # 主逻辑从这里开始"}, {"type": "code_line", "value": "    pass"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": ""}]}, {"type": "code_inline", "parts": [{"type": "slot", "index": 5}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if __name__ == \\"__main__\\":"}, {"type": "code_line", "value": "    main()"}]}]}',
  '["模块文档字符串（Module Docstring）", "模块级魔法变量（如 __author__）", "标准库导入（Standard Library Imports）", "第三方库导入（Third-party Imports）", "本地/应用特定导入（Local/Application Imports）", "函数和类定义", "主程序入口", "shebang 和编码声明之后"]',
  '[0, 1, 2, 4, 5, 6]',
  '典型的Python文件结构顺序是：1. Shebang和编码声明。2. 模块文档字符串。3. 模块级魔法变量。4. 标准库导入。5. 第三方库导入。6. 本地导入。7. 函数和类定义。8. 主程序入口（if __name__...）。',
  '标准结构利于代码维护和团队协作，是良好工程实践的体现。'
);