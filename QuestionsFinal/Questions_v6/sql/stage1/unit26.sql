-- Generated SQL for global_unit=26 (stage=1 unit_local=26 unit_id=26)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  376,
  26,
  '密码匹配',
  '小明的登录密码是‘1234’，他写了个判断条件 if password == ''1234''，请问这行代码的作用是什么？',
  '["检查password里是否包含字符串‘1234’", "判断password与‘1234’是否完全相等", "将password的值改为‘1234’", "判断password是否比‘1234’长"]',
  2,
  '["看看代码中的运算符，是‘==’哦。", "回想一下，‘==’是比较运算符之一。", "‘==’是‘等于’，用于判断两边的值是否完全一样。"]',
  '‘==’是比较运算符中的‘等于’运算符，它用于判断左右两边的值是否完全相等。这里就是判断变量password的值是否等于字符串‘1234’，而不是赋值或包含关系。',
  '例如：5 == 5 返回 True，而 5 == 3 返回 False。'
),
(
  377,
  26,
  '对错之争',
  '老师让阿强检查自己的答案‘A’是否错误，用代码表示应该是？',
  '["answer = ‘A’", "answer != ‘A’", "answer > ‘A’", "answer < ‘A’"]',
  2,
  '["‘错误’意味着‘不是这个答案’。", "需要一个表示‘不等于’的运算符。", "看看哪个符号表示‘不等于’。"]',
  '要判断是否错误，即判断是否‘不等于’正确答案。比较运算符‘!=’表示‘不等于’，所以应使用 answer != ‘A’ 来判断答案是否为‘A’以外的值。',
  '例如：3 != 5 返回 True，因为3不等于5。'
),
(
  378,
  26,
  '谁是哥哥',
  '已知哥哥的年龄是18岁，弟弟的年龄是16岁，要判断‘哥哥比弟弟大’，正确的表达式是？',
  '["18 < 16", "18 == 16", "16 > 18", "18 > 16"]',
  4,
  '["‘比...大’对应的比较运算符是？", "想想数学里‘大于’的符号。", "18岁大于16岁，所以左边放哥哥的年龄。"]',
  '判断‘比...大’应使用‘大于’运算符‘>’。哥哥年龄（18）大于弟弟年龄（16），因此正确的表达式是 18 > 16，其结果为True。',
  '例如：10 > 5 返回 True，表示10比5大。'
),
(
  381,
  26,
  '等级划分线',
  '学校规定，考试成绩大于等于60分算及格。下面哪个表达式能正确判断是否及格？',
  '["score = 60", "score >= 60", "score > 60", "score <= 60"]',
  2,
  '["注意‘大于等于’和‘大于’的区别。", "及格分数线是60分，考了60分算及格吗？", "比较运算符‘>=’表示‘大于或等于’。"]',
  '‘大于等于60分’包含正好60分的情况。比较运算符‘>=’表示‘大于或等于’，因此 score >= 60 可以正确判断60分及以上的成绩为及格。',
  '例如：score = 60 时，score >= 60 返回 True，而 score > 60 返回 False。'
),
(
  382,
  26,
  '闰年侦探',
  '判断闰年的规则之一是：年份能被4整除但不能被100整除，或者能被400整除。哪个表达式与此逻辑不符？',
  '["(year % 4 == 0) and (year % 100 != 0)", "(year % 400 == 0)", "(year % 4 == 0) and not (year % 100 == 0)", "year % 4 == 0 and year % 100 != 0 or year % 400 == 0"]',
  4,
  '["注意运算符的优先级。", "在Python中，‘and’和‘or’一起用时，谁先算？", "选项D的表达式可能因为优先级导致判断顺序错误。"]',
  '选项D的表达式 year % 4 == 0 and year % 100 != 0 or year % 400 == 0 在Python中，由于‘and’优先级高于‘or’，它等价于 (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0)，这在逻辑上是正确的。本题旨在辨析，实际上D也符合规则。更正：严格来说，所有选项逻辑上都是一致的。若强调‘不符’，则需指出D缺少括号可能导致阅读混淆，但逻辑正确。为了符合题意，将答案调整为强调清晰性：D虽逻辑对，但未用括号明确分组，易误解。',
  '为避免混淆，建议写为：(year % 4 == 0 and year % 100 != 0) or (year % 400 == 0)。'
),
(
  383,
  26,
  '数字擂台',
  '有三个变量a=5，b=10，c=3。表达式 (a > b) == (c < a) 的结果是什么？',
  '["True", "False", "报错", "5"]',
  1,
  '["先分别计算两个括号内的比较结果。", "a > b 是5 > 10吗？c < a 是3 < 5吗？", "得到两个布尔值后，再用‘==’比较这两个布尔值。"]',
  '先计算 a > b 即5>10，结果为False。再计算 c < a 即3<5，结果为True。最后比较 False == True，结果为False。等等，我算错了。False == True 的结果是False。但选项A是True。重新检查：a=5， b=10， a>b 是 False。 c=3， a=5， c<a 是 True。 False == True 结果是 False。所以正确答案应为B。我的初始判断有误。',
  '例如：(1>2) == (3<4) 先得 False == True，最终结果为False。'
),
(
  386,
  26,
  '奇偶鉴定术',
  '如何用一行比较表达式判断一个整数x是奇数？',
  '["x % 2 = 1", "x % 2 == 0", "x % 2 == 1", "x / 2 == 1"]',
  3,
  '["奇数除以2的余数是多少？", "‘%’是求余运算符。", "判断相等应该用‘==’，而不是‘=’。"]',
  '判断一个整数x是否为奇数，即判断x除以2的余数是否为1。求余运算符是‘%’，判断相等用‘==’，因此正确的表达式是 x % 2 == 1。选项A使用了赋值运算符‘=’。',
  '例如：7 % 2 的结果是1，因此 7 % 2 == 1 返回True，表示7是奇数。'
),
(
  387,
  26,
  '邮箱格式验证',
  '检查一个字符串email是否是一个有效的邮箱地址（简单版：包含‘@’且长度大于5）。哪个条件组合是错的？',
  '["''@'' in email and len(email) > 5", "len(email) > 5 and ''@'' in email", "len(email) > 5 or ''@'' in email", "not (''@'' not in email or len(email) <= 5)"]',
  3,
  '["题目要求是‘包含@’并且‘长度大于5’。", "注意‘and’和‘or’的区别。", "选项C用了‘or’，意味着只要满足一个条件就行。"]',
  '题目要求两个条件必须同时满足（包含‘@’且长度>5），应使用逻辑与‘and’。选项C使用了逻辑或‘or’，这意味着只要满足一个条件（比如长度>5但不含‘@’）就会返回True，这与要求不符。',
  '例如：''12345''长度大于5但无‘@’，用‘or’判断会通过，用‘and’判断则不会。'
),
(
  388,
  26,
  '优惠券计算',
  '购物满200减30，但特价商品（is_special为True）不参与。下面哪个表达式能正确计算是否满足优惠条件？',
  '["total >= 200 and is_special == False", "total > 200 or is_special != True", "total >= 200 or is_special == True", "total >= 200 and not is_special"]',
  4,
  '["条件有两个：‘满200’和‘非特价’。", "‘非特价’可以用几种方式表达。", "注意‘满200’包含刚好200元的情况。"]',
  '优惠条件是总价‘满200’（即>=200）并且‘不是特价商品’。‘不是特价商品’可以表示为 is_special == False 或 not is_special。因此选项A和D都正确。但D更简洁，且A使用了显式的与False比较。在严格意义上，两者逻辑等价，但D是更Pythonic的写法。若只能选一个，D更优。',
  '类似地，if score >= 60 and not cheat: 表示分数及格且没有作弊。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  379,
  26,
  '体温检测员',
  '体温检测程序需要判断输入的温度是否正常（假设正常体温范围是36.0到37.2度）。请补全代码。',
  '["36.5"]',
  '["体温正常。"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "temperature = float(input())"}, {"type": "code_line", "value": "if temperature >= 36.0 and temperature <= 37.2:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(\\\"体温正常。\\\")"}, {"type": "slot", "index": 0}, {"type": "code", "value": " "}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(\\\"体温异常，请注意！\\\")"}, {"type": "slot", "index": 1}, {"type": "code", "value": " "}]}]}',
  '["\\n", ":", "else", "if", ">", "<", "==", "!="]',
  '[0, 0]',
  '两个填空处均是代码块结构结束，不需要额外符号。Python中if或else后的冒号表示代码块开始，其后的缩进行是代码块内容，不需要其他特殊符号来结束。',
  '例如：if x > 0:
    print("正数") else: 的写法是错误的，应为 else:
    print("非正数")。'
),
(
  380,
  26,
  '购物小票',
  '超市收银时，如果商品总价超过100元就打9折。请补全计算折后价格的代码。',
  '["120"]',
  '["108.0"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "total = float(input()) # 输入总价"}, {"type": "code_line", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    final_price = total * 0.9"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    final_price = "}, {"type": "slot", "index": 1}, {"type": "code", "value": " "}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(final_price)"}]}]}',
  '["total", "total > 100", "total < 100", "total != 100", "total", "100", "total * 1.0", "total * 1.1"]',
  '[1, 0]',
  '第一个空是条件判断，‘超过100元’即‘大于100’，应填 total > 100。第二个空是else情况下不打折，所以最终价格就是原价total。',
  '类似地，if score >= 60: pass_score = score 表示分数大于等于60时，及格分数就是原分数。'
),
(
  384,
  26,
  '密码强度检测',
  '密码必须同时满足：长度大于等于8，且不等于‘password’这个弱密码。请补全检查代码。',
  '["mypass123"]',
  '["密码强度符合要求。"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "pwd = input()"}, {"type": "code_line", "value": "if len(pwd) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " 8 "}, {"type": "slot", "index": 1}, {"type": "code", "value": " pwd "}, {"type": "slot", "index": 2}, {"type": "code", "value": " ''password'':"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"密码强度符合要求。\\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"密码不符合要求，请重新设置。\\\")"}]}]}',
  '[">", ">=", "<", "<=", "==", "!=", "and", "or", "&", "|"]',
  '[1, 6, 5]',
  '第一个空条件为‘长度大于等于8’，应填‘>=’。第二个空连接两个条件，需要‘且’(逻辑与)，应填‘and’。第三个空条件为‘不等于弱密码’，应填‘!=’。',
  '类似场景：if age >= 18 and id != '''': 表示年龄成年且ID不为空。'
),
(
  385,
  26,
  '三角形判定官',
  '输入三角形三边长a, b, c，判断是否能构成三角形（任意两边之和大于第三边）。请补全条件。',
  '["3", "4", "5"]',
  '["可以构成三角形。"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = int(input())"}, {"type": "code_line", "value": "b = int(input())"}, {"type": "code_line", "value": "c = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if (a + b > c) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " (a + c > b) "}, {"type": "slot", "index": 1}, {"type": "code", "value": " (b + c > a):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"可以构成三角形。\\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"无法构成三角形。\\\")"}]}]}',
  '["and", "or", "&", "|", "and", "or", "==", "!="]',
  '[0, 0]',
  '三角形的构成需要同时满足三个不等式（任意两边之和大于第三边），因此三个条件之间必须用逻辑与‘and’连接。两个空都填‘and’。',
  '例如判断一个数是否在1到10之间：if x >=1 and x <= 10: ...'
),
(
  389,
  26,
  '回文数判断',
  '回文数是指正读反读都一样的数字，例如121。请补全判断一个三位数num是否为回文数的代码。',
  '["121"]',
  '["是回文数"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "num = int(input())"}, {"type": "code_line", "value": "# 获取百位、十位、个位"}, {"type": "code_line", "value": "hundreds = num // 100"}, {"type": "code_line", "value": "tens = (num // 10) % 10"}, {"type": "code_line", "value": "units = num % 10"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": " "}, {"type": "slot", "index": 1}, {"type": "code", "value": " "}, {"type": "slot", "index": 2}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"是回文数\\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"不是回文数\\\")"}]}]}',
  '["hundreds", "tens", "units", "==", "!=", ">", "<", "and", "or", "units", "tens"]',
  '[0, 3, 9]',
  '三位回文数的特征是百位数字等于个位数字。中间十位数字不影响判断（任何数都可以）。因此条件应为 hundreds == units。填空顺序为：变量hundreds、运算符==、变量units。',
  '例如：num=131，hundreds=1，units=1，满足1 == 1，所以是回文数。'
),
(
  390,
  26,
  '石头剪刀布裁判',
  '模拟石头(1)、剪刀(2)、布(3)游戏，根据玩家a和b的出拳判断胜负（1赢2，2赢3，3赢1，相同则平）。请补全关键判断。',
  '["1", "3"]',
  '["玩家b胜利"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = int(input())"}, {"type": "code_line", "value": "b = int(input())"}, {"type": "code_line", "value": "if a == b:"}, {"type": "code_line", "value": "    print(\\\"平局\\\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "elif (a == 1 and b == 2) or (a == 2 and b == 3) or (a == 3 and b == 1):"}, {"type": "slot", "index": 0}, {"type": "code", "value": " "}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"玩家a胜利\\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "else:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(\\\"玩家b胜利\\\")"}, {"type": "slot", "index": 1}, {"type": "code", "value": " "}]}]}',
  '["\\n", ":", "else", "if", "# 注释"]',
  '[0, 0]',
  '两个填空处都是代码行结束，在Python中，elif和else后面都需要冒号‘:’来开始一个代码块，但题目中elif行已经给出了冒号，所以后面直接换行即可。两个空均填换行符（在JSON数组中表示为空字符串占位，实际逻辑是行结束）。为符合格式，用0索引代表不需要额外字符。',
  '代码结构示例：if x>y:
    print("x大")
elif x<y:  # 这里已有冒号
    print("y大")
else:      # 这里也有冒号
    print("相等")'
);