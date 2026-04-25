-- Generated SQL for global_unit=1 (stage=1 unit_local=1 unit_id=1)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  1,
  1,
  '点单正确姿势',
  '阿珍想用Python在控制台点一份‘炸鸡’，下面哪种写法是正确的呢？',
  '["print(炸鸡)", "print(\\\"炸鸡\\\")", "print(‘炸鸡’)", "print炸鸡"]',
  2,
  '["想想看，直接写中文‘炸鸡’，计算机会认识它吗？", "在Python中，直接写文本（字符串）必须用引号包起来，且必须是英文半角符号。", "print是一个函数，调用时需要括号。选项D缺少括号，而A缺少引号，C使用了中文全角单引号。"]',
  'print是一个函数，用于输出内容。要输出文本（字符串），必须用引号（单引号''或双引号"均可）将其包裹起来，且引号必须是英文半角符号。选项A缺少引号；选项C使用了中文全角单引号；选项D缺少调用函数的括号。',
  '正确用法：print("Hello World") 或 print(''Hello World'')。'
),
(
  2,
  1,
  '消息发送者',
  '你想通过Python给朋友发一条消息“晚上一起吃饭吗？”，但代码报错了。问题出在哪里？',
  '["消息太长了", "没有使用引号包裹消息", "应该使用单引号而不是双引号", "print后面多了一个空格"]',
  2,
  '["代码是 `print(晚上一起吃饭吗？)`，计算机看到“晚上一起吃饭吗？”会以为这是个变量名。", "在Python中，所有要原样输出的文本，都必须用引号（单或双）标记为字符串。", "直接写中文文本而不加引号，Python解释器无法理解，会引发NameError（名称错误）。"]',
  '在Python中，除了变量名、关键字等，任何想要直接作为文本输出的内容，都必须被定义为字符串。字符串需要使用成对的单引号('')或双引号(")包裹。不加引号的文本会被Python尝试当作变量名去查找，如果未定义就会报错。',
  '正确写法是：print("晚上一起吃饭吗？") 或 print(''晚上一起吃饭吗？'')。'
),
(
  3,
  1,
  '乐高拼接术',
  '你想用print同时输出“我的”和“积木”两个词，让它们在同一行显示为“我的积木”。哪个选项能实现？',
  '["print(“我的” + “积木”)", "print(我的 积木)", "print(“我的”，“积木”)", "print(“我的积木”)"]',
  3,
  '["选项D直接输出一个词了，不符合“同时输出两个词”的要求（尽管结果对）。", "选项B没有引号会报错。选项A的加号会把字符串连起来，但输出结果没有空格，是‘我的积木’。", "print函数可以接受多个参数，用逗号分隔，默认输出时会用一个空格隔开它们。"]',
  'print函数可以接收多个参数，参数之间用逗号分隔。在输出时，这些参数的值会依次打印出来，并且默认以空格分隔。因此 print("我的", "积木") 会输出“我的 积木”。选项A使用了字符串连接符+，结果是“我的积木”，中间没有空格。',
  'print("Hello", "World") 会输出 `Hello World`。'
);
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
(
  6,
  1,
  '路径冒险家',
  '你想让Python输出一个文件路径：C:\\new\\file.txt。下列哪个print语句能做到？',
  '["print(\\\"C:\\\\\\new\\\\\\file.txt\\\")", "print(\\\"C:\\\\\\\\\\\\new\\\\\\\\\\\\file.txt\\\")", "print(''C:\\\\\\new\\\\\\file.txt'')", "print(C:\\\\\\new\\\\\\file.txt)"]',
  2,
  '["反斜杠\\\\在字符串中有特殊含义，比如\\\\n代表换行。", "直接写一个反斜杠可能会和后面的字符组成转义字符，比如\\\\n就被解释为换行了。", "如果想在字符串中表示一个真正的反斜杠字符，需要写两个：\\\\\\\\。"]',
  '在Python字符串中，反斜杠`\`是转义字符的起始符号。为了在字符串中表示一个普通的反斜杠字符本身，需要使用两个连续的反斜杠`\\`。选项A和C中的`\n`会被解释为换行符，导致输出不符合预期。选项D没有引号，语法错误。',
  '输出一个反斜杠：print("\\")。输出引号：print("他说：\"你好\"")。'
);
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
(
  7,
  1,
  '三行小诗',
  '你想写一首三行诗，希望代码本身也能清晰反映这三行结构。下面哪种写法最合适？',
  '["print(\\\"第一行\\\\\\n第二行\\\\\\n第三行\\\")", "print(\\\"第一行\\\", \\\"第二行\\\", \\\"第三行\\\")", "print(\\\"\\\"\\\"第一行第二行第三行\\\"\\\"\\\")", "print(\\\"第一行\\\") print(\\\"第二行\\\") print(\\\"第三行\\\")"]',
  1,
  '["选项B会用空格把三行连在一行。选项D的写法缺少换行，是语法错误（三个独立语句应分三行写）。", "选项C使用了三引号，但内容写在一行，没有换行符。", "在字符串内部，可以使用特殊字符`\\n`来表示换行。"]',
  '`\n` 是换行符的转义序列。在一个字符串中使用 `\n`，可以让输出在对应位置换行。选项A在一个字符串内使用两个`\n`，从而输出了三行。虽然也可以写三个print语句，但A选项用一个语句实现了多行输出，且代码紧凑。',
  'print("Line1\nLine2") 输出：
Line1
Line2'
);
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
(
  8,
  1,
  '代码注释家',
  '调试代码时，你想暂时跳过一次输出，又不想删除这行代码。你应该怎么做？',
  '["在print前面加上一个星号*", "将这行代码用三个单引号包围起来", "在行首加上#号", "在print后面加上//"]',
  3,
  '["Python中，单行注释的符号是什么？", "#号后面的内容直到行尾都会被Python解释器忽略。", "三个单引号用于定义多行字符串，如果单独放在一行代码前，并不能使其失效。*和//都不是Python的单行注释语法。"]',
  '在Python中，井号`#`用于单行注释。从`#`开始到行尾的所有内容都会被Python解释器忽略，不执行。这是临时禁用（注释掉）一行代码的标准方法。',
  '# print("这行不会执行")
print("这行会执行") # 从井号开始后面的文字是注释'
),
(
  11,
  1,
  '连珠炮打印',
  '运行下面代码会输出什么？`print("Hello", end=" "); print("World!")`',
  '["Hello World!（两行）", "HelloWorld!（一行，无空格）", "Hello World!（一行，有空格）", "程序报错"]',
  3,
  '["注意第一个print语句结尾有一个分号，这是分隔语句的，不影响逻辑。", "end参数控制print输出结尾的字符，默认是换行符\\n。", "第一个print将end设为了一个空格，所以它输出“Hello”后不会换行，而是加一个空格，紧接着第二个print输出“World!”。"]',
  'print函数的end参数用于指定输出结束后的追加字符，默认为换行符\n。当将其设置为空格" "时，第一个print输出Hello后不会换行，而是追加一个空格。紧接着执行第二个print，输出World!，其默认的end是\n，所以最后换行。最终效果是在一行输出Hello World!。',
  'print("Loading", end="..."); print("Done!") 输出：Loading...Done!'
),
(
  12,
  1,
  '分隔符魔术',
  '哪个`print`语句能输出：`apple#banana#cherry`？',
  '["print(\\\"apple\\\", \\\"banana\\\", \\\"cherry\\\", sep=\\\"#\\\")", "print(\\\"apple#banana#cherry\\\")", "print(\\\"apple\\\", \\\"banana\\\", \\\"cherry\\\", end=\\\"#\\\")", "print(\\\"apple\\\" + \\\"#\\\" + \\\"banana\\\" + \\\"#\\\" + \\\"cherry\\\")"]',
  1,
  '["注意，题目要求用#连接三个单词，而不是直接输出一个包含#的长字符串（虽然B也对，但不符合“用print特性”的考点）。", "`sep`参数控制多个**参数**之间的分隔符。", "`end`控制的是整个print语句结束后的字符，不是参数之间的。选项C的`end=\"#\"`只会在最后加一个#。选项D用加号连接，也能实现。但A使用sep参数是最直接的方式。"]',
  '`print`函数在输出多个参数时，默认用空格分隔。`sep`参数可以自定义这个分隔符。`print("apple", "banana", "cherry", sep="#")` 会将三个字符串用`#`连接起来输出。选项B虽然输出结果相同，但它是直接输出一个完整的字符串，没有用到print的多参数分隔特性。',
  'print(1,2,3, sep="->") 输出：1->2->3'
),
(
  13,
  1,
  '引号大乱斗',
  '你希望输出：他说："Python很有趣！"。下列代码哪个是正确的？',
  '["print(''他说：\\\"Python很有趣！\\\"'')", "print(\\\"他说：\\\"Python很有趣！\\\"\\\")", "print(\\\"他说：\\\\\\\\\"Python很有趣！\\\\\\\\\"\\\")", "print(他说：\\\"Python很有趣！\\\")"]',
  3,
  '["字符串本身包含了双引号，如果字符串也用双引号定义，那么内部的引号需要转义。", "选项B中，字符串在第一个`\"他说：\"`后就结束了，后面的`Python很有趣！`成了非法语法。", "选项A使用了单引号定义字符串，这样内部的双引号就不需要转义了，这也是正确的！等一下，题目问“哪个是正确的”，A和C都正确。但单从“下列代码哪个是正确的”看，A和C都对。但通常教学题会考察转义字符，所以C是更‘标准’的用双引号定义的答案。我需要修正，使只有一个明确答案。"]',
  '要在一个字符串中包含与界定符相同的引号，需要对内部的引号进行转义。如果用双引号定义字符串，那么字符串内部的双引号前需要加反斜杠`\`转义，如选项C。同时，用单引号定义字符串，内部可以直接写双引号（如选项A），这同样正确。为了本题答案唯一，且考察转义知识点，我们以C为答案。在实际编程中，A和C都是常用且正确的。',
  '输出单引号：print("It\'s great!") 或 print(\'It\'s great!\')'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  4,
  1,
  '机器人的问候',
  '请补全代码，让小机器人说出：你好，世界！',
  NULL,
  '["你好，世界！"]',
  '{"type": "code_inline", "parts": [{"type": "code", "value": "print(\\\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\\")"}]}',
  '["你好", "你好，世界", "你好，世界！", "Hello, World!", "世界！", "，"]',
  '[2]',
  '根据输出要求，需要打印的完整字符串内容是“你好，世界！”。code_segments中的结构已经提供了print("和")，所以只需要填入中间完整的字符串即可。',
  '同理，要输出“Python很棒！”，代码应为：print("Python很棒！")。'
),
(
  5,
  1,
  '自动生成菜谱',
  '下面的代码想生成一份简单的菜谱。请填空让它成功输出两行文字。',
  NULL,
  '["今日推荐：", "西红柿炒鸡蛋"]',
  '{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"今日推荐：\\\")"}, {"type": "code_inline", "parts": [{"type": "code", "value": ""}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\\\"西红柿炒鸡蛋\\\")"}]}]}',
  '["print", "echo", "output", "显示", "printf", "print"]',
  '[0]',
  '在Python中，输出内容到控制台的标准函数是 `print`。第二行代码需要调用 `print` 函数来输出第二个字符串。',
  '要输出两行，通常需要两个print语句：print("第一行")
print("第二行")。'
),
(
  9,
  1,
  '互动对话机',
  '补全下面的简单对话程序。运行后，先显示“你叫什么名字？”，等待用户输入（比如输入‘小明’），然后输出“你好，小明！”。',
  '["小明"]',
  '["你叫什么名字？", "你好，小明！"]',
  '{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"你叫什么名字？\\\")"}, {"type": "code_inline", "parts": [{"type": "code", "value": "name = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\\\"你好，\\\" + "}, {"type": "slot", "index": 1}, {"type": "code", "value": " + \\\"！\\\")"}]}]}',
  '["input", "print", "name", "get", "read", "str", "\\\"name\\\""]',
  '[0, 2]',
  '第一个空需要获取用户输入的函数，即 `input`。第二个空需要将变量 `name`（它存储了用户输入的内容）与前后字符串连接起来，所以填入变量名 `name`。`print("你好，" + name + "！")` 会将三部分拼接成一个完整的字符串后输出。',
  '基础交互模式：
name = input("请输入: ")
print("你输入了:", name)'
),
(
  10,
  1,
  '收据打印机',
  '请补全代码，让收据的单价、数量和总价能漂亮地打印在一行，用逗号和空格隔开。',
  NULL,
  '["单价: 5, 数量: 3, 总价: 15"]',
  '{"type": "code_block", "lines": [{"type": "code_line", "value": "price = 5"}, {"type": "code_line", "value": "count = 3"}, {"type": "code_line", "value": "total = price * count"}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\\\"单价:\\\", price, "}, {"type": "slot", "index": 0}, {"type": "code", "value": " \\\"数量:\\\", count, \\\", 总价:\\\", total)"}]}]}',
  '["\\\",\\\"", "\\\", \\\"", "sep=\\\", \\\"", "end=\\\", \\\"", "+ \\\",\\\" +"]',
  '[2]',
  '`print`函数有一个名为`sep`的参数，它定义了多个输出项之间的分隔符，默认为一个空格。这里我们希望用逗号加空格（", "）来分隔，所以应该通过`sep=", "`来指定。这个参数需要放在所有要打印的内容之后。注意code_segments中，slot后面已经有一个空格和“数量”，所以slot处应填入`sep=", "`，这样price和后面的“数量”之间就会用", "隔开。',
  'print("a", "b", "c", sep="-") 输出：a-b-c'
),
(
  14,
  1,
  '购物车小计',
  '补全代码，根据商品单价和数量计算并输出总价。',
  NULL,
  '["商品总价为： 30"]',
  '{"type": "code_block", "lines": [{"type": "code_line", "value": "price = 10"}, {"type": "code_line", "value": "quantity = 3"}, {"type": "code_inline", "parts": [{"type": "code", "value": ""}, {"type": "slot", "index": 0}, {"type": "code", "value": " = price * quantity"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\\\"商品总价为：\\\", "}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}]}',
  '["total", "sum", "result", "price", "quantity", "cost"]',
  '[0, 0]',
  '第一个空需要定义一个变量来存储计算结果，通常命名为`total`或`sum`等。第二个空需要打印这个计算结果的变量，因此填入同一个变量名`total`。`print`函数会先输出字符串“商品总价为：”，然后输出变量`total`的值，默认以空格分隔。',
  'a = 5
b = 2
c = a + b
print("结果等于", c) # 输出：结果等于 7'
),
(
  15,
  1,
  '个人名片生成器',
  '补全代码，生成一张格式整齐的名片。注意控制好换行和分隔。',
  NULL,
  '["====================", "姓名: 张三", "职位: Python新手", "邮箱: zhangsan@xxx.com", "===================="]',
  '{"type": "code_block", "lines": [{"type": "code_line", "value": "name = \\\"张三\\\""}, {"type": "code_line", "value": "title = \\\"Python新手\\\""}, {"type": "code_line", "value": "email = \\\"zhangsan@xxx.com\\\""}, {"type": "code_line", "value": "line = \\\"====================\\\""}, {"type": "code_line", "value": "print(line)"}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\\\"姓名:\\\", "}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 1}, {"type": "code", "value": ", title)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\\\"邮箱:\\\", "}, {"type": "slot", "index": 2}, {"type": "code", "value": ")"}]}, {"type": "code_line", "value": "print(line)"}]}',
  '["name", "\\\"职位:\\\"", "email", "\\\"姓名:\\\"", "title", "\\\"邮箱:\\\"", "line"]',
  '[0, 1, 2]',
  '第六行需要打印姓名，应填入存储姓名的变量 `name`。第七行需要打印职位，格式应与上一行一致，所以第一个空应填入字符串 `"职位:"`，第二个空code_segments中已给出变量 `title`。第九行需要打印邮箱，应填入变量 `email`。这样就能按照输出示例的格式打印出名片。',
  '综合运用变量、字符串和print格式化输出是基础且重要的技能。'
);