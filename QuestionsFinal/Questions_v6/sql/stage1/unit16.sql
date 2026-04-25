-- Generated SQL for global_unit=16 (stage=1 unit_local=16 unit_id=16)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  226,
  16,
  '量量狗名有多长',
  '阿珍的宠物狗叫‘Coffee’，她想用Python量一下这个名字有几个字母，应该用哪个代码片段？',
  '["len(dog_name)", "dog_name.len()", "length(dog_name)", "dog_name.length"]',
  1,
  '["想想看，Python里获取长度用的是哪个内置函数？", "它是一个函数，不是字符串的方法。", "正确答案是调用len(字符串)。"]',
  '在Python中，len()是内置函数，用于返回一个对象的长度或元素个数。对于字符串，它返回字符的数量。选项B和D的写法在其他语言中可能常见，但在Python中不正确。选项C中的length函数在Python中不存在。',
  'name = "Python"; print(len(name)) 将输出 6。'
),
(
  227,
  16,
  '让网名低调点',
  '小帅的网名是‘PYTHON_MASTER’，他想把它全部变成小写字母显得低调一些，应该怎么写？',
  '["name.upper()", "name.lower()", "lower(name)", "name.small()"]',
  2,
  '["仔细看，这是要将大写字母转换为小写。", "这是一个字符串本身具有的方法。", "它的名字很直白，‘lower’就是‘降低’的意思。"]',
  'lower()是字符串对象的一个方法，调用它会返回一个新字符串，其中所有大写字符都转换为小写。选项A是变大写，选项C是函数错误写法，选项D的方法不存在。字符串是不可变对象，原字符串不会改变。',
  'word = "HELLO"; print(word.lower()) 会输出 ‘hello’。'
),
(
  228,
  16,
  '标题要大写！',
  '为了一篇文章，你需要把标题‘introduction to python’全部变成大写字母。哪个选项能做到？',
  '["title.upper()", "upper(title)", "title.big()", "title.capitalize()"]',
  1,
  '["想想‘大写’的英文单词是什么？", "它也是一个字符串方法，和lower对应。", "capitalize方法只让首字母大写哦。"]',
  'upper()是字符串对象的一个方法，调用它会返回一个新字符串，其中所有小写字符都转换为大写。选项B是函数错误写法，选项C的方法不存在，选项D的capitalize()方法只会让整个字符串的首字母大写。',
  'text = "hello world"; print(text.upper()) 会输出 ‘HELLO WORLD’。'
),
(
  231,
  16,
  '密码长度检查员',
  '为了安全，系统要求密码长度至少8位。如何用Python检查变量password是否满足要求？',
  '["if len(password) > 8:", "if password.len >= 8:", "if len(password) >= 8:", "if length(password) > 8:"]',
  3,
  '["至少8位，意味着长度等于8或大于8。", "注意比较运算符的选择。", "获取长度要用内置函数len。"]',
  '‘至少8位’在编程中应表示为‘大于或等于8’，即使用‘>=’运算符。使用len(password)获取密码字符串的长度。选项A漏掉了等于8的情况，选项B和D的语法错误。',
  '检查用户名是否为空：if len(username) == 0: print("用户名不能为空")。'
),
(
  232,
  16,
  '忽略大小写的比较',
  '在登录时，系统希望用户名‘Admin’和用户输入的‘admin’被视为相同。如何实现这种不区分大小写的比较？',
  '["if input_name == ''Admin'':", "if input_name.lower() == ''admin'':", "if input_name.upper() == ''Admin'':", "if lower(input_name) == ''admin'':"]',
  2,
  '["目标是将两者都转换成同一种大小写格式再比较。", "可以将用户输入和标准用户名都转为小写。", "注意调用方法的正确语法。"]',
  '最可靠的方法是将双方都转换为小写（或大写）后再进行比较。选项B将用户输入转换为小写，再与同样是小写的标准用户名‘admin’比较。选项A直接比较会因大小写不同而失败，选项C的逻辑不匹配，选项D语法错误。',
  '验证码检查：if user_input.lower() == captcha.lower(): print("正确")。'
),
(
  233,
  16,
  '统一格式输出',
  '你需要将不同来源的标题（可能大小写不一）统一成大写格式后显示。应该用下面哪段代码？',
  '["print(title.upper())", "print(upper(title))", "print(title.capitalize())", "print(len(title))"]',
  1,
  '["目标是‘统一成大写格式’。", "字符串的哪个方法可以直接做到这一点？", "capitalize方法不符合要求。"]',
  'upper()方法能将字符串中的所有字母转换为大写，无论原字符串的大小写状态如何，从而实现统一大写格式的输出。选项B语法错误，选项C只会让首字母大写，选项D输出的是长度而非修改后的字符串。',
  'tags = "python, code, learning"; print(tags.upper()) 输出 ‘PYTHON, CODE, LEARNING’。'
),
(
  236,
  16,
  'len的返回值',
  '阿强写了代码：length = len("Python")。请问变量length中存储的数据类型是什么？',
  '["字符串（str）", "整数（int）", "浮点数（float）", "布尔值（bool）"]',
  2,
  '["想想‘长度’这个概念，通常用什么数字表示？", "len函数计算的是字符的‘个数’。", "个数、数量，通常是整数。"]',
  'len()函数返回的是一个表示对象长度（元素个数）的整数值。对于字符串“Python”，其长度为6，所以变量length中存储的是整数6。',
  '对于列表[10, 20, 30]，len()返回整数3。'
),
(
  237,
  16,
  '不变的原字符串',
  '执行以下代码后，原始字符串变量txt的内容会变成‘HELLO’吗？ txt = "hello"; txt.upper()',
  '["会，因为调用了upper方法。", "会，但需要先赋值，如 txt = txt.upper()。", "不会，因为upper()方法有错误。", "不会，字符串不可变，upper()返回新字符串。"]',
  4,
  '["回想一下，字符串在Python中是不可变对象。", "调用upper()方法时，原字符串本身改变了吗？", "方法的返回值去了哪里？"]',
  '字符串在Python中是不可变数据类型。调用upper()、lower()等方法时，并不会修改原字符串，而是生成并返回一个新的字符串。原字符串txt仍然是“hello”。',
  's = "Hi"; s.upper(); print(s)  # 输出仍然是 ‘Hi’，而非 ‘HI’。'
),
(
  238,
  16,
  '错误调用大赏',
  '下面哪个选项的代码会导致错误（无法正常运行）？',
  '["msg = \\\"HELLO\\\"; print(msg.lower())", "msg = \\\"hello\\\"; print(msg.upper())", "msg = \\\"hello\\\"; print(len.msg())", "msg = \\\"hello\\\"; print(len(msg))"]',
  3,
  '["仔细检查每个选项的方法调用语法。", "len是一个函数，调用方式是len(对象)。", "选项C把len当成了什么来用？"]',
  '选项C中，`len.msg()`试图将msg作为len函数的属性或方法来调用，这是完全错误的语法。len()是一个内置函数，正确的调用方式是将对象作为参数放在括号内，如len(msg)。其他选项语法正确。',
  '错误示例：num = 123; print(num.len())  # 整数没有len()方法。正确：print(len(str(num)))。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  229,
  16,
  '计算单词长度',
  '帮小美完成这段代码，让它计算并打印出单词‘Wonderful’的长度。',
  NULL,
  '["9"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "word = \\\"Wonderful\\\"\\nprint("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
  '["len(word)", "word.len()", "length(word)", "len(\\\"Wonderful\\\")", "word.length", "count(word)"]',
  '[0]',
  '这里需要计算字符串变量word的长度，正确的做法是使用内置函数len()，并将变量名word作为参数传递给它。其他选项要么语法错误，要么不是Python中获取长度的方法。',
  '计算列表长度：my_list = [1, 2, 3]; print(len(my_list)) 输出 3。'
),
(
  230,
  16,
  '大小写变换游戏',
  '一段神秘代码需要先将字符串变小写，然后再变大写。请选择正确的代码片段填空，完成这个‘变形’过程。',
  NULL,
  '["HELLO"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "text = \\\"HeLlO\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "result = text."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()."}, {"type": "slot", "index": 1}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(result)"}]}]}',
  '[".upper()", ".lower()", ".len()", ".capitalize()", ".swapcase()"]',
  '[1, 0]',
  '代码要求先变小写再变大写。因此，第一步应调用lower()方法将"HeLlO"变为"hello"，第二步再对‘hello’调用upper()方法，得到全大写的"HELLO"。其他方法不符合要求。',
  'text = "PyThOn"; print(text.lower().upper()) 同样会输出 ‘PYTHON’。'
),
(
  234,
  16,
  '用户输入处理',
  '这是一个简单的用户输入处理器：它接收输入，先打印出小写版本，再告诉用户输入的长度。请补全代码。',
  '["OpenAI"]',
  '["openai", "6"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "user_input = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(user_input."}, {"type": "slot", "index": 0}, {"type": "code", "value": "())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 1}, {"type": "code", "value": "(user_input))"}]}]}',
  '[".lower()", "len", ".upper()", "length", ".count()", "str"]',
  '[0, 1]',
  '第一空需要将输入转换为小写，所以应填入.lower()。第二空需要打印输入的长度，应调用内置函数len，所以填入len。其他选项不符合当前代码逻辑的需求。',
  '处理邮件地址：email = input(); print(email.lower()); print(len(email))。'
),
(
  235,
  16,
  '链式调用挑战',
  '看这段神奇的链式操作！它想把一个混杂大小写的字符串先全变‘低调’（小写），再瞬间‘高调’（大写）。请选择方法完成它。',
  NULL,
  '["HELLO WORLD"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = \\\"HeLlO WoRlD\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "final = s."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()."}, {"type": "slot", "index": 1}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(final)"}]}]}',
  '[".upper()", ".lower()", ".swapcase()", ".title()", ".len()"]',
  '[1, 0]',
  '代码的意图是先小写再大写。因此，第一个空应调用.lower()方法得到‘hello world’，第二个空紧接着对其结果调用.upper()方法，最终得到‘HELLO WORLD’。swapcase是大小写互换，不符合题意。',
  'name = "McDonald"; print(name.lower().upper()) 输出 ‘MCDONALD’。'
),
(
  239,
  16,
  '综合字符串报告',
  '完善这个程序，它接受一个单词，然后报告其原始形式、长度、小写和大写版本。',
  '["PyThOn"]',
  '["原始: PyThOn", "长度: 6", "小写: python", "大写: PYTHON"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "word = input()"}, {"type": "code_line", "value": "print(f\\\"原始: {word}\\\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\\"长度: {"}, {"type": "slot", "index": 0}, {"type": "code", "value": "(word)}\\\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\\"小写: {word."}, {"type": "slot", "index": 1}, {"type": "code", "value": "()}\\\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\\"大写: {word."}, {"type": "slot", "index": 2}, {"type": "code", "value": "()}\\\")"}]}]}',
  '["len", ".lower()", ".upper()", ".capitalize()", "length", ".len()"]',
  '[0, 1, 2]',
  '第二行需要打印长度，应填入内置函数`len`。第三行需要打印小写版本，应填入字符串方法`.lower()`。第四行需要打印大写版本，应填入字符串方法`.upper()`。这样就能完整生成所需报告。',
  '对于输入"Hello"，程序会输出：原始: Hello 长度: 5 小写: hello 大写: HELLO。'
),
(
  240,
  16,
  '统计大写字母',
  '这段代码想统计一个字符串中有多少个大写字母。其思路是：先将原字符串转为大写，再和原字符串逐位比较。请补全关键步骤。',
  '["PyThOnRocks"]',
  '["3"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}, {"type": "code_line", "value": "count = 0"}, {"type": "code_line", "value": "for i in range(len(s)):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    if s[i] == s[i]."}, {"type": "slot", "index": 0}, {"type": "code", "value": "():"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "        count += "}, {"type": "slot", "index": 1}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(count)"}]}]}',
  '[".upper()", "1", ".lower()", "0", "i", "s"]',
  '[0, 1]',
  '代码逻辑是：如果原字符`s[i]`等于它自己的大写形式`s[i].upper()`，说明它原本就是大写字母。因此第一空填`.upper()`。当条件成立时，计数器`count`需要增加1，所以第二空填`1`。',
  '检查‘A’：’A‘ == ’A‘.upper() 为真，说明是大写字母。检查‘a’：’a‘ == ’a‘.upper() 为假（因为’a‘.upper()是’A‘）。'
);