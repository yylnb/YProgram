USE study_app;
-- Unit 1: 选择题（questions_py）
INSERT INTO questions_py (q_id, unit_id, title, energy, question_text, options, answer, hints, explanation, example) 
VALUES
(1, 1, '便签首行的 print 写法', 2,
 '你想把便签第一行写成 Dear Alice,，在 Python 中最直接的 print 写法是哪一个？',
 JSON_ARRAY(
  'print(\"Dear\", \"Alice,\")',
  'print(\"Dear Alice,\")',
  'print(\"Dear\" + \"Alice,\")',
  'print(\'Dear\' \'Alice,\')'
 ),
 1,
 JSON_ARRAY(
  '提示1：直接把整句放在一个字符串里最简单。',
  '提示2：print(\"Dear\", \"Alice,\") 会在两个参数中间插入空格。',
  '提示3：选 B：print(\"Dear Alice,\") 最直接。'
 ),
 '直接把整句作为一个字符串传给 print 最简单，print 也支持多个参数但会插入空格。',
 'print(\"Dear Alice,\")'
),

(2, 1, '便签包含 emoji 的打印', 2,
 '你希望在同一行打印 心情：happy 🙂（含中文和表情），下面哪种写法能正确输出表情（假设源码文件编码正确）？',
 JSON_ARRAY(
  'print(\"心情：\", happy, \"🙂\")',
  'print(\"心情：happy 🙂\")',
  'print(u\"心情：happy 🙂\")',
  '以上任何一种（取决于变量类型）'
 ),
 3,
 JSON_ARRAY(
  '提示1：如果 happy 是变量，注意参数组合。',
  '提示2：print(\"心情：\", happy, \"🙂\") 会在项之间加空格。',
  '提示3：不同写法在不同上下文都可行，题目更通用的回答为 D。'
 ),
 '表情本质是 Unicode 字符，作为字符串或直接字面量都可以输出；若使用变量，注意拼接或多个参数间默认会有空格。',
 'mood = \"happy\"\nemoji = \"🙂\"\nprint(f\"心情：{mood} {emoji}\")'
),

(3, 1, '一次性输出多行', 2,
 '要打印多行便签（例如三行），最简洁的一次性输出写法是哪一个？',
 JSON_ARRAY(
  'print(\"line1\"); print(\"line2\"); print(\"line3\")',
  'print(\"line1\\nline2\\nline3\")',
  'print(\"line1\",\"line2\",\"line3\")',
  'print(\"line1\\r\\nline2\\r\\nline3\")'
 ),
 1,
 JSON_ARRAY(
  '提示1：\\n 是换行符。',
  '提示2：选项 A 是多次调用 print，不是一次性输出。',
  '提示3：若要一次性输出多行，使用带 \\n 的字符串（选 B）。'
 ),
 '使用 \\n 在字符串中插入换行可以一次性输出多行文本。也可用多次 print，但不是一次性输出。',
 'print(\"Dear Alice,\\n心情：happy\\nHave a nice day!\")'
),

(6, 1, '把姓名变为大写', 2,
 '你把用户输入的姓名保存在变量 name 中，下面哪句能把 name 改为全部大写？',
 JSON_ARRAY(
  'name.upcase()',
  'name.upper()',
  'upper(name)',
  'name.toUpperCase()'
 ),
 1,
 JSON_ARRAY(
  '提示1：Python 字符串方法一般是小写驼峰吗？',
  '提示2：upper() 是 Python 字符串的方法，会返回大写的新字符串。',
  '提示3：选 B：name.upper()。'
 ),
 'Python 的字符串方法为 name.upper()，它返回一个新的大写字符串（原字符串不变）。',
 'name = \"alice\"\nprint(name.upper())  # 输出 ALICE'
),

(7, 1, '将 input() 的年龄转换为整数', 2,
 '若你用 age = input() 读入年龄，接下来要把它当整数使用，应当怎么写？',
 JSON_ARRAY(
  'age = int(age)',
  'age = float(age)',
  'age = age + 0',
  'age = str(age)'
 ),
 0,
 JSON_ARRAY(
  '提示1：input() 返回字符串。',
  '提示2：若想得到整数应使用 int()。',
  '提示3：选 A：age = int(age)。'
 ),
 'input() 返回字符串；要将字符串形式的整数转换为整型需要用 int()。',
 'age_str = input()\nage = int(age_str)\nprint(type(age))  # <class \'int\'>'
),

(8, 1, '合法的变量名示例', 2,
 '关于变量命名，下列哪个是合法且符合 Python 标识符规则的变量名？',
 JSON_ARRAY(
  'user-name',
  '2name',
  '_mood',
  'class'
 ),
 2,
 JSON_ARRAY(
  '提示1：标识符不能以数字开头，也不能包含连字符 -。',
  '提示2：关键字不能当作变量名（例如 class）。',
  '提示3：_mood 是合法的（选 C）。'
 ),
 '合法标识符可以以下划线开头，不能以数字开头，也不能是关键字。',
 'name = \"_mood\"\nprint(name)'
),

(11, 1, 'f-string 中的 upper()', 2,
 '下面代码 name = \"Tom\"; print(f\"Hi, {name.upper()}!\") 的输出是？',
 JSON_ARRAY(
  'Hi, Tom!',
  'Hi, TOM!',
  'Hi, name.upper()!',
  'Hi, {name.upper()}!'
 ),
 1,
 JSON_ARRAY(
  '提示1：f-string 会对花括号内表达式求值。',
  '提示2：upper() 会把字母变成大写。',
  '提示3：因此输出 Hi, TOM!（选 B）。'
 ),
 'f-string 会求值 name.upper() 返回 \"TOM\"，组合成最终字符串。',
 'name = \"Tom\"\nprint(f\"Hi, {name.upper()}!\")  # 输出 Hi, TOM!'
),

(12, 1, '原始字符串（raw string）', 2,
 '下列哪个字符串前缀会把反斜杠 \\ 当作普通字符（不作为转义）？',
 JSON_ARRAY(
  '"a\\n b"',
  'r"a\\n b"',
  '"""a\\n b"""',
  'b"a\\n b"'
 ),
 1,
 JSON_ARRAY(
  '提示1：要让 \\n 原样显示需要原始字符串。',
  '提示2：Python 用 r 前缀表示 raw string（原始字符串）。',
  '提示3：选 B：r\"a\\n b\"。'
 ),
 '在原始字符串 r\"...\" 中，反斜杠不会被解释为转义字符（注意字符串末尾不能以单个反斜杠）。',
 's = r\"a\\n b\"\nprint(s)  # 输出 a\\n b（反斜杠 n）'
),

(13, 1, 'format 右对齐示例', 2,
 '下面表达式 print(\"{:>6}\".format(\"Hi\")) 的输出是多少（引号不算）？',
 JSON_ARRAY(
  'Hi',
  '    Hi',
  'Hi    ',
  'Error'
 ),
 1,
 JSON_ARRAY(
  '提示1：格式说明符 \">\" 表示右对齐。',
  '提示2：\">6\" 指定宽度 6 并右对齐。',
  '提示3：因此输出是四个空格再 Hi（选 B）。'
 ),
 'format 格式化中 \">6\" 表示总宽 6，右对齐，Hi 前填充空格。',
 'print(\"{:>6}\".format(\"Hi\"))  # 输出 前面有 4 个空格的 Hi'
),

(16, 1, '可变/不可变对象判断', 2,
 '关于 Python 中可变与不可变对象，下列说法正确的是？',
 JSON_ARRAY(
  '字符串是可变的，可以原地修改字符',
  '列表是不可变的，不能修改已有元素',
  '整数是不可变的，修改变量会创建新对象',
  '所有内置类型都是可变的'
 ),
 2,
 JSON_ARRAY(
  '提示1：字符串不能通过索引原地修改某个字符。',
  '提示2：整数与字符串在 Python 中都是不可变对象。',
  '提示3：因此 C 正确：整数不可变，重新赋值会创建新对象。'
 ),
 '整数、字符串、元组等是不可变类型，对其“修改”会生成新对象；列表、字典等是可变的。',
 'a = 1\nb = a\na += 1\nprint(b)  # b 仍然为 1，a 指向新对象'
),

(17, 1, 'a +=1 对 b 的影响', 2,
 '执行 a = b = 10; a += 1 后，b 的值是多少？',
 JSON_ARRAY(
  '10',
  '11',
  'None',
  '抛出异常'
 ),
 0,
 JSON_ARRAY(
  '提示1：a = b = 10 使两个名字都指向同一个整数对象 10。',
  '提示2：对不可变整数执行 a += 1 相当于 a = a + 1，会让 a 指向新对象。',
  '提示3：所以 b 仍然是 10（选 A）。'
 ),
 '对于不可变对象，增量赋值会绑定到新对象，其他名字仍然引用原对象。',
 'a = b = 10\na += 1\nprint(b)  # 输出 10'
),

(18, 1, '多重赋值与拆包', 2,
 '下面哪种写法可以同时给三个变量赋值为 1、2、3？（单选）\nA. a=1; b=2; c=3\nB. a,b,c = 1,2,3\nC. a=b=c=1,2,3\nD. a,b,c = (1,2,3)',
 JSON_ARRAY(
  '仅 A 正确',
  '仅 B 正确',
  'A 和 B 都可行，但 B 更简洁',
  '仅 C 正确'
 ),
 2,
 JSON_ARRAY(
  '提示1：多重赋值 a,b,c = 1,2,3 是常见拆包写法。',
  '提示2：A 与 B 都可以实现，C 会把元组整体赋给 a 并非想要的效果。',
  '提示3：按教学目的，A 与 B 都可行，B 更简洁（选 C 即选项 3）。'
 ),
 'a,b,c = 1,2,3 是最简洁的方式；多行赋值也可行，但拆包更常用。',
 'a,b,c = 1,2,3\nprint(a,b,c)'
),

(21, 1, '打印多个变量的最简法', 2,
 '如果要在同一行依次打印变量 a=1、b=\"hi\"、c=3.5，并以逗号加空格分隔，下面哪行代码最简洁？',
 JSON_ARRAY(
  'print(str(a) + \", \" + b + \", \" + str(c))',
  'print(a, \", \", b, \", \", c)',
  'print(f\"{a}, {b}, {c}\")',
  'print(\"{}, {}, {}\".format(a,b,c))'
 ),
 2,
 JSON_ARRAY(
  '提示1：f-string 与 format 都是简洁可读的方式。',
  '提示2：print(a, \", \", b, \", \", c) 会在逗号周围添加额外空格，且不简洁。',
  '提示3：现代推荐使用 f-string（选 C）。'
 ),
 'f-string 语法在可读性和简洁性上具有优势，适合新的 Python 代码风格。',
 'a,b,c = 1, \"hi\", 3.5\nprint(f\"{a}, {b}, {c}\")'
),

(22, 1, '改变 print 分隔符 sep', 2,
 '下面哪种方法可以在打印多个变量时把分隔符改为 |？',
 JSON_ARRAY(
  'print(a, b, c, sep=\'|\')',
  'print(a + \'|\' + b + \'|\' + c)',
  'print(\"{0}|{1}|{2}\".format(a,b,c))',
  '以上都可以'
 ),
 3,
 JSON_ARRAY(
  '提示1：print 有 sep 参数可以直接控制分隔符。',
  '提示2：字符串拼接和 format 也能实现相同结果。',
  '提示3：因此三种方法均可（选 D）。'
 ),
 'print 的 sep 参数、字符串拼接或 format 都能生成指定分隔符的输出，按场景选择即可。',
 'print(a, b, c, sep=\"|\")'
),

(23, 1, '安全转换年龄的方法', 2,
 '以下哪段代码可以把用户输入的 age_str 安全地转换为整数并在失败时输出 0？',
 JSON_ARRAY(
  'age = int(age_str)',
  'try:\\n  age = int(age_str)\\nexcept:\\n  age = 0',
  'age = int(age_str) if age_str.isdigit() else 0',
  'B 和 C 都能（但实现略有差别）'
 ),
 3,
 JSON_ARRAY(
  '提示1：isdigit() 对负数和空格有局限性。',
  '提示2：try/except 能捕获更多非法输入情况。',
  '提示3：B 更稳妥，但 C 在简单场景下也可；题目选项归纳 D（两者可用）。'
 ),
 '更稳妥的方法是 try/except 捕获 ValueError，但在简单且只存在正整数输入场景下 isdigit 也可用。',
 'age_str = input()\ntry:\n  age = int(age_str)\nexcept ValueError:\n  age = 0\nprint(age)'
),

(26, 1, '列表负索引的含义', 2,
 '关于列表的下标访问，下列说法正确的是：索引 -1 表示？',
 JSON_ARRAY(
  '第一个元素',
  '最后一个元素',
  '倒数第二个元素',
  '抛出异常'
 ),
 1,
 JSON_ARRAY(
  '提示1：Python 支持负索引访问列表元素。',
  '提示2：-1 对应最后一项，-2 对应倒数第二项。',
  '提示3：选 B（最后一个元素）。'
 ),
 '在 Python 中，负索引从列表末尾开始计数，-1 表示最后一个元素。',
 'lst = [\"a\",\"b\",\"c\"]\nprint(lst[-1])  # 输出 c'
),

(27, 1, '列表末尾添加元素的方法', 2,
 '下列哪条语句可以把 item 插入到列表 lst 的末尾？',
 JSON_ARRAY(
  'lst.add(item)',
  'lst.append(item)',
  'lst.insert(item)',
  'lst.push(item)'
 ),
 1,
 JSON_ARRAY(
  '提示1：列表方法有 append、insert、extend，没有 add 或 push（那是集合或其它语言）。',
  '提示2：append 在末尾添加单个元素，insert 需要两个参数（位置和元素）。',
  '提示3：选 B（lst.append(item)）。'
 ),
 '使用 lst.append(item) 可以在列表末尾添加元素；insert 需要指定索引位置。',
 'lst = []\nlst.append(\"apple\")\nprint(lst)'
),

