-- Generated SQL for global_unit=22 (stage=1 unit_local=22 unit_id=22)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  316,
  22,
  'input 的真相',
  '小明的咖啡店程序写了个input("请输入数量：")接收订单，顾客输入了‘3’。这个‘3’在程序里是什么类型？',
  '["整数 (int)", "浮点数 (float)", "字符串 (str)", "列表 (list)"]',
  3,
  '["回忆一下，input()这个函数是做什么的？", "input()从键盘获取的所有内容，都会先被它转换成同一种东西。", "无论你在键盘上敲的是数字还是文字，input()都会把它当作文本来处理。"]',
  '在Python中，input()函数永远且只会返回字符串（str）类型的数据。即使输入的是数字，如“3”，它也是包含数字字符的字符串“3”，而不是整数3。',
  '类似地，input("年龄：")得到输入"18"，类型是str，而不是int。'
),
(
  317,
  22,
  '糖果大丰收',
  '阿强想用代码算算自己的糖果总数。他写了：a = input(''我有几颗糖：''); b = ''10''; total = a + b。当输入‘5’时，total会是什么？',
  '["15", "\\\"510\\\"", "程序报错", "\\\"5\\\" + \\\"10\\\""]',
  2,
  '["先确认a和b的数据类型分别是什么？", "input()得到的是字符串，‘10’带引号，它是什么类型？", "两个字符串用加号+连接，会发生什么？"]',
  '变量a通过input()得到字符串‘5’，变量b是字符串‘10’。字符串相加是拼接操作，结果是字符串‘510’。要进行数学计算，必须先用int()或float()转换为数字类型。',
  '正确做法：total = int(a) + int(b)，这样结果为整数15。'
),
(
  318,
  22,
  '披萨均分委员会',
  '为了公平分披萨，你需要将输入的人数转换成数字。如果输入‘3.5’（代表3个半人），应该使用哪个转换函数？',
  '["int(''3.5'')", "float(''3.5'')", "str(''3.5'')", "input(''3.5'')"]',
  2,
  '["‘3.5’是一个带小数点的数字字符串。", "int()能处理带小数的字符串吗？试试看。", "需要一个能表示小数的数字类型，它是什么？"]',
  '输入‘3.5’是包含小数点的字符串。int()函数只能将纯整数字符串（如‘3’）或浮点数转换为整数（会截断小数），直接转换‘3.5’会引发ValueError。正确方法是使用float(''3.5'')将其转换为浮点数3.5。',
  '类似地，输入‘12.8’，应用float()转换得到12.8。'
),
(
  321,
  22,
  '正负裁判官',
  '下面哪段代码能正确读取一个数字，并判断它是正数、负数还是零？',
  '["num = input(); if num > 0: print(''正'')", "num = int(input()); if num > 0: print(''正'') elif num < 0: print(''负'') else: print(''零'')", "num = input(); if num == ''positive'': print(''正'')", "num = input(''正负零''); print(num)"]',
  2,
  '["输入的‘数字’首先要能被计算机当作数字来比较大小。", "input()得到的是字符串，不能直接与数字0比较。", "需要完整的if-elif-else结构来覆盖三种情况。"]',
  '正确流程是：先用int()或float()转换输入，得到一个数字类型变量。然后使用if-elif-else分支结构，分别判断该数大于0、小于0和等于0的情况并输出对应结果。选项A未转换类型，选项C逻辑错误，选项D没有判断。',
  '输入‘-5’，转换后num=-5，判断为负数，输出‘负’。'
),
(
  322,
  22,
  '名字的陷阱',
  '复习时间到！阿珍写代码问用户名字：name = input(''你叫啥？'')。然后她调皮地写了age = int(name)。如果用户输入‘小明’，会发生什么？',
  '["age变成0", "age变成‘小明’", "程序崩溃，报ValueError", "age变成None"]',
  3,
  '["int()函数希望把什么东西转换成整数？", "字符串‘小明’看起来像数字吗？", "int()无法将非数字组成的字符串转为整数。"]',
  'int()函数只能将纯整数字符串（如‘123’）或浮点数转换为整数。当传入一个无法解释为整数的字符串（如‘小明’）时，Python会抛出ValueError异常，导致程序崩溃。这是类型转换中常见的错误。',
  '类似错误：int(''12.3'') 也会引发ValueError，应先使用float(''12.3'')。'
),
(
  323,
  22,
  '无穷大的输入',
  '下列哪个输入，经过float()转换后，会得到一个表示无穷大（inf）的浮点数？',
  '["\\\"100e100\\\"", "\\\"inf\\\"", "\\\"NaN\\\"", "\\\"999999\\\""]',
  2,
  '["回忆一下，float()函数能识别一些特殊的字符串。", "inf是“无穷大”的英文缩写。", "试试在Python里输入float(''inf'')看看结果。"]',
  'float()函数可以解析表示无穷大的字符串‘inf’或‘Infinity’（不区分大小写），将其转换为浮点数inf。‘100e100’是一个很大的数但有限；‘NaN’转换为表示“非数字”的nan；‘999999’转换为普通浮点数。',
  'float(''inf'') + 100 的结果仍然是 inf，因为任何有限数加无穷大还是无穷大。'
),
(
  326,
  22,
  '防御性转换',
  '为了防止用户输入非数字导致程序崩溃，以下哪种是处理input类型转换的常见做法？',
  '["直接转换，相信用户总会输入数字。", "使用try-except块，在转换失败时提示用户重新输入。", "只使用str()函数，不进行数字转换。", "用if input().isdigit()来判断，这能完美判断所有数字。"]',
  2,
  '[]',
  '使用try-except进行异常处理是健壮的程序中处理潜在转换错误（如ValueError）的标准做法。它允许程序在转换失败时捕获异常并采取补救措施（如提示用户），而不是直接崩溃。',
  'try: num = int(input()); except ValueError: print(''输入的不是整数！'')'
),
(
  327,
  22,
  '四舍五入的考验',
  '小美输入了她的身高‘1.625’米，她想用int()转换得到以米为单位的整数部分。但在这之前，她希望先对原数进行四舍五入到两位小数。正确的做法是？',
  '["height = int(1.625)", "height = int(round(float(''1.625''), 2))", "height = round(int(''1.625''), 2)", "height = float(round(''1.625'', 2))"]',
  2,
  '["操作的顺序很重要：先转换类型，再计算，再转换类型。", "四舍五入函数round()操作的对象是什么类型？", "int()函数操作的对象是什么类型？"]',
  '正确流程是：先将字符串‘1.625’用float()转为浮点数1.625；然后用round(1.625, 2)进行四舍五入得到1.63；最后用int()取整得到1。选项A未处理字符串，选项C顺序错误，选项D对字符串使用round。',
  '输入‘2.718’，float(''2.718'')=2.718, round(2.718,2)=2.72, int(2.72)=2。'
),
(
  328,
  22,
  '平均分计算官',
  '下面哪段代码能正确读取三门课的成绩（整数），并计算平均分（保留一位小数）？',
  '["s1=input(); s2=input(); s3=input(); avg=(s1+s2+s3)/3; print(f''{avg:.1f}'')", "s1=int(input()); s2=int(input()); s3=int(input()); avg=(s1+s2+s3)/3; print(round(avg,1))", "scores = [input(), input(), input()]; avg = sum(scores)/len(scores); print(f''{avg:.1f}'')", "s1=int(input()); s2=int(input()); s3=int(input()); avg=(s1+s2+s3)//3; print(avg)"]',
  2,
  '["计算平均分需要先把输入转成数字吗？", "注意，平均分可能是小数，使用什么除法？", "如何格式化输出，确保保留一位小数？"]',
  '选项B正确：使用int()转换每个输入；使用/进行浮点数除法得到精确平均值；虽然用round(avg,1)可以四舍五入到一位小数，但更常见的做法是使用格式化字符串如f''{avg:.1f}''，不过round()在此上下文中也是可接受的显示方式。选项A未转换类型，选项C的列表内元素仍是字符串，选项D使用了整数除法//。',
  '输入90, 85, 95，计算(90+85+95)/3=90.0，输出90.0。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  319,
  22,
  '华氏度转换器',
  '帮温度转换器补全代码，它能把输入的摄氏度转为华氏度。公式：华氏度 = 摄氏度 * 9 / 5 + 32。',
  '["20"]',
  '["20.0 摄氏度 = 68.0 华氏度"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "# 温度转换小助手"}, {"type": "code_line", "value": "c_str = input(\\\"请输入摄氏度：\\\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "c = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(c_str)  # 将输入的字符串转换为数字"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "f = c "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 9 "}, {"type": "slot", "index": 2}, {"type": "code", "value": " 5 + 32"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(f\\\"{c} 摄氏度 = {f} 华氏度\\\")"}]}]}',
  '["int", "float", "str", "*", "/", "+", "-", "input"]',
  '[1, 3, 4]',
  '第一个空：输入可能包含小数，应使用float()转换为浮点数。第二和第三个空：根据公式，需要乘法(*)和除法(/)运算符。注意Python中除法应使用/而不是//，以确保结果为浮点数。',
  '若输入‘0’，则c=0.0，计算f=0.0*9/5+32=32.0。'
),
(
  320,
  22,
  '购物车小计',
  '补全代码，计算购买苹果的总价。已知苹果单价是5元。',
  '["3"]',
  '["您购买了 3 斤苹果，总价 15 元。"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "price_per_jin = 5"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "weight_str = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\\\"请输入苹果斤数：\\\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "weight = "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(weight_str)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "total = price_per_jin "}, {"type": "slot", "index": 2}, {"type": "code", "value": " weight"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(f\\\"您购买了 {weight} 斤苹果，总价 {total} 元。\\\")"}]}]}',
  '["input", "print", "int", "float", "*", "+", "-", "/"]',
  '[0, 2, 4]',
  '第一个空：需要input()函数来获取用户输入的斤数。第二个空：斤数应为整数，使用int()转换。第三个空：总价 = 单价 * 重量，因此使用乘法运算符*。',
  '若输入‘2’，weight=2，total=5*2=10，输出总价10元。'
),
(
  324,
  22,
  '猜数字游戏核心',
  '补全这个猜数字游戏的代码片段。程序预设一个秘密数字，然后让用户猜，直到猜中为止。',
  '["10", "5", "15", "10"]',
  '["猜小了！", "猜小了！", "猜大了！", "恭喜你，猜对了！"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "secret = 10"}, {"type": "code_line", "value": "guess = None"}, {"type": "code_line", "value": "while guess != secret:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    guess = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(input(\\\"猜一个数字：\\\"))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    if guess "}, {"type": "slot", "index": 1}, {"type": "code", "value": " secret:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        print(\\\"猜小了！\\\")"}, {"type": "code_line", "value": "    elif guess > secret:"}, {"type": "code_line", "value": "        print(\\\"猜大了！\\\")"}, {"type": "code_line", "value": "print(\\\"恭喜你，猜对了！\\\")"}]}]}',
  '["int", "float", "str", "<", ">", "==", "!=", "input"]',
  '[0, 3]',
  '第一个空：需要将输入的字符串转换为整数（因为secret是整数10），以便与secret比较，因此填int。第二个空：根据while循环的条件和后续的elif guess > secret，这里应该判断是否“小于”，因此填<。',
  '如果输入‘8’，guess=8，判断8<10为True，输出“猜小了！”，循环继续。'
),
(
  325,
  22,
  '混合计算器',
  '补全代码，使其能处理两种输入：先输入一个整数a，再输入一个浮点数b，最后计算它们的和与积。',
  '["5", "2.5"]',
  '["和是 7.5", "积是 12.5"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "a = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(input(\\\"输入整数a：\\\"))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "b = "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(input(\\\"输入浮点数b：\\\"))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "sum_ab = a + b"}, {"type": "code_line", "value": "product_ab = a * b"}, {"type": "code_line", "value": "print(f\\\"和是 {sum_ab}\\\")"}, {"type": "code_line", "value": "print(f\\\"积是 {product_ab}\\\")"}]}]}',
  '["int", "float", "str", "convert", "type", "input"]',
  '[0, 1]',
  '第一个空：根据题目要求，a应为整数，所以使用int()转换输入。第二个空：b应为浮点数，所以使用float()转换输入。Python中整数与浮点数运算会自动将结果提升为浮点数。',
  '输入a=‘3’，b=‘4.1’，得到a=3，b=4.1，和为7.1，积为12.3。'
),
(
  329,
  22,
  '找最大值',
  '补全代码，连续输入5个数字，找出并打印其中的最大值。',
  '["3", "9", "1", "7", "4"]',
  '["最大值是：9"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "max_num = None  # 初始化最大值"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for i in range(5):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    num = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(input(f\\\"请输入第{i+1}个数：\\\"))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if max_num is None or num > max_num:"}, {"type": "code_line", "value": "        max_num = num"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(f\\\"最大值是：{max_num}\\\")"}]}]}',
  '["int", "float", "str", "convert", "max", "min"]',
  '[0]',
  '此处需要将每次输入的字符串转换为数字，以便进行大小比较。由于输入示例都是整数，且未指定必须有小数，使用int()是合适且常见的选择。这样max_num最终会是一个整数。',
  '若输入序列为[‘10’, ‘20’, ‘5’]，经过int转换后，max_num最终为20。'
),
(
  330,
  22,
  '单位换算机',
  '补全这个单位换算程序。它询问用户想要转换的类型（1:英寸转厘米，2:磅转千克），然后根据选择进行换算。',
  '["1", "10"]',
  '["10.0 英寸 = 25.4 厘米"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "choice = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(input(\\\"请选择 (1:英寸->厘米, 2:磅->千克)：\\\"))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "value = "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(input(\\\"请输入数值：\\\"))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if choice == 1:"}, {"type": "code_line", "value": "    result = value * 2.54"}, {"type": "code_line", "value": "    print(f\\\"{value} 英寸 = {result} 厘米\\\")"}, {"type": "code_line", "value": "elif choice == 2:"}, {"type": "code_line", "value": "    result = value * 0.453592"}, {"type": "code_line", "value": "    print(f\\\"{value} 磅 = {result} 千克\\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\\"选择无效\\\")"}]}]}',
  '["int", "float", "str", "input", "print", "choice"]',
  '[0, 1]',
  '第一个空：choice用于与整数1和2进行比较，因此应使用int()转换。第二个空：value需要进行乘法运算，且转换系数为浮点数，因此使用float()转换以确保计算精度，即使输入是整数也能得到正确结果。',
  '若输入choice=‘2’，value=‘150’，则choice=2，value=150.0，计算结果为68.0388千克。'
);