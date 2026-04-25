-- Generated SQL for global_unit=16 (stage=1 unit_local=16 unit_id=16)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  226,
  16,
  '名字有多长',
  '阿强想看看自己的英文名''Aqiang''有几个字母，他应该使用以下哪段代码？',
  '["len(''Aqiang'')", "''Aqiang''.len()", "''Aqiang''.length", "length(''Aqiang'')"]',
  1,
  '["获取长度在Python里是一个函数还是一个方法呢？", "回想一下，len()函数的参数是什么？", "len()是内置函数，直接使用，字符串自身没有`.len()`或`.length`属性。"]',
  'len()是Python内置函数，用于获取序列（如字符串）的长度。调用方式为len(字符串)，因此选项A正确。选项B和C是其他语言的常见写法，在Python中无效。选项D的函数名错误。',
  '计算字符串‘Python’的长度：len("Python") 的结果是6。'
),
(
  227,
  16,
  '降噪模式开启',
  '小美的电脑音量设置被卡在了大写锁定，所有输入都变成了‘LOUD’。她想用一个方法把‘LOUD’变成温柔的小写，应该用哪个？',
  '["''LOUD''.lower()", "''LOUD''.small()", "lower(''LOUD'')", "''LOUD''.upper()"]',
  1,
  '["想想让字符串从大写变成小写的那个方法叫什么名字？", "字符串方法是属于字符串对象本身的，调用格式是‘字符串.方法名()’。", "lower是‘降低、小写’的意思，upper是‘向上、大写’的意思，别弄反了。"]',
  'lower()是字符串方法，用于将字符串中的所有大写字符转换为小写。调用格式为“字符串.lower()”。选项B方法名不存在；选项C错误地将其当作函数调用；选项D的作用是转为大写，与需求相反。',
  '将‘Hello’转为小写：‘Hello’.lower() 会返回新字符串‘hello’。'
),
(
  228,
  16,
  '让标题更醒目',
  '论坛里一个帖子的标题是‘important news’，版主想让它更显眼，以下哪个操作能得到‘IMPORTANT NEWS’？',
  '["''important news''.up()", "''important news''.upper()", "upper(''important news'')", "''important news''.uppercase()"]',
  2,
  '["让字母全部变成大写的那个方法，名字听起来就像是‘向上’。", "记住，方法是跟着字符串对象用的，格式是‘点方法名’。", "Python里标准的方法是.upper()，不是.up()或.uppercase()。"]',
  'upper()是字符串方法，用于将字符串中的所有小写字符转换为大写。调用格式为“字符串.upper()”。选项A和D的方法名不正确；选项C错误地将其当作独立函数调用。',
  '将‘python’转为大写：‘python’.upper() 会返回新字符串‘PYTHON’。'
),
(
  231,
  16,
  '中文字符长度之谜',
  '阿珍想知道自己的中文名‘阿珍’在Python里长度是多少。请问`len(''阿珍'')`的结果是？',
  '["2", "4", "1", "会报错"]',
  1,
  '["Python 3中，字符串默认使用Unicode编码。", "len()函数计算的是字符串中字符（包括中文字符）的个数，不是字节数。", "‘阿’和‘珍’各被视为一个字符。"]',
  '在Python 3中，字符串是Unicode字符序列。`len()`函数返回字符串中字符的个数。中文‘阿珍’包含两个字符，因此长度为2。',
  'len("Python编程") 的结果是8（6个英文字母+2个中文字符）。'
),
(
  232,
  16,
  '大小写转换混合战',
  '对于字符串s = "PyThOn"，连续执行`s.upper().lower()`后，最终得到的结果是？',
  '["PYTHON", "python", "PyThOn", "pYtHoN"]',
  2,
  '["先执行`s.upper()`，看看结果是什么？", "然后对第一步的结果再执行`.lower()`。", "这是一个链式调用，从左到右依次执行。"]',
  '首先`s.upper()`将‘PyThOn’全部转为大写，得到‘PYTHON’。然后对这个新字符串‘PYTHON’执行`.lower()`，将其全部转为小写，最终得到‘python’。',
  '"AbC".lower().upper() 会先得到''abc''，再得到''ABC''。'
),
(
  233,
  16,
  '不变的原石',
  '执行以下代码后，原始字符串`text`的值会改变吗？`text = "Hello"; new_text = text.upper()`',
  '["会，text变成‘HELLO’", "不会，text还是‘Hello’", "会，text变成‘hello’", "代码会报错"]',
  2,
  '["字符串在Python中是一种不可变的数据类型。", "字符串方法通常返回一个新的字符串对象。", "观察代码，是将`text.upper()`的结果赋值给了`new_text`。"]',
  '字符串是不可变对象。`text.upper()`方法会生成并返回一个全新的字符串‘HELLO’，但原始变量`text`所指向的字符串‘Hello’本身并没有发生任何改变。',
  's = "hi"; s2 = s.upper(); print(s)  # 输出仍然是‘hi’。'
),
(
  236,
  16,
  '判等陷阱',
  '在检查用户输入`user_input`是否等于预设密码‘secret’时，为了忽略大小写，以下哪种写法是正确且高效的？',
  '["if user_input == ''secret'' or user_input == ''SECRET'':", "if user_input.lower() == ''secret'':", "if user_input.upper() == ''SECRET'':", "if len(user_input) == len(''secret''):"]',
  2,
  '["选项A只考虑了两个特定的大小写组合，如果输入‘Secret’呢？", "核心思路是将双方都转为统一的大小写格式再比较。", "选项D只比较长度，显然不对，因为‘abc123’长度也是6。"]',
  '最可靠的方法是将用户输入和预设密码都转换为同一种大小写（通常是小写）后再进行比较。`user_input.lower() == ''secret''` 会将任何形式的‘Secret’、‘SECRET’等都转为‘secret’后判断。选项C原理类似，但预设字符串需改为大写。',
  '验证邮箱时忽略大小写：`if email.lower() == "admin@example.com":`'
),
(
  237,
  16,
  '方法的归属',
  '关于字符串的`len`, `lower`, `upper`，以下说法正确的是？',
  '["它们都是字符串对象的方法。", "`len`是函数，`lower`和`upper`是方法。", "`len`和`lower`是函数，`upper`是方法。", "它们都是Python内置函数。"]',
  2,
  '["回忆一下调用它们的语法：是`len(s)`还是`s.len()`？", "再回忆一下`lower`和`upper`的调用语法。", "`len()`可以用于多种数据类型，不只是字符串。"]',
  '`len()`是内置函数，其参数可以是字符串、列表等多种对象。`lower()`和`upper()`是字符串对象特有的方法，必须通过字符串实例调用（如`‘abc’.upper()`）。',
  '列表也有`len()`函数：`len([1,2,3])`，但列表没有`.lower()`方法。'
),
(
  238,
  16,
  '综合效果',
  '运行代码`text = " Hello World! "; result = len(text.strip().upper())`，请问`result`的值是多少？',
  '["11", "13", "12", "14"]',
  1,
  '["代码从右向左看：先`.strip()`，再`.upper()`，最后`len()`。", "`.strip()`方法的作用是移除字符串首尾的空格。", "数一下移除空格并转为大写后，还剩多少个字符。"]',
  '首先`text.strip()`移除首尾空格，得到‘Hello World!’。接着`.upper()`将其转为大写‘HELLO WORLD!’。最后`len()`计算这个字符串的字符数，包括字母和末尾的感叹号，共11个。',
  '"  Py  ".strip().upper() 得到‘PY’，长度为2。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  229,
  16,
  '格式化欢迎语',
  '一个系统需要统一处理用户输入的姓名，将其格式化为首字母大写、其余字母小写的标准格式。请补全下面的处理代码。',
  NULL,
  '["Welcome, Python!"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "username = \\\"pYtHoN\\\""}, {"type": "code_line", "value": "# 第一步：将所有字母转为小写"}, {"type": "code_inline", "parts": [{"type": "code", "value": "temp = username."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_line", "value": "# 第二步：将首字母转为大写"}, {"type": "code_inline", "parts": [{"type": "code", "value": "formatted_name = temp[0]."}, {"type": "slot", "index": 1}, {"type": "code", "value": "() + temp[1:]"}]}, {"type": "code_line", "value": "print(f\\\"Welcome, {formatted_name}!\\\")"}]}]}',
  '["lower", "upper", "len", "capitalize", "title"]',
  '[0, 1]',
  '第一步需要将整个字符串转为小写，应使用`lower()`方法。第二步需要将首字母（temp[0]）转为大写，应使用`upper()`方法。`capitalize()`方法虽然能一步到位，但此处要求分步填空。',
  '类似地，''hELLO''.lower().capitalize() 可以得到 ''Hello''。'
),
(
  230,
  16,
  '密码安全检查',
  '编写一个简单的密码安全检查，要求密码长度至少为8位。请补全条件判断语句。',
  NULL,
  '["密码太短，不安全！"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "password = input(\\\"请输入密码：\\\")"}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(password) "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 8:"}]}, {"type": "code_line", "value": "    print(\\\"密码太短，不安全！\\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\\"密码长度符合要求。\\\")"}]}]}',
  '["len", "lower", "upper", ">", ">=", "<", "<=", "==", "7", "9"]',
  '[0, 4]',
  '需要获取密码字符串的长度，应使用`len()`函数。条件判断是“如果长度小于8”，即“长度 < 8”。选项`<`表示小于。注意题目要求‘至少8位’，所以‘小于8’即不满足。',
  '判断字符串s是否恰好有5个字符：`if len(s) == 5:`'
),
(
  234,
  16,
  '统一验证码格式',
  '设计一个验证码生成器，要求无论用户输入的是大写还是小写字母，都统一转为大写后进行长度校验和输出。请补全代码。',
  '["abC123"]',
  '["转换后验证码：ABC123", "验证码长度为：6"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "raw_code = input()"}, {"type": "code_inline", "parts": [{"type": "code", "value": "std_code = raw_code."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()  # 统一格式"}]}, {"type": "code_line", "value": "print(f\\\"转换后验证码：{std_code}\\\")"}, {"type": "code_inline", "parts": [{"type": "code", "value": "code_length = "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(std_code)"}]}, {"type": "code_line", "value": "print(f\\\"验证码长度为：{code_length}\\\")"}]}]}',
  '["upper", "lower", "len", "size", "count", "capitalize"]',
  '[0, 2]',
  '题目要求统一转为大写，所以第一个空填`upper()`。第二个空需要获取统一后字符串的长度，应使用`len()`函数。',
  '类似需求：将用户输入的邮箱前缀统一为小写：`user_input.lower()`。'
),
(
  235,
  16,
  '创建简洁的用户ID',
  '程序需要从用户全名生成一个用户ID：取姓氏全小写，加上名字长度的数字。例如‘Zhang San’生成‘zhang3’。请补全生成逻辑。',
  NULL,
  '["zhang3"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "full_name = \\\"Zhang San\\\""}, {"type": "code_line", "value": "# 分割姓名"}, {"type": "code_line", "value": "last_name, first_name = full_name.split()"}, {"type": "code_line", "value": "# 处理姓氏：转为小写"}, {"type": "code_inline", "parts": [{"type": "code", "value": "processed_last = last_name."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()"}]}, {"type": "code_line", "value": "# 获取名字的长度"}, {"type": "code_inline", "parts": [{"type": "code", "value": "name_len = "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(first_name)"}]}, {"type": "code_line", "value": "# 组合成用户ID"}, {"type": "code_inline", "parts": [{"type": "code", "value": "user_id = processed_last + "}, {"type": "slot", "index": 2}, {"type": "code", "value": "(name_len)"}]}, {"type": "code_line", "value": "print(user_id)"}]}]}',
  '["lower", "upper", "len", "str", "int"]',
  '[0, 2, 3]',
  '第一个空需将姓氏转为小写，用`lower()`。第二个空需获取名字‘San’的长度，用`len()`，结果为3。第三个空需将数字长度3转换为字符串才能与前面的姓氏拼接，用`str()`。',
  '生成‘li4’：姓‘Li’小写为‘li’，名‘Si’长度为2，拼接为‘li’ + str(2) = ‘li2’。'
),
(
  239,
  16,
  '生成安全提示',
  '完成一个功能：根据用户输入密码的长度，生成不同‘温度’的安全提示。请补全判断逻辑。',
  '["abc"]',
  '["密码冰凉，强度过低！"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "pwd = input()"}, {"type": "code_inline", "parts": [{"type": "code", "value": "pwd_len = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(pwd)"}]}, {"type": "code_line", "value": "if pwd_len < 6:"}, {"type": "code_line", "value": "    print(\\\"密码冰凉，强度过低！\\\")"}, {"type": "code_inline", "parts": [{"type": "code", "value": "elif pwd_len "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 12:"}]}, {"type": "code_line", "value": "    print(\\\"密码温热，强度中等。\\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\\"密码滚烫，强度超高！\\\")"}]}]}',
  '["len", "lower", "upper", "<", "<=", ">", ">=", "==", "6", "12"]',
  '[0, 2]',
  '第一个空需要获取密码长度，用`len()`。根据上下文，第二个条件是判断长度是否大于等于12，对应‘>=’。因为小于6已处理，大于等于12为高，中间部分（6到11）为中等。注意边界值12的归属。',
  '分数评级：`if score >= 90: print(''A'')` 表示90分及以上为A。'
),
(
  240,
  16,
  '创建缩写标语',
  '编写程序，将公司口号‘Python Programming Is Fun’生成其缩写‘PPIF’。规则：取每个单词的首字母并大写。',
  NULL,
  '["PPIF"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "slogan = \\\"Python Programming Is Fun\\\""}, {"type": "code_line", "value": "words = slogan.split()  # 分割成单词列表"}, {"type": "code_line", "value": "abbr = \\\"\\\""}, {"type": "code_line", "value": "for word in words:"}, {"type": "code_inline", "parts": [{"type": "code", "value": "    abbr += word[0]."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()  # 取首字母并确保大写"}]}, {"type": "code_line", "value": "print(abbr)"}]}]}',
  '["upper", "lower", "len", "capitalize"]',
  '[0]',
  '需要将每个单词的首字母（word[0]）转换为大写，应使用`.upper()`方法。虽然`word[0]`可能已经是大写，但使用`.upper()`可以确保无论原单词首字母大小写如何，结果都是大写，使程序更健壮。',
  '为‘hello world’生成缩写：‘H’.upper() + ‘W’.upper() 得到 ‘HW’。'
);