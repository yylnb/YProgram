-- Generated SQL for global_unit=24 (stage=1 unit_local=24 unit_id=24)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  346,
  24,
  'f-string初体验',
  '阿明想用f-string在控制台热情地打个招呼，比如输出''Hello Alice''，假设name=''Alice''，哪个写法是正确的？',
  '["\\\"Hello {name}\\\"", "f\\\"Hello {name}\\\"", "f\\\"Hello \\\" name", "f\\\"Hello\\\" + name"]',
  2,
  '["f-string需要以f或F开头哦。", "变量名必须放在花括号{}里面。", "选项A缺少f前缀，C和D语法错误，正确是B。"]',
  '正确选项是B，因为f-string必须以f或F开头，并使用花括号{}嵌入变量名，直接输出字符串。',
  'name="Bob"; print(f"Hi {name}") 输出 Hi Bob。'
),
(
  347,
  24,
  '价格格式化',
  '小美在写购物程序，商品价格price=12.5，她希望显示为''Price: 12.50''（两位小数），应该用哪个f-string？',
  '["f\\\"Price: {price}\\\"", "f\\\"Price: {price:.2f}\\\"", "f\\\"Price: {price:2f}\\\"", "f\\\"Price: {price.d2f}\\\""]',
  2,
  '["数字格式化用冒号:加格式说明符。", ".2f表示保留两位小数。", "选项A无格式化，C缺少点，D语法错误。"]',
  '正确选项是B，: .2f指定了小数点后两位，将12.5格式化为12.50。',
  'value=3.14159; f"{value:.3f}" 输出 3.142。'
),
(
  348,
  24,
  '组合信息',
  '机器人想介绍用户：name=''Bob'', age=20，输出''Bob is 20 years old''，哪个f-string能实现？',
  '["f\\\"{name} is {age} years old\\\"", "\\\"{name} is {age} years old\\\"", "f\\\"{name} + is + {age} + years old\\\"", "f\\\"name is age years old\\\""]',
  1,
  '["f-string中变量直接放在{}里。", "选项B没有f前缀，不会替换变量。", "选项C和D语法错误，正确是A。"]',
  '正确选项A使用f-string嵌入变量name和age，花括号内的变量会被替换为值。',
  'f"Name: {name}, Age: {age}" 输出 Name: Bob, Age: 20。'
),
(
  351,
  24,
  '大写问候',
  '复习字符串方法：name=''alice''，如何用f-string输出''Hello ALICE''？',
  '["f\\\"Hello {name}\\\"", "f\\\"Hello {name.upper()}\\\"", "f\\\"Hello {upper(name)}\\\"", "f\\\"Hello {name.upper}\\\""]',
  2,
  '["字符串方法通过.调用，如upper()。", "在f-string中可以直接调用方法。", "选项A未大写，C和D语法错误。"]',
  '正确选项B在f-string中使用name.upper()调用upper方法，将字符串转换为大写。',
  'text=''hello''; f"{text.upper()}" 输出 ''HELLO''。'
),
(
  352,
  24,
  '清理空格',
  '复习字符串方法：user_input=''  python  ''，如何用f-string输出''python''（去除两端空格）？',
  '["f\\\"{user_input}\\\"", "f\\\"{user_input.strip()}\\\"", "f\\\"{strip(user_input)}\\\"", "f\\\"{user_input.trim()}\\\""]',
  2,
  '["strip()方法去除字符串两端空格。", "在f-string中调用方法需加括号。", "选项A保留空格，C和D语法错误。"]',
  '正确选项B使用user_input.strip()在f-string中调用strip方法，清理空格后输出。',
  'text=''  world  ''; f"{text.strip()}" 输出 ''world''。'
),
(
  353,
  24,
  '连接单词',
  '复习字符串方法：words=[''Hello'',''World'']，哪个选项能正确输出''Hello-World''？',
  '["\\\"-\\\".join(words)", "words.join(\\\"-\\\")", "join(words, \\\"-\\\")", "f\\\"{words.join(''-'')}\\\""]',
  1,
  '["join是字符串的方法，连接可迭代对象。", "语法是''separator''.join(iterable)。", "选项B、C、D语法错误。"]',
  '正确选项A使用"-".join(words)调用join方法，用连字符连接列表中的字符串。',
  '",".join([''a'',''b'']) 输出 ''a,b''。'
),
(
  356,
  24,
  '表达式计算',
  'f-string进阶：a=3, b=4，如何输出''The sum is 7''？',
  '["f\\\"The sum is {a+b}\\\"", "f\\\"The sum is {a}+{b}\\\"", "f\\\"The sum is \\\" + str(a+b)", "f\\\"The sum is {a} + {b}\\\""]',
  1,
  '["f-string花括号内可以放表达式。", "选项B会输出字面量，C和D语法或输出错误。", "直接计算a+b即可。"]',
  '正确选项A在f-string中嵌入表达式a+b，计算后输出结果7，实现动态内容。',
  'f"Product: {a*b}" 当a=3,b=4时输出 Product: 12。'
),
(
  357,
  24,
  '数字对齐',
  'f-string进阶：如何让数字10显示为''  10''（右对齐，宽度为3）？',
  '["f\\\"{10}\\\"", "f\\\"{10:3}\\\"", "f\\\"{10:>3}\\\"", "f\\\"{10:<3}\\\""]',
  3,
  '["对齐使用>（右对齐）或<（左对齐）。", "数字指定宽度，如:>3。", "选项A无格式化，B默认左对齐，D左对齐输出''10 ''。"]',
  '正确选项C使用:>3进行右对齐，宽度为3，数字10前填充两个空格，输出''  10''。',
  'f"{5:>5}" 输出 ''    5''（右对齐宽度5）。'
),
(
  358,
  24,
  '货币格式化',
  'f-string进阶：price=1234.567，如何输出''$1,234.57''（千位分隔符，两位小数）？',
  '["f\\\"${price:.2f}\\\"", "f\\\"${price:,.2f}\\\"", "f\\\"${price:.2f,}\\\"", "f\\\"${price:2f}\\\""]',
  2,
  '["千位分隔符用逗号,，格式如:,.2f。", ".2f保留两位小数。", "选项A无分隔符，C和D语法错误。"]',
  '正确选项B使用:,.2f添加千位分隔符并保留两位小数，1234.567格式化为1,234.57。',
  'f"{1234567:,.2f}" 输出 ''1,234,567.00''。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  349,
  24,
  '成绩百分比',
  '帮助小美用f-string格式化成绩score=0.95，输出''Score: 95%''。',
  NULL,
  '["Score: 95%"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "score = 0.95"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\\")"}]}]}',
  '["Score: {score:.0%}", "Score: {score:%}", "Score: {score:.1%}", "Score: {score}", "score:.0%"]',
  '[1]',
  '正确选项是''Score: {score:.0%}''，它使用百分比格式化，.0表示无小数位，0.95变为95%。',
  'f"{0.5:.0%}" 输出 ''50%''。'
),
(
  350,
  24,
  '用户信息输出',
  '完成代码，使用f-string输出''User: Alice, Age: 20''。',
  NULL,
  '["User: Alice, Age: 20"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "name = ''Alice''"}, {"type": "code_line", "value": "age = 20"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\\")"}]}]}',
  '["User: {name}, Age: {age}", "User: name, Age: age", "User: {name} Age: {age}", "{name} is {age}", "User: {name}, Age: age"]',
  '[1]',
  '正确选项是''User: {name}, Age: {age}''，它使用花括号嵌入变量name和age，输出格式化字符串。',
  'f"ID: {id}, Score: {score}" 输出类似 ID: 123, Score: 95。'
),
(
  354,
  24,
  '大写句子',
  '复习字符串方法：用f-string将text=''the quick brown fox''输出为全大写''THE QUICK BROWN FOX''。',
  NULL,
  '["THE QUICK BROWN FOX"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "text = ''the quick brown fox''"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\\")"}]}]}',
  '["{text.upper()}", "{text.upper}", "text.upper()", "{upper(text)}", "THE QUICK BROWN FOX"]',
  '[1]',
  '正确选项是''{text.upper()}''，它在f-string中调用upper方法，将字符串转换为大写。',
  'f"{''hello''.upper()}" 输出 ''HELLO''。'
),
(
  355,
  24,
  '清理输入',
  '复习字符串方法：用户输入有额外空格，完成代码输出''Name:John''。',
  '["  John  "]',
  '["Name:John"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "user_input = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "name = "}, {"type": "slot", "index": 0}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\\"Name:{name}\\\")"}]}]}',
  '["user_input", "user_input.strip()", "strip(user_input)", "user_input.trim()", " input() "]',
  '[2]',
  '正确选项是''user_input.strip()''，它使用strip方法去除输入字符串两端的空格，然后赋值给name。',
  'cleaned = input().strip(); f"Hello {cleaned}" 输出清理后的名字。'
),
(
  359,
  24,
  '报告格式化',
  '完成代码，用f-string输出''Report: Item A, Price: $10.50, Quantity: 3''。',
  NULL,
  '["Report: Item A, Price: $10.50, Quantity: 3"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "item = ''Item A''"}, {"type": "code_line", "value": "price = 10.5"}, {"type": "code_line", "value": "quantity = 3"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\\"Report: {item}, Price: $"}, {"type": "slot", "index": 0}, {"type": "code", "value": ", Quantity: "}, {"type": "slot", "index": 1}, {"type": "code", "value": "\\\")"}]}]}',
  '["{price:.2f}", "{quantity}", "{price}", "{item}", "10.5", "3", "{price:2f}"]',
  '[1, 2]',
  '第一个空使用{price:.2f}格式化价格为两位小数，第二个空使用{quantity}嵌入数量，输出完整报告。',
  'f"Item: {item}, Cost: ${cost:.2f}" 输出类似 Item: Book, Cost: $15.99。'
),
(
  360,
  24,
  '名字格式化',
  '输入名字，用f-string输出大写和标题格式，例如输入''alice''，输出''ALICE''和''Alice''。',
  '["alice"]',
  '["ALICE", "Alice"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "name = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\\""}, {"type": "slot", "index": 1}, {"type": "code", "value": "\\\")"}]}]}',
  '["{name.upper()}", "{name.title()}", "{upper(name)}", "{title(name)}", "name.upper()", "name.title()"]',
  '[1, 2]',
  '第一个print使用{name.upper()}输出大写，第二个使用{name.title()}输出标题格式，实现不同格式化。',
  '对于''hello'', f"{''hello''.upper()}" 输出 ''HELLO'', f"{''hello''.title()}" 输出 ''Hello''。'
);