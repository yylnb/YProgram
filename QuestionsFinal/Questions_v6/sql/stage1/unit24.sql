-- Generated SQL for global_unit=24 (stage=1 unit_local=24 unit_id=24)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  346,
  24,
  '点餐新招',
  '阿强写了个小程序来点餐，他想用 f-string 把商品`item`（炸鸡）和价格`price`（25.5）漂亮地输出为“炸鸡 25.5元”。哪一行代码是正确的？',
  '["print(f\\\"item price元\\\")", "print(f\\\"{item} {price}元\\\")", "print(f\\\"{‘item’} {‘price’}元\\\")", "print(\\\"f {item} {price}元\\\")"]',
  2,
  '["f-string里大括号里要放变量名，不是字符串。", "正确格式是以 f 或 F 开头，字符串内变量用{}包裹。", "选项A没放变量，C在{}里加了引号，D的f没在引号前。"]',
  'f-string 以 f 或 F 开头，字符串内用花括号 {} 直接包裹变量名或表达式，运行时会被其值替换。选项B的语法完全正确。',
  'name = ‘小明’; print(f"你好，{name}!")  # 输出：你好，小明！'
),
(
  347,
  24,
  '成绩单美化师',
  '编程课上，老师要求将平均分`avg_score`（87.654321）格式化为保留两位小数输出。哪个 f-string 表达式能满足要求？',
  '["f\\\"{avg_score:.2}\\\"", "f\\\"{avg_score:2f}\\\"", "f\\\"{avg_score:.2f}\\\"", "f\\\"{avg_score:2}\\\""]',
  3,
  '["想想格式化数字小数位的格式说明符。", "保留两位小数通常用‘.2f’来表示。", "冒号`:`后接格式说明符，`.2f`表示小数点后两位。"]',
  '在 f-string 中，`:` 后可以添加格式说明符。`.2f` 表示将数字格式化为浮点数，并保留两位小数。这是最常见的数字格式化方式之一。',
  'pi = 3.14159; print(f"{pi:.1f}")  # 输出：3.1'
),
(
  348,
  24,
  '购物小票',
  '你想用 f-string 直接计算并打印“3件商品，单价8元，总价：”的结果。哪个表达式不能正常工作？',
  '["f\\\"总价：{3 * 8}\\\"", "f\\\"总价：{‘3 * 8’}\\\"", "f\\\"总价：{3 * 8}元\\\"", "f\\\"总价：{24}\\\""]',
  2,
  '["f-string的{}里可以放表达式，但不能放带引号的字符串。", "计算机会直接计算{}内的表达式。", "选项B的{}内是字符串‘3 * 8’，所以输出的是这串字符，而非计算结果24。"]',
  'f-string 的花括号 `{}` 内可以放置任何有效的Python表达式，系统会计算该表达式并用结果替换。但若用引号包裹，则被视为字符串字面量，不会进行计算。选项B即为此错误。',
  'print(f"两数之和：{5 + 3}")  # 输出：两数之和：8'
),
(
  351,
  24,
  '单词切割机',
  '你拿到一句英文“I love Python!”，想把它按空格拆成单词列表。应该用哪个字符串方法？',
  '[".join()", ".split()", ".strip()", ".replace()"]',
  2,
  '["想想“拆分”这个动作对应的英文单词。", "这个方法默认以空白字符（空格、换行等）为分隔符。", ".split() 用于将字符串分割成子串并返回列表。"]',
  '`split()` 方法通过指定分隔符（默认是任意空白字符）对字符串进行分割，返回一个由分割后的子串组成的列表。这正是将句子拆分成单词所需的功能。',
  '"a,b,c".split('','') 得到列表 [''a'', ''b'', ''c'']。'
),
(
  352,
  24,
  '列表粘合剂',
  '你有一个列表`fruits = [‘苹果’， ‘香蕉’， ‘橙子’]`，想用‘和’字把它们连接成“苹果和香蕉和橙子”。哪个方法最合适？',
  '["fruits.join(‘和’)", "‘和’.join(fruits)", "fruits.split(‘和’)", "fruits.connect(‘和’)"]',
  2,
  '["注意！`join`方法是字符串的方法，不是列表的方法。", "语法是：连接符.join(待连接的字符串列表)。", "字符串‘和’调用`.join()`，参数是列表`fruits`。"]',
  '`join()` 是字符串（str）的一个方法，它接收一个可迭代对象（如列表），并用该字符串作为连接符，将其中的所有元素（必须是字符串）连接成一个新的字符串。',
  '"-".join([‘2023’, ‘05’, ‘01’]) 返回 ‘2023-05-01’。'
),
(
  353,
  24,
  '数据清理工',
  '从文件读入的用户名`user_input = " admin \n"` 两边有空格和换行符。哪个操作能最干净地得到‘admin’？',
  '["user_input.split()", "user_input.strip()", "user_input.replace(\\\" \\\", \\\"\\\")", "user_input.trim()"]',
  2,
  '["目标是去掉字符串“两端”的空白字符。", "Python中去除两端空白的方法是`.strip()`。", "`.replace()`只能替换指定字符，不能处理所有空白；`.split()`会分割；Python没有`.trim()`。"]',
  '`strip()` 方法用于移除字符串**开头和末尾**的指定字符（默认为所有空白字符，包括空格、换行`\n`、制表符`\t`等），非常适合清理用户输入。',
  'text = "  hello\t"; print(text.strip())  # 输出：‘hello’'
),
(
  356,
  24,
  '对齐的菜单',
  '为了让菜单看起来整齐，你需要将菜名`dish`（‘鱼香肉丝’）在10个字符宽度内左对齐，价格`price`（28）在6个字符宽度内右对齐。哪个f-string能做到？',
  '["f\\\"{dish:10} {price:>6}\\\"", "f\\\"{dish:<10} {price:6}\\\"", "f\\\"{dish:<10} {price:>6}\\\"", "f\\\"{dish:>10} {price:<6}\\\""]',
  3,
  '["`<`表示左对齐，`>`表示右对齐。", "数字表示字段的总宽度，对齐符号放在冒号和宽度数字之间。", "菜名要左对齐用`<10`，价格要右对齐用`>6`。"]',
  '在f-string的格式说明符中，`<` 表示左对齐，`>` 表示右对齐，其后接的数字表示该字段占用的最小总宽度。因此 `{dish:<10}` 和 `{price:>6}` 符合题目要求。',
  'print(f"{‘Hi’:>5}{3:<4}")  # 输出：‘   Hi3   ’ (Hi右对齐占5格，3左对齐占4格)'
),
(
  357,
  24,
  '格式说明符大比拼',
  '对于整数`num = 42`，哪个f-string格式化表达式输出的结果**不是**‘00042’？',
  '["f\\\"{num:05d}\\\"", "f\\\"{num:0>5}\\\"", "f\\\"{num:>5}\\\"", "f\\\"{num:0>5d}\\\""]',
  3,
  '["目标是输出5位，不足位用0补齐。", "注意`>`是右对齐，但如果不指定填充字符，默认用空格。", "选项C只指定了右对齐宽度5，没用0填充，所以会用空格补位。"]',
  '`{num:>5}` 表示右对齐，宽度为5，但未指定填充字符，因此默认用空格填充左侧，结果是‘   42’。其他选项都明确用‘0’作为填充字符，并满足宽度5的要求，故输出‘00042’。',
  'n=7; print(f"{n:*>3}")  # 输出：‘**7’；print(f"{n:3}")  # 输出：‘  7’'
),
(
  358,
  24,
  '嵌套的乐趣',
  '变量`a=1, b=2`，你想用f-string计算并输出“(1+2)=3”。哪项写法是**错误**的？',
  '["f\\\"({a}+{b})={a+b}\\\"", "f\\\"({a}+{b})={f''{a+b}''}\\\"", "f\\\"({a}+{b})={{a+b}}\\\"", "f\\\"({a}+{b})={‘{a+b}’}\\\""]',
  4,
  '["f-string内的大括号需要转义才能输出原字符。", "选项C用了双重`{{`和`}}`来输出单层大括号。", "选项B是合法的嵌套f-string，但D在{}内放了带引号的字符串，不会计算。"]',
  '在f-string中，`{}` 用于求值表达式。要输出花括号本身，需使用双写 `{{` 或 `}}` 进行转义。选项D在 `{}` 内放置了字符串字面量 `‘{a+b}’`，因此直接输出该字符串，而非计算结果。',
  'print(f"{{{1+2}}}")  # 输出：{3}；print(f"{‘{1+2}’}")  # 输出：{1+2}'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  349,
  24,
  '体温报告',
  '帮医生完善他的诊断报告生成器，将病人姓名和体温（一位小数）填入报告模板。',
  NULL,
  '["病人：张三，当前体温：37.2°C。"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "name = \\\"张三\\\""}, {"type": "code_line", "value": "temperature = 37.155"}, {"type": "code_line", "value": "report = f\\\"病人：{name}，当前体温：{___}°C。\\\""}, {"type": "code_line", "value": "print(report)"}]}]}',
  '["temperature", "temperature:.1f", "temperature:.0f", "name", "\\\"temperature\\\"", "temperature:.2f"]',
  '[1]',
  '题目要求体温保留一位小数，因此需要在变量`temperature`后使用格式说明符 `:.1f` 来控制输出格式，得到37.2°C。',
  'num = 5.666; print(f"{num:.2f}")  # 输出：5.67'
),
(
  350,
  24,
  '简易计算器',
  '小明的计算器代码被墨水弄花了几个关键部分，请帮他恢复，使其能正确输出格式化的计算结果。',
  NULL,
  '["10 + 20 = 30", "10 / 3 ≈ 3.33"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = 10"}, {"type": "code_line", "value": "b = 20"}, {"type": "code_line", "value": "print(____)"}, {"type": "code_line", "value": "b = 3"}, {"type": "code_line", "value": "print(f\\\"{a} / {b} ≈ {____}\\\")"}]}]}',
  '["f\\\"{a} + {b} = {a+b}\\\"", "\\\"{a} + {b} = {a+b}\\\"", "a + b = a+b", "a / b", "a/b:.2f", "a/b", "a/b:.1f", "f\\\"{a}+{b}={a+b}\\\""]',
  '[0, 4]',
  '第一处需要f-string来输出完整的算式和结果，选项0正确。第二处是除法计算并要求保留两位小数，`a/b:.2f` 满足要求。',
  'x,y=7,2; print(f"{x}*{y}={x*y}, {x/y:.3f}")  # 输出：7*2=14, 3.500'
),
(
  354,
  24,
  '用户名格式化',
  '下面代码用于处理用户输入的邮箱，提取用户名并确保其小写且首字母大写。请补全缺失的部分。',
  '["alICE@example.com"]',
  '["Formatted Username: Alice"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "email = input()"}, {"type": "code_line", "value": "# 提取‘@’之前的部分"}, {"type": "code_line", "value": "username = email.____(''@'')[0]"}, {"type": "code_line", "value": "# 先全部转为小写，再将首字母大写"}, {"type": "code_line", "value": "formatted_name = username.____().____()"}, {"type": "code_line", "value": "print(f\\\"Formatted Username: {formatted_name}\\\")"}]}]}',
  '["split", "lower", "title", "upper", "capitalize", "find", "replace", "strip"]',
  '[0, 1, 4]',
  '首先用`.split(''@'')`分割邮箱，取第一部分得到‘alICE’。然后用`.lower()`转为全小写‘alice’。最后用`.capitalize()`将首字母大写得到‘Alice’。`.title()`会将每个单词首字母大写，此处不适用。',
  '"heLLO wORLD".lower().capitalize()  # 得到 ‘Hello world’'
),
(
  355,
  24,
  '密文生成器',
  '这段“机密”代码要将一句话中的空格替换为下划线，并倒序输出。请填入正确的字符串方法。',
  NULL,
  '["_siht_ekil_si_ti_oS"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "text = \\\"So it is like this\\\""}, {"type": "code_line", "value": "# 替换空格为下划线"}, {"type": "code_line", "value": "step1 = text.____(\\\" \\\", \\\"_\\\")"}, {"type": "code_line", "value": "# 将字符串反转"}, {"type": "code_line", "value": "secret = step1[____]"}, {"type": "code_line", "value": "print(secret)"}]}]}',
  '["replace", "split", "::-1", "-1::", "swapcase", "join", "strip", ":0:-1"]',
  '[0, 2]',
  '第一步，使用`.replace(" ", "_")`将空格替换为下划线，得到‘So_it_is_like_this’。第二步，使用切片`[::-1]`可以反转整个字符串。',
  '"abc".replace(''b'', ''x'')[::-1]  # 结果为 ‘xca’'
),
(
  359,
  24,
  '财务简报',
  '请补全代码，生成一份格式清晰的财务简报，要求收入千分位分隔，利润率显示为百分比。',
  NULL,
  '["收入： 1,234,567 ¥", "利润率： 12.35%"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "revenue = 1234567"}, {"type": "code_line", "value": "profit_ratio = 0.12345"}, {"type": "code_line", "value": "print(f\\\"收入： {revenue:____} ¥\\\")"}, {"type": "code_line", "value": "print(f\\\"利润率： {profit_ratio:____}\\\")"}]}]}',
  '[">10d", ",", ":.2%", ":.1f", ":,.0f", ":d", ":>10,.0f", ":.0%"]',
  '[6, 2]',
  '收入`revenue`需要千分位逗号分隔且为整数格式，右对齐占10位宽度，格式说明符为`:>10,.0f`。利润率`profit_ratio`需要格式化为百分比并保留两位小数，格式说明符为`:.2%`。',
  'print(f"{1000000:,.2f}元， {0.15:.0%}")  # 输出：1,000,000.00元， 15%'
),
(
  360,
  24,
  '终极挑战：复杂报表',
  '这段代码根据多种格式要求生成报表。请填入缺失的格式说明符片段，使输出完全匹配。',
  NULL,
  '["ID: #0007 | Value: 1,234.57 | Status: ON  |", "Progress: [=====     ] 50.0%"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "id_num = 7"}, {"type": "code_line", "value": "value = 1234.567"}, {"type": "code_line", "value": "status = \\\"ON\\\""}, {"type": "code_line", "value": "progress = 0.5"}, {"type": "code_line", "value": "bar = \\\"=\\\" * int(progress * 10) + \\\" \\\" * (10 - int(progress * 10))"}, {"type": "code_line", "value": "print(f\\\"ID: #{id_num:____} | Value: {value:____} | Status: {status:____} |\\\")"}, {"type": "code_line", "value": "print(f\\\"Progress: [{bar}] {progress:____}\\\")"}]}]}',
  '["04d", ">3", "<4", ":>8,.2f", ":^4", ":.1%", ":6.2f", ":,.1f", ":<4"]',
  '[0, 3, 8, 5]',
  'ID需要4位数字，不足补零，用`04d`。Value需要千分位分隔、总宽8、右对齐、保留两位小数，用`>8,.2f`。Status左对齐占4位宽度，用`<4`。Progress以百分比显示并保留一位小数，用`:.1%`。',
  'n=5; v=1234.5; s="Y"; print(f"#{n:03d} | {v:7,.1f} | {s:<2} |")  # 输出：#005 | 1,234.5 | Y  |'
);