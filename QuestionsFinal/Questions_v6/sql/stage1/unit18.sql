-- Generated SQL for global_unit=18 (stage=1 unit_local=18 unit_id=18)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  256,
  18,
  '切蛋糕啦',
  '阿强有一串糖葫芦名字符串''苹果,草莓,香蕉''，他想用split('','')把它分开。切开后会得到什么？',
  '["[''苹果,草莓,香蕉'']", "[''苹果'', ''草莓'', ''香蕉'']", "[''苹果,草莓'', ''香蕉'']", "(''苹果'', ''草莓'', ''香蕉'')"]',
  2,
  '["split方法是将字符串按指定分隔符切开。", "指定的分隔符是逗号‘,’，字符串中正好有两个逗号。", "按逗号切开后，会得到三个部分，并以列表形式返回。"]',
  'split(‘,’)方法会以逗号为分隔符，将原字符串‘苹果,草莓,香蕉’分割成三个子串‘苹果’、‘草莓’、‘香蕉’，并放入一个列表中返回。',
  '类似地，‘a-b-c’.split(‘-’)会得到[‘a’， ‘b’， ‘c’]。'
),
(
  257,
  18,
  '牵线搭桥',
  '小美的朋友名字在一个列表里：["小明", "小红", "小刚"]，她想用‘和’字把他们连起来，应该用哪个方法？',
  '["\\\"和\\\".split([\\\"小明\\\", \\\"小红\\\", \\\"小刚\\\"])", "\\\"和\\\".join([\\\"小明\\\", \\\"小红\\\", \\\"小刚\\\"])", "[\\\"小明\\\", \\\"小红\\\", \\\"小刚\\\"].join(\\\"和\\\")", "[\\\"小明\\\", \\\"小红\\\", \\\"小刚\\\"].split(\\\"和\\\")"]',
  2,
  '["join方法是用来连接字符串的。", "注意join方法是由‘连接符’调用的。", "join方法的参数是一个可迭代对象（如列表），里面装着要连接的字符串。"]',
  'join是字符串的一个方法，由作为连接符的字符串（这里是‘和’）来调用。它接收一个字符串序列（如列表）作为参数，并返回将这些字符串用连接符连接起来的新字符串。',
  '‘-’.join([‘a’， ‘b’])的结果是字符串‘a-b’。'
),
(
  258,
  18,
  '拆快递的学问',
  '快递单号字符串是‘PY2024-06-15-001’，我们使用split(‘-’)后，得到的列表长度是多少？',
  '["1", "2", "3", "4"]',
  4,
  '["先数一数字符串里有几个分隔符‘-’。", "分隔符的数量和分割后的片段数量有关系。", "有n个分隔符，通常会得到n+1个片段。"]',
  '字符串‘PY2024-06-15-001’中包含三个‘-’分隔符。split(‘-’)会将其分割成4个部分：[‘PY2024’， ‘06’， ‘15’， ‘001’]，因此列表长度为4。',
  '‘a.b.c.d’.split(‘.’)会得到长度为4的列表[‘a’， ‘b’， ‘c’， ‘d’]。'
),
(
  261,
  18,
  '句子的段落',
  '对于句子s = "Hello world from Python"，执行s.split()后，列表的第二个元素（索引为1）是什么？',
  '["\\\"world\\\"", "\\\"Hello\\\"", "\\\"from\\\"", "\\\"Python\\\""]',
  1,
  '["split()不带参数时，默认按空白字符（空格、换行等）分割。", "先把字符串按空格切成几个部分。", "注意列表索引从0开始，第二个元素的索引是1。"]',
  's.split()默认按空白字符分割，得到列表[‘Hello’， ‘world’， ‘from’， ‘Python’]。索引为1（第二个）的元素是‘world’。',
  '对于‘a b c’.split()，得到[‘a’， ‘b’， ‘c’]，索引1的元素是‘b’。'
),
(
  262,
  18,
  '数字联欢会',
  '我们有一个数字列表nums = [1, 2, 3]。执行‘，’.join(nums)会怎么样？',
  '["得到字符串‘1,2,3’", "得到字符串‘123’", "程序报错", "得到列表[‘1’， ‘2’， ‘3’]"]',
  3,
  '["join方法要求序列里的元素是什么类型？", "查看一下nums列表里的元素是整数还是字符串。", "join只能连接字符串序列。"]',
  'join方法要求其参数中的每个元素都必须是字符串类型。而nums列表中的元素是整数（int），因此直接使用‘，’.join(nums)会引发TypeError。需要先将数字转换为字符串。',
  '正确做法：‘，’.join(str(x) for x in [1， 2, 3]) 或 ‘，’.join(map(str， [1， 2, 3]))。'
),
(
  263,
  18,
  '有限分割术',
  '文件路径‘home/user/docs/file.txt’，我们使用split(‘/’， 2)进行分割，结果是什么？',
  '["[''home'', ''user/docs/file.txt'']", "[''home'', ''user'', ''docs/file.txt'']", "[''home'', ''user'', ''docs'', ''file.txt'']", "[''home/user/docs/file.txt'']"]',
  2,
  '["split方法的第二个参数maxsplit指定最大分割次数。", "这里maxsplit=2，意思是最多切2刀。", "从左往右找到前两个分隔符进行分割。"]',
  'split(‘/’， 2)表示以‘/’为分隔符，最多分割2次。字符串从左到右有3个‘/’，只对前两个进行分割。第一次分割得到‘home’和‘user/docs/file.txt’，第二次对后者分割得到‘user’和‘docs/file.txt’。最终结果为[‘home’， ‘user’， ‘docs/file.txt’]。',
  '‘a.b.c.d’.split(‘.’， 1)得到[‘a’， ‘b.c.d’]，只分割一次。'
),
(
  266,
  18,
  '消失的馅饼',
  '对于字符串s = "apple,,pie,,,yum"，执行s.split(‘,’)后，列表里空字符串的数量是多少？',
  '["0", "2", "4", "6"]',
  3,
  '["split方法对连续的分隔符会怎么处理？", "两个逗号之间会产生一个空字符串片段。", "仔细数一数原字符串中逗号之间的“空隙”。"]',
  '字符串为‘apple，，pie，，，yum’。以‘，’分割： ‘apple’后有两个逗号，产生一个空字符串；‘pie’后有三个逗号，产生两个空字符串；末尾没有内容，不产生额外空串。因此列表为[‘apple’， ‘’（第一个空）， ‘pie’， ‘’（第二个空）， ‘’（第三个空）， ‘yum’]，共有4个空字符串（索引1，3，4，注意索引1和3之间还有‘pie’）。',
  '‘a，，b’.split(‘，’)得到[‘a’， ‘’， ‘b’]，有1个空字符串。'
),
(
  267,
  18,
  '生成器牵手',
  '以下哪种写法是正确使用join连接一个生成器表达式产生的字符串？',
  '["‘‘.join(x for x in ‘abc’)", "‘‘.join((x for x in ‘abc’))", "‘‘.join([x for x in ‘abc’])", "以上都可以"]',
  4,
  '["join方法的参数要求是一个可迭代对象。", "生成器表达式本身是可迭代的。", "列表推导式产生的列表也是可迭代的。"]',
  'join方法接受任何可迭代对象作为参数，包括生成器表达式（带括号或不带外层括号）、列表推导式产生的列表等。只要可迭代对象产生字符串元素即可。因此A（生成器表达式）、B（显式生成器）、C（列表）都可以正常工作。',
  '这三种写法连接‘abc’的结果都是字符串‘abc’。'
),
(
  268,
  18,
  '单词反转魔术',
  '如何将句子“I am learning”中的单词顺序反转，变成“learning am I”？',
  '["\\\" \\\".join(\\\"I am learning\\\".split()[::-1])", "\\\"I am learning\\\".split().reverse().join(\\\" \\\")", "\\\" \\\".join(reversed(\\\"I am learning\\\".split()))", "A和C都对"]',
  4,
  '["思路：先分割成单词列表，再反转列表顺序，最后用空格连接。", "注意列表的reverse()方法不返回值（返回None）。", "切片[::-1]和reversed()函数都可以实现反转。"]',
  '选项A：先split()得到列表[‘I’， ‘am’， ‘learning’]，用切片[::-1]反转得到[‘learning’， ‘am’， ‘I’]，再用空格join。选项C：使用reversed()函数得到反转后的迭代器，再用空格join。两者都正确。选项B错误，因为list.reverse()是原地操作，返回None，无法链式调用join。',
  '类似地，‘hello world’反转单词为‘world hello’。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  259,
  18,
  '整理购物单',
  '妈妈的购物单是一个长字符串，请帮小明用代码把它按逗号分开，看看要买哪些东西。',
  NULL,
  '["[''牛奶'', ''面包'', ''鸡蛋'', ''水果'']"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "shopping_str = \\\"牛奶,面包,鸡蛋,水果\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "shopping_list = shopping_str."}, {"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(shopping_list)"}]}]}',
  '["split", "join", "\\\",\\\"", "'',''", "‘,’", "(\\\",\\\")", "(\\\" \\\")", "()"]',
  '[0, 3]',
  '我们需要使用split方法分割字符串，并且指定的分隔符是半角逗号字符‘,’，所以参数是‘,’。注意在代码中需要用引号将字符括起来。',
  '类似地，‘x|y|z’.split(‘|’)会得到列表[‘x’， ‘y’， ‘z’]。'
),
(
  260,
  18,
  '单词小火车',
  '几个单词小伙伴想手拉手连成一列小火车，请用join方法帮它们实现。',
  NULL,
  '["cat-dog-bird"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "words = [\\\"cat\\\", \\\"dog\\\", \\\"bird\\\"]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "result = \\\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\\"."}, {"type": "slot", "index": 1}, {"type": "code", "value": "(words)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(result)"}]}]}',
  '["-", ":", "join", "split", "connect", "link", "+"]',
  '[0, 2]',
  '连接符是短横线‘-’，因此字符串“-”调用join方法，参数是单词列表words。这样就能用‘-’把列表中的所有单词连接起来。',
  '如果用‘*’连接，代码为“*”.join(words)，结果是‘cat*dog*bird’。'
),
(
  264,
  18,
  '邮箱变形记',
  '有一段代码想把邮箱‘user@example.com’中的域名‘example.com’提取出来并加上‘www.’前缀，形成‘www.example.com’。请填空完成。',
  NULL,
  '["www.example.com"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "email = \\\"user@example.com\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "parts = email."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\\\"@\\\")  # 得到 [''user'', ''example.com'']"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "domain = parts["}, {"type": "slot", "index": 1}, {"type": "code", "value": "]  # 取后半部分 ''example.com''"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "new_url = \\\"www.\\\" + "}, {"type": "slot", "index": 2}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(new_url)"}]}]}',
  '["split", "join", "0", "1", "-1", "domain", "parts[0]", "parts"]',
  '[0, 1, 5]',
  '首先用split(‘@’)分割邮箱，得到列表[‘user’， ‘example.com’]。域名是第二部分，索引为1。然后将‘www.’与域名domain连接。',
  '处理‘name@site.org’得到‘www.site.org’也是类似逻辑。'
),
(
  265,
  18,
  '歌词清洁工',
  '一段歌词字符串，单词间有多个空格。需要把它分割开，然后过滤掉空字符串，再用单个空格重新连接成整洁的句子。',
  NULL,
  '["I love Python programming"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lyric = \\\"I   love    Python  programming\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "words = lyric."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()  # 按空白字符分割，得到 [''I'', '''', '''', ''love'', '''', '''', '''', ''Python'', '''', ''programming'']"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 过滤掉空字符串"}, {"type": "code_line", "value": "clean_words = [w for w in words if w]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "result = \\\""}, {"type": "slot", "index": 1}, {"type": "code", "value": "\\\"."}, {"type": "slot", "index": 2}, {"type": "code", "value": "(clean_words)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(result)"}]}]}',
  '["split", "join", "\\\" \\\"", "\\\"\\\"", "\\\",\\\"", "strip", "connect"]',
  '[0, 2, 1]',
  '第一步用split()分割，不传参时连续空白字符会产生空字符串项。第二步过滤后得到真正的单词列表。第三步用空格“ ”作为连接符，调用join方法连接过滤后的列表。',
  '处理‘a  b   c’得到‘a b c’的过程与此相同。'
),
(
  269,
  18,
  '日志解析器',
  '解析一条日志“2024-06-18 10:30:15 INFO User login successfully”，需要提取出日志级别“INFO”和消息“User login successfully”。',
  NULL,
  '["Level: INFO", "Message: User login successfully"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "log = \\\"2024-06-18 10:30:15 INFO User login successfully\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "# 先按空格分割，但消息部分本身有空格，所以先分割成三部分：时间戳、级别、消息"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "parts = log."}, {"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": ")  # 设置最大分割次数为2"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# parts 现在是 [''2024-06-18 10:30:15'', ''INFO'', ''User login successfully'']"}, {"type": "code_line", "value": "level = parts[1]"}, {"type": "code_line", "value": "message = parts[2]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\\"Level: {"}, {"type": "slot", "index": 2}, {"type": "code", "value": "}\\\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\\"Message: {"}, {"type": "slot", "index": 3}, {"type": "code", "value": "}\\\")"}]}]}',
  '["split", "join", "level", "message", "\\\" \\\"", "2", "1", "3", "maxsplit=2", "maxsplit=3"]',
  '[0, 8, 2, 3]',
  '使用split(‘ ’， maxsplit=2)将字符串最多分割两次，这样就能将字符串分成三部分：时间戳（包含内部空格）、级别和完整的消息。然后通过索引1和2分别取出级别和消息进行输出。',
  '处理“ERROR Disk full”可以用split(‘ ’， maxsplit=1)得到[‘ERROR’， ‘Disk full’]。'
),
(
  270,
  18,
  '多分隔符处理',
  '一个字符串中包含多种分隔符（逗号、分号、空格），需要将它们全部统一替换为下划线‘_’。',
  NULL,
  '["apple_banana_cherry_date"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "data = \\\"apple,banana;cherry date\\\""}, {"type": "code_line", "value": "# 思路：用循环依次按不同分隔符分割并连接，但更优雅的方式是："}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "import re  # 导入正则表达式模块，用于更灵活的分割"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 使用正则表达式的split方法，匹配任意一个分隔符 [,; ]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "parts = re."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(r\\\"[,; ]\\\", data)  # 模式匹配逗号、分号或空格"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "# 过滤掉因连续分隔符可能产生的空字符串"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "clean_parts = [p for p in parts if p]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "result = \\\"_\\\"."}, {"type": "slot", "index": 1}, {"type": "code", "value": "(clean_parts)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(result)"}]}]}',
  '["split", "join", "sub", "findall", "compile", "search"]',
  '[0, 1]',
  '这里使用了正则表达式模块re的split方法，可以按照一个复杂的模式（这里是匹配逗号、分号或空格）进行分割。分割后过滤掉空字符串，最后用下划线‘_’调用join方法连接列表。',
  're.split(r‘[，.]’， ‘a，b.c’)会按逗号或点分割，得到[‘a’， ‘b’， ‘c’]。'
);