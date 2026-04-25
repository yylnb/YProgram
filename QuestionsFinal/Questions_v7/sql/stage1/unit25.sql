-- Generated SQL for global_unit=25 (stage=1 unit_local=25 unit_id=25)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  361,
  25,
  '真与假的字面',
  '阿强想告诉Python“这是真的”，下面哪个写法能被Python正确理解为布尔值真？',
  '["true", "True", "TRUE", "‘True’"]',
  2,
  '["想想看，Python对大小写敏感吗？", "Python中的布尔值是两个特定的关键字。", "它们分别是首字母大写的True和False。"]',
  '在Python中，布尔值True和False是关键字，必须首字母大写，其余字母小写。选项A和C大小写错误，选项D是字符串，不是布尔值。',
  '正确的布尔值写法：is_active = True； is_ready = False。'
),
(
  362,
  25,
  '比较结果',
  '猫猫和狗狗谁的年龄大？变量cat_age=3，dog_age=5，表达式 cat_age > dog_age 的结果是什么？',
  '["True", "False", "3", "5"]',
  2,
  '["这是一个比较大小的表达式。", "3大于5吗？想想看。", "比较运算符（如>）的结果是布尔值。"]',
  '比较运算符用于比较两个值，结果返回布尔值True或False。因为3不大于5，所以表达式cat_age > dog_age的结果是False。',
  '类似地，10 == 10 的结果是True，7 < 2 的结果是False。'
),
(
  363,
  25,
  '逻辑“与”的考验',
  '要参加派对，需要“年满18岁”并且“有邀请函”。小明20岁但没邀请函。用布尔表达，他能参加吗？',
  '["True and True 的结果是True，所以能。", "True and False 的结果是False，所以不能。", "False and False 的结果是True，所以能。", "False and True 的结果是True，所以能。"]',
  2,
  '["将条件转化为布尔值：20>=18为True，有邀请函为False。", "逻辑运算符and要求两边都为True，结果才是True。", "只要有一边是False，and的结果就是False。"]',
  '逻辑运算符and表示“并且”，只有左右两边的布尔值都为True时，结果才为True。此处True and False的结果为False，因此小明不能参加。',
  '例如，(5>2) and (3==3) 结果为True；(5>2) and (3==4) 结果为False。'
),
(
  366,
  25,
  '“非”此即彼',
  '机器人收到指令“不执行任务”。变量task_allowed原本是True，如何用一行代码改变其含义？',
  '["task_allowed = false", "task_allowed = not True", "task_allowed == False", "task_allowed = not task_allowed"]',
  4,
  '["“不执行”意味着对原布尔值取反。", "not是一个逻辑运算符，可以对布尔值进行反转。", "想想如何将变量自身的值变为相反值。"]',
  '逻辑运算符not用于对布尔值取反。`task_allowed = not task_allowed`会将变量从True变为False，或从False变为True，完美实现“反转”指令。选项A语法错误，选项B是常量，选项C是比较而非赋值。',
  '类似操作：is_day = not is_night。'
),
(
  367,
  25,
  '或运算的宽容',
  '超市促销：“用会员卡或消费满100元可打折”。小李没会员卡，消费了120元。用布尔逻辑判断，他能打折吗？',
  '["False or False 是 False，不能。", "False or True 是 True，能。", "True or False 是 True，能。", "True or True 是 False，不能。"]',
  2,
  '["转化条件：有会员卡=False，消费满100元=True。", "逻辑运算符or表示“或者”。", "or的规则是：只要有一边为True，结果就是True。"]',
  '逻辑运算符or表示“或者”，只要其左右两边的布尔值有一个为True，结果就为True。此处False or True结果为True，因此小李可以打折。',
  '例如，if (is_weekend) or (is_holiday): 表示周末或假期。'
),
(
  368,
  25,
  '真值检测',
  '在Python的if语句中，以下哪个值会被当作False，从而导致条件不成立？',
  '["1", "\\\"hello\\\"", "[1, 2, 3]", "0"]',
  4,
  '["Python中一些非布尔值在条件判断时也有“真”“假”概念。", "数字0通常被视作假值。", "非零数字、非空字符串、非空列表通常被视作真值。"]',
  '在Python布尔上下文中，0、0.0、空字符串''''、空列表[]、None等会被视为False。数字1、非空字符串、非空列表等被视为True。',
  'if 0: print("这不会执行")； if 1: print("这会执行")。'
),
(
  371,
  25,
  '优先级混战',
  '请问表达式 `not True and False or True` 在Python中的求值结果是什么？',
  '["False", "True", "报错", "None"]',
  2,
  '["记住逻辑运算符的优先级：not > and > or。", "先计算not True，得到False。", "然后计算False and False，得到False。最后计算False or True。"]',
  '逻辑运算符优先级为not最高，其次and，最后or。计算步骤：1. `not True` -> False；2. `False and False` -> False；3. `False or True` -> True。因此最终结果为True。',
  '使用括号可以改变优先级，如`not (True and False)`的结果是True。'
),
(
  372,
  25,
  '不等于的抉择',
  '阿宁想判断她的幸运数字（7）是否不等于朋友的幸运数字（9）。她应该用哪个表达式？',
  '["7 != 9", "7 == not 9", "not 7 == 9", "7 <> 9"]',
  1,
  '["“不等于”有专门的比较运算符。", "Python中不等于运算符是 !=。", "选项D是某些旧语言中的写法，Python不支持。"]',
  'Python中的“不等于”比较运算符是`!=`。`7 != 9`会正确返回True。选项B语法错误，选项C虽然逻辑对但写法不直接（`not (7 == 9)`更好），选项D是无效语法。',
  '类似判断：`password != ""` 用于检查密码是否非空。'
),
(
  373,
  25,
  '布尔类型本身',
  '在Python中，执行 `type(True)` 会得到什么结果？',
  '["<class ''int''>", "<class ''str''>", "<class ''bool''>", "<class ''keyword''>"]',
  3,
  '["True是Python内置的一种数据类型。", "它和整数、字符串一样，有自己专属的类型名称。", "想想我们正在学习的这个单元的主题是什么？"]',
  '`True`和`False`是布尔类型（bool）仅有的两个实例。使用`type()`函数查看其类型，会返回`<class ''bool''>`。',
  '同样，`type(False)` 也返回 `<class ''bool''>`。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  364,
  25,
  '灯光开关',
  '帮助小智完成电灯开关的模拟程序。当开关状态是“on”时灯亮，否则灯灭。',
  NULL,
  '["灯是亮的"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "switch = \\\"on\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "is_light_on = ("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 1}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"灯是亮的\\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\\"灯是灭的\\\")"}]}]}',
  '["switch == \\\"on\\\"", "is_light_on", "True", "switch", "\\\"on\\\"", "False"]',
  '[1, 2]',
  '第一个空需要将switch的值与"on"比较，得到一个布尔值（True或False）赋给is_light_on。第二个空if的条件直接使用这个布尔变量is_light_on即可。',
  '类似逻辑：is_rainy = (weather == "rainy")； if is_rainy: print("带伞")。'
),
(
  365,
  25,
  '双重认证',
  '一个安全系统需要密码正确且指纹验证通过才开门。补全下面的检查逻辑。',
  NULL,
  '["Access Granted!"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "password_correct = True"}, {"type": "code_line", "value": "fingerprint_verified = True"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if password_correct "}, {"type": "slot", "index": 0}, {"type": "code", "value": " fingerprint_verified:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"Access Granted!\\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\\"Access Denied!\\\")"}]}]}',
  '["and", "or", "not", "==", "+", "&"]',
  '[1]',
  '逻辑需求是“密码正确且指纹验证通过”，这对应逻辑运算符and。只有两个条件都为True时，整个表达式才为True。',
  '例如，if (age >= 18) and (has_id == True): 表示成年且有身份证。'
),
(
  369,
  25,
  '短路求值奇遇',
  '观察下面的代码，由于短路求值，有些函数根本不会被调用。请补全缺失的部分。',
  NULL,
  '["A is False", "Check over."]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def check_a():"}, {"type": "code_line", "value": "    print(\\\"A is False\\\")"}, {"type": "code_line", "value": "    return False"}, {"type": "code_line", "value": "def check_b():"}, {"type": "code_line", "value": "    print(\\\"B is True\\\")"}, {"type": "code_line", "value": "    return True"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "result = "}, {"type": "slot", "index": 0}, {"type": "code", "value": " check_a() "}, {"type": "slot", "index": 1}, {"type": "code", "value": " check_b()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"Check over.\\\")"}]}]}',
  '["and", "or", "True", "False", "not", "+"]',
  '[2, 1]',
  '由于输出只打印了“A is False”，说明check_b()没有被调用。在`True or X`中，因为第一个操作数已经是True，or运算结果必定为True，Python不会计算X，这就是短路求值。因此第一个空填True，第二个空填or。',
  '类似情况：`False and some_function()`，some_function永远不会被调用。'
),
(
  370,
  25,
  '范围守卫',
  '游戏里，英雄的攻击只有在他的生命值大于0且小于等于100时才有效。补全这个条件判断。',
  '["75"]',
  '["攻击有效！"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "hp = int(input())  # 假设输入75"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": " hp "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 0 "}, {"type": "slot", "index": 2}, {"type": "code", "value": " hp "}, {"type": "slot", "index": 3}, {"type": "code", "value": " 100:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"攻击有效！\\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\\"无法攻击。\\\")"}]}]}',
  '[">", ">=", "<", "<=", "==", "!=", "and", "or"]',
  '[1, 1, 6, 3]',
  '条件“hp大于0”写作`hp > 0`；“hp小于等于100”写作`hp <= 100`。两个条件需要同时满足，所以用`and`连接。完整的布尔表达式是 `hp > 0 and hp <= 100`。',
  '判断分数score是否在60到100之间：`if score >= 60 and score <= 100:`。'
),
(
  374,
  25,
  '登录逻辑拼图',
  '一个登录系统：如果用户名是“admin”且密码是“123”，或者临时令牌为真，则允许登录。补全这段核心逻辑。',
  NULL,
  '["登录成功！"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "username = \\\"admin\\\""}, {"type": "code_line", "value": "password = \\\"123\\\""}, {"type": "code_line", "value": "has_temp_token = True"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if ("}, {"type": "slot", "index": 0}, {"type": "code", "value": " == \\\"admin\\\" "}, {"type": "slot", "index": 1}, {"type": "code", "value": " "}, {"type": "slot", "index": 2}, {"type": "code", "value": " == \\\"123\\\") "}, {"type": "slot", "index": 3}, {"type": "code", "value": " has_temp_token:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"登录成功！\\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\\"登录失败。\\\")"}]}]}',
  '["username", "password", "and", "or", "has_temp_token", "True"]',
  '[1, 2, 3, 4]',
  '逻辑是“(用户名正确且密码正确) 或 有临时令牌”。因此，前两个空分别填入用户名和密码的变量名，第三个空连接两个条件用`and`，第四个空连接前面整体和最后一个条件用`or`。',
  '类似复杂条件：`if (score > 90 and attendance > 0.8) or is_exempt:`。'
),
(
  375,
  25,
  '布尔值变身记',
  '下面的代码演示了如何将布尔值用于算术运算。请补全代码，让最后输出的结果是数字1。',
  NULL,
  '["1"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = True"}, {"type": "code_line", "value": "b = False"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "result = int(a) "}, {"type": "slot", "index": 0}, {"type": "code", "value": " int(b)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(result)"}]}]}',
  '["+", "-", "*", "and", "or", "//"]',
  '[2]',
  '在Python中，`True`在算术上下文中被视为1，`False`被视为0。`int(True)`是1，`int(False)`是0。要使结果为1，需要用加法：1 + 0 = 1。',
  '类似地，`sum([True, False, True])`的结果是2，因为列表求和时True被当作1。'
);