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
      {"type": "code", "value": " 计算圆的面积"}
    ]}, 
    {"type": "code_block", "lines": [
      {"type": "code_line", "value": "radius = 5"}, 
      {"type": "code_line", "value": "area = 3.14 * radius ** 2"}, 
      {"type": "code_line", "value": "print(area)"}
    ]}
  ]}',
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
      {"type": "code_line", "value": "    return x"}
    ]}
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
      {"type": "code_line", "value": "    for itemPrice in priceList:"}
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
    ]}
  ]}',
  '["#", "\\\"\\\"\\\"", "\\\"\\\"\\\"", "//", " = ", " == ", "result = ", " = result", "    "]',
  '[2, 3]',
  '第一和第二个空：应用三个单引号`''''''`包裹文档字符串。第三个空：赋值运算符`=`两侧应添加空格，即`result = base**exponent`。',
  'def square(n):
    ''''''返回n的平方。''''''
    result = n ** 2
    return result'
);