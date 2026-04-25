-- Generated SQL for global_unit=29 (stage=1 unit_local=29 unit_id=29)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  421,
  29,
  '逻辑大挑战',
  '阿强写了一个逻辑表达式：(5 > 3) and (10 < 20) or (4 == 5)，你觉得这个表达式的最终结果是True还是False？',
  '["True", "False", "报错", "无法确定"]',
  1,
  '["想想逻辑运算符的优先级规则。", "and的优先级高于or。先计算and部分。", "(True and True) 是 True，然后 True or False 的结果是 True。"]',
  '根据逻辑运算符优先级，and高于or。先计算(5 > 3) and (10 < 20)得到True，再计算True or (4 == 5)得到True。因此最终结果为True。',
  '类似地，(1==2) or (3<4) and (5>0) 会先算and得到True，再算or得到True。'
),
(
  422,
  29,
  '优先级侦探',
  'Python侦察兵小智看到表达式：not a > b or c == d and e <= f。他想先执行‘not a > b’，应该怎么用括号明确这个意图？',
  '["(not a > b) or c == d and e <= f", "not (a > b or c == d and e <= f)", "not (a > b) or (c == d and e <= f)", "(not a > b or c == d) and e <= f"]',
  1,
  '["题目只想改变‘not’和比较运算‘a > b’的绑定。", "‘not’的优先级比比较运算符高，但比and/or低。", "加括号可以强制让‘not a > b’成为一个整体先计算。"]',
  'not的优先级高于比较运算符>，所以‘not a > b’本身会先结合。题目意图是让它整体先计算，所以只需将其括起来，即(not a > b)。其他部分保持原优先级顺序。',
  '类似需求：想让‘x == y and z’整体被not否定，应写为 not (x == y and z)。'
),
(
  423,
  29,
  '短路陷阱',
  '变量x=10，执行 if x > 100 and x / 0 > 1: print(‘危险!’) 会发生什么？',
  '["什么都不打印，无报错", "打印‘危险!’", "抛出除零错误ZeroDivisionError", "抛出语法错误"]',
  1,
  '["回忆逻辑运算符‘and’的短路求值特性。", "当第一个条件为假时，还会计算第二个条件吗？", "x>100为False，根据短路规则，整个表达式已确定为False。"]',
  '由于and运算符具有短路求值特性，当第一个条件x > 100为False时，整个表达式结果已确定为False，Python不会再去计算第二个条件x / 0 > 1，因此避免了除零错误，也不会执行print。',
  '短路求值的保护：if (y != 0) and (x / y > 5): 当y为0时，能安全避免除零错误。'
),
(
  426,
  29,
  '表达式解剖',
  '已知 a=True, b=False, c=True。请问表达式 not a or b and c 的值是多少？',
  '["True", "False", "报错", "None"]',
  2,
  '["逻辑运算符优先级：not > and > or。", "所以先算 not a 得 False，再算 b and c 得 False。", "最后是 False or False，结果是 False。"]',
  '根据优先级，not a 先计算得到 False。接着 b and c 计算得到 False。最后 False or False 得到 False。因此整个表达式结果为False。',
  '计算 not False and True or False：先not得True，再and得True，最后or得True。'
),
(
  427,
  29,
  '多重要求',
  '检查用户名‘admin’是否有效：它不能是空字符串，且要么是‘admin’，要么是‘root’。下面哪个表达式正确？',
  '["username != \\\"\\\" and username == \\\"admin\\\" or username == \\\"root\\\"", "username != \\\"\\\" and (username == \\\"admin\\\" or username == \\\"root\\\")", "(username != \\\"\\\" and username == \\\"admin\\\") or username == \\\"root\\\"", "username != \\\"\\\" or username == \\\"admin\\\" and username == \\\"root\\\""]',
  2,
  '[]',
  '正确逻辑是：用户名非空，并且（用户名等于‘admin’或‘root’）。由于and优先级高于or，选项A等价于 (非空且等于‘admin’) 或 (‘root’)，这会导致仅输入‘root’时也满足非空条件（虽然成立但逻辑顺序不佳）。选项B用括号明确了‘或’关系先结合，再与‘非空’进行‘且’运算，逻辑最清晰正确。',
  '类似条件：score > 0 and (answer == ‘A’ or answer == ‘B’)。'
),
(
  428,
  29,
  '动态逻辑',
  '初始时 x=5, y=10。执行 z = x > 3 and y < 20 后，再将 x 改为 2。请问此时 z 的值是？',
  '["True", "False", "报错", "值会随x改变而自动变化"]',
  1,
  '["z 在赋值时就已经被计算并存储了一个结果值。", "这个结果是 True 还是 False 呢？", "赋值时 x=5>3为True， y=10<20为True， True and True 得 True。"]',
  'Python中变量赋值存储的是表达式的计算结果值，而不是表达式本身。当执行 z = x > 3 and y < 20 时，使用当时的x和y值计算得到True，并将True这个结果赋给z。后续修改x的值不会影响z中已存储的True。',
  'a = 3; b = a > 2 # b为True。之后a=1，但b仍为True，不会变。'
),
(
  431,
  29,
  '权限检查点',
  '系统检查用户权限：是VIP会员（vip=True），或者（不是访客（guest=False）且积分大于1000）。下面哪个表达式能准确描述？',
  '["vip or not guest and points > 1000", "vip or (not guest and points > 1000)", "(vip or not guest) and points > 1000", "vip and not guest or points > 1000"]',
  2,
  '[]',
  '根据描述，满足条件一是vip=True。条件二是‘不是访客且积分>1000’，这是一个整体。两个条件是‘或’的关系。由于and优先级高于or，不加括号的vip or not guest and points > 1000在语法上等价于vip or (not guest and points > 1000)，但为了清晰表达意图，选项B的括号是最佳实践。选项C改变了条件关系，选项D逻辑错误。',
  '类似权限判断：is_admin or (is_user and has_permission)。'
),
(
  432,
  29,
  '非此即彼？',
  '表达式 not (x > 5 or y <= 10) 在什么情况下会为True？',
  '["x > 5 且 y <= 10", "x <= 5 且 y > 10", "x > 5 或 y <= 10", "x <= 5 或 y > 10"]',
  2,
  '["not对整个括号内的结果取反。", "括号内(x > 5 or y <= 10)为True的条件是什么？", "要使not后为True，括号内必须为False。想想‘或’运算为假的条件。"]',
  'not对括号内的整个‘或’表达式取反。‘(x > 5 or y <= 10)’为False的条件是：x > 5 为假 并且 y <= 10 为假，即 x <= 5 且 y > 10。此时not后得到True。',
  'not (a == b or c != d) 等价于 a != b and c == d。'
),
(
  433,
  29,
  '真假对对碰',
  '假设所有变量都是布尔类型。以下哪个复合表达式的结果一定为True？',
  '["p and not p", "p or not p", "p and (q or not q)", "(p and q) or (not p and not q)"]',
  2,
  '[]',
  'p or not p 是一个逻辑上的‘排中律’。对于布尔值p，它要么为True，要么为False。如果是True，则 p or ... 为True；如果是False，则 not p 为True，所以 ... or not p 也为True。因此无论p为何值，p or not p 恒为True。其他选项结果都依赖于p和q的具体值。',
  '类似的永真式：True or (任何表达式) 结果总是True。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  424,
  29,
  '智能门票',
  '帮助编写游乐园门票的优惠条件：年龄在12岁以下或65岁及以上，并且持有学生证或老年证，即可享受优惠。请补全if语句。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "age = 10"}, {"type": "code_line", "value": "has_student_card = True"}, {"type": "code_line", "value": "has_senior_card = False"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if (______):"}, {"type": "code_line", "value": "    print(\\\"您可以享受优惠票价！\\\")"}]}]}',
  '["age < 12", "age >= 65", "age < 12 or age >= 65", "has_student_card", "has_senior_card", "has_student_card or has_senior_card", "age < 12 and age >= 65", "has_student_card and has_senior_card", "age < 12 or has_senior_card"]',
  '[3, 6]',
  '条件分两部分：‘年龄在12岁以下或65岁及以上’用(age < 12 or age >= 65)表示；‘持有学生证或老年证’用(has_student_card or has_senior_card)表示。两者需要同时满足，所以用and连接。',
  '类似逻辑：(score >= 90 or attendance >= 0.95) and (project_done == True)。'
),
(
  425,
  29,
  '热气球起飞',
  '热气球起飞的条件是：天气不是雨天，且风速适中（大于5且小于等于20）。补全下面的逻辑判断。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "weather = \\\"sunny\\\""}, {"type": "code_line", "value": "wind_speed = 15"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "can_launch = "}, {"type": "slot", "index": 0}, {"type": "code", "value": " weather "}, {"type": "slot", "index": 1}, {"type": "code", "value": " \\\"rainy\\\" "}, {"type": "slot", "index": 2}, {"type": "code", "value": " wind_speed > 5 "}, {"type": "slot", "index": 3}, {"type": "code", "value": " wind_speed <= 20"}]}]}',
  '["not", "and", "or", "==", "!=", ">=", "<=", "(", ")"]',
  '[1, 8, 5, 2, 8]',
  '条件1：天气不是雨天，应写为 weather != "rainy"。条件2：风速适中，是 wind_speed > 5 and wind_speed <= 20。两个条件需同时成立，用and连接。用括号可以更清晰，但非必须。答案序列表示插入顺序：插入‘not’、‘(’、‘!=’、‘and’、‘)’以形成正确表达式。',
  '类似复合条件：not is_holiday and (time > 9 and time < 18)。'
),
(
  429,
  29,
  '安全密码锁',
  '一个简单的密码锁逻辑：尝试次数小于3次，并且（输入的密码等于‘123456’或等于‘000000’）。请补全while循环的条件。',
  '["1", "111111", "2", "123456"]',
  '["密码错误！", "解锁成功！"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "attempts = 0"}, {"type": "code_line", "value": "correct_pwd1 = \\\"123456\\\""}, {"type": "code_line", "value": "correct_pwd2 = \\\"000000\\\""}, {"type": "code_line", "value": "unlocked = False"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while ______ and not unlocked:"}, {"type": "code_line", "value": "    user_input = input(\\\"请输入密码: \\\")"}, {"type": "code_line", "value": "    if user_input == correct_pwd1 ______ user_input == correct_pwd2:"}, {"type": "code_line", "value": "        print(\\\"解锁成功！\\\")"}, {"type": "code_line", "value": "        unlocked = True"}, {"type": "code_line", "value": "    else:"}, {"type": "code_line", "value": "        print(\\\"密码错误！\\\")"}, {"type": "code_line", "value": "        attempts ______ 1"}]}]}',
  '["attempts < 3", "attempts <= 3", "attempts > 3", "or", "and", "==", "!=", "+=", "-=", "="]',
  '[1, 4, 8]',
  '第一个空：循环继续条件是尝试次数小于3次，即 attempts < 3。第二个空：两个正确密码满足一个即可，用 or 连接。第三个空：尝试次数需要增加1，用复合赋值运算符 attempts += 1。',
  '类似循环条件：while (count < max_tries) and (not found): 。类似条件：if key == ‘A’ or key == ‘B’:。'
),
(
  430,
  29,
  '智能夜灯',
  '帮小夜灯写判断逻辑：如果（天黑了并且有人移动）或者（时间超过晚上10点），就自动打开。补全条件表达式。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "is_dark = True"}, {"type": "code_line", "value": "motion_detected = False"}, {"type": "code_line", "value": "current_hour = 22"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "light_on = ("}, {"type": "slot", "index": 0}, {"type": "code", "value": " ______ "}, {"type": "slot", "index": 1}, {"type": "code", "value": ") ______ "}, {"type": "slot", "index": 2}, {"type": "code", "value": " > 22"}]}]}',
  '["is_dark", "motion_detected", "current_hour", "and", "or", "not", "(", ")"]',
  '[1, 2, 4, 5, 4]',
  '根据题意，条件A：天黑了并且有人移动 -> is_dark and motion_detected。条件B：时间超过晚上10点 -> current_hour > 22。两者是‘或’的关系。因此整个表达式应为 (is_dark and motion_detected) or (current_hour > 22)。',
  '类似应用：alarm = (door_open and not at_home) or (smoke_level > 100)。'
),
(
  434,
  29,
  '游戏关卡逻辑',
  '角色进入下一关的条件是：当前关卡大于1，并且（拥有‘钥匙’道具或打败了‘Boss’），同时生命值大于0。补全条件。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "level = 3"}, {"type": "code_line", "value": "has_key = True"}, {"type": "code_line", "value": "defeated_boss = False"}, {"type": "code_line", "value": "hp = 50"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "can_advance = level > 1 ______ (______ ______ ______) ______ hp > 0"}, {"type": "code_line", "value": "print(can_advance)"}]}]}',
  '["and", "or", "has_key", "defeated_boss", "hp", "level", "(", ")"]',
  '[1, 7, 3, 2, 4, 8, 1]',
  '整个条件是三个部分的‘与’：1. level > 1；2. (has_key or defeated_boss)；3. hp > 0。由于and优先级一致，从左到右结合，但用括号将‘或’部分括起来更清晰。因此填入 and, (, has_key, or, defeated_boss, ), and。',
  '综合条件示例：age >= 18 and (has_id or is_member) and fee_paid。'
),
(
  435,
  29,
  '终极表达式重构',
  '将下面的复杂表达式，按照运算优先级，通过添加括号来明确其默认的计算顺序。注意，只加括号，不改变其他部分。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "result = "}, {"type": "slot", "index": 0}, {"type": "code", "value": " not a "}, {"type": "slot", "index": 1}, {"type": "code", "value": " b "}, {"type": "slot", "index": 2}, {"type": "code", "value": " c "}, {"type": "slot", "index": 3}, {"type": "code", "value": " d > e"}]}]}',
  '["and", "or", "(", ")"]',
  '[3, 3, 2, 5, 5, 5]',
  '原表达式为 not a or b and c or d > e。默认优先级顺序为：not最高，然后是and，最后是or，比较运算符优先级高于逻辑运算符但此处d>e已是一个整体。因此，等价的计算顺序是 ((not a) or ((b and c) or (d > e)))。我们按此顺序添加括号，但不改变原表达式结构。',
  'a and b or c and d 的默认顺序等价于 (a and b) or (c and d)。'
);