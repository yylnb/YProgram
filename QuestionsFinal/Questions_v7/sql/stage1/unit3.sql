-- Generated SQL for global_unit=3 (stage=1 unit_local=3 unit_id=3)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  31,
  3,
  '购物车里的变量',
  '小明的购物车是一件商品。程序运行时，这个商品信息可能会变化。在Python中，什么最适合用来表示这种会变化的数据容器呢？',
  '["常量", "变量", "函数", "字符串"]',
  2,
  '["想想它的名字，“可变化”的东西。", "在编程里，用来存储可变数据的叫啥？", "答案就在单元主题里：变量与命名规则。"]',
  '变量就像一个带标签的盒子，可以存放数据，并且存放的数据可以在程序运行时被改变。常量则值固定不变，字符串是数据类型，函数是执行特定任务的代码块。',
  '例如，item_in_cart = ‘炸鸡’ 中的 item_in_cart 就是一个变量。'
),
(
  32,
  3,
  '给存钱罐起名字',
  '阿强想把数字100存起来，方便以后使用。下面哪一行代码正确地创建了一个名为“piggy_bank”的变量来完成这个任务？',
  '["piggy_bank == 100", "100 = piggy_bank", "piggy_bank = 100", "int piggy_bank = 100"]',
  3,
  '["Python里，变量名应该在等号的哪一边？", "‘==’是比较操作符，不是赋值用的。", "记住赋值的基本格式：变量名 = 值。"]',
  '在Python中，使用等号‘=’进行赋值操作，变量名总是在等号左边，要赋予的值在右边。选项A是比较，选项B颠倒了左右，选项D是其他语言的语法。',
  '类似地，age = 18 表示将数值18赋值给变量age。'
),
(
  33,
  3,
  '谁的名字最合法',
  'Python世界正在举办“最佳公民（变量名）评选”，以下哪位候选者拥有完全合法的名字？',
  '["2b_or_not_2b", "my-variable", "_private_data", "for"]',
  3,
  '["变量名可以以数字开头吗？", "变量名中允许出现短横线‘-’吗？", "‘for’这个词在Python里有特殊用途吗？"]',
  '变量名可以包含字母、数字和下划线，但不能以数字开头，不能包含连字符等特殊字符，且不能是Python关键字。‘_private_data’以单下划线开头是允许的。',
  '合法的名字如：user_name, total_price1, _index。'
),
(
  36,
  3,
  '电影院的座位',
  '小美的座位号一开始是‘A12’。后来她换到了‘B07’。下面代码执行后，会打印出什么？
seat = ‘A12’
seat = ‘B07’
print(seat)',
  '["A12", "B07", "A12B07", "报错"]',
  2,
  '["仔细看代码，给变量seat赋了几次值？", "第二次赋值后，变量seat里存的是哪个座位号？", "print(seat)打印的是变量当前的值。"]',
  '变量可以被重新赋值。代码先让seat指向字符串‘A12’，然后立即让它指向新的字符串‘B07’。最后打印时，输出的是变量seat当前的值‘B07’。',
  '类似地，x=1; x=5; print(x) 会输出5，因为x的最新值是5。'
),
(
  37,
  3,
  '起外号的规矩',
  '班里新来一个同学，大家想给他起个Python变量名当外号。以下哪个外号是不被允许的（非法的）？',
  '["new_student_2023", "_transfer_from_BJ", "99_lucy", "class_representative"]',
  3,
  '["回忆一下，变量名的开头能是数字吗？", "看看哪个选项是以数字开头的？", "“99_lucy”这个名字，第一个字符是‘9’，这允许吗？"]',
  'Python变量名不能以数字开头。“99_lucy”以数字‘9’开头，因此是非法变量名。其他选项均符合命名规则：可包含字母、数字、下划线，且不以数字开头。',
  '非法命名示例：2nd_place, 123abc。合法命名示例：place_2nd, abc123。'
),
(
  38,
  3,
  'Python的禁用语',
  '下面哪个选项是Python的关键字（保留字），因此绝对不能用作变量名？',
  '["print", "switch", "True", "sum"]',
  3,
  '["想想表示“真”或“假”的固定值。", "‘print’和‘sum’都是内置函数名，并非关键字。", "‘True’是布尔值常量，属于Python的保留字。"]',
  'True、False、None是Python中的字面常量，同时也是关键字，不能用作变量名。‘print’和‘sum’是内置函数名，虽然不建议覆盖它们，但技术上可以用作变量名（会覆盖原函数）。',
  '常见关键字包括：if, else, for, while, def, class, import等。'
),
(
  41,
  3,
  '售货机的秘密',
  '自动售货机用变量`item_code`存储商品代码‘A01’。从概念上讲，这个变量里真正存储的是什么？',
  '["内存中的一个地址，指向‘A01’这个数据", "印刷在纸条上的‘A01’字样", "一个名为‘A01’的小盒子", "显示在屏幕上的‘A01’"]',
  1,
  '["变量是直接拿着数据，还是知道数据在哪？", "想想现实中的快递柜，你是拿到了包裹，还是拿到了取件码？", "变量名是数据的‘标签’或‘引用’。"]',
  '变量本身是一个标识符（名字），它存储的是对数据所在内存位置的引用（地址），而不是数据本身。当我们使用变量名时，Python通过这个引用找到实际的数据。',
  '就像名片上写着地址，而不是把整栋房子带在身上。a=5，a是名字，它指向存有5的内存位置。'
),
(
  42,
  3,
  '符号迷阵',
  '以下哪个变量名的定义，会因为使用了不允许的符号而立即导致SyntaxError语法错误？',
  '["global_score", "player1_score", "player-score", "score_"]',
  3,
  '["连字符‘-’在变量名里是合法的吗？", "想想数学里的减号，如果用在名字里会怎样？", "‘player-score’看起来像个减法表达式。"]',
  '连字符‘-’在Python中会被解释为减号运算符，因此‘player-score’不是一个合法的变量名，会引发语法错误。变量名中只允许使用字母、数字和下划线。',
  '非法：total-price (应改为 total_price)。合法：total_price, price_total。'
),
(
  43,
  3,
  '内置函数大冒险',
  '虽然不推荐，但技术上可以将内置函数名（如`print`）用作变量名。这样做之后会发生什么？',
  '["程序会立即崩溃", "该变量会被自动重命名", "原`print`函数的功能被覆盖，无法再正常使用", "没有任何影响，两者和平共存"]',
  3,
  '["想想如果给‘张三’这个名字指派了另一个人，原来的张三去哪了？", "变量赋值会改变名字的‘指向’。", "关键字不能用作变量名，但内置函数名可以，只是..."]',
  '在Python中，内置函数名（如print, len）位于内置作用域。如果将它们用作变量名并赋值，就会在当前位置用新值覆盖这个名称，导致无法再访问原函数。',
  'print = ‘hello’; print(‘world’) 会报错，因为此时print是字符串，不是函数了。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  34,
  3,
  '填空订餐',
  '披萨店的点单程序需要记录顾客姓名和订单号。请将下面的代码补充完整。',
  NULL,
  '["顾客：张三", "订单号： 1024"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "customer_name = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\n"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "order_id = "}, {"type": "slot", "index": 1}, {"type": "code", "value": "\\n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"顾客：\\\" + customer_name)"}, {"type": "code_line", "value": "print(\\\"订单号：\\\", order_id)"}]}]}',
  '["张三", "\\\"张三\\\"", "1024", "‘1024’", "1024", "‘张三’", "\\\"1024\\\"", "customer_name"]',
  '[2, 5]',
  '第一个空需要为customer_name赋一个字符串值，所以是‘张三’（含引号）。第二个空需要为order_id赋一个整数值1024，所以是不带引号的1024。',
  '类似的，age = 25 赋整数值，city = ‘北京’ 赋字符串值。'
),
(
  35,
  3,
  '命名大改造',
  '一段糟糕的代码需要你重命名变量，使其符合Python命名规范。请从下方选择正确的名字填入挖空处。',
  NULL,
  '["30", "苹果"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": " "}, {"type": "slot", "index": 0}, {"type": "code", "value": " = 30\\n"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": " "}, {"type": "slot", "index": 1}, {"type": "code", "value": " = "}, {"type": "slot", "index": 2}, {"type": "code", "value": "\\n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(item_count)"}, {"type": "code_line", "value": "print(fruit_type)"}]}]}',
  '["item-count", "ItemCount", "item_count", "水果类型", "fruitType", "fruit_type", "\\\"苹果\\\"", "‘苹果’"]',
  '[3, 6, 8]',
  '变量名应使用小写字母和下划线组合。item_count符合规范。fruit_type也符合规范，应赋予字符串值‘苹果’。',
  '良好命名示例：student_age, file_path, max_score。'
),
(
  39,
  3,
  '交换果汁',
  '小红和小蓝想交换手里的果汁（变量值）。请用经典的三变量法帮他们完成交换。',
  NULL,
  '["小红有： 橙汁", "小蓝有： 苹果汁"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "hong = \\\"苹果汁\\\""}, {"type": "code_line", "value": "lan = \\\"橙汁\\\""}, {"type": "code_line", "value": "print(\\\"交换前：\\\" )"}, {"type": "code_line", "value": "print(\\\"小红有：\\\", hong)"}, {"type": "code_line", "value": "print(\\\"小蓝有：\\\", lan)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": " "}, {"type": "slot", "index": 0}, {"type": "code", "value": " = hong\\n"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "hong = "}, {"type": "slot", "index": 1}, {"type": "code", "value": "\\n"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "lan = "}, {"type": "slot", "index": 2}, {"type": "code", "value": "\\n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"\\\\\\n交换后：\\\")"}, {"type": "code_line", "value": "print(\\\"小红有：\\\", hong)"}, {"type": "code_line", "value": "print(\\\"小蓝有：\\\", lan)"}]}]}',
  '["temp", "lan", "hong", "temp"]',
  '[1, 2, 4]',
  '交换两个变量的值需要一个临时变量temp。首先将hong的值存入temp，然后将lan的值赋给hong，最后将temp（原hong的值）赋给lan。',
  '通用交换代码：temp = a; a = b; b = temp。'
),
(
  40,
  3,
  '填词造句',
  '请选择合适的变量名和字符串，让程序输出一句有趣的自我介绍。',
  NULL,
  '["我的名字是Python，我今年32岁了！"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "my_"}, {"type": "slot", "index": 0}, {"type": "code", "value": " = "}, {"type": "slot", "index": 1}, {"type": "code", "value": "\\n"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "my_"}, {"type": "slot", "index": 2}, {"type": "code", "value": " = 32\\n"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\\\"我的名字是\\\" + my_name + \\\"，我今年\\\" + str(my_age) + \\\"岁了！\\\" )"}]}]}',
  '["name", "age", "\\\"Python\\\"", "\\\"32\\\"", "‘Guido‘"]',
  '[1, 3, 2]',
  '根据输出，需要存储名字和年龄。第一个空应为“name”，并赋予字符串值“Python”。第二个空应为“age”，并赋予整数值32（打印时用str转换）。',
  '类似自我介绍：name=‘小明’; age=10; print(f‘我叫{name}，今年{age}岁。‘)'
),
(
  44,
  3,
  '快捷赋值',
  '请用Python的链式赋值和多重赋值，一次性完成多个变量的初始化。',
  NULL,
  '["a=5, b=5, c=5", "x=1, y=2, z=3"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "a = b = c = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\n"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(f\\\"a={a}, b={b}, c={c}\\\")\\n"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": " "}, {"type": "slot", "index": 1}, {"type": "code", "value": " = "}, {"type": "slot", "index": 2}, {"type": "code", "value": "\\n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(f\\\"x={x}, y={y}, z={z}\\\")"}]}]}',
  '["x, y, z", "1, 2, 3", "5", "(1, 2, 3)", "[1,2,3]"]',
  '[3, 1, 5]',
  '第一处是链式赋值，将同一个值5赋给a, b, c三个变量。第二处是多重赋值，将右侧元组(1,2,3)中的值按顺序解包赋给左侧的变量x, y, z。',
  '链式赋值：i=j=k=0。多重赋值：name, age = (‘李四‘, 20)。'
),
(
  45,
  3,
  '运算与命名',
  '请完成一个简单的购物计算：计算总价，并存储折扣后的价格。注意变量名的选择。',
  NULL,
  '["总价： 150", "折后价： 135.0"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "price_per_item = 50"}, {"type": "code_line", "value": "quantity = 3"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": " "}, {"type": "slot", "index": 0}, {"type": "code", "value": " = price_per_item "}, {"type": "slot", "index": 1}, {"type": "code", "value": " quantity\\n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"总价：\\\", total_price)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "discount_rate = 0.1\\n"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "final_price = total_price * (1 - "}, {"type": "slot", "index": 2}, {"type": "code", "value": ")\\n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"折后价：\\\", final_price)"}]}]}',
  '["total_price", "*", "discount", "discount_rate", "+", "-", "total"]',
  '[1, 2, 4]',
  '第一个空应为变量名total_price，第二个空应为乘法运算符*，用于计算总价。第三个空应为变量名discount_rate，用于计算折扣。',
  '类似计算：total = unit_price * count； discounted = total * (1 - discount)。'
);