-- Generated SQL for global_unit=6 (stage=1 unit_local=6 unit_id=6)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  76,
  6,
  '阿强买鸡腿',
  '阿强去小吃店，一个鸡腿5元，一瓶可乐3元。他想用Python计算总价，但写错了。哪个选项的计算结果是正确的8元？',
  '["5 - 3", "\\\"5\\\" + \\\"3\\\"", "5 + 3", "5 + ''3''"]',
  3,
  '["总价应该是把价格加起来。", "数字相加用加法运算符+。", "引号里的数字是文本，不是用来计算的。"]',
  '选项C使用数字5和3进行加法运算，得到结果8，符合总价计算。选项A是减法，选项B是字符串连接得到''53''，选项D尝试数字和字符串相加会引发类型错误。',
  '计算7+2：直接在交互环境输入 7 + 2，会得到结果9。'
),
(
  77,
  6,
  '小美的零钱',
  '小美有10元，买笔花了2元，她想用变量money来记录剩余金额。下列哪段代码能正确计算并打印结果？',
  '["money = 10\\nmoney - 2\\nprint(money)", "money = 10\\nmoney = money - 2\\nprint(money)", "money = 10 - 2\\nprint = money", "money = 10\\nprint(money - money)"]',
  2,
  '["计算后需要把新值存回变量。", "print是函数，括号里放要打印的内容。", "跟踪变量money在每行代码后的值。"]',
  '选项B先将10赋值给money，然后执行‘money = money - 2’，将运算结果8重新赋值给money，最后打印money的值。A未重新赋值，money仍是10；C错误地将print当作变量赋值；D打印的是10-10的结果0。',
  '计算变量a减1：a = 5; a = a - 1; print(a) # 输出4'
),
(
  78,
  6,
  '“加”法的困惑',
  '当加号+遇到两个用英文双引号包住的数字时，Python会怎么做？',
  '["尝试进行数学加法运算。", "报告语法错误，因为引号不该用在数字上。", "将两个“数字”文本连接起来。", "先去掉引号，再进行数学加法运算。"]',
  3,
  '["想想引号的作用是什么。", "对文本“操作”和对数字操作一样吗？", "字符串的‘加’法是拼接。"]',
  '在Python中，被引号（单引号或双引号）包裹的内容是字符串（文本）。加法运算符+用于字符串时，功能是连接（拼接），而不是数学运算。',
  '"12" + "34" 的结果是字符串 "1234"，而不是数字46。'
),
(
  81,
  6,
  '游戏闯关计分',
  '游戏角色初始分数为100。第一关得分加30，第二关失误扣15分。下列哪段代码能正确计算最终分数？',
  '["score = 100\\nscore = score + 30 - 15\\nprint(score)", "score = 100 + 30 - 15\\nprint(score)", "score = 100\\nscore + 30\\nscore - 15\\nprint(score)", "score = 100\\nscore = (score + 30) - 15\\nprint(score)"]',
  1,
  '["需要逐步更新分数变量。", "注意运算符的结合顺序。", "选项A和D的计算过程在数学上等价，但写法不同。"]',
  '选项A是简洁且正确的写法，‘score = score + 30 - 15’ 从左到右计算，等价于先加后减，结果115。选项B虽然结果正确，但未体现分数逐步变化的过程。选项C未将计算结果赋回score变量。选项D加了括号，结果正确，但非必需。',
  '类似地，账户余额变化：balance = 200; balance = balance - 50 + 20。'
),
(
  82,
  6,
  '“订餐”风波',
  '外卖程序里有代码：item = "汉堡" + "薯条"； price = 15 + 7。问：print(item, price) 会输出什么？',
  '["汉堡 薯条 22", "汉堡薯条 157", "汉堡薯条 22", "程序报错"]',
  3,
  '["第一行是两个字符串相加。", "第二行是两个整数相加。", "print可以打印多个值。"]',
  '第一行中，+ 对字符串进行连接，item 的值为 "汉堡薯条"。第二行中，+ 对数字进行加法运算，price 的值为 22。print(item, price) 会依次打印这两个值，中间用空格分隔。',
  '"Py" + "thon" 结果是 "Python"； 10 + 20 结果是 30。'
),
(
  83,
  6,
  '海拔高度差',
  '珠峰高8848米，山脚下营地海拔5200米。登山者爬升的高度差计算代码正确的是？',
  '["height = 8848 + 5200", "height = \\\"8848\\\" - \\\"5200\\\"", "height = 8848 - 5200", "height = 8848 - (0 - 5200)"]',
  3,
  '["高度差是海拔的差值。", "应该用减法。", "参与运算的应该是数字。"]',
  '计算高度差需要用较高的海拔减去较低的海拔，即 8848 - 5200。选项A是相加，B尝试对字符串做减法会报错，D的写法虽结果相同但多此一举。',
  '计算温差：high_temp = 30; low_temp = 22; diff = high_temp - low_temp。'
),
(
  86,
  6,
  '预算大作战',
  '预算100元，买了两件商品，价格分别是‘25’和30。代码：budget = 100 - "25" + 30。运行结果会怎样？',
  '["输出105", "输出75", "程序引发TypeError（类型错误）", "输出 \\\"7530\\\""]',
  3,
  '["注意第一个价格有引号。", "预算100和价格30是数字。", "Python不能直接混合数字和字符串做减法。"]',
  'Python中，减法运算符‘-’不能用于数字和字符串之间的运算。表达式‘100 - "25"’试图从整数100中减去字符串‘"25"’，会导致TypeError。必须先将字符串转换为整数，例如 int("25")。',
  '正确写法：budget = 100 - int("25") + 30， 结果为105。'
),
(
  87,
  6,
  '谜之算式',
  '在Python中，执行 print(10 - 3 + 2) 和 print(10 - (3 + 2))，两次打印的结果分别是？',
  '["9 和 5", "5 和 9", "9 和 9", "5 和 5"]',
  1,
  '["加减运算符优先级相同。", "没有括号时，按从左到右顺序计算。", "括号会改变计算顺序。"]',
  '加减法运算符优先级相同，结合性为从左到右。所以‘10 - 3 + 2’等价于‘(10 - 3) + 2’，结果为9。括号‘(3 + 2)’优先计算得到5，然后‘10 - 5’结果为5。',
  '类似地，20 - 5 - 3 结果是12，而20 - (5 - 3) 结果是18。'
),
(
  88,
  6,
  '数字吞噬者',
  '一个神奇的函数每次‘吞噬’一个数字会让自己增加该数字的值。初始为0，先后吞噬了5和-3。哪个表达式能计算最终值？',
  '["0 + 5 - 3", "0 + 5 + (-3)", "0 - 5 - 3", "A和B都对"]',
  4,
  '["吞噬5是加5。", "吞噬-3是加(-3)。", "减法可以看作是加一个负数。"]',
  '最终值 = 0 + 5 + (-3)。在数学上，加一个负数等于减去这个负数的绝对值，因此表达式‘0 + 5 - 3’与之等价，结果都是2。所以选项A和B都是正确的表达。',
  '计算 8 + (-2) 与 8 - 2 的结果相同，都是6。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  79,
  6,
  '购物小票生成器',
  '帮阿珍完善这个计算购物总额并打印小票的程序。她买了单价10元的苹果和单价5元的香蕉各一份。',
  NULL,
  '["商品总价： 15 元"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "apple_price = 10"}, {"type": "code_line", "value": "banana_price = 5"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "total = apple_price "}, {"type": "slot", "index": 0}, {"type": "code", "value": " banana_price"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"商品总价：\\\", total, \\\"元\\\")"}]}]}',
  '["+", "-", "*", "/", "&", "and", "plus"]',
  '[0]',
  '此处需要计算苹果和香蕉价格的总和，因此应使用加法运算符+。其他选项分别是减法、乘法、除法、位与运算符、逻辑运算符和无效单词。',
  '计算两数之和：sum = 6 + 9'
),
(
  80,
  6,
  '温度转换小助手',
  '今天的天气预报说华氏68度，相当于多少摄氏度呢？公式：摄氏度 = (华氏度 - 32) / 1.8。补全代码。',
  NULL,
  '["20.0"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "f = 68"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "c = (f "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 32) "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 1.8"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(c)"}]}]}',
  '["+", "-", "*", "/", "//", "%", "**"]',
  '[1, 3]',
  '根据公式，首先需要用华氏度f减去32，因此第一个空填减法运算符-。然后需要将减法的结果除以1.8，因此第二个空填除法运算符/。',
  '计算 (100 - 50) / 2 的结果是 25.0。'
),
(
  84,
  6,
  '银行账户模拟',
  '模拟一个简化的银行账户，月初余额1000元，发生了一笔存款和一笔取款。补全代码计算月末余额。',
  NULL,
  '["月末余额： 1050 元"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "balance = 1000  # 月初余额"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "deposit = 200  # 存入"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "withdraw = 150  # 取出"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "# 更新余额"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "balance = balance "}, {"type": "slot", "index": 0}, {"type": "code", "value": " deposit "}, {"type": "slot", "index": 1}, {"type": "code", "value": " withdraw"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"月末余额：\\\", balance, \\\"元\\\")"}]}]}',
  '["+", "-", "*", "/", "&", "|", "//", "然后", "接着"]',
  '[0, 1]',
  '更新余额的逻辑是：余额先加上存入的金额，再减去取出的金额。因此第一个空填加法运算符+，第二个空填减法运算符-。表达式‘balance + deposit - withdraw’的计算顺序从左到右，符合业务逻辑。',
  '计算最终资金：cash = 50; cash = cash + 30 - 10  # 结果70'
),
(
  85,
  6,
  '小车的旅程',
  '一辆小车从起点出发，先向东前进50米，又回头向西走了15米。补全代码计算它离起点的位置（东为正方向）。',
  NULL,
  '["35"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "# 东为正，西为负"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "move_east = 50"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "move_west = -15"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "position = 0 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " move_east "}, {"type": "slot", "index": 1}, {"type": "code", "value": " move_west"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(position)"}]}]}',
  '["+", "-", "*", "/", "加上", "减去", "移动"]',
  '[0, 0]',
  '计算位移是矢量的叠加。从0开始，先向东+50米，所以第一个空用+。然后加上向西的位移（已定义为-15米），所以第二个空也用+。最终 position = 0 + 50 + (-15) = 35。',
  '类似计算：result = 0 + 10 + (-3)  # 结果是7'
),
(
  89,
  6,
  '项目进度计算',
  '一个项目计划100天完成。第一周完成5天任务，第二周因故耽误了2天。补全代码计算剩余所需天数。',
  NULL,
  '["剩余天数： 97"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "total_days = 100"}, {"type": "code_line", "value": "days_done = 5"}, {"type": "code_line", "value": "days_delayed = 2  # 耽误的天数需要补上"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "days_left = total_days "}, {"type": "slot", "index": 0}, {"type": "code", "value": " days_done "}, {"type": "slot", "index": 1}, {"type": "code", "value": " days_delayed"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"剩余天数：\\\", days_left)"}]}]}',
  '["+", "-", "*", "/", "减去", "加上", "扣除"]',
  '[1, 0]',
  '剩余天数 = 总天数 - 已完成天数 + 需要补上的耽误天数。因此，第一个空是减去已完成天数，用-；第二个空是加上耽误天数，用+。即 days_left = 100 - 5 + 2 = 97。',
  '书本总页数500，已读120页，复习需加读10页：left = 500 - 120 + 10'
),
(
  90,
  6,
  '资源调配中心',
  '仓库A有物资80箱，调出20箱到仓库B，又从仓库C获得15箱。补全代码计算仓库A的最终库存。',
  NULL,
  '["仓库A现有库存： 75 箱"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "stock = 80"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "out = 20"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "in_ = 15  # 注意‘in’是关键字，加了下划线"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "stock = (stock "}, {"type": "slot", "index": 0}, {"type": "code", "value": " out) "}, {"type": "slot", "index": 1}, {"type": "code", "value": " in_"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"仓库A现有库存：\\\", stock, \\\"箱\\\")"}]}]}',
  '["-", "+", "*", "/", "minus", "plus"]',
  '[0, 1]',
  '计算过程是：先减去调出的数量，再加上获得的数量。所以，第一个空填-，第二个空填+。括号保证了先减后加的顺序，虽然这里不加括号结果也一样。stock = (80 - 20) + 15 = 75。',
  '账户余额变化：money = (money - 支出) + 收入'
);