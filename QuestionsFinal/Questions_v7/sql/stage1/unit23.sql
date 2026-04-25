-- Generated SQL for global_unit=23 (stage=1 unit_local=23 unit_id=23)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  331,
  23,
  'f-string初体验',
  '小菜鸟阿瓜想用f-string做个自我介绍，他的名字是‘Agua’。下面哪行代码能正确打印出‘My name is Agua.’？',
  '["print(f\\\"My name is {name}.\\\")", "print(\\\"My name is {name}.\\\")", "name = \\\"Agua\\\" \\nprint(f\\\"My name is {name}.\\\")", "name = \\\"Agua\\\" \\nprint(\\\"My name is {name}.\\\")"]',
  3,
  '["f-string需要在字符串前加一个字母f。", "使用f-string前，变量需要先被定义。", "对比选项C和D的print语句开头，一个带f，一个不带。"]',
  '使用f-string需要在字符串引号前加前缀f或F。同时，要嵌入的变量（如name）必须在之前被定义和赋值。选项A未定义name；选项B未使用f前缀；选项D未使用f前缀。',
  '正确格式：`name = "John"; print(f"Hello {name}!")` 会输出：Hello John!'
),
(
  332,
  23,
  '花括号的学问',
  '程序猿阿强想用f-string输出字面量的大括号`{}`和变量值，他写了`print(f"{{age}}")`，其中`age=18`。请问输出是什么？',
  '["{18}", "18", "{age}", "{{18}}"]',
  3,
  '["在f-string中，单层`{}`用于包裹表达式。", "要输出字面量的大括号，需要将其转义。", "双重花括号`{{`和`}}`会被转义成单个的花括号输出。"]',
  '在f-string中，使用双重花括号`{{`和`}}`来输出单个花括号的字面量。因此`f"{{age}}"`中的`{{`和`}}`被转义为`{`和`}`，而`age`不再被识别为变量，直接作为字符串的一部分输出。',
  '`print(f"{{{1+2}}}")` 会输出字符串`{3}`，外层的`{}`是字面量，内层的`{}`计算表达式。'
),
(
  333,
  23,
  '表达式狂欢',
  '在f-string的大括号`{}`里，除了放变量名，还能放什么让代码更‘智能’？',
  '["只能放已经定义好的变量名。", "可以放简单的数学表达式，比如 `{x+1}`。", "可以放函数调用，比如 `{\\\"hi\\\".upper()}`。", "可以放任何有效的Python表达式。"]',
  4,
  '["回想一下基础数学运算是否可以在`{}`里进行。", "字符串的方法调用，比如`.upper()`，是否可以呢？", "想想`{}`内的处理原则，它是一个表达式求值环境。"]',
  'f-string的大括号`{}`内可以放入任何在当下语境中有效的Python表达式。这包括变量、算术运算、函数调用、列表索引、属性访问等，表达式的结果会被转换为字符串并嵌入。',
  '`name="alice"; print(f"Name: {name.title()}, Score: {95+5}")` 输出：Name: Alice, Score: 100'
),
(
  336,
  23,
  '变量大杂烩',
  '阿珍的代码：`a=5; b=2; print(f"{a}+{b}={a+b}")`。请问输出是什么？这体现了f-string的什么优点？',
  '["输出`5+2=7`，体现其只能做简单拼接。", "输出`a+b=7`，体现其表达式计算能力。", "输出`5+2=7`，体现其可读性强，逻辑清晰。", "输出`5+2=a+b`，体现其语法复杂。"]',
  3,
  '["把a=5，b=2代入f-string的各个`{}`中看看。", "第一个`{}`是a，第二个`{}`是b，第三个`{}`是a+b。", "这种写法是不是比分开用`+`拼接字符串更一目了然？"]',
  '输出为`5+2=7`。f-string允许将变量和表达式直接嵌入字符串中，使得代码意图非常清晰，一眼就能看出字符串的最终形态和计算逻辑，大大提升了可读性。',
  '比起`print(str(a)+"+"+str(b)+"="+str(a+b))`，f-string的写法`print(f"{a}+{b}={a+b}")`简洁明了得多。'
),
(
  337,
  23,
  '调用函数',
  '下面哪段使用f-string的代码无法正常执行？',
  '["print(f\\\"结果：{max(3, 5, 1)}\\\")", "name = \\\"python\\\"; print(f\\\"语言：{name.upper()[0:2]}\\\")", "lst = [1,2,3]; print(f\\\"第一个元素：{lst[0]}\\\")", "print(f\\\"随机数：{import random; random.randint(1,10)}\\\")"]',
  4,
  '["检查每个选项`{}`里的内容是否是单一表达式。", "`import`语句是导入模块，它是一个语句。", "回忆一下，`{}`内能放语句吗？还是只能放表达式？"]',
  'f-string的`{}`内只能放置表达式（expression），不能放置语句（statement）。`import random`是一个导入语句，因此不能放在`{}`内。正确的做法是在f-string之前先导入模块。',
  '应先执行`import random; num = random.randint(1,10)`，再使用`print(f"数字：{num}")`。'
),
(
  338,
  23,
  '格式化选项辨析',
  '变量`num = 1234.5678`。想要输出`1,234.57`（千位分隔符且保留两位小数），应该用哪个f-string？',
  '["f\\\"{num:.2f}\\\"", "f\\\"{num:,.2f}\\\"", "f\\\"{num:.2,}\\\"", "f\\\"{num:,.2}\\\""]',
  2,
  '["保留两位小数的格式符是`.2f`。", "在格式说明符中，千位分隔符用哪个符号表示？", "格式符的顺序：先是填充对齐等，然后是千位分隔符，再是精度。"]',
  '在格式说明符中，逗号`,`表示使用千位分隔符。正确的顺序是：在`:`后，先放置千位分隔符`,`，再放置精度`.2f`。因此`f"{num:,.2f}"`是正确的写法。',
  '`pop = 1412000000; print(f"{pop:,}")` 输出：`1,412,000,000`（添加千位分隔符）。'
),
(
  341,
  23,
  '大数字格式化',
  '公司年收入`revenue = 987654321`。老板想看到“约9.87亿”这样的中文习惯表示（保留两位小数，单位‘亿’）。哪个f-string最接近？',
  '["f\\\"约{revenue / 100000000}亿\\\"", "f\\\"约{revenue / 1e8:.2f}亿\\\"", "f\\\"约{revenue:,}亿\\\"", "f\\\"约{revenue:.2e}亿\\\""]',
  2,
  '["1亿等于1乘以10的8次方。", "需要将revenue除以1亿来转换单位。", "除以1亿后得到一个浮点数，需要限制小数位数。"]',
  '`revenue / 1e8` 将收入除以1亿（即10的8次方），得到以‘亿’为单位的数值。`:.2f`将其格式化为保留两位小数的浮点数。因此`f"约{revenue / 1e8:.2f}亿"`输出类似`约9.88亿`。',
  '`distance = 384400; print(f"地月距离约{distance / 1000:.1f}千公里")` 输出：地月距离约384.4千公里。'
),
(
  342,
  23,
  '访问字典与列表',
  '给定`data = {"name": "Bob", "scores": [85, 92, 78]}`，哪个f-string能正确输出“Bob的第二科成绩是92。”？',
  '["f\\\"{data[''name'']}的第二科成绩是{data[''scores''][1]}。\\\"", "f\\\"{data.name}的第二科成绩是{data.scores.1}。\\\"", "f\\\"{data[\\\"name\\\"]}的第二科成绩是{data.scores[1]}。\\\"", "f\\\"{data[''name'']}的第二科成绩是{data[''scores''][2]}。\\\""]',
  1,
  '["访问字典的值，使用方括号和键名。", "列表索引从0开始，第二科成绩的索引是1。", "在f-string的`{}`内使用字符串键时，注意引号的嵌套。"]',
  '访问字典`data`中的`name`键，应使用`data[‘name‘]`或`data["name"]`。访问列表`scores`的第二个元素（索引为1），应使用`data[‘scores‘][1]`。选项A的写法正确。注意在f-string内使用双引号时，字典键宜用单引号以避免冲突。',
  '`info = {"city": "Paris"}; print(f"City: {info[''city'']}")` 输出：City: Paris。'
),
(
  343,
  23,
  '条件表达式',
  '体温`temp = 37.6`。想用f-string输出“体温偏高”或“体温正常”（以37.3为界）。哪段代码是正确的？',
  '["f\\\"体温{‘偏高‘ if temp > 37.3 else ‘正常‘}\\\"", "f\\\"体温{‘偏高‘ if temp > 37.3}\\\"", "f\\\"体温{if temp > 37.3: ‘偏高‘ else: ‘正常‘}\\\"", "f\\\"体温{temp > 37.3 ? ‘偏高‘ : ‘正常‘}\\\""]',
  1,
  '["Python中的三元条件表达式语法是 `a if condition else b`。", "这个表达式本身会返回一个值（‘偏高‘或‘正常‘）。", "f-string的`{}`内可以放这种能返回值的表达式。"]',
  'Python的三元条件表达式格式为 `x if condition else y`。当`temp > 37.3`为真时，表达式返回`‘偏高‘`，否则返回`‘正常‘`。这是一个合法的表达式，可以嵌入f-string中。',
  '`score=88; print(f"成绩等级：{‘A‘ if score >= 90 else ‘B‘ if score >= 80 else ‘C‘}")` 可以嵌套判断。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  334,
  23,
  '填空点餐',
  '快餐厅的点餐系统坏了，帮它用f-string补全代码，生成订单小票。',
  NULL,
  '["您点了1个汉堡，2份薯条，总计消费：21.5元。"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "burger = 1"}, {"type": "code_line", "value": "fries = 2"}, {"type": "code_line", "value": "price_burger = 15.5"}, {"type": "code_line", "value": "price_fries = 3.0"}, {"type": "code_line", "value": "total = burger * price_burger + fries * price_fries"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "receipt = f\\\"您点了"}, {"type": "slot", "index": 0}, {"type": "code", "value": "个汉堡，"}, {"type": "slot", "index": 1}, {"type": "code", "value": "份薯条，总计消费："}, {"type": "slot", "index": 2}, {"type": "code", "value": "元。\\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(receipt)"}]}]}',
  '["burger", "fries", "total", "{burger}", "{fries}", "{total}", "f\\\"{total}\\\"", "{\\\"total\\\"}", "1", "2", "21.5", "burger*price_burger+fries*price_fries"]',
  '[4, 5, 6]',
  '在f-string中，要嵌入变量的值，必须将变量名放在花括号`{}`内。因此，`burger`变量需要写成`{burger}`，`fries`写成`{fries}`，`total`写成`{total}`。注意`total`本身已经是计算好的数值变量。',
  '`item="coffee"; cups=3; print(f"买了{cups}杯{item}。")` 输出：买了3杯coffee。'
),
(
  335,
  23,
  '格式化圆周率',
  '数学课代表想把圆周率π（变量`pi = 3.1415926535`）格式化为保留两位小数，补全他的f-string代码。',
  NULL,
  '["圆周率约等于：3.14"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "pi = 3.1415926535"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\\"圆周率约等于："}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\\")"}]}]}',
  '["pi", "{pi}", "{pi:.2f}", "pi:.2f", ":.2f", "{:.2f}", "3.14", "pi:.2", "{pi:.2}"]',
  '[3]',
  '在f-string中，使用`:`在表达式后引入格式说明符。`:.2f`表示将数字格式化为保留两位小数的浮点数。因此，完整的写法是`{pi:.2f}`。',
  '`money = 12.3456; print(f"${money:.1f}")` 输出：$12.3（保留一位小数）。'
),
(
  339,
  23,
  '制作个人主页',
  '帮小美用f-string生成她的个人主页欢迎语，需要计算她的年龄（当前年-出生年），并将技能列表连接起来。',
  NULL,
  '["欢迎小美（20岁）访问主页！她的技能有：Python, Painting, Cooking。"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "name = \\\"小美\\\""}, {"type": "code_line", "value": "birth_year = 2004"}, {"type": "code_line", "value": "current_year = 2024"}, {"type": "code_line", "value": "skills = [\\\"Python\\\", \\\"Painting\\\", \\\"Cooking\\\"]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "welcome = f\\\"欢迎{name}（"}, {"type": "slot", "index": 0}, {"type": "code", "value": "岁）访问主页！她的技能有："}, {"type": "slot", "index": 1}, {"type": "code", "value": "。\\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(welcome)"}]}]}',
  '["current_year - birth_year", "{current_year - birth_year}", "{\\\", \\\".join(skills)}", "skills", "str(skills)", "{skills}", "{\\\" \\\".join(skills)}", "{birth_year}"]',
  '[2, 3]',
  '第一个空需要计算年龄，这是一个表达式，应放入`{}`中，即`{current_year - birth_year}`。第二个空需要将列表`skills`中的元素用逗号和空格连接成一个字符串，应使用字符串的`.join()`方法，并放入`{}`中，即`{", ".join(skills)}`。',
  '`nums=[1,2,3]; print(f"列表：{nums}，连接后：{''-''.join(map(str, nums))}")` 输出：列表：[1, 2, 3]，连接后：1-2-3'
),
(
  340,
  23,
  '对齐与精度',
  '制作一个简易表格，需要将产品名左对齐，价格右对齐并保留一位小数。补全格式说明符。',
  NULL,
  '["Apple     12.5", "Banana     3.8", "Cherry    25.0"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "items = [(\\\"Apple\\\", 12.5), (\\\"Banana\\\", 3.75), (\\\"Cherry\\\", 25.0)]"}, {"type": "code_line", "value": "for name, price in items:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(f\\\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "    "}, {"type": "slot", "index": 1}, {"type": "code", "value": "\\\")"}]}]}',
  '["{name}", "{name:<10}", "{name:10}", "{price}", "{price:.1f}", "{price:>8.1f}", "{price:8.1f}", "{price:>.1f}"]',
  '[2, 7]',
  '`{name:<10}`表示变量`name`左对齐（`<`），并占用10个字符宽度。`{price:>8.1f}`表示变量`price`右对齐（`>`），占用8个字符宽度，并格式化为保留一位小数的浮点数（`.1f`）。这样能形成整齐的表格列。',
  '`print(f"|{‘ID‘:^10}|{‘Score‘:>6}|")` 输出：`|    ID     | Score|` （ID居中，Score右对齐）。'
),
(
  344,
  23,
  '综合报告生成',
  '生成一份数据分析简报，需要综合运用变量、计算、格式化和条件判断。',
  NULL,
  '["数据简报：用户数 1,024（↑ 增长），平均得分 85.7，状态：优秀。"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "current_users = 1024"}, {"type": "code_line", "value": "previous_users = 950"}, {"type": "code_line", "value": "growth_rate = (current_users - previous_users) / previous_users"}, {"type": "code_line", "value": "avg_score = 85.6666"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "report = f\\\"数据简报：用户数 {current_users:,}（"}, {"type": "slot", "index": 0}, {"type": "code", "value": " 增长），平均得分 "}, {"type": "slot", "index": 1}, {"type": "code", "value": "，状态："}, {"type": "slot", "index": 2}, {"type": "code", "value": "。\\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(report)"}]}]}',
  '["{growth_rate:.1%}", "‘↑‘ if growth_rate > 0 else ‘↓‘", "{‘优秀‘ if avg_score > 85 else ‘良好‘}", "{avg_score}", "{avg_score:.1f}", "growth_rate", "↑", "{growth_rate:+.1%}"]',
  '[7, 5, 3]',
  '第一空使用`{growth_rate:+.1%}`，`+`表示显示正负号，`.1%`表示以百分比形式保留一位小数。第二空使用`{avg_score:.1f}`保留一位小数。第三空使用条件表达式`{‘优秀‘ if avg_score > 85 else ‘良好‘}`根据分数判断状态。',
  '`rate=0.123; print(f"比率：{rate:+.2%}")` 输出：比率：+12.30%。'
),
(
  345,
  23,
  '循环中的f-string',
  '在循环中，使用f-string动态生成每一行的输出，补全代码。',
  NULL,
  '["第1名: Alice (95分)", "第2名: Bob (88分)", "第3名: Charlie (91分)"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "students = [(\\\"Alice\\\", 95), (\\\"Bob\\\", 88), (\\\"Charlie\\\", 91)]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "for i, (name, score) in enumerate(students, "}, {"type": "slot", "index": 0}, {"type": "code", "value": "):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print(f\\\"第{i}名: {name} ({score}分)\\\")"}]}]}',
  '["0", "1", "start=1", "2", "i+1", "index=1"]',
  '[3]',
  '`enumerate`函数默认从0开始计数。为了使循环变量`i`从1开始，以匹配“第1名”，需要设置`start=1`参数，即`enumerate(students, start=1)`。这样，第一轮循环`i`就是1。',
  '`for idx, item in enumerate([‘a‘, ‘b‘], start=100): print(f"{idx}-{item}")` 输出：100-a, 101-b。'
);