-- Generated SQL for global_unit=2 (stage=1 unit_local=2 unit_id=2)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  16,
  2,
  '代码的“悄悄话”',
  '大雄想让Python解释器忽略某行代码，以便给同学留个秘密提示，他应该使用什么符号？',
  '["# 这是注释", "// 这是注释", "/* 这是注释 */", "<!-- 这是注释 -->"]',
  1,
  '["Python和某些语言不同，它用独特的符号开头。", "想想看，哪个符号在Python里最常用来写注释？", "Python的单行注释符号像一个“井”字。"]',
  'Python使用#符号来表示单行注释，其后内容会被解释器完全忽略。其他选项是C、Java或HTML的注释方式，在Python中无效。',
  '# 这是一个价格变量
price = 10'
),
(
  17,
  2,
  '多行注释大不同',
  '小美想为一段复杂的函数添加跨越多行的详细说明，在Python中，她应该使用什么？',
  '["用多个#号分别写在每行前面", "用三个连续的单引号''''''或双引号\\\"\\\"\\\"包裹", "用/*开始，用*/结束", "Python不支持多行注释"]',
  2,
  '["Python确实有办法写出多行注释。", "想想文档字符串常用什么符号？", "三个引号，无论是单引号还是双引号。"]',
  'Python中，用三引号（''''''或"""）包裹的多行字符串常用作多行注释或文档字符串。虽然#每行都写也能实现，但三引号更便捷。选项C是其他语言的语法。',
  '''''''
这是一个计算总和的函数。
参数：a, b
返回：两数之和
'''''''
),
(
  18,
  2,
  'PEP 8的呼唤',
  '根据Python的PEP 8代码风格指南，用于命名函数和变量的推荐风格是？',
  '["camelCase（驼峰式）", "PascalCase（帕斯卡式）", "snake_case（蛇形式）", "kebab-case（烤肉串式）"]',
  3,
  '["想想Python内置函数的名字，比如`print`、`len`。", "它们是用下划线连接的，比如`is_valid`。", "这种风格看起来像一条蛇。"]',
  'PEP 8规定函数名和变量名应使用小写字母，单词间用下划线连接，即snake_case风格。这有助于保持代码的一致性和可读性。',
  'def calculate_average():
    total_sum = 100'
),
(
  21,
  2,
  '注释的“副作用”',
  '运行下面代码会输出什么？代码：print("Hello") # print("World")',
  '["Hello", "World", "Hello World", "报错"]',
  1,
  '["#号后面的内容是什么？", "注释会被Python解释器执行吗？", "只有#前面的`print(\\\"Hello\\\")`会被执行。"]',
  '`#`是单行注释符号，其后的`print("World")`被解释器完全忽略，不会执行。因此只有第一个`print`语句生效，输出Hello。',
  'x = 1 # 这里x被赋值为1，注释不影响赋值操作'
),
(
  22,
  2,
  '风格检查员',
  '下列哪个变量名最符合PEP 8的风格建议？',
  '["userName", "UserName", "user_name", "user-name"]',
  3,
  '["回顾一下，PEP 8推荐变量名用什么风格？", "是驼峰式、帕斯卡式还是蛇形式？", "单词之间用下划线连接。"]',
  'PEP 8推荐变量名使用小写字母，并用下划线分隔单词，即snake_case。`user_name`完全符合这一规范，其他选项分别采用了不同的命名风格。',
  'first_name = "Alice"  # 符合规范
firstName = "Alice"     # 不符合Python主流风格'
),
(
  23,
  2,
  '缩进大冒险',
  '在Python中，哪种缩进方式是符合PEP 8推荐且能正常工作的？',
  '["使用1个空格", "使用4个空格", "使用1个制表符(Tab)", "混合使用空格和Tab"]',
  2,
  '["PEP 8对缩进有明确的推荐。", "空格和Tab都能让代码运行，但哪个是“推荐”的？", "四个空格是黄金标准。"]',
  'PEP 8明确推荐使用4个空格作为每级缩进。虽然一个Tab或混合方式可能不会导致语法错误，但为了代码的一致性和可读性，应使用4个空格。',
  'def example():
    print("缩进4个空格")  # 推荐
    print("再缩进4个空格")'
),
(
  26,
  2,
  '综合风格判断',
  '以下哪段代码在注释和代码风格上都符合PEP 8的推荐？',
  '["def add(x,y):#相加\\n    return x+y", "def add(x, y):  # 相加函数\\n    return x + y", "def Add(x, y):  # 相加函数\\n    return x+y", "# 相加函数\\ndef add(x,y):\\n    return x + y"]',
  2,
  '["检查函数名风格、参数空格、注释格式。", "好的风格包括函数名小写、参数逗号后空格、运算符空格。", "注释`#`后应有一个空格再写内容。"]',
  '选项B完全符合：函数名snake_case、参数逗号后有一个空格、注释`#`后有一个空格、运算符`+`两侧有空格。其他选项在空格、命名或注释格式上存在一处或多处问题。',
  'def multiply(a, b):  # 返回乘积
    return a * b'
),
(
  27,
  2,
  '注释的智慧',
  '关于Python代码注释，以下哪种说法是最佳实践？',
  '["注释越多越好，每行代码都加上注释", "注释应解释“为什么”这么做，而不是“做什么”", "使用复杂的多行注释来解释简单的代码", "注释可以用任何语言写，包括拼音和缩写"]',
  2,
  '["注释的目的是补充代码难以表达的信息。", "代码本身已经说明了“做什么”，但“为什么”这样做可能不清楚。", "想想什么样的注释对未来的维护者最有帮助。"]',
  '好的注释应解释代码的意图和原因（为什么），因为代码本身通常能展示“做什么”。过度注释或注释无关信息反而会降低可读性。注释应简洁、清晰，通常使用项目主要语言。',
  '# 使用快速排序因为数据量可能很大
result = quick_sort(data)'
),
(
  28,
  2,
  '行长度的秘密',
  '根据PEP 8，代码行的最大推荐长度是多少字符？',
  '["80", "100", "120", "79"]',
  4,
  '["PEP 8有一个非常具体的数字。", "这个数字小于80。", "它允许在80字符的终端中显示行号。"]',
  'PEP 8推荐将所有行限制在最多79个字符。这有助于在多个编辑器并排查看时保持可读性，并且兼容大多数工具和终端窗口的默认宽度（通常是80字符）。',
  '# 这是一个很长的注释，但我们应该尽量将它保持在79个字符以内，以确保代码的整洁。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  19,
  2,
  '给代码加注释',
  '帮阿强完善代码，让注释告诉别人这段代码计算的是圆的面积。',
  NULL,
  NULL,
  '{"segments": [
    {"type": "code_inline", "parts": [
      {"type": "slot", "index": 0}, 
      {"type": "code", "value": " 计算圆的面积"}, 
    ]}, 
    {"type": "code_block", "lines": [
      {"type": "code_line", "value": "radius = 5"}, 
      {"type": "code_line", "value": "area = 3.14 * radius ** 2"}, 
      {"type": "code_line", "value": "print(area)"}]}]}',
  '["#", "//", "/*", "''''''", "*/", "<!--", "-->"]',
  '[1]',
  '第一个空应为`#`，因为这是Python的单行注释符号。',
  '# 这是一行注释
x = 1'
),
(
  20,
  2,
  '三引号文档',
  '帮小丽用三引号给她的函数添加一个简单的说明文档。',
  NULL,
  NULL,
  '{"segments": [
    {"type": "code_block", "lines": [
      {"type": "code_line", "value": "def greet(name):"}, 
      {"type": "code_line", "value": "    "}
    ]}, 
    {"type": "code_inline", "parts": [
      {"type": "slot", "index": 0}, 
      {"type": "code", "value": "打印问候语"}, 
      {"type": "slot", "index": 1}
    ]}, 
    {"type": "code_block", "lines": [
      {"type": "code_line", "value": "    print(f\\\"Hello, {name}!\\\")"}
    ]}
  ]}',
  '["#", "\\\"\\\"\\\"", "''''''", "//", "/*", "*/", "''''''"]',
  '[3, 7]',
  '两个空都应填入三个单引号`''''''`，它们作为多行字符串（常用作文档字符串）的开始和结束标记。注意，三个双引号`"""`也同样正确。',
  'def my_func():
    ''''''这是一个文档字符串。''''''
    pass'
),
(
  24,
  2,
  '整理代码布局',
  '根据PEP 8，帮阿飞修正代码中的空行和空格使用。',
  NULL,
  NULL,
  '{"segments": [
    {"type": "code_block", "lines": [
      {"type": "code_line", "value": "def func1():"}, 
      {"type": "code_line", "value": "    pass"}
    ]},
    {"type": "code_inline", "parts":[
      {"type": "slot", "index": 0}
    ]},
    {"type": "code_block", "lines": [
      {"type": "code_line", "value": "def func2():"}
    ]},
    {"type": "code_inline", "parts": [
      {"type": "code", "value": "    "},
      {"type": "slot", "index": 1}
    ]},
    {"type": "code_block", "lines": [
      {"type": "code_line", "value": "    return x"}, 
    ]},
  ]}',
  '["一个空格", "一个空行", "两个空行", "两个空格", "# 空行", "x=1+2", "x = 1 + 2"]',
  '[3, 7]',
  '第一个空：PEP 8建议在函数定义之间用两个空行（即`\n\n`）分隔。第二个空：在运算符（如`=`）两侧添加空格可以提高可读性，应为`x = 1 + 2`。',
  'def a():
    pass


def b():
    result = 3 * 4  # 运算符两边有空格'
),
(
  25,
  2,
  '命名大改造',
  '将不符合PEP 8规范的变量名和函数名替换为推荐的形式。',
  NULL,
  NULL,
  '{"segments": [
    {"type": "code_block", "lines": [
      {"type": "code_line", "value": "def CalculateTotal(priceList):"}, 
      {"type": "code_line", "value": "    total_sum = 0"}, 
      {"type": "code_line", "value": "    for itemPrice in priceList:"},
    ]},
    {"type": "code_inline", "parts": [
      {"type": "slot", "index": 0}, 
      {"type": "code", "value": " = total_sum + itemPrice"}, 
      {"type": "slot", "index": 1}
    ]},
    {"type": "code_block", "lines": [
      {"type": "code_line", "value": "    return total_sum"}
    ]}
  ]}',
  '["total_sum", "TotalSum", "totalSum", "item_price", "ItemPrice", "itemPrice", "calculate_total", "Calculate_Total"]',
  '[1, 6]',
  '第一个空：函数名应改为snake_case，`calculate_total`符合规范。第二个空：`total_sum`变量名已经是snake_case且符合上下文，无需更改。但题目要求替换，且填空对应的是变量名`total_sum`的首次出现？仔细看代码：第一行`total_sum = 0`已经定义，填空处是`[slot] = total_sum + itemPrice`，所以slot处应该是变量名`total_sum`。选项1是`total_sum`。但注意，代码中已有`total_sum`，此处是重新赋值，所以用同一个名字。',
  'def get_user_score():  # 函数名snake_case
    max_score = 100     # 变量名snake_case'
),
(
  29,
  2,
  '修复综合风格',
  '这段代码在注释、命名和空格上有多处问题，请根据PEP 8修正它。',
  NULL,
  NULL,
  '{"segments": [
    {"type": "code_inline", "parts": [
      {"type": "slot", "index": 0}, 
      {"type": "code", "value": "计算平均值"}
    ]}, 
    {"type": "code_block", "lines": [
      {"type": "code_line", "value": "def calc_avg(num_list):"}, 
      {"type": "code_line", "value": "    sum=0"}, 
      {"type": "code_line", "value": "    for n in num_list:"}
    ]},
    {"type": "code_inline", "parts": [
      {"type": "slot", "index": 1}, 
      {"type": "code", "value": "n"}
    ]},
    {"type": "code_block", "lines": [
      {"type": "code_line", "value": "    avg=sum/len(num_list)"}, 
      {"type": "code_line", "value": "    return avg"}
    ]}
  ]}',
  '["#", "''''''", "\\\"\\\"\\\"", "//", " = ", " == ", "sum+", "sum + ", "sum = sum + ", "sum+= "]',
  '[1,10]',
  '第一和第二空：应为`#`和` `（一个空格），组成`# 计算平均值`，这是带空格的单行注释。第三和第四空：累加操作应为`sum += n`或`sum = sum + n`',
  ''
),
(
  30,
  2,
  '完善函数文档',
  '为这个函数添加合适的文档字符串（docstring）并修正一处风格问题。',
  NULL,
  NULL,
  '{"segments": [
    {"type": "code_block", "lines": [
      {"type": "code_line", "value": "def power(base, exponent):"}
    ]},
    {"type": "code_inline", "parts": [
      {"type": "slot", "index": 0}, 
      {"type": "code", "value": "返回base的exponent次幂。"}, 
      {"type": "slot", "index": 1}
    ]}, 
    {"type": "code_block", "lines": [
      {"type": "code_line", "value": "    result=base**exponent"}, 
      {"type": "code_line", "value": "    return result"}
    ]},
  ]}',
  '["#", "\\\"\\\"\\\"", "\\\"\\\"\\\"", "//", " = ", " == ", "result = ", " = result", "    "]',
  '[2, 3]',
  '第一和第二个空：应用三个单引号`''''''`包裹文档字符串。第三个空：赋值运算符`=`两侧应添加空格，即`result = base**exponent`。',
  'def square(n):
    ''''''返回n的平方。''''''
    result = n ** 2
    return result'
);