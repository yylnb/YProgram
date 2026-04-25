-- Generated SQL for global_unit=18 (stage=1 unit_local=18 unit_id=18)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  256,
  18,
  'split：分蛋糕喽',
  '珍妮有一个字符串 ‘apple,banana,orange’。她想用逗号把它们分开，变成独立的水果名字。她该使用哪个字符串方法呢？',
  '["split()", "split('','')", "join('','')", "cut('','')"]',
  2,
  '["珍妮的目标是‘分开’，而不是‘连接’。", "这个方法通常需要指明按什么符号来切分。", "括号里放上分隔符，一个英文逗号。"]',
  'split()方法用于分割字符串。默认按空白字符分割，但本题明确要求按逗号分割，所以需要在括号内指定分隔符，即 `split('','')`。',
  '如 `"a.b.c".split(''.'')` 会得到列表 `[''a'', ''b'', ''c'']`。'
),
(
  257,
  18,
  'join：糖葫芦串串',
  '小李有一个水果列表 [''西瓜'', ''葡萄'', ''草莓'']，他想用‘和’字把它们连成一句‘西瓜和葡萄和草莓’。应该使用哪个方法？',
  '["list.join(‘和’)", "‘和’.join(list)", "join(list, ‘和’)", "concat(list, ‘和’)"]',
  2,
  '["join方法不是列表的方法哦。", "想想看，是谁去连接谁？是‘胶水’去粘‘碎片’。", "正确语法是 `‘连接符’.join(列表)`。"]',
  'join是字符串的方法，语法为 `‘连接符’.join(可迭代对象)`。它会用指定的字符串连接起可迭代对象（如列表）中的每个元素。',
  '`''-''.join([''a'', ''b''])` 的结果是字符串 `‘a-b’`。'
),
(
  258,
  18,
  'split的默认口味',
  '如果不给split方法任何参数，比如 `"Python is fun!".split()`，它会按什么来分割字符串呢？',
  '["按字母分割", "按逗号分割", "按所有空白字符（空格、换行等）分割", "不分割，返回原字符串"]',
  3,
  '[]',
  'split()方法在不传入参数时，默认使用任何空白字符（包括空格、换行符`\n`、制表符`\t`等）作为分隔符，并将连续的空格视为一个分隔符。',
  '`"Hello   World".split()` 会返回 `[''Hello'', ''World'']`，中间多个空格被视为一个分隔符。'
),
(
  261,
  18,
  'split的限量版',
  '字符串`s = "one:two:three:four"`。执行 `result = s.split('':'', 2)` 后，`result` 的值是什么？',
  '["[''one'', ''two'', ''three:four'']", "[''one'', ''two'', ''three'', ''four'']", "[''one'', ''two:three:four'']", "[''one:two'', ''three:four'']"]',
  1,
  '["split的第二个参数`maxsplit`限制了分割的次数。", "`maxsplit=2`表示最多切2刀，会把字符串分成几段？", "从左边开始，找到前两个冒号进行分割。"]',
  '`split('':'', 2)`表示按冒号分割，最多分割2次。从左到右找到两个冒号进行分割，剩余部分作为最后一个元素。所以结果是`[''one'', ''two'', ''three:four'']`。',
  '`"a.b.c.d".split(''.'', 1)`得到`[''a'', ''b.c.d'']`，只分割了一次。'
),
(
  262,
  18,
  'join能连接什么？',
  '下面哪段代码能够成功运行并产生一个由连字符连接的字符串？',
  '["‘-’.join([1, 2, 3])", "‘-’.join([''1'', ''2'', ''3''])", "‘-’.join(123)", "join(‘-’, [‘a’, ‘b’])"]',
  2,
  '["join方法要求连接的每个元素必须是字符串类型。", "选项A的列表里是整数，不是字符串。", "回顾一下join方法的正确调用者是谁。"]',
  'join方法要求可迭代对象中的元素必须都是字符串。选项B的列表元素是字符串‘1’,‘2’,‘3’，因此可以正确连接成‘1-2-3’。选项A是整数，选项C是整数而非可迭代对象，选项D语法错误。',
  '若想连接数字，需先转为字符串：`‘-’.join(str(x) for x in [1,2,3])`。'
),
(
  263,
  18,
  'split的空格魔术',
  '对于字符串 `text = "Hello\n\t World  Python"`，执行 `text.split()` 的结果是什么？',
  '["[''Hello'', ''World'', ''Python'']", "[''Hello'', ''\\\\\\n'', ''\\\\\\t'', ''World'', ''Python'']", "[''Hello\\\\\\n\\\\\\t'', ''World'', ''Python'']", "[''Hello'', ''\\\\\\n\\\\\\t World  Python'']"]',
  1,
  '[]',
  '当split()不传参数时，默认以任何空白字符（空格、换行符`\n`、制表符`\t`等）分割，并将连续的多个空白字符视为一个分隔符。因此它会干净地分割出三个单词。',
  '`"a  b\tc".split()` 也会返回 `[''a'', ''b'', ''c'']`，忽略空格和制表符的差异与连续出现。'
),
(
  266,
  18,
  '链式操作陷阱',
  '对于字符串`s = " a b c "`（前后有空格），执行`s.strip().split()`的结果是什么？',
  '["['' a b c '']", "[''a'', ''b'', ''c'']", "[''a b c'']", "报错"]',
  2,
  '["先执行`s.strip()`，看看它去掉了什么。", "去掉首尾空格后，字符串变成了什么样子？", "再对这个处理后的字符串执行默认的split()。"]',
  '`s.strip()`首先去除字符串首尾的空格，得到`“a b c”`。然后对这个新字符串执行`split()`，默认按空白字符分割，得到列表`[''a'', ''b'', ''c'']`。',
  '链式调用是处理字符串的常见技巧，如`‘, ’.join(text.split())`可先将连续空格分割的单词用逗号空格重新连接。'
),
(
  267,
  18,
  'join的起始站',
  '对于列表`lst = [''X'', ''Y'', ''Z'']`，执行`result = ‘->’.join(lst)`后，`result`字符串的开头和结尾分别是什么？',
  '["开头是‘->’，结尾是‘->’", "开头是‘X’，结尾是‘Z’", "开头是‘X->’，结尾是‘->Z’", "开头是空，结尾是空"]',
  2,
  '["想象一下，连接符‘->’是放在列表的每个元素‘之间’的。", "第一个元素‘X’前面有连接符吗？最后一个元素‘Z’后面有吗？", "画出连接过程：X -> Y -> Z。"]',
  'join方法只在列表的各个元素‘之间’插入连接符，不会在第一个元素前或最后一个元素后添加。所以结果字符串是‘X->Y->Z’，开头是‘X’，结尾是‘Z’。',
  '`‘.''.join([''www'', ''example'', ''com''])`得到`‘www.example.com’`，前后没有多余的点。'
),
(
  268,
  18,
  'split空字符串会怎样？',
  '对一个空字符串`""`执行`split()`方法，会得到什么结果？',
  '["[] (空列表)", "[''''] (包含一个空字符串的列表)", "报错", "None"]',
  1,
  '["空字符串里没有任何字符，包括空白字符。", "split默认按空白分割，能找到空白字符吗？", "如果没有可分割的内容，结果是空列表还是保留原样？"]',
  '对空字符串使用`split()`，由于字符串中没有内容可供分割（即便是默认的空白字符也没有），所以返回一个空列表`[]`。这与`split('','')`的行为不同。',
  '`"".split('','')`返回的是`['''']`，因为按指定分隔符分割空字符串会得到一个空元素。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  259,
  18,
  '点餐订单解析',
  '餐厅点餐系统收到一个订单字符串。请补全代码，将其中的菜品名称提取到一个列表中。',
  NULL,
  '["[''宫保鸡丁'', ''麻婆豆腐'', ''鱼香肉丝'']"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "order = \\\"宫保鸡丁-麻婆豆腐-鱼香肉丝\\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 请补全下面的代码"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "dishes = order."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(dishes)"}]}]}',
  '["split", "join", "cut", "separate", "(''-'')", "('' - '')", "(''-'', 1)", "(''_'')"]',
  '[1, 5]',
  '这里需要按订单字符串中的短横线‘-’来分割字符串。因此，应调用split方法并传入分隔符参数，即 `split(''-'')`。',
  '类似地，按冒号分割：`time="12:30".split('':'')` 得到 `[''12'', ''30'']`。'
),
(
  260,
  18,
  '制作购物清单',
  '将购物车里的物品列表，用逗号和空格连接成一句易于阅读的话。请补全代码。',
  NULL,
  '["我需要购买: 牛奶, 鸡蛋, 面包"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "cart = [''牛奶'', ''鸡蛋'', ''面包'']"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 请补全下面的代码"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "sentence = \\\"我需要购买: \\\" + "}, {"type": "slot", "index": 0}, {"type": "code", "value": "."}, {"type": "slot", "index": 1}, {"type": "code", "value": "(cart)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(sentence)"}]}]}',
  '["\\\"， \\\"", "'',''", "'', ''", "\\\". \\\"", "join", "split", "connect", "merge"]',
  '[3, 5]',
  '需要将列表用逗号和空格‘, ’连接起来。join是字符串的方法，所以前面的连接符是字符串 `'', ''`，然后调用 `join(cart)`。',
  '类似连接：`'' & ''.join([''A'', ''B''])` 结果是 `‘A & B’`。'
),
(
  264,
  18,
  '歌词分析与重组',
  '有一段歌词，我们需要先按行分割，再将每行歌词的单词用星号连接起来。请补全代码。',
  NULL,
  '["Hello*World", "Python*Is*Fun"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lyrics = \\\"Hello World\\\\\\nPython Is Fun\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lines = lyrics."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(''\\\\\\n'')"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "new_lines = []"}, {"type": "code_line", "value": "for line in lines:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    words = line."}, {"type": "slot", "index": 1}, {"type": "code", "value": "()  # 默认按空格分割单词"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    new_line = \\\""}, {"type": "slot", "index": 2}, {"type": "code", "value": "\\\"."}, {"type": "slot", "index": 3}, {"type": "code", "value": "(words)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    new_lines.append(new_line)"}, {"type": "code_line", "value": "for l in new_lines:"}, {"type": "code_line", "value": "    print(l)"}]}]}',
  '["split", "join", "strip", "replace", "*", "**", "++", "|"]',
  '[1, 1, 5, 2]',
  '第一步，按换行符`‘\n’`分割歌词得到行列表（使用split）。第二步，在循环里将每行字符串line按默认空格分割成单词列表（使用split）。第三步，用星号`‘*’`作为连接符，将单词列表连接成新字符串（使用join）。',
  '这是一个经典的split和join组合应用：先拆分处理，再用新规则重组。'
),
(
  265,
  18,
  '路径名处理',
  '给定一个文件路径，我们需要提取其目录路径和文件名。请补全代码。',
  NULL,
  '["目录: /home/user/docs", "文件名: report.txt"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "full_path = \\\"/home/user/docs/report.txt\\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 使用split方法将路径按最后一个''/''分开成两部分"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "parts = full_path."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(''/'', "}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# parts现在是 [''/home/user/docs'', ''report.txt'']"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "dir_path = parts["}, {"type": "slot", "index": 2}, {"type": "code", "value": "]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "file_name = parts["}, {"type": "slot", "index": 3}, {"type": "code", "value": "]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(f\\\"目录: {dir_path}\\\")"}, {"type": "code_line", "value": "print(f\\\"文件名: {file_name}\\\")"}]}]}',
  '["split", "join", "rsplit", "0", "1", "-1", "2"]',
  '[3, 5, 1, 2]',
  '要从右开始分割，需要使用`rsplit`方法。`rsplit(''/'', 1)`表示从右边开始，按`‘/’`最多分割1次，得到`[''/home/user/docs'', ''report.txt'']`。目录是第一部分parts[0]，文件名是第二部分parts[1]。',
  '`rsplit`常用于从末尾开始分割的场景，如分离文件扩展名。'
),
(
  269,
  18,
  '密码生成器',
  '编写一个简单的密码生成器，将用户输入的单词用随机特殊符号连接起来。请补全核心代码。',
  '["hello", "world", "python"]',
  '["hello#world$python"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import random"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 假设用户输入了三个单词，已存入列表"}, {"type": "code_line", "value": "words = [''hello'', ''world'', ''python'']"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 定义可用的特殊符号集"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "symbols = [''@'', ''#'', ''$'', ''%'', ''&'']"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 生成两个不同的随机符号"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "sep1 = random."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(symbols)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "# 确保第二个符号与第一个不同"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "sep2 = random."}, {"type": "slot", "index": 1}, {"type": "code", "value": "([s for s in symbols if s != sep1])"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 用 sep1 连接前两个词，再用 sep2 连接第三个词，形成一个连接符列表"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "password = \\\"\\\"."}, {"type": "slot", "index": 2}, {"type": "code", "value": "([words[0], "}, {"type": "slot", "index": 3}, {"type": "code", "value": ", words[1], "}, {"type": "slot", "index": 4}, {"type": "code", "value": ", words[2]])"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(password)"}]}]}',
  '["join", "split", "choice", "sample", "sep1", "sep2", "words[0]"]',
  '[3, 3, 1, 5, 6, 4]',
  '首先，使用`random.choice`从列表中随机选取一个元素。然后，密码生成的思路是构造一个新列表：`[‘hello’, sep1, ‘world’, sep2, ‘python’]`，最后对这个列表使用空字符串`‘’`调用`join`方法，即可将列表中的所有元素无缝拼接成一个字符串。',
  '`‘’.join([‘a’, ‘-’, ‘b’, ‘*’, ‘c’])` 的结果是 `‘a-b*c’`。这是一种灵活构建字符串的技巧。'
),
(
  270,
  18,
  'CSV数据清洗',
  '处理一行格式混乱的CSV数据，将其清理并转换为标准列表。请补全代码。',
  NULL,
  '["[''Alice'', ''25'', ''Engineer'']"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "dirty_data = \\\" Alice , 25 ; Engineer \\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 目标：得到干净的列表 [''Alice'', ''25'', ''Engineer'']"}, {"type": "code_line", "value": "# 第一步：替换分号为逗号，便于统一处理"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "data = dirty_data."}, {"type": "slot", "index": 0}, {"type": "code", "value": "('';'', '','')"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 第二步：按逗号分割，但分割后的每个元素可能还包含空格"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "raw_items = data."}, {"type": "slot", "index": 1}, {"type": "code", "value": "('','')"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 第三步：清洗每个元素，去除首尾空格"}, {"type": "code_line", "value": "clean_items = []"}, {"type": "code_line", "value": "for item in raw_items:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    clean_items.append(item."}, {"type": "slot", "index": 2}, {"type": "code", "value": "())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(clean_items)"}]}]}',
  '["split", "join", "replace", "strip"]',
  '[3, 1, 4]',
  '这是一个典型的数据清洗流程：1. 使用`replace`将不一致的分隔符（;）统一为逗号。2. 使用`split('','')`按统一的分隔符分割。3. 使用`strip()`去除每个分割后元素的首尾空格，得到最终干净列表。',
  '数据处理中，`split`和`strip`常结合使用，`replace`用于预处理统一格式。'
);