-- Generated SQL for global_unit=4 (stage=1 unit_local=4 unit_id=4)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  46,
  4,
  '购物小票计算器',
  '阿强买了3本书，每本25元，用Python整数运算计算总价，以下哪个表达式是错误的？',
  '["3 * 25", "25 + 25 + 25", "3 + 25", "75 // 1"]',
  3,
  '["3+25是多少？这和3本书的总价相符吗？", "计算总价应该用乘法或重复加法。", "3+25结果是28，而总价是75，所以这个表达式错误。"]',
  '整数运算用于数学计算，选项C执行的是加法（3+25=28），而非计算3本书的总价（3*25=75），因此错误。其他选项都能正确计算出总价75。',
  '求5个单价为10元的物品总价：5 * 10 或 10+10+10+10+10。'
),
(
  47,
  4,
  '猜猜整数除法的结果',
  '在Python中，计算 `10 / 2`，得到的结果是什么类型？',
  '["整数（int）", "浮点数（float）", "布尔值（bool）", "字符串（str）"]',
  2,
  '["/ 是除法运算符，想想小学除法。", "即使能整除，在Python中它也会返回小数形式。", "结果是5.0，带小数点的数字是浮点数。"]',
  '在Python中，使用单斜杠 `/` 进行除法运算，结果总是浮点数（float），即使两个整数能整除。所以10/2结果是5.0，是float类型。',
  '`8 / 4` 的结果是2.0，也是浮点数类型。'
),
(
  48,
  4,
  '身份证变量名',
  '阿珍想用Python存储自己的年龄18岁，以下哪个变量名是合法且推荐的？',
  '["18_age", "my age", "myAge", "class"]',
  3,
  '["变量名能以数字开头吗？看看选项A。", "变量名中间可以有空格吗？看看选项B。", "class这个词Python自己要用，我们能抢吗？看看选项D。"]',
  '变量命名规则：1. 只能包含字母、数字、下划线。2. 不能以数字开头。3. 不能是Python关键字。4. 推荐使用描述性名称，如myAge。myAge合法且清晰。',
  '存储用户分数：`user_score = 95`。'
),
(
  51,
  4,
  '变量的奥秘',
  '在Python中，执行`x = 5; y = x; x = 10`后，`y`的值是多少？',
  '["5", "10", "x", "程序会报错"]',
  1,
  '["y = x 是把x的‘值’给了y，还是把x这个‘标签’给了y？", "执行第二行后，y的值就固定为当时x的值5了。", "第三行修改x，不会影响已经赋值给y的5。"]',
  '变量赋值是值的传递。`y = x`时，将x当时的值（5）复制一份给了y。之后改变x的值，不影响y。y的值仍然是5。',
  '`a=1; b=a; a=2` 执行后，b的值是1。'
),
(
  52,
  4,
  '合法的命名游戏',
  '下列哪个选项不能作为Python的变量名？',
  '["my_variable", "_private", "2nd_place", "totalScore"]',
  3,
  '["变量名的第一个字符有什么限制？", "试试看‘2nd_place’第一个字符是什么？", "数字2不能作为变量名的开头。"]',
  'Python变量命名规则规定，变量名必须以字母（a-z, A-Z）或下划线（_）开头，不能以数字开头。因此`2nd_place`是非法变量名。',
  '合法的数字相关变量名：`score2`, `round_2`。'
),
(
  53,
  4,
  '整数的超能力',
  '关于Python整数（int），以下哪个说法是错误的？',
  '["整数可以进行加（+）、减（-）、乘（*）、除（/）运算。", "整数在Python中可以表示任意大的数值（受内存限制）。", "两个整数相除（/），结果一定是整数。", "整数可以用十进制、二进制（0b）、十六进制（0x）表示。"]',
  3,
  '["回忆一下第2题，10/2的结果是什么类型？", "Python里，整数除法和数学除法概念略有不同。", "单斜杠‘/’除法结果总是浮点数，即使能整除。"]',
  '在Python中，两个整数使用单斜杠`/`进行除法运算，结果总是浮点数（float），例如`4/2`结果是`2.0`，而不是整数2。',
  '`7 / 2` 的结果是3.5，是浮点数。'
),
(
  56,
  4,
  '大整数运算',
  '阿伟写了一个计算2的100次方的程序：`result = 2 ** 100`。这个计算在Python中会怎么样？',
  '["会发生整数溢出错误，因为数字太大。", "会得到一个近似值（浮点数）。", "会得到一个极其巨大的精确整数结果。", "程序会卡死，无法计算。"]',
  3,
  '["Python的整数有范围限制吗？想想第8题的一个知识点。", "2**10=1024，2**100会是一个天文数字。", "Python的int类型可以处理任意大的整数（只要内存够）。"]',
  'Python的整数（int）类型支持任意精度，这意味着它可以表示任意大的整数（仅受计算机可用内存限制），所以`2 ** 100`会计算出一个非常长但精确的整数。',
  '计算`10 ** 100`也会得到一个精确的、有101位的巨大整数。'
),
(
  57,
  4,
  '运算优先级之争',
  '表达式 `2 + 3 * 4 ** 2` 在Python中计算结果是多少？',
  '["80", "100", "196", "50"]',
  4,
  '["Python运算遵循数学优先级：先乘方，再乘除，后加减。", "先算`4 ** 2`等于多少？", "然后算`3 * 16`等于多少？最后再加2。"]',
  '根据运算优先级：`**`（幂运算）最高，然后是`*`，最后是`+`。计算过程：`4**2=16`，`3*16=48`，`2+48=50`。',
  '计算 `1 + 2 * 3 ** 2`：先算3的平方9，再乘2得18，最后加1得19。'
),
(
  58,
  4,
  '类型混搭的后果',
  '小明的代码里写着 `age = 18` 和 `name = ''小明''`，他尝试执行 `info = name + age`，会发生什么？',
  '["info会变成字符串''小明18''。", "info会变成整数36（如果name能转为数字的话）。", "程序会报错，因为类型不匹配。", "info会变成布尔值True。"]',
  3,
  '["`+`对字符串和数字都能用吗？对字符串是拼接，对数字是加法。", "Python是强类型语言，不同基本类型不能直接混合运算。", "试试看，字符串''abc''和整数123能直接相加吗？"]',
  '在Python中，`+`运算符在字符串间表示拼接，在数字间表示加法。但字符串和整数是两种不同的数据类型，不能直接使用`+`运算，会导致`TypeError`。',
  '正确做法：`info = name + str(age)`，先将整数转为字符串再拼接。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  49,
  4,
  '填空年龄计算',
  '帮助小明计算两年后的年龄，他今年15岁。请补全代码。',
  NULL,
  '["17"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "age_now = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\nage_future = age_now "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 2\\nprint(age_future)"}]}]}',
  '["15", "+", "-", "*", "/", "1.5", "=", "==", "age_now"]',
  '[0, 1]',
  '代码首先需要一个整数15给age_now赋值，然后两年后年龄应为当前年龄加2，因此第二个空填加法运算符‘+’。',
  '计算三年后的年龄：`age_future = age_now + 3`。'
),
(
  50,
  4,
  '整数类型转换',
  '小明的体重是45.7公斤，但他只想用整数部分记录，请补全代码进行转换。',
  NULL,
  '["45"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "weight_float = 45.7"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "weight_int = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(weight_float)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(weight_int)"}]}]}',
  '["str", "float", "int", "bool", "convert", "to_int", "type"]',
  '[2]',
  '`int()`函数可以将一个数值（浮点数）转换为其整数部分（直接舍弃小数，不是四舍五入），45.7转换后为45。',
  '将浮点数3.14转为整数：`int(3.14)` 结果是3。'
),
(
  54,
  4,
  '填空变量交换',
  '经典问题：不使用第三个变量，交换变量a和b的值（a和b都是整数）。请补全代码。',
  NULL,
  '["a=20, b=10"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = 10"}, {"type": "code_line", "value": "b = 20"}, {"type": "code_line", "value": "print(f\\\"初始值: a={a}, b={b}\\\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "a = "}, {"type": "slot", "index": 0}, {"type": "code", "value": " b"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "b = "}, {"type": "slot", "index": 1}, {"type": "code", "value": " "}, {"type": "slot", "index": 2}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(f\\\"交换后: a={a}, b={b}\\\")"}]}]}',
  '["+", "-", "*", "/", "a", "b", "10", "20", "a + b", "a - b"]',
  '[0, 8, 1]',
  '这是经典的交换算法。首先`a = a + b`将和存入a（a变为30）。然后`b = a - b`，此时a是30，减去原b值20，b得到原a值10。最后`a = a - b`，此时a是30，b是10，相减后a得到原b值20。',
  '若x=3， y=4。交换：x=x+y(7); y=x-y(3); x=x-y(4)。完成交换。'
),
(
  55,
  4,
  '填空题：余额计算器',
  '用变量记录零花钱和消费，计算剩余余额。请补全代码。',
  NULL,
  '["剩余余额： 15"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": " "}, {"type": "slot", "index": 0}, {"type": "code", "value": " = 50  # 零花钱"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "spent_on_book = "}, {"type": "slot", "index": 1}, {"type": "code", "value": "  # 买书花了25"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "spent_on_snack = 10  # 买零食花了10\\nbalance = pocket_money "}, {"type": "slot", "index": 2}, {"type": "code", "value": " spent_on_book "}, {"type": "slot", "index": 3}, {"type": "code", "value": " spent_on_snack\\nprint(\\\"剩余余额：\\\", balance)"}]}]}',
  '["50", "25", "10", "pocket_money", "balance", "-", "+", "*", "/", "="]',
  '[3, 1, 5, 5]',
  '代码逻辑：先定义变量存储零花钱和各项消费，然后计算余额。零花钱变量名应为‘pocket_money’，买书花费为整数25，计算余额需要从零花钱中连续减去两项花费，因此使用减法运算符‘-’。',
  '收入100，支出30和20，余额计算：`balance = 100 - 30 - 20`。'
),
(
  59,
  4,
  '进阶填空：求余数应用',
  '判断一个整数（存在变量num中）是奇数还是偶数。偶数输出‘Even’，奇数输出‘Odd’。请补全代码。',
  '["7"]',
  '["Odd"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "num = int(input())  # 假设输入是7"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if num "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 2 "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"Even\\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\\"Odd\\\")"}]}]}',
  '["+", "-", "*", "/", "%", "//", "==", "!=", ">", "<", "="]',
  '[4, 1]',
  '判断奇偶性的核心是求余数运算`%`。一个整数除以2的余数为0则是偶数，否则为奇数。因此条件应为 `if num % 2 == 0:`。',
  '判断变量x是否能被3整除：`if x % 3 == 0:`。'
),
(
  60,
  4,
  '终极填空：综合计算器',
  '编写一个迷你计算器，计算两个整数的和、差、积、整除商和余数。请补全代码。',
  '["8", "3"]',
  '["和: 11", "差: 5", "积: 24", "整除商: 2", "余数: 2"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = int(input())"}, {"type": "code_line", "value": "b = int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "sum_ab = a + b"}, {"type": "code_line", "value": "diff_ab = a - b"}, {"type": "code_line", "value": "prod_ab = a * b"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "quotient_ab = a "}, {"type": "slot", "index": 0}, {"type": "code", "value": " b  # 整除商"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "remainder_ab = a "}, {"type": "slot", "index": 1}, {"type": "code", "value": " b  # 余数"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(f\\\"和: {sum_ab}\\\")"}, {"type": "code_line", "value": "print(f\\\"差: {diff_ab}\\\")"}, {"type": "code_line", "value": "print(f\\\"积: {prod_ab}\\\")"}, {"type": "code_line", "value": "print(f\\\"整除商: {quotient_ab}\\\")"}, {"type": "code_line", "value": "print(f\\\"余数: {remainder_ab}\\\")"}]}]}',
  '["+", "-", "*", "/", "%", "//", "**", "=="]',
  '[5, 4]',
  '求两个整数的整除商应使用取整除法运算符`//`（例如8//3=2）。求余数应使用模运算符`%`（例如8%3=2）。它们都是针对整数的常用运算。',
  '13除以5：整除商 `13 // 5` 结果是2，余数 `13 % 5` 结果是3。'
);