(28, 1, '通过索引修改列表元素', 2,
 '若 lst = [\"a\",\"b\",\"c\"]，执行 lst[1] = \"x\" 后 lst 是什么？',
 JSON_ARRAY(
  '[\"a\",\"b\",\"c\"]',
  '[\"a\",\"x\",\"c\"]',
  '[\"x\",\"b\",\"c\"]',
  '抛出异常（不可赋值）'
 ),
 1,
 JSON_ARRAY(
  '提示1：列表是可变的，可以通过索引直接赋值。',
  '提示2：索引 1 指第二个元素（从 0 开始）。',
  '提示3：结果为 [\"a\",\"x\",\"c\"]（选 B）。'
 ),
 '列表是可变类型，可以直接通过索引赋值修改元素。',
 'lst = [\"a\",\"b\",\"c\"]\nlst[1] = \"x\"\nprint(lst)  # [\"a\",\"x\",\"c\"]'
);
-- Unit 1: 实操题（questions_py_exec）
INSERT INTO questions_py_exec
(q_id, unit_id, title, energy, question_text, hints, link, eg_in1, eg_out1, eg_in2, eg_out2, eg_in3, eg_out3)
VALUES
(4, 1, '生成三行电子便签', 3,
 '编写脚本：读取两行输入，第一行为姓名，第二行为心情（单词，如 happy / sad）。输出三行便签格式：\\nDear <姓名>,\\n心情：<心情>\\nHave a nice day!',
 JSON_ARRAY(
  '提示1：用 input() 读取姓名与心情并用 print() 输出。',
  '提示2：可用 f-string 拼接：print(f\"Dear {name},\") 等。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Alice\nhappy\n',
 'Dear Alice,\n心情：happy\nHave a nice day!\n',
 'Bob\nsad\n',
 'Dear Bob,\n心情：sad\nHave a nice day!\n',
 'Amy\nexcited\n',
 'Dear Amy,\n心情：excited\nHave a nice day!\n'
),

(5, 1, '心情为 sad 时追加 Cheer up!', 3,
 '把上题扩展：当心情为 sad 时，第二行在 心情：sad 后再输出一句 Cheer up!（作为第四行）。其余心情只输出前三行。',
 JSON_ARRAY(
  '提示1：读取后用 if 判断 mood == \"sad\"。',
  '提示2：若是 sad，用额外的 print() 输出 \"Cheer up!\"。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Bob\nsad\n',
 'Dear Bob,\n心情：sad\nHave a nice day!\nCheer up!\n',
 'Carol\nhappy\n',
 'Dear Carol,\n心情：happy\nHave a nice day!\n',
 'Ted\nsad\n',
 'Dear Ted,\n心情：sad\nHave a nice day!\nCheer up!\n'
),

(9, 1, '签名可选的便签输出', 3,
 '编写脚本：读取三行输入：姓名、心情、签名（可空行）。打印便签三行，如果签名不为空，在最后追加 — <签名>（单独一行）。',
 JSON_ARRAY(
  '提示1：读取签名后判断是否等于空字符串 \"\"。',
  '提示2：如果签名存在，使用 print(\"— \" + signature)。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Cathy\nexcited\nFrom Cathy\n',
 'Dear Cathy,\n心情：excited\nHave a nice day!\n— From Cathy\n',
 'D\nhappy\n\n',
 'Dear D,\n心情：happy\nHave a nice day!\n',
 'Eve\nsad\nBest,\n',
 'Dear Eve,\n心情：sad\nHave a nice day!\n— Best,\n'
),

(10, 1, '便签包含 emoji', 3,
 '读取三行（姓名、心情、emoji），在心情行中打印心情与 emoji，例如 心情：happy 🙂。',
 JSON_ARRAY(
  '提示1：emoji 当作字符串处理，直接拼接。',
  '提示2：确保读入并输出时保留 emoji 的 Unicode 字符。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Diana\nhappy\n🙂\n',
 'Dear Diana,\n心情：happy 🙂\nHave a nice day!\n',
 'L\nsad\n😢\n',
 'Dear L,\n心情：sad 😢\nHave a nice day!\n',
 'Z\njoyful\n🎉\n',
 'Dear Z,\n心情：joyful 🎉\nHave a nice day!\n'
),

(14, 1, '按心情变结尾', 3,
 '实现“按心情变结尾”功能：读取两行（姓名、心情）。若心情是 happy 输出结尾 Have a nice day! : )；若 sad 输出 Hope tomorrow is better. : (；其他输出 Have a good one.',
 JSON_ARRAY(
  '提示1：使用 if / elif / else 根据心情设置不同结尾。',
  '提示2：把结尾存入变量 ending，然后打印，方便扩展。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Eve\nsad\n',
 'Dear Eve,\n心情：sad\nHope tomorrow is better. :(\n',
 'Sam\nhappy\n',
 'Dear Sam,\n心情：happy\nHave a nice day! :)\n',
 'Tam\nok\n',
 'Dear Tam,\n心情：ok\nHave a good one.\n'
),

(15, 1, '按模板输出便签 A 或 B', 3,
 '实现“模板化便签”：程序内有两个模板（A: 正式，B: 随意）。读取三行输入：姓名、心情、模板类型（A 或 B），渲染对应模板并输出。',
 JSON_ARRAY(
  '提示1：定义两个字符串模板，然后根据用户输入选择。',
  '提示2：可用 str.format() 或 f-string 替换占位符。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Frank\nexcited\nB\n',
 'Hey Frank!\nMood: excited :)\n',
 'Anne\ncalm\nA\n',
 'Dear Anne,\n心情：calm\nRegards,\n',
 'Joe\nhappy\nB\n',
 'Hey Joe!\nMood: happy :)\n'
),

(19, 1, '安全读取年龄并祝福', 3,
 '实现“安全读取年龄并打印祝福”的脚本：读取两行（姓名、年龄字符串）。如果年龄可转为整数且 >= 18 输出 Welcome, <name>!，否则输出 You are not eligible.',
 JSON_ARRAY(
  '提示1：使用 try/except 捕获 int() 转换异常。',
  '提示2：转换后比较数值是否 >= 18 决定输出。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Gina\n20\n',
 'Welcome, Gina!\n',
 'Gina\ntwenty\n',
 'You are not eligible.\n',
 'Sam\n17\n',
 'You are not eligible.\n'
),

(20, 1, '心情关键词替换', 3,
 '实现“心情关键词替换”功能：读取一行心情短句，如果包含单词 happy（区分大小写），替换为 HAPPY 并输出整行；否则输出原句。',
 JSON_ARRAY(
  '提示1：使用 if \"happy\" in s 判断包含关系。',
  '提示2：用 s.replace(\"happy\",\"HAPPY\") 完成替换。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'feeling very happy today\n',
 'feeling very HAPPY today\n',
 'I am happy\n',
 'I am HAPPY\n',
 'no joy here\n',
 'no joy here\n'
),

(24, 1, '读取到空行为止的购物清单编号打印（示例借鉴）', 3,
 '实现“批量生成便签”脚本（此处改写为示例：读取多组姓名+心情直到空姓名，输出每组便签；便签间空行）。',
 JSON_ARRAY(
  '提示1：循环读取，检测空姓名退出。',
  '提示2：打印完一张便签后输出空行作为分隔。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Anna\nhappy\nBen\nsad\n\n',
 'Dear Anna,\n心情：happy\nHave a nice day!\n\nDear Ben,\n心情：sad\nHave a nice day!\n',
 'Tom\njoy\n\n',
 'Dear Tom,\n心情：joy\nHave a nice day!\n',
 'A\nb\nC\nc\n\n',
 'Dear A,\n心情：b\nHave a nice day!\n\nDear C,\n心情：c\nHave a nice day!\n'
),

(25, 1, '便签模板写入 notes.txt 并确认保存', 3,
 '实现“便签模板选择器并写入文件”功能：读取姓名、心情、模板编号（1 或 2），将渲染好的便签追加写入 notes.txt（每张便签间用 --- 分割），并打印 Saved.',
 JSON_ARRAY(
  '提示1：用 with open(...,\"a\",encoding=\"utf-8\") 追加写入。',
  '提示2：写入完成后 print(\"Saved.\") 作为确认提示。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Chris\ncontent\n1\n',
 'Saved.\n',
 'Bob\nsad\n2\n',
 'Saved.\n',
 'D\nhappy\n1\n',
 'Saved.\n'
),

(29, 1, '按心情统计并写报告', 3,
 '实现“按心情统计并写报告”脚本：读取多组姓名+心情直到空姓名，统计各心情出现次数并按次数降序输出每行 <心情>: <次数>（同次数按字母序）。',
 JSON_ARRAY(
  '提示1：用字典计数 counts[mood] = counts.get(mood,0) + 1。',
  '提示2：用 sorted(counts.items(), key=lambda x:(-x[1], x[0])) 排序并输出。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Alice\nhappy\nBob\nsad\nCathy\nhappy\n\n',
 'happy: 2\nsad: 1\n',
 'Tom\njoy\nTom\njoy\nSam\njoy\n\n',
 'joy: 3\n',
 'A\nb\nC\nb\n\n',
 'b: 2\na: 1\n'
),

(30, 1, '每日便签自动化并写文件', 3,
 '实现“每日便签自动化”脚本：读取一行日期 YYYY-MM-DD，后续读取多组姓名+心情直到空姓名，渲染每张便签并写入 daily_<date>.txt（UTF-8），最后打印 Wrote N notes to daily_<date>.txt',
 JSON_ARRAY(
  '提示1：用 date = input().strip() 构造文件名。',
  '提示2：写文件时用 with open(fname,\"w\",encoding=\"utf-8\") 并计数写入的便签数。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 '2025-09-21\nAmy\nhappy\nBen\nsad\n\n',
 'Wrote 2 notes to daily_2025-09-21.txt\n',
 '2025-01-01\nTom\njoy\n\n',
 'Wrote 1 notes to daily_2025-01-01.txt\n',
 '2025-12-31\nA\nb\nC\nd\n\n',
 'Wrote 2 notes to daily_2025-12-31.txt\n'
);
-- Unit 2: 选择题（questions_py）, unit_id = 2
INSERT INTO questions_py (q_id, unit_id, title, energy, question_text, options, answer, hints, explanation, example) VALUES
(1, 2, '读取三行输入', 2,
 '你想写一个脚本，按顺序读取三行：姓名、工号、部门。下面哪种读取方式正确？',
 JSON_ARRAY(
  'name = input(); id = input(); dept = input()',
  'name, id, dept = input()',
  'name = input(3)',
  'name = raw_input()'
 ),
 0,
 JSON_ARRAY(
  '提示1：Python 3 中读取一行使用 input()。',
  '提示2：一次读三行需要分别调用三次 input()。',
  '提示3：选 A：逐行读取最直接。'
 ),
 '在 Python 3 中，input() 用来读取一行输入，要读多行就重复调用 input()。',
 'name = input()\nid = input()\ndept = input()\nprint(name, id, dept)'
),

(2, 2, '工号是否全为数字', 2,
 '如果读取工号后需要判断它是否只包含数字，下面哪个方法更直接？',
 JSON_ARRAY(
  'if id_str.isdigit():',
  'if isinstance(id_str, int):',
  'if id_str.isnumeric():',
  'if id_str.isalnum():'
 ),
 0,
 JSON_ARRAY(
  '提示1：input() 返回字符串。',
  '提示2：isdigit() 可以检查字符串是否全部为数字字符（常见场景使用）。',
  '提示3：选 A：在大多数场景下使用 id_str.isdigit()。'
 ),
 '对于 ASCII 数字形式，id_str.isdigit() 能够判断字符串是否全是数字字符，是最直接的方法。',
 'id_str = "2025"\nprint(id_str.isdigit())  # True'
),

(3, 2, '拼接输出名片单行', 2,
 '当你要把工号（字符串）与姓名拼成 ID: <工号>, Name: <姓名>，下面哪种方法更常见也易读？',
 JSON_ARRAY(
  'print("ID: " + id_str + ", Name: " + name)',
  'print("ID: %s, Name: %s" % (id_str, name))',
  'print(f"ID: {id_str}, Name: {name}")',
  '以上都可，但哪种更现代易读？'
 ),
 2,
 JSON_ARRAY(
  '提示1：% 格式化是旧式方法，仍可用。',
  '提示2：字符串拼接也可，但在多字段时略显冗长。',
  '提示3：f-string（选 C）是 Python 3.6+ 更现代、可读的写法。'
 ),
 'f-string（例如 f"ID: {id_str}, Name: {name}"）在可读性和书写上都很便利，为现代 Python 的推荐方式。',
 'id_str = "2025"\nname = "Alice"\nprint(f"ID: {id_str}, Name: {name}")'
),

(6, 2, '部门首字母处理', 2,
 '为了让所有名片上的部门名首字母大写（例如 marketing → Marketing），下面哪个方法能做到？',
 JSON_ARRAY(
  'dept.capitalize()',
  'dept.upper()',
  'dept.title()',
  'dept.lower()'
 ),
 2,
 JSON_ARRAY(
  '提示1：upper() 会将整个字符串变大写。',
  '提示2：capitalize() 只会把第一个字符大写，其余小写。',
  '提示3：title() 会把每个单词首字母大写，对多词部门名较合适。'
 ),
 '对于多单词的部门名（例如 "research and development"），使用 dept.title() 可以把每个单词首字母大写。',
 'dept = "research and development"\nprint(dept.title())  # Research And Development'
),

(7, 2, '去除姓名前后空格', 2,
 '输入的姓名可能带有多余空格（如 "  Alice  "），要清理两端空格正确写法是？',
 JSON_ARRAY(
  'name.strip()',
  'name.remove()',
  'name.trim()',
  'name.clean()'
 ),
 0,
 JSON_ARRAY(
  '提示1：strip() 可以移除首尾空白。',
  '提示2：trim() 不是 Python 的字符串方法。',
  '提示3：选 A：使用 name.strip()。'
 ),
 '用 name = name.strip() 可以清除输入字符串首尾的空白字符，是处理用户输入的常用步骤。',
 'name = "  Alice  "\nprint(name.strip())  # Alice'
),

(8, 2, '工号补零方法', 2,
 '如果你想限制输出中的工号显示为至少 6 位，不足前面补零（例如 2025 → 002025），下面哪个方法直接且不需转型？',
 JSON_ARRAY(
  'print(f"{int(id_str):06d}")',
  'print(f"{id_str:06d}")',
  'print("{:06}".format(id_str))',
  'print(id_str.zfill(6))'
 ),
 3,
 JSON_ARRAY(
  '提示1：zfill 是字符串方法，用于在左侧补零。',
  '提示2：格式化方法也可以，但可能需先转成整数。',
  '提示3：选 D（id_str.zfill(6) 更直接且不需转型）。'
 ),
 'id_str.zfill(6) 是处理字符串工号补零的简洁方法；若要数字作格式化也可用格式化语法但需转型。',
 'id_str = "2025"\nprint(id_str.zfill(6))  # 002025'
),

(11, 2, '字段宽度左对齐', 2,
 '你想让名片上姓名与部门对齐（姓名 12 宽左对齐，部门 15 宽左对齐），下面哪种 f-string 写法可实现？',
 JSON_ARRAY(
  'f"{name:<12}{dept:<15}"',
  'f"{name:>12}{dept:>15}"',
  'f"{name:^12}{dept:^15}"',
  'f"{name:12}{dept:15}"'
 ),
 0,
 JSON_ARRAY(
  '提示1：格式说明符 < 表示左对齐。',
  '提示2：> 表示右对齐，^ 表示居中。',
  '提示3：选 A：使用 < 实现左对齐。'
 ),
 '使用 f"{name:<12}{dept:<15}" 可指定每个字段的宽度与左对齐，方便控制列对齐。',
 'name = "Alice"\ndept = "Marketing"\nprint(f"{name:<12}{dept:<15}")'
),

(12, 2, '替换字符串中的竖线', 2,
 '为避免用户输入造成注入或格式问题，你想把所有输入里的竖线 | 替换为斜线 /，下面哪句实现这一点？（变量名 s）',
 JSON_ARRAY(
  's.replace("|","/")',
  's.repl("|","/")',
  'replace(s,"|","/")',
  's.sub("|","/")'
 ),
 0,
 JSON_ARRAY(
  '提示1：Python 字符串替换方法为 str.replace(old, new)。',
  '提示2：其他选项不是字符串的标准方法。',
  '提示3：选 A：s.replace("|","/")。'
 ),
 's.replace(old, new) 可以返回替换后的新字符串，原字符串不变，通常用 s = s.replace(...) 保存结果。',
 's = "A|B"\ns = s.replace("|","/")\nprint(s)  # A/B'
),

(13, 2, '输出包含反引号的代码块', 2,
 '要生成一个可粘贴到聊天的 Markdown 名片块（使用三反引号包裹多行），下列哪种办法能正确生成包含反引号的字符串？',
 JSON_ARRAY(
  '在 Python 源码中用三引号字符串直接包裹三反引号（需小心）',
  '用 print("```\\n" + s + "\\n```") 将换行与反引号手动拼接',
  '两者都可',
  '无法在字符串中包含反引号'
 ),
 1,
 JSON_ARRAY(
  '提示1：字符串中可以包含任何字符，只要正确处理引号或使用拼接。',
  '提示2：三引号字符串内直接放三反引号会导致结束字符串，需转义或拼接。',
  '提示3：选 B：用拼接较稳妥。'
 ),
 '最直接的做法是拼接字符串，加上换行与反引号，例如 print("```\\n" + content + "\\n```")，避免与源代码中的引号冲突。',
 'content = "Name: Alice\\nID: 002025\\nDept: Marketing"\nprint("```\\n" + content + "\\n```")'
),

(16, 2, '部门首字母特殊处理', 2,
 '部门字符串可能包含多词（如 research and development），要把每个单词首字母大写并把 and 保持小写，哪种做法更易实现且可控？',
 JSON_ARRAY(
  'dept.title() 然后把 " And " 替换回 " and "',
  'dept.split() 后自己处理每个词',
  '使用正则复杂替换',
  '以上都不可行'
 ),
 0,
 JSON_ARRAY(
  '提示1：dept.title() 会把所有单词首字母大写，但会把 and 也变为 And。',
  '提示2：后处理替换是简洁可行的方式。',
  '提示3：选 A：先 title() 后替换特例是简洁解法。'
 ),
 '一种常见做法：s = dept.title().replace(" And ", " and ")，注意边界情况；也可以更精细地 split 后逐词处理。',
 'dept = "research and development"\nprint(dept.title().replace(" And ", " and "))'
),

(17, 2, '姓、名互换', 2,
 '要把姓名格式改成 Last, First（假设用户输入 First Last），下面哪步骤能实现？',
 JSON_ARRAY(
  'parts = name.split(); print(parts[-1] + ", " + parts[0])',
  'name[::-1]',
  'name.replace(" ", ", ")',
  'name.split(",")'
 ),
 0,
 JSON_ARRAY(
  '提示1：先 split() 分词是合理做法。',
  '提示2：取最后一个词为姓，第一个词为名并拼接即可。',
  '提示3：选 A：parts[-1] 为姓，parts[0] 为名。'
 ),
 '对于简单的 First Last 格式，可以 parts = name.split(); print(parts[-1] + ", " + " ".join(parts[:-1])) 以支持中间名。',
 'name = "Mary Jane Watson"\nparts = name.split()\nprint(parts[-1] + ", " + " ".join(parts[:-1]))'
),

(18, 2, '去除内部多余空格', 2,
 '要去掉姓名中的多余内部空格（例如 "  Alice   Cooper  " → "Alice Cooper"），下列哪种做法正确且简单？',
 JSON_ARRAY(
  '" ".join(name.split())',
  'name.strip()',
  'name.replace("  "," ")',
  '使用正则 re.sub'
 ),
 0,
 JSON_ARRAY(
  '提示1：strip() 只去首尾空白，不能去除内部多重空格。',
  '提示2：split() 后再 join() 可以把任意多空白标准化为单个空格。',
  '提示3：选 A：" ".join(name.split())。'
 ),
 '常用技巧：" ".join(name.split()) 会先按任意空白分割再按单个空格连回字符串，达到清理内部多余空格的目的。',
 'name = "  Alice   Cooper  "\nprint(" ".join(name.split()))  # Alice Cooper'
),

(21, 2, '导出 JSON 最佳方式', 2,
 '你要把名片信息导出为 JSON（字段 name,id,dept），下面哪种方式更直接生成合法 JSON 字符串？',
 JSON_ARRAY(
  '手工拼接字符串 f\'{{"name":"{name}", "id":"{id_norm}"}}\'',
  '使用 json.dumps({"name":name, "id":id_norm, "dept":dept}, ensure_ascii=False)',
  '使用 str(dict(...))',
  '使用 repr()'
 ),
 1,
 JSON_ARRAY(
  '提示1：手工拼接容易在字段包含引号时出错。',
  '提示2：json.dumps 会正确处理转义与编码选项。',
  '提示3：选 B：使用 json.dumps 更可靠。'
 ),
 '使用 json.dumps 可以安全地序列化 Python 对象为 JSON 字符串，并能设置 ensure_ascii=False 以保持非 ASCII 字符。',
 'import json\ndata = {"name": name, "id": id_norm, "dept": dept}\nprint(json.dumps(data, ensure_ascii=False))'
),

(22, 2, '终端表格输出做法', 2,
 '如果你想在终端把名片输出成表格列（列宽固定），最常用的做法是？',
 JSON_ARRAY(
  '使用格式化字符串指定宽度（f-string / format）',
  '使用第三方表格库（如 tabulate）',
  '只用 print 随意对齐',
  'A 与 B 均可，视需求而定'
 ),
 3,
 JSON_ARRAY(
  '提示1：小规模需求用格式化字符串即可。',
  '提示2：大量或漂亮表格可用现成库，例如 tabulate。',
  '提示3：根据场景选择 A 或 B，故选 D（更灵活）。'
 ),
 '对于简单输出，用 f-string 指定宽度足够；对于更复杂的输出，可使用 tabulate 类库生成更美观表格。',
 'print(f"{name:<12}{dept:<15}")  # 简单对齐示例'
),

(23, 2, 'Unicode 规范化方法', 2,
 '在生成名片的过程中，你希望统一所有输入为 Unicode 规范化（如 NFKC），下面哪个模块可用来规范化 Unicode？',
 JSON_ARRAY(
  'unicodedata.normalize("NFKC", s)',
  'str.normalize(s)',
  's.encode("utf-8")',
  's.decode("utf-8")'
 ),
 0,
 JSON_ARRAY(
  '提示1：Python 标准库中有 unicodedata 用于 Unicode 处理。',
  '提示2：encode/decode 与规范化不是同一概念。',
  '提示3：选 A。'
 ),
 '使用 unicodedata.normalize("NFKC", s) 可以统一半角/全角等 Unicode 形式，适用于处理用户输入的规范化。',
 'import unicodedata\ns = unicodedata.normalize("NFKC", s)'
),

(26, 2, '展示可读转义字符串的方法', 2,
 '要把名片字符串内的特殊字符（如换行、制表符）转义以便在单行展示，哪种方法最常用于“可读的转义后字符串”？',
 JSON_ARRAY(
  's.replace("\\n","\\\\n")',
  'repr(s)',
  'json.dumps(s)',
  '以上都可，但选择 repr() 作为展示'
 ),
 1,
 JSON_ARRAY(
  '提示1：repr() 返回带引号的字面量表示并显示转义字符。',
  '提示2：json.dumps 也能生成带引号并转义的字符串。',
  '提示3：repr() 通常用于简单可读展示（选 B）。'
 ),
 'repr(s) 会返回字符串的字面量形式并显示转义字符，常用于调试或展示用途；json.dumps 也可用于特定输出。',
 's = "Line1\\nLine2"\nprint(repr(s))  # "Line1\\nLine2"'
),

(27, 2, '命令行参数解析库', 2,
 '如果你想让脚本在命令行支持可选参数（比如 --format=single），推荐使用哪个模块来解析？',
 JSON_ARRAY(
  'sys.argv 手工解析',
  'argparse 标准库',
  'optparse（已废弃）',
  'getopt'
 ),
 1,
 JSON_ARRAY(
  '提示1：sys.argv 可行但需手动解析。',
  '提示2：argparse 是 Python 标准且功能完整的选择。',
  '提示3：选 B（argparse）。'
 ),
 'argparse 提供丰富的命令行参数定义与自动帮助文本，适合构建 CLI 工具。',
 'import argparse\nparser = argparse.ArgumentParser()\nparser.add_argument("--format", default="single")\nargs = parser.parse_args()'
),

(28, 2, '打印时间戳的方法', 2,
 '在把名片写入文件后，你想在控制台显示写入时间戳（例如 Saved at 2025-09-21 09:00），哪个模块与函数组合最合适？',
 JSON_ARRAY(
  'time.time()',
  'datetime.datetime.now().strftime("%Y-%m-%d %H:%M")',
  'os.stat()',
  'calendar.timegm()'
 ),
 1,
 JSON_ARRAY(
  '提示1：time.time() 返回 UNIX 时间戳，不便于人阅读。',
  '提示2：datetime.now() 结合 strftime 可以生成可读时间字符串。',
  '提示3：选 B。'
 ),
 '使用 datetime.datetime.now().strftime("%Y-%m-%d %H:%M") 可以得到可读的本地时间字符串，方便在日志或终端显示。',
 'import datetime\nprint(datetime.datetime.now().strftime("%Y-%m-%d %H:%M"))'
);
-- Unit 2: 实操题（questions_py_exec）, unit_id = 2
INSERT INTO questions_py_exec
(q_id, unit_id, title, energy, question_text, hints, link, eg_in1, eg_out1, eg_in2, eg_out2, eg_in3, eg_out3)
VALUES
(4, 2, '读取姓名/工号/部门并多行输出', 3,
 '编写脚本：读取三行（姓名、工号、部门），输出三行自我介绍，格式为：\\nName: <姓名>\\nID: <工号>\\nDept: <部门>',
 JSON_ARRAY(
  '提示1：逐行用 input() 读取三个值。',
  '提示2：逐行用 print() 输出对应标签和值。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Alice\n2025\nMarketing\n',
 'Name: Alice\nID: 2025\nDept: Marketing\n',
 'Bob\n007\nOps\n',
 'Name: Bob\nID: 007\nDept: Ops\n',
 'Cathy\n45\nHR\n',
 'Name: Cathy\nID: 45\nDept: HR\n'
),

(5, 2, '单行名片：竖线分隔与工号补零', 3,
 '把上题输出调整为单行可粘贴格式：Alice | 002025 | Marketing（工号补零 6 位）。读三行并输出一行。',
 JSON_ARRAY(
  '提示1：先用 id_str.zfill(6) 补零。',
  '提示2：用 f-string 拼接为单行格式。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Alice\n2025\nMarketing\n',
 'Alice | 002025 | Marketing\n',
 'Tom\n1\nSales\n',
 'Tom | 000001 | Sales\n',
 'Z\n123456\nR&D\n',
 'Z | 123456 | R&D\n'
),

(9, 2, '显示掩码与多行名片', 3,
 '编写脚本：读取三行（姓名、工号、部门），先打印单行形式（Name | EMP-xxxxxx | Dept），再打印多行形式（ID 与 EMP- 前缀）。工号需补零 6 位并加 EMP- 前缀。',
 JSON_ARRAY(
  '提示1：先对工号补零 id_norm = id_str.zfill(6)。',
  '提示2：多处使用相同标准化工号变量以避免重复代码。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Alice\n2025\nMarketing\n',
 'Alice | EMP-002025 | Marketing\nName: Alice\nID: EMP-002025\nDept: Marketing\n',
 'Bob\n12\nSupport\n',
 'Bob | EMP-000012 | Support\nName: Bob\nID: EMP-000012\nDept: Support\n',
 'E\n345\nQA\n',
 'E | EMP-000345 | QA\nName: E\nID: EMP-000345\nDept: QA\n'
),

(10, 2, '工号格式检查与错误处理', 3,
 '实现“安全显示名片”：读取姓名、工号、部门；若工号包含非数字，输出 Invalid ID 并结束；否则显示单行与多行形式（工号补零并加 EMP- 前缀）。',
 JSON_ARRAY(
  '提示1：使用 id_str.isdigit() 检查是否全为数字。',
  '提示2：若非数字请直接 print("Invalid ID") 并 return/结束。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Ivy\n45\nHR\n',
 'Ivy | EMP-000045 | HR\nName: Ivy\nID: EMP-000045\nDept: HR\n',
 'Ivy\n45A\nHR\n',
 'Invalid ID\n',
 'Tom\n0007\nOps\n',
 'Tom | EMP-000007 | Ops\nName: Tom\nID: EMP-000007\nDept: Ops\n'
),

(14, 2, '批量名片生成：读 N 并输出单行', 3,
 '实现“批量名片生成器”：读取 N（整数），接着读取 N 组三行（姓名、工号、部门），输出每张名片的单行格式（工号补零 6 位）。',
 JSON_ARRAY(
  '提示1：先读 N = int(input())，然后在 for 循环中每次读 3 行。',
  '提示2：在输出前对工号做 id_str.zfill(6)。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 '2\nJack\n1\nSales\nJill\n12\nR&D\n',
 'Jack | 000001 | Sales\nJill | 000012 | R&D\n',
 '1\nTom\n123\nOps\n',
 'Tom | 000123 | Ops\n',
 '3\nA\n1\nX\nB\n22\nY\nC\n333\nZ\n',
 'A | 000001 | X\nB | 000022 | Y\nC | 000333 | Z\n'
),

(15, 2, '名片模板与多语言输出', 3,
 '实现“名片模板与多语言导出”：读取姓名、工号、部门和语言代码（en 或 cn）；根据语言选模板（英文或中文），将渲染文本写入 clipboard.txt（代替剪贴板），并输出 Ready to paste.',
 JSON_ARRAY(
  '提示1：根据 lang 选择不同模板字符串。',
  '提示2：用 with open("clipboard.txt","w",encoding="utf-8") 写入内容。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Lena\n77\nHR\ncn\n',
 'Ready to paste.\n',
 'Tom\n1\nOps\nen\n',
 'Ready to paste.\n',
 'Ann\n12\nR&D\ncn\n',
 'Ready to paste.\n'
),

(19, 2, '姓名倒序显示', 3,
 '实现“姓名倒序显示”：读取姓名（可能包含中间名），输出 Last, Rest 格式，例如 Mary Jane Watson → Watson, Mary Jane。',
 JSON_ARRAY(
  '提示1：parts = name.split()，last = parts[-1]，rest = " ".join(parts[:-1])。',
  '提示2：若只有一个词，直接输出原样。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Mary Jane Watson\n',
 'Watson, Mary Jane\n',
 'Tom\n',
 'Tom\n',
 'A B C D\n',
 'D, A B C\n'
),

(20, 2, '隐私保护：工号掩码', 3,
 '实现“隐私保护的名片”：读取姓名、工号、部门，把工号只显示后两位，前面以 * 替代（长度可变），输出单行名片。',
 JSON_ARRAY(
  '提示1：用 id_str[-2:] 取最后两位，前缀用 "*"*(len(id_str)-2)。',
  '提示2：注意工号可能短于 2 位，需特殊处理或假定至少 2 位。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Alice\n2025\nMarketing\n',
 'Alice | **25 | Marketing\n',
 'Bob\n7\nSupport\n',
 'Bob | *7 | Support\n',
 'C\n12\nHR\n',
 'C | **12 | HR\n'
),

(24, 2, 'CSV 批量导出', 3,
 '实现“名片批量导出 CSV”：读取 N（第一行），然后读 N 组（姓名、工号、部门），把结果写到 cards.csv（UTF-8），列头 name,id,dept，并在终端打印 Exported N cards to cards.csv。',
 JSON_ARRAY(
  '提示1：使用 csv 模块写入并先写 header。',
  '提示2：写入前可对工号做规范化（如补零或掩码）。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 '2\nTom\n1\nOps\nJerry\n12\nSupport\n',
 'Exported 2 cards to cards.csv\n',
 '1\nA\n123\nX\n',
 'Exported 1 cards to cards.csv\n',
 '3\nU\n1\nA\nV\n22\nB\nW\n333\nC\n',
 'Exported 3 cards to cards.csv\n'
),

(25, 2, '多语言名片存到剪贴板文件', 3,
 '实现“名片模板与多语言导出（写入 clipboard.txt）”：读三行并读语言，将渲染结果写入 clipboard.txt，并输出 Ready to paste.',
 JSON_ARRAY(
  '提示1：选模板后用 with open("clipboard.txt","w",encoding="utf-8") 写入。',
  '提示2：最后打印 Ready to paste. 作为确认。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Lena\n77\nHR\ncn\n',
 'Ready to paste.\n',
 'J\n12\nOps\nen\n',
 'Ready to paste.\n',
 'A\n1\nX\ncn\n',
 'Ready to paste.\n'
),

(29, 2, '导出并掩码名片（csv/txt/show）', 3,
 '实现“可选导出与掩码名片”：读三行（姓名、工号、部门），再读一行命令：export csv / export txt / show；根据命令执行对应导出（写入相应文件或终端打印），工号要掩码（仅保留后两位）。执行后打印 Done.',
 JSON_ARRAY(
  '提示1：解析最后一行命令并做分支处理。',
  '提示2：掩码用 "*"*(len(id)-2) + id[-2:]，CSV 用 csv.writer。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Mia\n3456\nDesign\nexport csv\n',
 'Done.\n',
 'Z\n12\nQA\nshow\n',
 'Done.\n',
 'Tom\n7\nOps\nexport txt\n',
 'Done.\n'
),

(30, 2, '交互式名片管理小工具（单次运行）', 3,
 '实现交互式小工具（单次运行）：先读三行（姓名、工号、部门），然后循环读命令直到 quit：save（追加到 cards.csv，若文件不存在先写列头）、mask（打印掩码后的单行名片）、show（打印多行名片）、quit（退出）。每次命令后打印确认。',
 JSON_ARRAY(
  '提示1：使用 while True 读取命令并用 if/elif 分支处理。',
  '提示2：save 时检查文件是否存在或在首次写入时写 header。'
 ),
 JSON_ARRAY('/library','/library','/library'),
 'Oscar\n99\nQA\nmask\nsave\nquit\n',
 'Masked: Oscar | **99 | QA\nSaved.\n',
 'Amy\n1\nOps\nshow\nquit\n',
 'Name: Amy\nID: 000001\nDept: Ops\n',
 'Z\n123\nR&D\nsave\nquit\n',
 'Saved.\n'
);
-- Unit 3: 选择题 (unit_id = 3)
INSERT INTO questions_py (q_id, unit_id, title, energy, question_text, options, answer, hints, explanation, example) VALUES
(1, 3, '读取总额与人数的写法', 2,
 '晚饭结账脚本里，读取总额与人数的最直接 Python 写法是？（每个输入占一行）',
 JSON_ARRAY('total = input(); people = input()','total, people = input()','total = int(input()) people = int(input())','read(total, people)'),
 2,
 JSON_ARRAY('提示1：input() 每次读取一行字符串。','提示2：要把数作为数字使用需要转换类型。','提示3：C 最接近正确，但两条语句需换行或分号，且要用 int()/float() 转换。'),
 '要做算术运算需把字符串转换为数值：使用 int() 或 float()。',
 'total = float(input())\npeople = int(input())'
),
(2, 3, '将金额字符串转为浮点数', 2,
 '如果用户输入是 12.50 表示金额，下面哪个函数能把该字符串转换为浮点数？',
 JSON_ARRAY('int(\"12.50\")','float(\"12.50\")','str(\"12.50\")','decimal(\"12.50\")'),
 1,
 JSON_ARRAY('提示1：字符串中含小数点，用 float 转换。','提示2：int() 无法解析含小数点的字符串。','提示3：选 B：float(\"12.50\")。'),
 '带小数的数字应使用 float() 进行转换。',
 'value = float(\"12.50\")\nprint(type(value))  # <class \'float\'>'
),
(3, 3, '处理输入两侧空格', 2,
 '当你用 input() 读取人数（期望为整数）时，哪种做法更健壮以处理用户偶然输入空格？（变量 s）',
 JSON_ARRAY('n = int(s)','n = int(s.strip())','n = int(s.replace(\" \", \"\"))','n = s'),
 1,
 JSON_ARRAY('提示1：先去掉首尾空白是常用做法。','提示2：strip() 只去掉首尾空白，不会破坏内部数字。','提示3：选 B：int(s.strip())。'),
 '使用 s.strip() 去除首尾空白后再 int() 转换更安全。',
 's = \" 3 \"\nn = int(s.strip())\nprint(n)  # 3'
),
(6, 3, 'round 四舍五入示例', 2,
 '若总额是 100，参与人数 3，使用 round(100/3, 2) 的结果是？',
 JSON_ARRAY('33.33','33.34','33.3333','抛出异常'),
 0,
 JSON_ARRAY('提示1：看第三位小数判断四舍五入。','提示2：100/3 ≈ 33.3333… 第三位为 3。','提示3：第三位小于 5，round(...,2) 得 33.33。'),
 'round(100/3,2) 会返回 33.33，因为四舍五入查看第三位小数。',
 'print(round(100/3,2))  # 33.33'
),
(7, 3, '向上取整函数', 2,
 '下面哪个表达式可以计算“每人应该付的整数元（向上取整）”？',
 JSON_ARRAY('math.ceil(total/people)','round(total/people)','int(total/people)','total//people'),
 0,
 JSON_ARRAY('提示1：向上取整通常使用 math.ceil。','提示2：int() 与 // 是向下截断。','提示3：选 A (需 import math)。'),
 '向上取整应使用 math.ceil(total/people)（需 import math）。',
 'import math\nprint(math.ceil(10/3))  # 4'
),
(8, 3, '计算多付/少付的差值', 2,
 '如果想确定每人支付后“多付/少付”的量（用四舍五入后的每人份与真实平均的差），哪步是正确的？',
 JSON_ARRAY('paid = round(avg,2); diff = paid - avg','paid = int(avg); diff = avg - paid','diff = round(avg,2)','diff = avg'),
 0,
 JSON_ARRAY('提示1：先确定四舍五入后的 paid，再求差。','提示2：差值应该是 paid - avg。','提示3：选 A。'),
 '先用 paid = round(avg,2) 得到实际支付，再 diff = paid - avg 得到多付/少付。',
 'avg = 100/3\npaid = round(avg,2)\ndiff = paid - avg\nprint(paid, diff)'
),
(11, 3, 'f-string 拼接文件名与金额', 2,
 '当你从命令行读取小票文件名并想把它和每人金额关联为 receipt.jpg -> 100.00，哪种写法更直观？',
 JSON_ARRAY('f\"{fname} -> {total:.2f}\"','fname + \" -> \" + total','\"%s -> %s\" % (fname, total)','print(fname, \"->\", total)'),
 0,
 JSON_ARRAY('提示1：格式化可控制数字小数位。','提示2：拼接数字需 str() 转换。','提示3：选 A：f-string 最直观且可控制格式。'),
 '用 f-string 可以同时控制字符串与数字格式例如 f\"{fname} -> {total:.2f}\"。',
 'fname = \"r.jpg\" \ntotal = 100\nprint(f\"{fname} -> {total:.2f}\")'
),
(12, 3, 'float 解析整数或小数', 2,
 '若用户可能输入 100 或 100.0，两者都能被正确解析为浮点数的写法是？',
 JSON_ARRAY('total = float(input().strip())','total = int(input())','total = input()','total = eval(input())'),
 0,
 JSON_ARRAY('提示1：float 能解析整数和带小数的字符串。','提示2：int 在遇到 100.0 会报错。','提示3：选 A。'),
 '使用 float(input().strip()) 可以兼容 100 和 100.0 两种输入形式。',
 's = \" 100 \"\ntotal = float(s.strip())\nprint(total)'
),
(13, 3, '货币符号前缀格式化', 2,
 '如果想把每人金额显示为货币形式，例如 ¥33.33，下列 f-string 哪个合适？',
 JSON_ARRAY('f\"¥{paid}\"','f\"¥{paid:.2f}\"','f\"{paid:.2f}¥\"','f\"¥{paid:.02f}\"'),
 1,
 JSON_ARRAY('提示1：需保留两位小数并在前加符号。','提示2：格式说明符应为 :.2f。','提示3：选 B（f\"¥{paid:.2f}\")。'),
 '用 f\"¥{paid:.2f}\" 可以把数值格式化为两位小数并在前面加人民币符号。',
 'paid = 33.333\nprint(f\"¥{paid:.2f}\")  # ¥33.33'
),
(16, 3, '分配余数策略思路', 2,
 '如果想把多出的分配给前几个人（例如剩余 1 分给第一个人），哪种实现思路正确？',
 JSON_ARRAY('计算 base = floor(avg*100)/100，然后把余数依次 +0.01 给前 k 人','用 round(avg,2) 给所有人相同金额','随机给一个人多付','使用 total//people'),
 0,
 JSON_ARRAY('提示1：需先得到基础每人分为向下截断到分的值。','提示2：再把余数依次分配给前几人。','提示3：选 A。'),
 '常用策略：把金额转为分做整数运算，然后把余数依次加给前几个人。',
 'cents = int(total*100)\nbase = cents // people\nrem = cents % people'
),
(17, 3, '避免浮点误差的做法', 2,
 '为避免浮点误差更稳妥的做法是？',
 JSON_ARRAY('使用 decimal.Decimal 或把金额转为整数分再运算','直接使用 float 并 round 多次','使用字符串处理金额','使用 complex 类型'),
 0,
 JSON_ARRAY('提示1：财务计算应避免浮点累积误差。','提示2：把金额转为分（整数）或用 Decimal 更安全。','提示3：选 A。'),
 '把金额转为以分为单位的整数或使用 decimal.Decimal 可避免浮点误差。',
 'cents = int(round(total * 100))'
),
(18, 3, '转换为整数分的安全方法', 2,
 '下面哪个表达式将 total（浮点）转换为 cents（整数分）更保险？',
 JSON_ARRAY('cents = int(total * 100)','cents = round(total*100)','cents = int(round(total*100))','以上都可'),
 2,
 JSON_ARRAY('提示1：直接 int() 会截断可能造成误差。','提示2：先 round 再 int 更能避免 0.99999 问题。','提示3：选 C（先 round 再 int）。'),
 '先用 round(total*100) 再 int() 可以减少因浮点表示带来的边界误差。',
 'cents = int(round(total * 100))'
),
(21, 3, '总和校验的稳妥做法', 2,
 '如果你想在输出时同时打印“每人金额”和“总和校验”，哪种做法更稳妥？',
 JSON_ARRAY('把 paid_list 的浮点相加得到总和并格式化','把 paid_cents（整数分）相加再除以 100 格式化输出','只打印用户输入的总额，不做校验','用 sum(map(str, paid_list))'),
 1,
 JSON_ARRAY('提示1：浮点相加会有微小误差。','提示2：整数分相加再除以 100 更精确。','提示3：选 B。'),
 '先把每人金额以分为单位求和再转换为元格式化输出可以避免浮点误差。',
 'total_check = sum(paid_cents) / 100\nprint(f\"Total check: {total_check:.2f}\")'
),
(22, 3, '人数有效性检查', 2,
 '若希望人数不是正整数时提示错误并退出，哪种检查更可靠？',
 JSON_ARRAY('if people <= 0 or not str(people).isdigit():','try: p = int(input().strip()); if p<=0: error','if float(people) != int(people): error','以上都可'),
 1,
 JSON_ARRAY('提示1：先尝试 int() 并捕获异常是常用做法。','提示2：isdigit() 在带符号或空格情况下不可靠。','提示3：选 B（try/except 并检查 p>0）。'),
 '用 try/except 把输入转换为 int 并判断 p>0 是直接可靠的方法。',
 'try:\n  p = int(input().strip())\n  if p <= 0:\n    print(\"Invalid number of people\")\nexcept:\n  print(\"Invalid number\")'
),
(23, 3, '处理千位分隔符', 2,
 '若想支持带千位分隔符的输入（如 1,200.50），哪种预处理更合适？',
 JSON_ARRAY('s.replace(\',\', \"\") 后再 float(s)','直接 float(\"1,200.50\")','使用 locale 自动解析','报错不支持'),
 0,
 JSON_ARRAY('提示1：float 不接受带逗号的数字字面量。','提示2：最简单的做法是先去掉逗号再转换。','提示3：选 A（先 replace）。'),
 '将输入字符串中的逗号去掉再使用 float() 转换是常见做法。',
 's = \"1,200.50\"\nvalue = float(s.replace(\",\", \"\"))\nprint(value)'
),
(26, 3, '货币字段灵活处理', 2,
 '若想支持不同货币符号（不硬编码），哪种做法更灵活？',
 JSON_ARRAY('硬编码 ¥ 在所有输出中','读入一个 currency 字段然后在格式化时使用它','在输出前用正则替换所有数字前加 ¥','忽略货币，只显示数字'),
 1,
 JSON_ARRAY('提示1：硬编码无法支持多货币。','提示2：读入 currency 并在输出时用占位符更灵活。','提示3：选 B。'),
 '读入 currency 并在输出时使用 f\"{currency}{value:.2f}\" 可以支持多种货币符号。',
 'currency = input().strip()\nprint(f\"{currency}{value:.2f}\")'
),
(27, 3, '保存记录的最佳实践', 2,
 '当实现保存记录为 CSV（fields: date, receipt, total, people, paid_list）时，哪种写法更规范？',
 JSON_ARRAY('手工拼接字符串 line = date + \",\" + ...','使用 csv.writer 并 writerow([...])','把字典的 str() 写入文件','把所有写成一个大 JSON 字符串写入文件'),
 1,
 JSON_ARRAY('提示1：CSV 写入要处理逗号与引号的转义。','提示2：csv 模块能自动处理转义与引用。','提示3：选 B（csv.writer 更规范）。'),
 '使用 csv.writer 能自动处理字段中的逗号、引号等特殊字符，写入更规范。',
 'import csv\nwith open(\"records.csv\",\"a\",encoding=\"utf-8\") as f:\n  csv.writer(f).writerow([date,receipt,total,people,str(paid_list)])'
),
(28, 3, '命令行参数解析库', 2,
 '若想支持命令行参数 --total 100 --people 3 --receipt r.jpg，应该使用哪个库来解析？',
 JSON_ARRAY('sys.argv 手工解析','argparse 标准库','optparse（已废弃）','getopt'),
 1,
 JSON_ARRAY('提示1：argparse 是标准且功能完整的选项解析库。','提示2：sys.argv 可行但需手动解析。','提示3：选 B（argparse）。'),
 'argparse 能自动生成帮助信息并解析类型，适合构建 CLI 工具。',
 'import argparse\nparser=argparse.ArgumentParser()'
);

-- Unit 4: 选择题 (unit_id = 4)
INSERT INTO questions_py (q_id, unit_id, title, energy, question_text, options, answer, hints, explanation, example) VALUES
(1, 4, '读取原价与折扣的写法', 2,
 '折扣计算器中，读取原价与折扣率的最直接写法是哪种？（每项一行）',
 JSON_ARRAY('price = input(); disc = input()','price, disc = input()','price = float(input()); disc = float(input())','price = int(input()); disc = int(input())'),
 2,
 JSON_ARRAY('提示1：折扣可能为小数，比如 12.5%。','提示2：要进行算术运算需把字符串转为数值。','提示3：选 C（使用 float）。'),
 '使用 float 能同时处理整数和小数输入，适合价格和折扣率。',
 'price = float(input())\ndisc = float(input())'
),
(2, 4, '折后价公式', 2,
 '如果用户输入折扣为 20 表示 20%，计算折后价的公式是哪一个？',
 JSON_ARRAY('price * (100 - 20)','price * (1 - 20)','price * (1 - 20/100)','price - 20'),
 2,
 JSON_ARRAY('提示1：折扣 20% 应换算为 0.2。','提示2：1 - 0.2 是折后系数。','提示3：选 C（price * (1 - disc/100)）。'),
 '折后价 = price * (1 - disc/100)。',
 'price = 100\ndisc = 20\nfinal = price * (1 - disc/100)\nprint(final)'
),
(3, 4, '处理带%的折扣输入', 2,
 '若用户可能输入 20%（含百分号），下列哪种预处理可以把它转换为数值 20？（变量 s）',
 JSON_ARRAY('s = s.strip(\'%\')','s = s.replace(\'%\', \'\')','s = float(s.strip(\'%\'))','以上都需配合 float 转换，但哪步是必要的？'),
 2,
 JSON_ARRAY('提示1：需要先去掉 % 再转换为数值。','提示2：strip 与 replace 都能去掉 %。','提示3：选 D（先去 % 再 float；C 是一步完成的写法）。'),
 '去掉百分号后再 float(s) 或直接用 float(s.strip(\'%\')) 都可得到数值。',
 's = \"20%\"\nprint(float(s.strip(\"%\")))'
),
(6, 4, '折后价与预算比较', 2,
 '若想判断折后价是否低于预算（budget），下面哪种比较写法正确？',
 JSON_ARRAY('if final < budget:','if final <= budget:','if final == budget:','if budget < final:'),
 0,
 JSON_ARRAY('提示1：题目问“低于预算”通常指严格小于。','提示2：<= 包含相等情形。','提示3：选 A。'),
 '“低于预算”直接使用 final < budget 判断。',
 'if final < budget:\n  print(\"Buy\")'
),
(7, 4, '边界相等时的建议', 2,
 '若 final 与 budget 相等，你会给出哪个建议更合理？',
 JSON_ARRAY('Buy',"Don't buy",'Wait','Ask for coupon'),
 0,
 JSON_ARRAY('提示1：价格等于预算通常可认为符合预算。','提示2：实际建议受产品价值影响，但简化规则常建议购买。','提示3：选 A（Buy）。'),
 '当 final == budget 时，简单规则下视为可购买。',
 'final = budget\nprint(\"Buy\")'
),
(8, 4, '0% 折扣的结果', 2,
 '如果折扣为 0（0%），下列哪项是正确的 final 计算结果？',
 JSON_ARRAY('final = price','final = 0','final = price * 0','final = price * 100'),
 0,
 JSON_ARRAY('提示1：0% 表示不打折。','提示2：final 应该等于原价。','提示3：选 A（final = price）。'),
 '0% 折扣即无折扣，折后价等于原价。',
 'price = 50\nprint(price)'
),
(11, 4, '显示节省金额的格式', 2,
 '若要显示“你节省了多少”（savings = price - final），哪个输出比较合适？',
 JSON_ARRAY('print(\"Saved:\", price - final)','print(f\"Saved: {price - final:.2f}\")','print(\"Saved: \" + price - final)','print(\"Saved: \" + str(price - final) + \"¥\")'),
 1,
 JSON_ARRAY('提示1：用户喜爱带两位小数的货币格式。','提示2：f-string 便于格式化。','提示3：选 B（保留两位小数）。'),
 '用 f\"Saved: {price - final:.2f}\" 可以清晰显示节省金额并保留两位小数。',
 'price = 100\nfinal = 80\nprint(f\"Saved: {price - final:.2f}\")'
),
(12, 4, '100% 折扣的结果', 2,
 '如果折扣率为 100，折后价应该是多少？',
 JSON_ARRAY('0','price','price * 100','抛出异常'),
 0,
 JSON_ARRAY('提示1：100% 表示免费。','提示2：final = price * (1 - 1) = 0。','提示3：选 A。'),
 '100% 折扣意味着折后价为 0。',
 'price = 100\nprint(price * (1 - 100/100))  # 0'
),
(13, 4, '去除货币符号再转换', 2,
 '若用户输入原价为字符串带货币符号 ¥100，下列哪种预处理能把它解析为数值？',
 JSON_ARRAY('s = s.replace(\"¥\", \"\") 再 float(s)','float(s)','s.isdigit()','int(s)'),
 0,
 JSON_ARRAY('提示1：带货币符号需要先去掉再转换。','提示2：直接 float(\"¥100\") 会失败。','提示3：选 A（先 replace 再 float）。'),
 '先用 s = s.replace(\"¥\", \"\") 然后 float(s) 来解析带货币符号的输入。',
 's = \"¥100\"\nprint(float(s.replace(\"¥\", \"\")))'
),
(16, 4, '比较时避免浮点误差', 2,
 '在比较 final 与 budget 时，为避免浮点精度问题，哪种做法最稳妥？',
 JSON_ARRAY('直接用 final < budget 比较','把 final 与 budget 都四舍五入到两位再比较','把 final 与 budget 转为 cents 再比较','用字符串比较'),
 2,
 JSON_ARRAY('提示1：浮点比较可能存在微小误差。','提示2：转为整数分单位比较更可靠。','提示3：选 C（转为 cents 再比较）。'),
 '将金额转为分（整数）后比较可以避免浮点精度问题。',
 'a = int(round(final*100))\nb = int(round(budget*100))\nprint(a < b)'
),
(17, 4, '完整的非法输入检测', 2,
 '若希望对输入做严格检测，下列哪项应当包含在检测列表内？',
 JSON_ARRAY('disc < 0','disc > 100','price <= 0','上述所有项都应检测'),
 3,
 JSON_ARRAY('提示1：负折扣或大于 100% 都是非法。','提示2：price <= 0 也应视为非法输入。','提示3：选 D：应检查所有这些。'),
 '对输入进行完整验证（disc<0 或 >100，price<=0）可以避免异常和错误判断。',
 'if disc < 0 or disc > 100 or price <= 0:\n  print(\"Invalid input\")'
),
(18, 4, '统一处理 0.2 与 20 的折扣表示', 2,
 '若希望支持折扣输入 0.2（表示 20%）或 20（表示 20%），下面哪种写法能统一处理？',
 JSON_ARRAY('d = float(d_str); if d<=1: d = d*100','d = float(d_str); if d<1: d = d*100','d = float(d_str)*100','d = float(d_str)/100'),
 1,
 JSON_ARRAY('提示1：当输入 0.2 时 d<1，应把它乘 100。','提示2：判断应该用 < 1 而非 <= 1 以避免把 1 误判。','提示3：选 B（先 float，再 if d < 1 则乘以 100）。'),
 '先 float(d_str)，若 d < 1 则乘以 100 可以兼容 0.2 与 20 两种表示。',
 'd_str = \"0.2\"\nd = float(d_str)\nif d < 1:\n  d *= 100\nprint(d)'
),
(21, 4, '处理 price 为 0 的 savings', 2,
 '若要计算节省百分比 savings_pct = (price-final)/price*100，price 为 0 时该如何处理？',
 JSON_ARRAY('savings_pct 为 0','抛出除零错误','将 savings_pct 设置为 100','跳过计算并提示 Invalid price'),
 3,
 JSON_ARRAY('提示1：除以 0 会产生异常。','提示2：应在计算前检查 price>0。','提示3：选 D（提示输入无效）。'),
 '遇到 price == 0 时应先检测并提示错误，避免除零。',
 'if price <= 0:\n  print(\"Invalid price\")'
),
(22, 4, '导出日志的安全做法', 2,
 '若要把结果导出成可读日志（每行 price,discount,final,advice），哪种方法最安全？',
 JSON_ARRAY('手工用逗号拼接字符串','使用 csv.writer 写入','使用 print 打印并重定向到文件','把所有字段 join(\',\')'),
 1,
 JSON_ARRAY('提示1：手工拼接可能在字段包含逗号时出错。','提示2：csv 模块会处理转义和引号。','提示3：选 B（使用 csv.writer）。'),
 '使用 csv.writer 写入可自动处理字段中的逗号与引号，保证 CSV 格式正确。',
 'import csv\nwith open(\"log.csv\",\"a\",encoding=\"utf-8\") as f:\n  csv.writer(f).writerow([price,disc,final,advice])'
),
(23, 4, '寻找最小折扣的算法', 2,
 '若要寻找最小折扣使 final <= budget，哪种算法更合适？',
 JSON_ARRAY('从 0 到 100 每 0.1% 递增测试','用二分查找在 0~100 范围内查找','随机尝试一些折扣值','手工估算'),
 1,
 JSON_ARRAY('提示1：这是单调函数问题，二分查找效率高。','提示2：从 0 到 100 顺序搜索较慢。','提示3：选 B（二分查找）。'),
 '对单调可比函数使用二分查找能快速找到满足条件的最小折扣。',
 'low,high = 0,100\nwhile high-low>eps:\n  mid=(low+high)/2\n  ...'
),
(26, 4, '记录历史写文件的好习惯', 2,
 '若要把尝试过的折扣写入 history.txt，每行 timestamp,price,discount,final，写入时的良好实践是哪项？',
 JSON_ARRAY('每次以 a 模式追加并指定 encoding','每次覆盖写入 w 模式','把所有历史存在内存退出时一次写入','不需要写入文件'),
 0,
 JSON_ARRAY('提示1：追加写入比覆盖更安全。','提示2：指定 encoding=\'utf-8\' 可跨平台。','提示3：选 A（with open(...,\'a\',encoding=\'utf-8\')）。'),
 '使用 with open(...,\'a\',encoding=\'utf-8\') 可追加写入并保证编码一致。',
 'with open(\"history.txt\",\"a\",encoding=\"utf-8\") as f:\n  f.write(line+\"\\n\")'
),
(27, 4, '显示节省百分比保留一位', 2,
 '若要显示节省百分比并保留一位小数，下面哪个格式化最合适（pct=12.345）？',
 JSON_ARRAY('f\"{pct:.1f}%\"','f\"{pct:.01f}%\"','f\"{pct:.0f}%\"','str(pct) + \"%\"'),
 0,
 JSON_ARRAY('提示1：.1f 表示保留一位小数。','提示2：.01f 是错误写法，.0f 表示取整。','提示3：选 A（f\"{pct:.1f}%\"）。'),
 '用 f\"{pct:.1f}%\" 可以把数值格式化为保留一位小数的百分比字符串。',
 'pct = 12.345\nprint(f\"{pct:.1f}%\")  # 12.3%'
),
(28, 4, '性能优先的做法', 2,
 '在寻找最小折扣功能中，为保证速度应优先考虑？',
 JSON_ARRAY('使用浮点运算并减少格式化开销','每次都把结果格式化为字符串再比较','在循环内频繁写入磁盘','使用字符串操作替代数值比较'),
 0,
 JSON_ARRAY('提示1：字符串格式化和 IO 会影响性能。','提示2：数值比较更高效且直接。','提示3：选 A。'),
 '在循环算法中尽量减少格式化与 IO，专注数值计算以提高性能。',
 '# 在循环内只做数值比较，最后再格式化输出'
);
-- Unit 3: 实操题 (unit_id = 3)
INSERT INTO questions_py_exec
(q_id, unit_id, title, energy, question_text, hints, link, eg_in1, eg_out1, eg_in2, eg_out2, eg_in3, eg_out3) VALUES
(4, 3, '每人平均不四舍五入金额', 3,
 '写脚本：读取两行输入，第一行为总额（可含小数），第二行为人数（整数）。计算每人平均（不四舍五入）并打印 Each: <两位小数>。',
 JSON_ARRAY('提示1：用 float() 和 int() 分别读取并转换。','提示2：用 f\"{value:.2f}\" 保留两位小数。'),
 JSON_ARRAY('/library','/library','/library'),
 '100.00\n3\n',
 'Each: 33.33\n',
 '50\n2\n',
 'Each: 25.00\n',
 '9.9\n3\n',
 'Each: 3.30\n'
),
(5, 3, '人数为0 的校验', 3,
 '改写上题：如果人数为 0 输出 Invalid number of people；否则打印 Each: <两位小数>。',
 JSON_ARRAY('提示1：先把人数转换为 int。','提示2：若为 0 则打印错误信息并结束。'),
 JSON_ARRAY('/library','/library','/library'),
 '50.0\n0\n',
 'Invalid number of people\n',
 '100\n1\n',
 'Each: 100.00\n',
 '10\n2\n',
 'Each: 5.00\n'
),
(9, 3, '每人金额与差值 diff', 3,
 '实现脚本：读两行（总额，人数），输出 Each: <两位> 和 Diff: <两位>，其中 paid = round(avg,2)，diff = paid - avg。',
 JSON_ARRAY('提示1：先计算 avg = total/people，再 paid = round(avg,2)。','提示2：diff = paid - avg，格式化两位。'),
 JSON_ARRAY('/library','/library','/library'),
 '100\n3\n',
 'Each: 33.33\nDiff: -0.00\n',
 '10\n4\n',
 'Each: 2.50\nDiff: 0.00\n',
 '9.99\n2\n',
 'Each: 4.99\nDiff: -0.00\n'
),
(10, 3, '判断是否需要人工调整', 3,
 '在上题基础上：若 abs(diff) >= 0.01，打印第三行 Adjust: Yes，否则 Adjust: No。',
 JSON_ARRAY('提示1：用 abs(diff) 判断绝对值。','提示2：注意 diff 可能为负数。'),
 JSON_ARRAY('/library','/library','/library'),
 '100\n6\n',
 'Each: 16.67\nDiff: 0.01\nAdjust: Yes\n',
 '100\n3\n',
 'Each: 33.33\nDiff: -0.00\nAdjust: No\n',
 '50\n7\n',
 'Each: 7.14\nDiff: -0.00\nAdjust: No\n'
),
(14, 3, 'AA 并保存记录（显示 receipt）', 3,
 '实现脚本：读取三行——总额、人数、小票文件名；输出 Each: <两位> 和 Receipt: <file> -> <每人两位>。',
 JSON_ARRAY('提示1：total 用 float()，people 用 int()，receipt 为字符串。','提示2：每人金额保留两位，使用 f-string 拼接。'),
 JSON_ARRAY('/library','/library','/library'),
 '120.5\n4\ndinner1.jpg\n',
 'Each: 30.12\nReceipt: dinner1.jpg -> 30.12\n',
 '100\n2\nr.png\n',
 'Each: 50.00\nReceipt: r.png -> 50.00\n',
 '9\n3\nrec.jpg\n',
 'Each: 3.00\nReceipt: rec.jpg -> 3.00\n'
),
(15, 3, '四舍五入导致短缺或多收提示', 3,
 '增强上题：若四舍五入导致总收回少于 total（short>0），打印 Warning: shortage <金额>；若多收则打印 Info: overpay <金额>。',
 JSON_ARRAY('提示1：sum_paid = paid * people，short = total - sum_paid。','提示2：根据 short 正负决定打印 Warning 或 Info，并格式化两位。'),
 JSON_ARRAY('/library','/library','/library'),
 '100\n3\nr1.png\n',
 'Each: 33.33\nReceipt: r1.png -> 33.33\nWarning: shortage 0.01\n',
 '50\n2\nr2.png\n',
 'Each: 25.00\nReceipt: r2.png -> 25.00\nInfo: overpay -0.00\n',
 '10\n3\nr3.jpg\n',
 'Each: 3.33\nReceipt: r3.jpg -> 3.33\nWarning: shortage 0.01\n'
),
(19, 3, '分配余数给前 k 人', 3,
 '实现脚本：读取三行（总额、人数、策略 left/cycle），把金额转为分并把余数按策略分配，输出每人付费 Person i: <两位>。',
 JSON_ARRAY('提示1：把 total 转为 cents（int(round(total*100)))。','提示2：left 将余数全部加给第一个人，cycle 依次分配。'),
 JSON_ARRAY('/library','/library','/library'),
 '100\n3\nleft\n',
 'Person 1: 33.34\nPerson 2: 33.33\nPerson 3: 33.33\n',
 '100\n3\ncycle\n',
 'Person 1: 33.34\nPerson 2: 33.33\nPerson 3: 33.33\n',
 '10\n4\ncycle\n',
 'Person 1: 2.50\nPerson 2: 2.50\nPerson 3: 2.50\nPerson 4: 2.50\n'
),
(20, 3, '文件关联并打印 Saved 行', 3,
 '实现含文件关联的脚本：读取三行（总额、人数、receipt），按 cent 精度计算并输出每人付款，最后打印 Saved: <receipt> -> <N> persons recorded。',
 JSON_ARRAY('提示1：最后一行拼接文件名与人数输出即可模拟保存。','提示2：注意循环或策略分配余数时人数可能大于余数数。'),
 JSON_ARRAY('/library','/library','/library'),
 '120.50\n4\nshop123.jpg\n',
 'Person 1: 30.13\nPerson 2: 30.12\nPerson 3: 30.12\nPerson 4: 30.13\nSaved: shop123.jpg -> 4 persons recorded\n',
 '10\n3\nr.jpg\n',
 'Person 1: 3.34\nPerson 2: 3.33\nPerson 3: 3.33\nSaved: r.jpg -> 3 persons recorded\n',
 '9.9\n2\ns.jpg\n',
 'Person 1: 4.95\nPerson 2: 4.95\nSaved: s.jpg -> 2 persons recorded\n'
),
(24, 3, '智能 AA：支持千位逗号', 3,
 '实现智能 AA 脚本：读取三行（total 支持千位逗号，people，receipt），解析并按 cent 精度分配，输出每人付款并 Total check: <总额去逗号格式>。',
 JSON_ARRAY('提示1：先 s = s.replace(\',\', \"\") 再 float(s)。','提示2：用 cents 分配并用整数和验证总和后格式化输出。'),
 JSON_ARRAY('/library','/library','/library'),
 '1,200.50\n5\ndinnerA.jpg\n',
 'Person 1: 240.10\nPerson 2: 240.10\nPerson 3: 240.10\nPerson 4: 240.10\nPerson 5: 240.10\nTotal check: 1200.50\n',
 '1000\n4\nr.jpg\n',
 'Person 1: 250.00\nPerson 2: 250.00\nPerson 3: 250.00\nPerson 4: 250.00\nTotal check: 1000.00\n',
 '9,999.99\n3\nx.jpg\n',
 'Person 1: 3333.33\nPerson 2: 3333.33\nPerson 3: 3333.33\nTotal check: 9999.99\n'
),
(25, 3, '循环分配余数并 Saved', 3,
 '实现多人轮流多收策略：读取三行（total, people, receipt），按分为单位 base = cents//people，rem = cents%people，余数依序循环分配，输出每人付款并打印 Saved: <receipt>。',
 JSON_ARRAY('提示1：base = cents // people，rem = cents % people。','提示2：通过循环把余数依次 +1 到前 rem 个人。'),
 JSON_ARRAY('/library','/library','/library'),
 '10\n3\nt.jpg\n',
 'Person 1: 3.34\nPerson 2: 3.33\nPerson 3: 3.33\nSaved: t.jpg\n',
 '100\n6\nr.png\n',
 'Person 1: 16.67\nPerson 2: 16.67\nPerson 3: 16.67\nPerson 4: 16.67\nPerson 5: 16.66\nPerson 6: 16.66\nSaved: r.png\n',
 '9\n4\ns.jpg\n',
 'Person 1: 2.25\nPerson 2: 2.25\nPerson 3: 2.25\nPerson 4: 2.25\nSaved: s.jpg\n'
),
(29, 3, 'AA CLI 支持命令行或交互式', 3,
 '实现最小版 AA CLI：如果首行以 -- 开头按命令行参数解析，否则按交互式三行读取，最终输出每人付款并打印 Saved: <receipt>。',
 JSON_ARRAY('提示1：检查第一行是否以 \"--\" 开头决定解析方式。','提示2：命令行样式可简单拆分 \"--key=value\" 并解析值。'),
 JSON_ARRAY('/library','/library','/library'),
 '120\n4\nr.jpg\n',
 'Person 1: 30.00\nPerson 2: 30.00\nPerson 3: 30.00\nPerson 4: 30.00\nSaved: r.jpg\n',
 '--total=100 --people=3 --receipt=a.jpg\n',
 'Person 1: 33.34\nPerson 2: 33.33\nPerson 3: 33.33\nSaved: a.jpg\n',
 '--total=9.9 --people=2 --receipt=x.png\n',
 'Person 1: 4.95\nPerson 2: 4.95\nSaved: x.png\n'
),
(30, 3, 'aa_tool.py 核心逻辑（终极）', 3,
 '实现 aa_tool.py：支持命令行或交互式输入，解析 total 支持千位逗号、people、receipt、strategy（left/cycle，默认 cycle），以 cents 精度分配并写入 records.csv（可模拟写入），最后打印 Recorded: <receipt> (<N> people)。',
 JSON_ARRAY('提示1：把金额转为 cents 做整数分配，strategy 控制余数分配。','提示2：保存时把 paid_list 格式化为可读字符串并写 CSV（可模拟）。'),
 JSON_ARRAY('/library','/library','/library'),
 '--total=100 --people=3 --receipt=r.jpg --strategy=left\n',
 'Person 1: 33.34\nPerson 2: 33.33\nPerson 3: 33.33\nRecorded: r.jpg (3 people)\n',
 '120.50\n4\nshop.jpg\n',
 'Person 1: 30.13\nPerson 2: 30.12\nPerson 3: 30.12\nPerson 4: 30.13\nRecorded: shop.jpg (4 people)\n',
 '1,200.00\n5\nd.jpg\n',
 'Person 1: 240.00\nPerson 2: 240.00\nPerson 3: 240.00\nPerson 4: 240.00\nPerson 5: 240.00\nRecorded: d.jpg (5 people)\n'
);

-- Unit 4: 实操题 (unit_id = 4)
INSERT INTO questions_py_exec
(q_id, unit_id, title, energy, question_text, hints, link, eg_in1, eg_out1, eg_in2, eg_out2, eg_in3, eg_out3) VALUES
(4, 4, '计算折后价并输出 Final', 3,
 '写脚本：读取三行（原价、折扣率（如 20 表示 20%）、预算），输出一行 Final: <两位小数>（只计算折后价）。',
 JSON_ARRAY('提示1：final = price * (1 - disc/100)。','提示2：用 f\"{final:.2f}\" 保留两位小数。'),
 JSON_ARRAY('/library','/library','/library'),
 '100\n20\n90\n',
 'Final: 80.00\n',
 '50\n10\n60\n',
 'Final: 45.00\n',
 '9.99\n5\n10\n',
 'Final: 9.49\n'
),
(5, 4, '折扣合法性校验', 3,
 '改写上题：如果折扣率不在 0~100 输出 Invalid discount 并退出；否则输出 Final: <两位>。',
 JSON_ARRAY('提示1：判断 if disc < 0 or disc > 100。','提示2：若非法直接打印错误并结束。'),
 JSON_ARRAY('/library','/library','/library'),
 '100\n-5\n90\n',
 'Invalid discount\n',
 '100\n50\n120\n',
 'Final: 50.00\n',
 '200\n100\n10\n',
 'Final: 0.00\n'
),
(9, 4, "建议器：Buy/Wait/Don't buy", 3,
 "实现建议器：读 price, disc, budget；若折扣非法输出 Invalid discount；否则打印 Final: <两位> 然后建议：Buy（final<=budget）、Wait（final>budget 且 final-budget<=5）、Don't buy（否则）。",
 JSON_ARRAY('提示1：先校验折扣合法性再计算 final。','提示2：比较 final 与 budget 并计算差值决定建议。'),
 JSON_ARRAY('/library','/library','/library'),
 '120\n20\n100\n',
 'Final: 96.00\nBuy\n',
 '120\n10\n110\n',
 'Final: 108.00\nBuy\n',
 '120\n0\n100\n',
 "Final: 120.00\nDon't buy\n"
),
(10, 4, '接受带%的折扣输入', 3,
 '增强上题：折扣可能带有 %（例如 15%），需先去掉 % 再解析并按规则输出 Final 与建议。',
 JSON_ARRAY('提示1：用 disc = disc_str.strip().strip(\"%\") 再 float().','提示2：检测折扣范围时用数值形式判断。'),
 JSON_ARRAY('/library','/library','/library'),
 '120\n15%\n105\n',
 'Final: 102.00\nBuy\n',
 '200\n0%\n150\n',
 "Final: 200.00\nDon't buy\n",
 '100\n0.2\n80\n',
 'Final: 80.00\nBuy\n'
),
(14, 4, '带诊断信息的折扣工具', 3,
 '实现带诊断信息的工具：读 price, disc, budget，校验合法性（price>0,0<=disc<=100,budget>=0），若不合法输出 Invalid input；否则输出 Price:, Discount:, Final:, Advice: 四行（格式见示例）。',
 JSON_ARRAY('提示1：先做输入范围检查。','提示2：discount 显示带 %。'),
 JSON_ARRAY('/library','/library','/library'),
 '200\n50\n120\n',
 'Price: 200.00\nDiscount: 50.00%\nFinal: 100.00\nAdvice: Buy\n',
 '100\n-5\n80\n',
 'Invalid input\n',
 '80\n0\n70\n',
 "Price: 80.00\nDiscount: 0.00%\nFinal: 80.00\nAdvice: Don't buy\n"
),
(15, 4, '折扣为0时给出 Tip', 3,
 '扩展上题：若 discount == 0 且 price > budget，额外打印 Tip: Look for coupons，其他逻辑不变。',
 JSON_ARRAY('提示1：检测 disc == 0 且 price > budget。','提示2：在满足条件时打印额外提示行。'),
 JSON_ARRAY('/library','/library','/library'),
 '80\n0\n70\n',
 "Price: 80.00\nDiscount: 0.00%\nFinal: 80.00\nAdvice: Don't buy\nTip: Look for coupons\n",
 '50\n0\n60\n',
 'Price: 50.00\nDiscount: 0.00%\nFinal: 50.00\nAdvice: Buy\n',
 '100\n10\n95\n',
 'Price: 100.00\nDiscount: 10.00%\nFinal: 90.00\nAdvice: Buy\n'
),
(19, 4, '安全折扣解析器', 3,
 '实现安全折扣解析器：读取 price 和 disc，两种输入 disc 可能为 20、20% 或 0.2 三种格式，解析为百分比数值 0~100，若非法输出 Invalid discount，否则输出 Parsed discount: <两位>。',
 JSON_ARRAY('提示1：先去掉 % 再 float()。','提示2：若值 < 1 则乘以 100，最后检查 0~100。'),
 JSON_ARRAY('/library','/library','/library'),
 '100\n20%\n',
 'Parsed discount: 20.00\n',
 '100\n0.2\n',
 'Parsed discount: 20.00\n',
 '100\n20\n',
 'Parsed discount: 20.00\n'
),
(20, 4, '折扣预算建议器（综合）', 3,
 "实现终极折扣预算建议器：读取 price, disc, budget（支持三种 disc 表示），若非法输出 Saved: Invalid 且 Advice: N/A；否则输出 Final: <两位>, Saved: ok, Advice: <Buy/Wait/Don't buy>。",
 JSON_ARRAY('提示1：先解析 disc 并验证合法性。','提示2：计算 final，保存状态可模拟输出 ok 或 Invalid。'),
 JSON_ARRAY('/library','/library','/library'),
 '150\n0.25\n120\n',
 'Final: 112.50\nSaved: ok\nAdvice: Buy\n',
 '100\n200\n90\n',
 'Final: 0.00\nSaved: Invalid\nAdvice: N/A\n',
 '120\n15%\n100\n',
 'Final: 102.00\nSaved: ok\nAdvice: Buy\n'
),
(24, 4, '用二分法求最小折扣', 3,
 '实现二分查找最小折扣使 final <= budget：读取 price, budget, precision（如 0.1 表示 0.1%），输出 Needed discount: <两位> 或 Impossible。',
 JSON_ARRAY('提示1：折后价为 price*(1-d/100)。','提示2：用二分法在 0~100 搜索，直到区间小于 precision。'),
 JSON_ARRAY('/library','/library','/library'),
 '200\n150\n0.1\n',
 'Needed discount: 25.00\n',
 '100\n50\n0.5\n',
 'Needed discount: 50.00\n',
 '80\n100\n0.1\n',
 'Needed discount: 0.00\n'
),
(25, 4, '折扣对比器：批量输入折扣', 3,
 '实现折扣对比器：读取 price,budget，然后多行折扣直到空行，输出每个折扣的 Final 与 Advice（格式见示例）。',
 JSON_ARRAY('提示1：按行读取直到空行。','提示2：重用折扣解析函数并逐行输出。'),
 JSON_ARRAY('/library','/library','/library'),
 '120\n100\n10%\n15%\n0.25\n\n',
 'Discount 10%: Final 108.00 Advice: Buy\nDiscount 15%: Final 102.00 Advice: Buy\nDiscount 0.25: Final 90.00 Advice: Buy\n',
 '100\n80\n5%\n\n',
 'Discount 5%: Final 95.00 Advice: Buy\n',
 '200\n150\n50%\n60%\n\n',
 'Discount 50%: Final 100.00 Advice: Buy\nDiscount 60%: Final 80.00 Advice: Buy\n'
),
(29, 4, '折扣助手：交互或批量模式', 3,
 '实现折扣助手：支持交互式三行（price,disc,budget）或批量模式（price,budget,随后多行折扣直到空行）。交互式输出 Final 与 Advice，批量逐行输出并最后打印 Done.',
 JSON_ARRAY('提示1：用空行作为批量输入结束标志。','提示2：解析与建议逻辑应复用。'),
 JSON_ARRAY('/library','/library','/library'),
 '120\n100\n10%\n20%\n0.5\n\n',
 'Discount 10%: Final 108.00 Advice: Buy\nDiscount 20%: Final 96.00 Advice: Buy\nDiscount 0.5: Final 60.00 Advice: Buy\nDone.\n',
 '150\n120\n10%\n\n',
 'Discount 10%: Final 135.00 Advice: Buy\nDone.\n',
 '100\n90\n0.2\n\n',
 'Final: 80.00\nAdvice: Buy\n'
),
(30, 4, 'discount_tool.py（终极）', 3,
 '实现 discount_tool.py：支持命令行参数 --price --budget --mode=batch|single --precision，解析各种折扣表示（%,0~1,0~100），mode=single 输出 Final, Saved, Advice；mode=batch 读取 stdin 多折扣并保存历史（模拟），最后打印 Completed。',
 JSON_ARRAY('提示1：使用 argparse 解析命令行参数。','提示2：复用解析逻辑并在保存时模拟写入 history.csv。'),
 JSON_ARRAY('/library','/library','/library'),
 '--price=150 --discount=0.2 --budget=120 --mode=single\n',
 'Final: 120.00\nSaved: ok\nAdvice: Buy\n',
 '--price=120 --budget=100 --mode=batch\n10%\n20%\n\n',
 'Discount 10%: Final 108.00 Advice: Buy\nDiscount 20%: Final 96.00 Advice: Buy\nCompleted.\n',
 '--price=80 --discount=0 --budget=70 --mode=single\n',
 "Final: 80.00\nSaved: ok\nAdvice: Don't buy\n"
);

-- Unit 5 选择题 (q_id 1..30 for unit 5; only choice q's included)
INSERT INTO questions_py
(q_id, unit_id, title, energy, question_text, options, answer, hints, explanation, example) VALUES
(1, 5, '单行注释符号', 2,
 '在 Python 中，写单行注释的正确符号是？',
 JSON_ARRAY('\/\/',' #','/* */','--'),
 1,
 JSON_ARRAY('提示1：许多语言注释符不同。','提示2：Python 使用井号作为单行注释。','提示3：答案是 #。'),
 'Python 使用 # 作为单行注释符。',
 'print(\"# 这是注释\")  # 注释示例'
),
(2, 5, '文件顶部写食材说明', 2,
 '把食材写在脚本顶部作为说明，哪种写法更规范？',
 JSON_ARRAY('在文件顶部用连续的 # 注释列出食材和用量','把说明写在代码内部随意位置','把说明写在版本控制提交里','不写说明，读者自行猜测'),
 0,
 JSON_ARRAY('提示1：让读者第一眼看到配料会更方便。','提示2：文件顶部注释常用来写元信息与说明。','提示3：答案是把说明写在文件顶部的注释中。'),
 '把配料与用量写在文件顶部的注释区，利于阅读与文档化。',
 '# 材料：五花肉 500g\n# 调料：生抽 2 大勺'
),
(3, 5, '注释写在相关代码前', 2,
 '若要在注释里记录“烹饪注意：先小火后大火”，哪种做法最恰当？',
 JSON_ARRAY('把这条写成注释并接在对应步骤前面','把它写成普通代码行','写在文件外纸条上不写脚本','在注释里写一篇长篇故事'),
 0,
 JSON_ARRAY('提示1：注释应紧靠相关代码或步骤。','提示2：把注意事项写在步骤前能提醒读者。','提示3：选 A。'),
 '把注意事项放在对应步骤之前的注释里最有用且易维护。',
 '# 注意：先小火，后大火收汁'
),
(6, 5, 'if 语句结尾符', 2,
 '在 Python 中，if 条件行后面必须以什么符号结尾？',
 JSON_ARRAY(';',':','{','空格'),
 1,
 JSON_ARRAY('提示1：Python 使用缩进表示代码块。','提示2：条件后要有冒号表示块开始。','提示3：选择冒号 :。'),
 'if 条件后需要加冒号 :，并在下一行缩进代码块。',
 'if score >= 8:\n    print(\"推荐\")'
),
(7, 5, '区间判断写法', 2,
 '下面哪种写法可以判断 score 在 5 到 7（含）之间？',
 JSON_ARRAY('if 5 <= score <= 7:','if score >= 5 and score <= 7:','if score in range(5,8):','以上都可以'),
 3,
 JSON_ARRAY('提示1：Python 支持链式比较。','提示2：range(5,8) 表示 5,6,7。','提示3：以上写法均可，因场景可选最合适写法。'),
 'Python 中链式比较或 and 或 range 都可用于区间判断。',
 'score = 6\nif 5 <= score <= 7:\n    print(\"在区间内\")'
),
(8, 5, 'elif 的作用', 2,
 '为什么在多分支判断时常用 elif 而不是多个独立 if？',
 JSON_ARRAY('elif 保证互斥，避免多个分支同时执行','没有区别，顺序随意','if 比 elif 更快','elif 能替代所有循环'),
 0,
 JSON_ARRAY('提示1：if/elif/else 是顺序检测的。','提示2：若用独立 if 多个条件都满足会多次执行。','提示3：使用 elif 可以保证互斥执行。'),
 'elif 可确保一旦某分支被选中，后续分支不会再被执行，避免重复逻辑。',
 'if score >= 8:\n    print(\"推荐\")\nelif score >=5:\n    print(\"一般\")'
),
(11, 5, '顶部写作者与版本', 2,
 '你要在脚本顶部写作者与版本信息，下面哪种做法更合适？',
 JSON_ARRAY('在文件开头用注释写 # Author: ... 与 # Version: ...','把版本信息写在注释里但放到文件末尾','只在提交备注里写版本信息','把作者信息写成代码常量并暴露给用户'),
 0,
 JSON_ARRAY('提示1：文件顶部是最先被看到的位置。','提示2：注释形式适合放元信息且便于查看。','提示3：选 A。'),
 '把作者与版本信息写在文件顶部注释中易于维护与查看。',
 '# Author: 张三\n# Version: 1.0'
),
(12, 5, '注释与代码同步', 2,
 '当注释与代码含义冲突时应该怎么做？',
 JSON_ARRAY('保持注释不变，不更新代码','更新注释以反映当前代码或修正代码以匹配注释','删除代码保留注释','忽略注释不重要'),
 1,
 JSON_ARRAY('提示1：注释应与代码一致避免误导。','提示2：应及时更新注释或修正代码。','提示3：选 B。'),
 '注释若与代码不一致会误导维护者，应更新注释或修正代码。',
 '# 更新注释以匹配最新实现'
),
(13, 5, '注释关注点', 2,
 '写注释时更应该关注哪类信息？',
 JSON_ARRAY('解释“为什么”要这样做（设计意图）','把每行代码逐字解释（过度细节）','写与实现无关的故事','完全不写注释'),
 0,
 JSON_ARRAY('提示1：注释最有价值的是解释设计意图与边界。','提示2：过度行注释会造成维护负担。','提示3：选 A。'),
 '注释应解释设计意图与边界，帮助读者理解为何这样实现。',
 '# 设计意图：保持小火慢炖以保证入味'
),
(16, 5, '避免重复匹配', 2,
 '在评分判断中，哪种写法能避免重复匹配并提高可读性？',
 JSON_ARRAY('if s >= 8: ... elif s >= 5: ... else: ...','if s >= 8: ... if s >= 5: ... else: ...','if s >= 5: ... elif s >= 8: ... else: ...','if s >= 8 or s >= 5: ...'),
 0,
 JSON_ARRAY('提示1：先写严格条件再写宽泛条件。','提示2：使用 elif 确保互斥。','提示3：选 A。'),
 '先判断较高阈值再判断较低阈值并使用 elif 可提高可读性与正确性。',
 'if s >= 8:\n    ...\nelif s >= 5:\n    ...'
),
(17, 5, '处理非数字输入', 2,
 '若评分输入非数字且不处理会抛异常，以下哪种做法更稳妥？',
 JSON_ARRAY('使用 try/except 捕获转换异常并给出友好提示','不做捕获，让程序直接报错','只在文档里说明输入规则','放到云端自动修复错误'),
 0,
 JSON_ARRAY('提示1：用户输入常常不可靠。','提示2：用 try/except 可避免程序崩溃并提示用户。','提示3：选 A。'),
 '对用户输入做异常捕获并给出明确提示能提升体验并避免崩溃。',
 'try:\n  s = int(input().strip())\nexcept ValueError:\n  print(\"Invalid score\")'
),
(18, 5, '多道菜评分显示格式', 2,
 '当要把多道菜的评分汇总为可读文本时，哪种格式较容易阅读？',
 JSON_ARRAY('菜名 - 评分 每行一条','所有菜名和评分写成一行','把评分写成二进制保存','写成混乱的表情符号串'),
 0,
 JSON_ARRAY('提示1：逐行显示便于阅读与比对。','提示2：常用格式是 `菜名 - 评分` 或 CSV。','提示3：选 A。'),
 '逐行显示（例如`菜名 - 评分`）便于人工阅读和比对。',
 'print(\"红烧肉 - 9\")'
),
(21, 5, '记录作者与修改时间的位置', 2,
 '在脚本中记录作者和最后修改日期最合适的位置是？',
 JSON_ARRAY('文件顶部注释区','每条打印输出后','文件底部任意注释','代码中间某个 if 分支里'),
 0,
 JSON_ARRAY('提示1：文件顶部最易被看到。','提示2：元信息放在顶部便于快速查阅。','提示3：选 A。'),
 '把作者与日期写在文件顶部注释中最便于查阅。',
 '# Author: 张三\n# Last modified: 2025-09-21'
),
(22, 5, '边界包含判断', 2,
 '让评分脚本支持 0 和 10 这样的边界值应注意使用何种比较？',
 JSON_ARRAY('使用 <= 和 >= 来包含边界值','用 < 和 > 排除边界值','忽略边界直接处理内部值','把边界值当作非法输入'),
 0,
 JSON_ARRAY('提示1：题目要求包含 0 和 10。','提示2：使用 <= 和 >= 可包含边界。','提示3：选 A。'),
 '使用 <= 和 >= 可确保边界值被视为合法输入。',
 'if 0 <= score <= 10:\n    print(\"合法\")'
),
(23, 5, '提取常量的好处', 2,
 '如果把阈值提取为顶部常量（如 RECOMMEND = 8），有什么好处？',
 JSON_ARRAY('更易于统一修改与维护','让代码变长难读','无任何好处只是装饰','增加运行时错误概率'),
 0,
 JSON_ARRAY('提示1：集中管理阈值便于修改与测试。','提示2：把阈值写在顶部常量便于查找。','提示3：选 A。'),
 '将阈值提为常量有利于维护和统一修改。','RECOMMEND = 8\nif score >= RECOMMEND:\n    print(\"推荐\")'
),
(26, 5, '对浮点评分的策略', 2,
 '若评分输入为浮点数（如 8.5），但脚本只接受整数评分，哪种处理方式比较合理？',
 JSON_ARRAY('把浮点四舍五入为最近整数再接受','直接接受浮点数','把输入视为非法并提示 Invalid score','自动截取整数部分'),
 2,
 JSON_ARRAY('提示1：若只接受整数，应明确提示用户输入规则。','提示2：拒绝不符合规定的输入更明确且可控。','提示3：选 C（提示 Invalid score）。'),
 '若仅接受整数，遇到浮点应视为非法并提示用户修正。','输入: 8.5 => 输出: Invalid score'
),
(27, 5, '写使用说明的位置', 2,
 '你想在脚本中增加简单使用说明（usage），最方便的写法是？',
 JSON_ARRAY('在文件顶部注释中列出示例输入输出','把使用说明写在代码某处不运行时展示','不写说明，用户应阅读源码','每次运行强制打印帮助信息'),
 0,
 JSON_ARRAY('提示1：把示例和说明放在文件顶部注释中方便用户查看。','提示2：顶部注释不会在运行时打扰用户。','提示3：选 A。'),
 '把使用示例与说明写在文件顶部注释中，用户查看源码即可获知用法。','''# Usage:\n# 输入示例:\n# add\\n菜名\\n步骤...'''
),
(28, 5, '支持中文编码', 2,
 '评分脚本要支持中文与英文输入时，哪种做法有助于兼容性？',
 JSON_ARRAY('指定 encoding=\'utf-8\' 并在提示/注释里说明','忽略编码问题，依赖默认','只支持英文','把中文转为拼音再处理'),
 0,
 JSON_ARRAY('提示1：显式使用 UTF-8 能避免跨平台编码问题。','提示2：在文件读写时指定 encoding 以保证中文正常。','提示3：选 A。'),
 '在读写文件时指定 encoding=\"utf-8\" 能保证中文兼容性。','with open(\"recipes.csv\",\"a\",encoding=\"utf-8\") as f:...'
)

-- Unit 6 选择题 (q_id 1..30 for unit 6; only choice q's included)
INSERT INTO questions_py
(q_id, unit_id, title, energy, question_text, options, answer, hints, explanation, example) VALUES
(1, 6, '合法的 if 语句起始', 2,
 '在 Python 中，合法的 if 语句起始行是哪一种？',
 JSON_ARRAY('if age > 18 then:','if age > 18:','if (age > 18) {','if age > 18'),
 1,
 JSON_ARRAY('提示1：Python 条件后需冒号。','提示2：不要使用其他语言的 then 或大括号语法。','提示3：选 B。'),
 'Python 条件后需要冒号 : 并在下一行缩进块。','if age > 18:\n    print(age)'
),
(2, 6, '判断年龄区间写法', 2,
 '判断年龄是否在 13 到 17（含）最简洁的写法是？',
 JSON_ARRAY('if 13 <= age <= 17:','if age >= 13 and age <= 17:','if age in range(13,18):','以上都可'),
 3,
 JSON_ARRAY('提示1：Python 支持链式比较。','提示2：range(13,18) 表示 13..17。','提示3：以上写法均可，A 更简洁。'),
 '链式比较和 range 都可用于判断区间。','age = 15\nif 13 <= age <= 17:\n    print(\"青少年\")'
),
(3, 6, '先验证年龄合法性的原因', 2,
 '为什么要先验证年龄合法性（是否为整数且 >= 0）？',
 JSON_ARRAY('因为年龄很重要','防止后续逻辑出错或产生不合理分组','验证会使程序变慢','任何输入都可直接使用'),
 1,
 JSON_ARRAY('提示1：不合法输入可能导致异常或错误分组。','提示2：提前验证能保证分组逻辑正确且安全。','提示3：选 B。'),
 '先验证年龄合法可以避免非数字、负值等导致后续逻辑错误。','try: age = int(input().strip())'
),
(6, 6, '注释写在何处', 2,
 '写注释记录“18 岁归成人”的理由，最合适放在哪？',
 JSON_ARRAY('文件顶部注释或接近分组判断的地方','注释写在程序中随机位置','只写在外部文档','不需要注释'),
 0,
 JSON_ARRAY('提示1：把设计意图写在接近实现处最方便维护者看到。','提示2：函数 docstring 不使用（题目不要求函数）。','提示3：选 A。'),
 '把边界设计理由写在文件顶部或接近分组逻辑的注释中有利维护。','''# 设计: 把 18 岁归成人，考虑安全与责任'''
),
(7, 6, '判断相等用什么', 2,
 '判断相等应该使用哪个运算符？',
 JSON_ARRAY('=','==','===','eq'),
 1,
 JSON_ARRAY('提示1：= 在 Python 中为赋值。','提示2：比较相等使用 ==。','提示3：选 B。'),
 '== 用于比较相等，= 用于赋值。','if age == 18:\n    print(\"18岁\")'
),
(8, 6, '组合条件写法', 2,
 '要同时判断年龄在 18–59 且项目类型为 \"contact\"，哪种写法正确？',
 JSON_ARRAY("if 18 <= age <= 59 and proj == 'contact':","if 18 <= age <= 59 & proj == 'contact':","if 18 <= age <= 59 && proj == 'contact':","if 18 <= age <= 59 or proj == 'contact':"),
 0,
 JSON_ARRAY('提示1：Python 的逻辑与应使用 and。','提示2：& 是位运算符，&& 不是 Python 语法。','提示3：选 A。'),
 '使用 and 进行布尔组合判断，例如 if 18 <= age <= 59 and proj == \"contact\": 。','proj = \"contact\"\nage = 30\nif 18 <= age <= 59 and proj == \"contact\":\n    print(\"需要\")'
),
(11, 6, '18 岁归哪组调整', 2,
 '如果想把 18 岁归为青少年而不是成人，应如何调整边界？',
 JSON_ARRAY('把青少年上限从 17 改为 18','把成人条件改为 > 18','两者均可，但把青少年上限改为 18 更直观','无法调整'),
 2,
 JSON_ARRAY('提示1：两种改法都可实现目标。','提示2：把青少年上限扩大到 18 更直接清晰。','提示3：选 C。'),
 '将青少年上限调整为 18 更直观地把 18 岁划为青少年。','TEEN_MAX = 18\nif age <= TEEN_MAX: ...'
),
(12, 6, '浮点年龄处理策略', 2,
 '当年龄为浮点（如 18.0）时，哪种处理更稳妥？',
 JSON_ARRAY('先把输入转换为 float，再判断是否为整数或按近似处理','直接拒绝非整数输入','直接截断 float 为 int','用字符串比较'),
 0,
 JSON_ARRAY('提示1：先 float 再决定更灵活。','提示2：可接受 18.0 作为合法输入并转换为 int。','提示3：选 A。'),
 '先用 float() 解析，再判断是否为整数或按业务规则处理。','s = input().strip()\nval = float(s)\nif val.is_integer(): age = int(val)'
),
(13, 6, '阈值放在哪里', 2,
 '为了便于维护，应把年龄阈值放在哪里？',
 JSON_ARRAY('文件顶部的常量定义处','代码随机位置','写在注释里但不放到代码中','写死在字符串里'),
 0,
 JSON_ARRAY('提示1：集中定义阈值便于修改。','提示2：常量放文件顶部易于查找。','提示3：选 A。'),
 '在文件顶部定义常量（如 SENIOR_MIN = 60）利于统一修改。','SENIOR_MIN = 60'
),
(16, 6, '使用 and 进行复合判断', 2,
 '检查年龄与项目类型的组合是否需要特殊处理时应使用哪个逻辑运算？',
 JSON_ARRAY('and','&','||','or'),
 0,
 JSON_ARRAY('提示1：Python 布尔“与”使用 and。','提示2：& 是位运算符，不适用于布尔短路。','提示3：选 A。'),
 '使用 and 连接多个布尔条件，例如 if 18 <= age <= 59 and proj == \"contact\":。','if 18 <= age <= 59 and proj == \"contact\":\n    print(\"special\")'
),
(17, 6, '年龄字符串处理', 2,
 '若年龄是字符串 \"18\"，最保险的预处理方式是？',
 JSON_ARRAY('age = int(input().strip())','age = input() 不做处理','age = float(input())','age = input().replace(\" \",\"\") 不转换'),
 0,
 JSON_ARRAY('提示1：去首尾空白并转换为 int 是常见做法。','提示2：strip() 去除首尾空白更稳妥。','提示3：选 A。'),
 '用 age = int(input().strip()) 可处理 \" 18 \" 等带空白的输入。','age = int(input().strip())'
),
(18, 6, '外部配置的好处', 2,
 '如果把分组阈值放到配置文件中读取，会带来什么好处？',
 JSON_ARRAY('非程序员也能修改分组规则而不改代码','会增加程序复杂度且无用','配置文件只读，不能实现','无任何好处'),
 0,
 JSON_ARRAY('提示1：外部配置提高灵活性与可维护性。','提示2：使用 JSON/YAML 等配置文件便于管理。','提示3：选 A。'),
 '把阈值放在配置文件便于调整与部署。','# config.json: {\"TEEN_MAX\": 17}'
);
-- Unit 5 实操题 (unit_id = 5) : q_id positions 4,5,9,10,14,15,19,20,24,25,29,30
INSERT INTO questions_py_exec
(q_id, unit_id, title, energy, question_text, hints, link, eg_in1, eg_out1, eg_in2, eg_out2, eg_in3, eg_out3) VALUES

(4, 5, '读取并打印菜名与注释步骤', 3,
 '读取三行输入：菜名、主要食材、简短步骤（一句话）。按格式打印三行，其中步骤行以注释形式显示（前缀 "# Step:"）。',
 JSON_ARRAY('提示1：逐行用 input() 读取字符串。','提示2：步骤行前加 "# Step:" 前缀便于阅读。'),
 JSON_ARRAY('/library','/library','/library'),
 '红烧肉\n五花肉\n小火炖30分钟\n',
 'Dish: 红烧肉\nMain: 五花肉\n# Step: 小火炖30分钟\n',
 '番茄炒蛋\n番茄\n快炒两分钟\n',
 'Dish: 番茄炒蛋\nMain: 番茄\n# Step: 快炒两分钟\n',
 '清蒸鱼\n鲈鱼\n蒸8分钟\n',
 'Dish: 清蒸鱼\nMain: 鲈鱼\n# Step: 蒸8分钟\n'
),

(5, 5, '评分并输出建议', 3,
 '读取一行评分（整数 0~10），若评分 >= 8 输出 推荐；评分 5~7 输出 一般；否则输出 不推荐。',
 JSON_ARRAY('提示1：先把输入转换为 int()。','提示2：用 if/elif/else 做判断并打印对应结果。'),
 JSON_ARRAY('/library','/library','/library'),
 '9\n',
 '推荐\n',
 '6\n',
 '一般\n',
 '3\n',
 '不推荐\n'
),

(9, 5, '打印分数与建议', 3,
 '读取一行评分（整数），先打印 Score: <分数>，再打印 Advice: <推荐/一般/不推荐>（规则同上）。',
 JSON_ARRAY('提示1：先打印原始分数。','提示2：按范围用分支输出建议。'),
 JSON_ARRAY('/library','/library','/library'),
 '6\n',
 'Score: 6\nAdvice: 一般\n',
 '8\n',
 'Score: 8\nAdvice: 推荐\n',
 '4\n',
 'Score: 4\nAdvice: 不推荐\n'
),

(10, 5, '清理空白并校验评分', 3,
 '读取评分（可能带空格），先 strip() 后尝试转换为整数，若无法转换输出 Invalid score，否则按规则输出 Result: <建议>。',
 JSON_ARRAY('提示1：用 .strip() 去首尾空白。','提示2：用 try/except 捕获非整数字符。'),
 JSON_ARRAY('/library','/library','/library'),
 ' 8 \n',
 'Result: 推荐\n',
 'abc\n',
 'Invalid score\n',
 ' 5\n',
 'Result: 一般\n'
),

(14, 5, '读取并打印三步骤（不使用循环）', 3,
 '读取菜名（可忽略）并分别读取三次步骤输入，按顺序打印三行：# Step 1: ... 至 # Step 3: ...（**不使用循环**）。',
 JSON_ARRAY('提示1：分别进行三次 input() 读取步骤。','提示2：按示例逐行打印带 # Step 前缀。'),
 JSON_ARRAY('/library','/library','/library'),
 '鱼香肉丝\n切肉\n炒酱\n出锅\n',
 '# Step 1: 切肉\n# Step 2: 炒酱\n# Step 3: 出锅\n',
 '蒜蓉西兰花\n洗菜\n切蒜\n蒸熟\n',
 '# Step 1: 洗菜\n# Step 2: 切蒜\n# Step 3: 蒸熟\n',
 '红烧茄子\n切茄子\n炸茄子\n收汁\n',
 '# Step 1: 切茄子\n# Step 2: 炸茄子\n# Step 3: 收汁\n'
),

(15, 5, '验证评分并模拟保存', 3,
 '读取两行（菜名、评分），若评分不在 0~10 输出 Invalid score，否则打印 Saved: <菜名> (<score>)（模拟保存）。',
 JSON_ARRAY('提示1：先把评分转换为 int 并验证范围。','提示2：合法时按固定格式打印 Saved 信息。'),
 JSON_ARRAY('/library','/library','/library'),
 '糖醋里脊\n10\n',
 'Saved: 糖醯里脊 (10)\n',
 '糖醋里脊\n10\n',
 'Saved: 糖醯里脊 (10)\n',
 '麻婆豆腐\n11\n',
 'Invalid score\n'
),

(19, 5, '读菜名与评分并打印两行', 3,
 '读取两行（菜名、评分），若评分非法输出 Invalid score；否则打印两行：Dish: <菜名> 和 Status: <推荐/一般/不推荐>。',
 JSON_ARRAY('提示1：使用 try/except 验证评分是否为整数。','提示2：按示例格式严格打印两行。'),
 JSON_ARRAY('/library','/library','/library'),
 '麻婆豆腐\n7\n',
 'Dish: 麻婆豆腐\nStatus: 一般\n',
 '西红柿炒蛋\n10\n',
 'Dish: 西红柿炒蛋\nStatus: 推荐\n',
 '糖醋肉\n-1\n',
 'Invalid score\n'
),

(20, 5, '读取菜名、食材与评分并输出', 3,
 '读取三行：菜名、主要食材、评分；若评分不合法输出 Invalid score；若合法打印 Dish:, Main:, Advice: 三行（建议同评分规则）。',
 JSON_ARRAY('提示1：先验证评分再打印其它信息。','提示2：输出顺序必须与示例一致。'),
 JSON_ARRAY('/library','/library','/library'),
 '番茄炒蛋\n番茄\n6\n',
 'Dish: 番茄炒蛋\nMain: 番茄\nAdvice: 一般\n',
 '清蒸鱼\n鲈鱼\n9\n',
 'Dish: 清蒸鱼\nMain: 鲈鱼\nAdvice: 推荐\n',
 '糖醋排骨\n排骨\n11\n',
 'Invalid score\n'
),

(24, 5, '读取菜名评分备注并保存（模拟）', 3,
 '读取三行：菜名、评分、备注；若评分非法输出 Invalid score；若合法打印 Name:, Score:, Note:, Saved（模拟保存）。',
 JSON_ARRAY('提示1：先验证评分再输出其它信息。','提示2：按示例格式严格打印三行再打印 Saved。'),
 JSON_ARRAY('/library','/library','/library'),
 '红焖牛肉\n9\n口味偏咸\n',
 'Name: 红焖牛肉\nScore: 9\nNote: 口味偏咸\nSaved\n',
 '番茄炒蛋\n5\n少盐\n',
 'Name: 番茄炒蛋\nScore: 5\nNote: 少盐\nSaved\n',
 '菜名\nabc\n备注\n',
 'Invalid score\n'
),

(25, 5, '读取三步并打印并保存提示', 3,
 '读取菜名与三条步骤并以注释行打印前三步（# Step 1..3），最后打印 Recipe saved（不写文件）。',
 JSON_ARRAY('提示1：按顺序读取三步并每行加 # Step n:。','提示2：最后打印确认文字 Recipe saved。'),
 JSON_ARRAY('/library','/library','/library'),
 '蒜蓉西兰花\n洗菜\n切蒜\n炒熟\n',
 '# Step 1: 洗菜\n# Step 2: 切蒜\n# Step 3: 炒熟\nRecipe saved\n',
 '青瓜拌豆腐\n洗青瓜\n切豆腐\n拌匀\n',
 '# Step 1: 洗青瓜\n# Step 2: 切豆腐\n# Step 3: 拌匀\nRecipe saved\n',
 '菜\n步1\n步2\n步3\n',
 '# Step 1: 步1\n# Step 2: 步2\n# Step 3: 步3\nRecipe saved\n'
),

(29, 5, '命令分支 add 或 rate（简化版）', 3,
 '首行命令决定行为：若为 add 则读菜名与三步并打印三条注释步骤及 Wrote <菜名>_recipe.txt；若为 rate 则读菜名与评分并验证后打印 Saved: <菜名> (<score>) 或 Invalid score。',
 JSON_ARRAY('提示1：首行决定分支逻辑。','提示2：按示例顺序读取后续行。'),
 JSON_ARRAY('/library','/library','/library'),
 'add\n鱼香肉丝\n洗菜\n切肉\n炒酱\n',
 '# Step 1: 洗菜\n# Step 2: 切肉\n# Step 3: 炒酱\nWrote 鱼香肉丝_recipe.txt\n',
 'rate\n糖醋里脊\n10\n',
 'Saved: 糖醋里脊 (10)\n',
 'rate\n菜\nabc\n',
 'Invalid score\n'
),

(30, 5, '交互命令流（不使用函数）', 3,
 '支持交互命令流（命令 add/rate/show/quit）：实现 add（读菜名及三步并打印并写提示）、rate（读菜名与评分并保存模拟）、show（读菜名并显示记录或 No record）、quit 结束并打印 Done。所有逻辑用顺序语句与分支实现（不使用函数）。',
 JSON_ARRAY('提示1：用主循环读取命令并用 if/elif/else 分支处理。','提示2：可用简单内存结构保存评分以便 show 使用。'),
 JSON_ARRAY('/library','/library','/library'),
 'add\n宫保鸡丁\n切鸡\n腌制\n爆炒\nrate\n宫保鸡丁\n9\nshow\n宫保鸡丁\nquit\n',
 '# Step 1: 切鸡\n# Step 2: 腌制\n# Step 3: 爆炒\nWrote 宫保鸡丁_recipe.txt\nSaved\nDish: 宫保鸡丁 (score: 9)\nDone\n',
 'add\n菜\n步1\n步2\n步3\nquit\n',
 '# Step 1: 步1\n# Step 2: 步2\n# Step 3: 步3\nWrote 菜_recipe.txt\nDone\n',
 'rate\n菜\n5\nshow\n菜\nquit\n',
 'Saved\nDish: 菜 (score: 5)\nDone\n'
);

-- Unit 6 实操题 (unit_id = 6) : q_id positions 4,5,9,10,14,15,19,20,24,25,29,30
INSERT INTO questions_py_exec
(q_id, unit_id, title, energy, question_text, hints, link, eg_in1, eg_out1, eg_in2, eg_out2, eg_in3, eg_out3) VALUES

(4, 6, '读取年龄并输出组别（基础）', 3,
 '读取一行年龄（整数），若 age < 0 输出 Invalid age；否则按规则输出 Group: <组>（简化规则：age <=12 儿童，13-17 青少年，>=18 成人）。',
 JSON_ARRAY('提示1：先把输入用 int() 转换。','提示2：按顺序用 if/elif/else 判断区间并输出。'),
 JSON_ARRAY('/library','/library','/library'),
 '10\n',
 'Group: 儿童\n',
 '13\n',
 'Group: 青少年\n',
 '18\n',
 'Group: 成人\n'
),

(5, 6, '使用常量 CHILD_MAX 判断', 3,
 '把儿童上限定义为常量 CHILD_MAX = 12，并据此判断输入年龄的组别（与 Q4 等价但使用常量）。',
 JSON_ARRAY('提示1：把 CHILD_MAX 写在脚本顶部便于修改。','提示2：按示例读取并比较。'),
 JSON_ARRAY('/library','/library','/library'),
 '12\n',
 'Group: 儿童\n',
 '11\n',
 'Group: 儿童\n',
 '13\n',
 'Group: 青少年\n'
),

(9, 6, '完整四分组判定', 3,
 '读取一行年龄（整数），按规则：0-12 儿童，13-17 青少年，18-59 成人，>=60 老年人；若 age < 0 输出 Invalid age；否则输出 Age <n>: <组别>。',
 JSON_ARRAY('提示1：注意各区间边界包含关系。','提示2：输出格式为 Age <n>: <组别>。'),
 JSON_ARRAY('/library','/library','/library'),
 '70\n',
 'Age 70: 老年人\n',
 '0\n',
 'Age 0: 儿童\n',
 '59\n',
 'Age 59: 成人\n'
),

(10, 6, 'strip 后判定并输出', 3,
 '读取一行年龄（可能带空格），先 strip() 再转换为 int，若非法或负数输出 Invalid age，否则输出 Result: <组别>（分组同 Q9）。',
 JSON_ARRAY('提示1：用 .strip() 去掉首尾空白。','提示2：处理转换异常并输出 Invalid age。'),
 JSON_ARRAY('/library','/library','/library'),
 ' 18 \n',
 'Result: 成人\n',
 ' -1 \n',
 'Invalid age\n',
 ' 60\n',
 'Result: 老年人\n'
),

(14, 6, '四人年龄统计（可不使用循环）', 3,
 '读取固定 4 行年龄（每行一个），统计每个分组人数并打印统计报告：Children:, Teen:, Adult:, Senior:（每行一个计数）。可不使用循环，直接四次读取并累加计数器。',
 JSON_ARRAY('提示1：可分别读取四次并用变量统计。','提示2：按示例顺序打印统计结果。'),
 JSON_ARRAY('/library','/library','/library'),
 '10\n17\n18\n65\n',
 'Children: 1\nTeen: 1\nAdult: 1\nSenior: 1\n',
 '12\n13\n14\n15\n',
 'Children: 1\nTeen: 3\nAdult: 0\nSenior: 0\n',
 '0\n60\n59\n11\n',
 'Children: 2\nTeen: 0\nAdult: 1\nSenior: 1\n'
),

(15, 6, '免责声明判断并输出', 3,
 '读取一行年龄并判断是否需要免责声明（规则：18–59 需要免责声明），输出两行：Group: <组别> 与 Waiver: Yes/No（成人且 18–59 输出 Yes）。',
 JSON_ARRAY('提示1：先判定组别再判断 Waiver。','提示2：严格按示例输出两行。'),
 JSON_ARRAY('/library','/library','/library'),
 '30\n',
 'Group: 成人\nWaiver: Yes\n',
 '65\n',
 'Group: 老年人\nWaiver: No\n',
 '12\n',
 'Group: 儿童\nWaiver: No\n'
),

(19, 6, '解析 name,age 并打印两行', 3,
 '读取一行格式为 姓名,年龄（例如 小明,15），解析并打印两行：Name: <姓名> 与 Group: <组别>；若解析失败或年龄非法输出 Invalid input。',
 JSON_ARRAY('提示1：用 split(\',\') 拆分并 strip() 清理空白。','提示2：验证年龄为整数且 >= 0。'),
 JSON_ARRAY('/library','/library','/library'),
 '小明,15\n',
 'Name: 小明\nGroup: 青少年\n',
 '阿华,10\n',
 'Name: 阿华\nGroup: 儿童\n',
 '张三,abc\n',
 'Invalid input\n'
),

(20, 6, '姓名、年龄、家长同意判定', 3,
 '读取三行：姓名、年龄、是否有家长同意（yes/no）。若年龄在 13–17 且家长同意为 yes 输出 Eligible 并打印 Group: 青少年；否则输出 Not eligible 并打印 Group: <组别>。',
 JSON_ARRAY('提示1：年龄判断在先，再检查同意（使用 .lower() 规范化）。','提示2：输出顺序参照示例。'),
 JSON_ARRAY('/library','/library','/library'),
 '小红\n15\nyes\n',
 'Eligible\nGroup: 青少年\n',
 '小明\n12\nno\n',
 'Not eligible\nGroup: 儿童\n',
 '小华\n16\nno\n',
 'Not eligible\nGroup: 青少年\n'
),

(24, 6, '导出 3 条 CSV 记录（简化）', 3,
 '读取三条 name,age（固定三行），解析并按分组输出三行 CSV 格式 name,age,group，最后打印 Exported 3 records。',
 JSON_ARRAY('提示1：逐行解析并按分组输出 CSV 行。','提示2：最后打印导出计数。'),
 JSON_ARRAY('/library','/library','/library'),
 '小明,10\n阿华,16\n老王,65\n',
 '小明,10,儿童\n阿华,16,青少年\n老王,65,老年人\nExported 3 records\n',
 'a,12\nb,13\nc,60\n',
 'a,12,儿童\nb,13,青少年\nc,60,老年人\nExported 3 records\n',
 'x,0\ny,59\nz,18\n',
 'x,0,儿童\ny,59,成人\nz,18,成人\nExported 3 records\n'
),

(25, 6, '年龄与家长同意判定（简化）', 3,
 '读取两行：年龄、yes/no（家长是否同意）。若年龄在 13–17 并且第二行是 yes 输出 Eligible；否则输出 Not eligible。',
 JSON_ARRAY('提示1：先判断年龄是否在 13–17。','提示2：用 .lower() 标准化 yes/no。'),
 JSON_ARRAY('/library','/library','/library'),
 '15\nyes\n',
 'Eligible\n',
 '15\nno\n',
 'Not eligible\n',
 '12\nyes\n',
 'Not eligible\n'
),

(29, 6, '分发写入模拟（3 条）', 3,
 '读取三行 name,age（固定三行），将每人分配到对应文件（children.txt/teen.txt/adult.txt/senior.txt），模拟写入时打印每条：Wrote to <group>.txt: <name>,<age> 并在最后打印 Saved files: <comma-separated filenames>（按出现顺序）。',
 JSON_ARRAY('提示1：解析每行并决定目标文件名。','提示2：收集已用文件名并按顺序打印最后一行。'),
 JSON_ARRAY('/library','/library','/library'),
 '小明,10\n小红,14\n老李,61\n',
 'Wrote to children.txt: 小明,10\nWrote to teen.txt: 小红,14\nWrote to senior.txt: 老李,61\nSaved files: children.txt, teen.txt, senior.txt\n',
 'a,12\nb,18\nc,65\n',
 'Wrote to children.txt: a,12\nWrote to adult.txt: b,18\nWrote to senior.txt: c,65\nSaved files: children.txt, adult.txt, senior.txt\n',
 'x,13\ny,59\nz,11\n',
 'Wrote to teen.txt: x,13\nWrote to adult.txt: y,59\nWrote to children.txt: z,11\nSaved files: teen.txt, adult.txt, children.txt\n'
),

(30, 6, '批量读取 N 条并输出 CSV', 3,
 '先读取整数 N，然后读取 N 行，每行 name,age,gender，校验年龄并按分组打印 CSV 行 name,age,group,gender，最后打印 Completed: N records。',
 JSON_ARRAY('提示1：先读取 N，再循环 N 次读取并解析每行。','提示2：校验年龄并按规则生成分组列。'),
 JSON_ARRAY('/library','/library','/library'),
 '3\n小明,10,M\n小红,16,F\n老王,65,M\n',
 '小明,10,儿童,M\n小红,16,青少年,F\n老王,65,老年人,M\nCompleted: 3 records\n',
 '2\na,12,M\nb,18,F\n',
 'a,12,儿童,M\nb,18,成人,F\nCompleted: 2 records\n',
 '1\nx,59,M\n',
 'x,59,成人,M\nCompleted: 1 records\n'
);
