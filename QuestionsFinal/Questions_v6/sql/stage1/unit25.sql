-- Generated SQL for global_unit=25 (stage=1 unit_local=25 unit_id=25)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  361,
  25,
  '数据分类员',
  '数据分类机器人小宝面对一堆数据犯了难，请问以下哪个选项是布尔（bool）类型的数据呢？',
  '["42", "3.14", "\\\"Hello\\\"", "False"]',
  4,
  '["想想看，布尔类型只有两个特定的值。", "一个是表示‘真’的True，另一个是表示‘假’的__？", "选项A是整数，B是小数，C是字符串，只有D是布尔值False。"]',
  '布尔类型只有两个值：True（真）和 False（假）。选项A是整数，B是浮点数，C是字符串，只有D的False是布尔类型。',
  '`is_open = True` 或 `has_error = False` 是布尔变量的常见用法。'
),
(
  362,
  25,
  '真假的拼写',
  '阿强想输入一个表示“真”的布尔值来启动魔法程序，他应该输入以下哪个？',
  '["true", "TRUE", "Ture", "True"]',
  4,
  '["在Python中，布尔值是关键字，有严格的写法。", "第一个字母是大写，后面的字母是小写。", "只有全部字母大小写都正确，Python才能识别。"]',
  '在Python中，布尔常量 True 和 False 的首字母必须大写，其余字母小写。true、TRUE、Ture 等写法都会被Python视为未定义的变量名而导致错误。',
  '定义开关状态：`light_on = True`，`system_running = False`。'
),
(
  363,
  25,
  '购物比较',
  '小明的钱包里有50元，一个玩具价格是30元。表达式 `50 > 30` 的结果是什么类型的值？',
  '["整数，结果是20", "布尔，结果是True", "布尔，结果是False", "字符串，结果是‘Yes’"]',
  2,
  '["比较操作符（如 >, ==）的作用是什么？", "它们不是进行数学计算，而是进行判断。", "判断就会得到一个‘是’或‘否’的结论，对应布尔值。"]',
  '比较运算符（如>, <, ==）用于比较两个值的大小或相等关系，其运算结果是布尔值（True或False）。50确实大于30，所以结果是True。',
  '`10 == 20` 的结果是 False，`‘a’ < ‘b’` 的结果通常是 True。'
),
(
  366,
  25,
  '闯关条件',
  '游戏角色要进入下一关，需要同时满足等级（level）≥10且拥有钥匙（has_key）为真。下面哪个布尔表达式可以正确表示这个条件？',
  '["level > 10 or has_key", "level >= 10 and has_key == True", "level >= 10 and has_key", "level >= 10 or has_key == True"]',
  3,
  '["‘同时满足’意味着要用哪个逻辑运算符？", "`has_key`本身已经是布尔变量，可以直接用于逻辑运算。", "`and`连接的两个条件都必须为真，且比较等级时‘≥’对应的运算符是`>=`。"]',
  '‘同时满足’使用 `and`。`level >= 10` 是条件一。`has_key` 是布尔变量，值为 True 或 False，可以直接作为条件二，写成 `has_key == True` 是冗余的。',
  '判断及格且优秀：`is_pass and is_excellent`。'
),
(
  367,
  25,
  '点餐二选一',
  '餐厅今日特惠：点‘汉堡’或‘披萨’可以打八折。变量 `order_burger` 和 `order_pizza` 记录了点餐情况。哪个表达式可以判断是否符合折扣条件？',
  '["order_burger and order_pizza", "order_burger or order_pizza", "not order_burger and not order_pizza", "order_burger == order_pizza"]',
  2,
  '["‘或’在逻辑运算中对应哪个关键词？", "是要求两个都点，还是点其中任意一个即可？", "`or`运算符表示只要任意一个条件为真，结果就为真。"]',
  '‘或’关系使用逻辑运算符 `or`。只要 `order_burger` 或 `order_pizza` 中有一个为 True（即点了这道菜），整个 `or` 表达式的结果就为 True，符合折扣条件。',
  '`has_coupon or is_member` 表示有优惠券或是会员即可享受优惠。'
),
(
  368,
  25,
  '反转会员状态',
  '变量 `is_member` 表示用户是否是会员。现在想得到一个表示‘非会员’状态的布尔值，应该使用哪个表达式？',
  '["is_member == False", "not is_member", "is_member = False", "False and is_member"]',
  2,
  '["逻辑‘非’运算在Python中使用哪个关键字？", "‘非’运算会反转一个布尔值：True变False，False变True。", "选项A也能得到结果，但选项B是更直接、更地道的用法。"]',
  '逻辑‘非’运算符 `not` 用于反转布尔值。`not is_member` 在 `is_member` 为 True 时结果为 False，反之则为 True，完美表示‘非会员’状态。',
  '`is_not_empty = not is_empty`，如果 `is_empty` 为假（即非空），则 `is_not_empty` 为真。'
),
(
  371,
  25,
  '类型转换魔法',
  '以下哪个表达式的结果是布尔值 `True`？',
  '["bool(0)", "bool(\\\"\\\")", "bool([])", "bool([1,2,3])"]',
  4,
  '["`bool()`函数可以将其他类型转换为布尔值。", "在Python中，0、空字符串、空列表通常被视作‘假’。", "非零数字、非空字符串、非空列表通常被视作‘真’。"]',
  '`bool()` 函数进行布尔转换。对于数字，0为False，非0为True。对于序列（如字符串、列表），空序列为False，非空序列为True。`[1,2,3]` 是非空列表，所以为True。',
  '`bool(10)` 为 True，`bool("Hi")` 为 True，`bool(0.0)` 为 False。'
),
(
  372,
  25,
  '短路判断',
  '已知 `x = 5`，执行 `result = (x > 10) and (x / 0 > 1)`，程序会如何？',
  '["result 为 True", "result 为 False", "程序崩溃，因为除以0了", "result 为 None"]',
  2,
  '["注意 `and` 运算符的特性。", "`and` 要求所有条件都为真才为真，如果第一个为假，它还会去看第二个吗？", "Python的 `and` 和 `or` 具有‘短路’求值特性，可以避免不必要的计算。"]',
  '`and` 运算符具有短路特性。`x > 10` 为 False，由于第一个操作数已经为 False，整个 `and` 表达式的结果必定为 False，Python不会计算第二个操作数 `(x / 0 > 1)`，因此程序不会因除以0而崩溃，`result` 被赋值为 False。',
  '类似 `is_valid and process(data)`，如果 `is_valid` 为假，则不会执行可能有风险的 `process` 函数。'
),
(
  373,
  25,
  '循环的开关',
  '小智用布尔变量 `found_treasure` 控制一个寻宝循环。下面哪段代码最有可能让循环在找到宝藏后停止？',
  '["while found_treasure: continue_searching()", "while not found_treasure: continue_searching()", "if found_treasure: while True: continue_searching()", "while found_treasure == True: stop_searching()"]',
  2,
  '["`while` 循环在条件为真时持续执行。", "我们希望在‘未找到宝藏’时继续找，找到后就停止。", "所以循环条件应该是‘未找到’，即对 `found_treasure` 取反。"]',
  '逻辑是：当‘没有找到宝藏’（`not found_treasure` 为 True）时，持续执行搜索函数 `continue_searching()`。一旦找到宝藏，`found_treasure` 变为 True，`not found_treasure` 变为 False，循环条件不再满足，循环停止。',
  '常用模式：`while not task_completed: do_work()` 表示任务未完成时就持续工作。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  364,
  25,
  '布尔变量赋值',
  '请帮小美完成代码，定义一个名为 `is_weekend` 的布尔变量，表示今天是周末。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "is_weekend = "}, {"type": "slot", "index": 0}]}]}',
  '["True", "False", "\\\"True\\\"", "1", "0", "是", "周末"]',
  '[0]',
  '定义一个布尔变量直接使用关键字 True 或 False 赋值即可，不需要引号。`True` 表示真/是，`False` 表示假/否。',
  '`is_raining = False` 表示没有下雨。'
),
(
  365,
  25,
  '晴天真好',
  '天气变量 `is_sunny` 为真，温度变量 `temperature` 为25。请补全代码，判断是否适合外出（晴天且温度高于20度）。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "is_sunny = True"}, {"type": "code_line", "value": "temperature = 25"}, {"type": "code_line", "value": ""}, {"type": "code_inline", "parts": [{"type": "code", "value": "can_go_out = is_sunny "}, {"type": "slot", "index": 0}, {"type": "code", "value": " temperature "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 20"}]}]}]}',
  '["and", "or", "not", ">", "<", "==", ">=", "<="]',
  '[0, 3]',
  '‘且’关系使用逻辑运算符 `and`。‘温度高于20度’用比较运算符 `>` 表示。因此完整表达式为 `is_sunny and temperature > 20`。',
  '`is_adult = age >= 18` 判断是否成年，`can_enter = is_member and has_ticket` 判断是否能入场。'
),
(
  369,
  25,
  '成绩单判断',
  '补全代码，如果成绩（score）大于等于60分，则打印‘及格’，否则打印‘不及格’。',
  '["75"]',
  '["及格"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "score = int(input())"}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_line", "value": "    print(\\\"及格\\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\\"不及格\\\")"}]}]}',
  '["score > 60", "score >= 60", "score == 60", "score", "True", "score < 60"]',
  '[1]',
  '条件需要判断成绩是否大于或等于60分，对应的比较运算符是 `>=`。`if` 后面的表达式结果为布尔值，当其为 True 时执行后续代码块。',
  '类似判断：`if age >= 18: print("成年人")`。'
),
(
  370,
  25,
  '借书规则',
  '图书馆规定：有借书卡（has_card）且没有未还书籍（has_overdue）才能借书。请补全判断逻辑。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "has_card = True"}, {"type": "code_line", "value": "has_overdue = False"}, {"type": "code_inline", "parts": [{"type": "code", "value": "can_borrow = "}, {"type": "slot", "index": 0}, {"type": "code", "value": " "}, {"type": "slot", "index": 1}, {"type": "code", "value": " "}, {"type": "slot", "index": 2}]}]}]}',
  '["has_card", "has_overdue", "not", "and", "or", "True", "False"]',
  '[0, 3, 2]',
  '条件一是 `has_card`。条件二是‘没有未还书籍’，即对 `has_overdue` 取反，写作 `not has_overdue`。两个条件需同时满足，用 `and` 连接。',
  '`can_park = has_permit and not in_violation` 表示有许可且未违规才能停车。'
),
(
  374,
  25,
  '空列表检测',
  '请补全代码，使用 `bool()` 函数判断列表 `my_list` 是否为空，并将结果存入变量 `is_list_empty`。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "my_list = []"}, {"type": "code_inline", "parts": [{"type": "code", "value": "is_list_empty = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "("}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}]}]}',
  '["bool", "not", "my_list", "len", "\\\"[]\\\"", "True", "False"]',
  '[0, 2]',
  '使用 `bool()` 函数进行转换。将需要判断的列表 `my_list` 作为参数传入。对于空列表 `[]`，`bool([])` 的结果是 False。因此 `is_list_empty` 会得到 False，但这个变量名本身意味着‘列表是空的’，所以逻辑上，`is_list_empty = not bool(my_list)` 更直接，但题目要求用 `bool()`。',
  '检查字符串是否为空：`is_empty = bool(message)` 为 False 则表示 `message` 是空字符串。'
),
(
  375,
  25,
  '智能家居逻辑',
  '智能家居系统：当温度（temp）低于20度‘或’时间（is_night）为夜晚‘且’有人在家（is_home）时，自动打开暖气。补全这个复杂的布尔表达式。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "temp = 18"}, {"type": "code_line", "value": "is_night = True"}, {"type": "code_line", "value": "is_home = True"}, {"type": "code_inline", "parts": [{"type": "code", "value": "heat_on = (temp < 20) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " ("}, {"type": "slot", "index": 1}, {"type": "code", "value": " "}, {"type": "slot", "index": 2}, {"type": "code", "value": " is_home)"}]}]}]}',
  '["or", "and", "is_night", "not", "temp", "<", ">", "True"]',
  '[0, 1, 2]',
  '条件A：`temp < 20`。条件B：`is_night and is_home`（夜晚且有人在家）。题目要求A‘或’B成立即可打开暖气，因此用 `or` 连接A和B。括号确保了正确的运算顺序。',
  '类似逻辑：`alarm_on = (door_open) or (window_open and is_night)` 表示门开或（窗开且是夜晚）就触发警报。'
);