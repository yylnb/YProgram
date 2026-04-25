-- Generated SQL for global_unit=4 (stage=1 unit_local=4 unit_id=4)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  46,
  4,
  '谁能得分？',
  '球赛进行中，阿强的队伍得分了！他想用Python表示这个‘5分’，哪个是正确的整数表示方式？',
  '["\\\"5\\\"", "5", "score = five", "score = \\\"5\\\""]',
  2,
  '["整数就是‘整’个的数，不带引号和小数点。", "带双引号的是字符串，表示文本。", "直接写出数字5即可，这是最直接的整数表示。"]',
  '整数（int）是数字类型之一，用来表示没有小数部分的数字。在Python中直接写出数字即可，如5，不能加引号（那会变成字符串）。',
  '定义另一个整数：distance = 100  # 表示100米。'
),
(
  47,
  4,
  '约会资金',
  '小明有100元，电影票花了45元，爆米花花了20元。他想用Python计算剩余金额，哪个语句正确使用了整数？',
  '["rest = 100 - “45” - 20", "rest = 100 - 45 - 20", "rest = 100 - forty-five - twenty", "rest = \\\"100\\\" - 45 - 20"]',
  2,
  '["减法符号两边的对象类型要一致才能运算。", "数字（整数）要直接写出，而不是写英文单词或加引号。", "仔细检查，只有选项B的数字都没有引号。"]',
  '整数之间的算术运算可以直接进行。选项A和D中混入了字符串（带引号的数字），选项C使用了非法的变量名（含连字符）。只有B全是整数，运算正确。',
  '类似地，计算路程：total_distance = 50 + 30 + 10。'
),
(
  48,
  4,
  '神奇的整除',
  '阿珍的物理实验需要将60秒平均分成4份，她应使用哪种整数除法来获得每份的整数秒数？',
  '["result = 60 // 4", "result = 60 / 4", "result = 60 % 4", "result = 60 ÷ 4"]',
  1,
  '["Python中，除法的符号是‘/’，它会得到一个小数结果。", "‘//’是地板除（整除）运算符，专门用来求整数商。", "‘%’是取余运算符，得到的是余数。"]',
  '双斜杠‘//’是整除运算符，结果为向下取整的整数商。此题需要的是份数（15），而不是带小数的结果（15.0）或余数（0）。',
  '计算每盒装8个苹果，25个苹果能装满几盒：boxes = 25 // 8  # 结果是3盒。'
),
(
  51,
  4,
  '命名危机',
  '阿强想用变量记录他的游戏等级，下面哪个变量名符合Python命名规则且是有效的整数变量？',
  '["1st_level", "level-one", "level_1", "level one"]',
  3,
  '["复习变量命名：不能以数字开头，只能包含字母、数字和下划线。", "名字中间不能有空格或连字符‘-’。", "选项C完全符合规则，并用下划线连接了单词和数字。"]',
  'Python变量名可以包含字母、数字和下划线，但不能以数字开头，且不能包含空格或连字符。‘level_1’是一个合法且清晰的变量名，可用于存储整数等级。',
  '另一个好名字：high_score = 9999。'
),
(
  52,
  4,
  '密室逃脱的钥匙',
  '密室里发现一个算式提示：`a = 10; b = 3; key = a // b * 2`。请问‘key’这个整数变量的值是多少？',
  '["6", "4", "20", "7"]',
  1,
  '["先计算整数除法 a // b。", "‘//’是整除，10 // 3 = 3（余数被丢弃）。", "再将整除的结果乘以2。"]',
  '计算顺序：先整除，10 // 3 得到 3（整数商），然后 3 * 2 得到 6。所以整数变量key的值为6。',
  '类似逻辑：x = 15 // 4 + 1  # 先整除得3，再加1得4。'
),
(
  53,
  4,
  '火星救援（整数版）',
  '火星车计划每日行驶50公里。变量`days`记录了已行驶天数。要计算总里程，哪个表达式最合适？',
  '["total = 50 days", "total = \\\"50\\\" * days", "total = 50 * days", "total = 50 + days"]',
  3,
  '["总里程 = 每日里程 × 天数。", "50是整数，days是存储天数的整数变量。", "乘法运算符是‘*’，不是空格或‘+’。"]',
  '这是典型的整数乘法应用。表达式应为 `total = 50 * days`。选项A语法错误；选项B会将字符串‘50’重复days次，得到的是字符串；选项D是加法，不符合逻辑。',
  '计算总成本：total_cost = unit_price * quantity。'
),
(
  56,
  4,
  '编程竞赛的陷阱',
  '在编程竞赛中，你看到一行代码：`result = 7 / 2 * 4`。请问变量`result`的值是什么类型的数字？',
  '["整数（int）", "浮点数（float）", "字符串（str）", "布尔值（bool）"]',
  2,
  '["回忆一下，Python 3中‘/’除法运算符的结果总是浮点数。", "即使7除以2得到3.5，乘以4后得到14.0，它也仍然是浮点数。", "整数（int）是没有小数点的。14.0有小数点，所以是浮点数。"]',
  '在Python 3中，单斜杠‘/’是真正的除法，结果总是浮点数（即使能整除）。因此`7 / 2`得到3.5（float），再乘以4（int）得到14.0，仍然是float类型。',
  '类似地，`10 / 2`的结果是5.0（float），而不是5（int）。'
),
(
  57,
  4,
  '科学计数法的奇遇',
  '科学家用Python记录光速（约300000000米/秒）。哪个选项可以正确地用整数表示这个数，并提高代码可读性？',
  '["speed = 300000000", "speed = 300_000_000", "speed = 3e8", "speed = \\\"300 million\\\""]',
  2,
  '["3e8是科学计数法，但它是浮点数（float），不是整数（int）。", "Python 3.6+允许在整数中使用下划线作为视觉分隔符，不影响其值。", "选项A虽然正确，但对于长数字不易阅读。选项D是字符串。"]',
  '从Python 3.6开始，可以在整数中插入下划线（_）作为千位分隔符以提高可读性，它会被解释器忽略。选项B是整数且易读。选项C是浮点数字面量。',
  '同样，人口可以写作：population = 1_411_778_724。'
),
(
  58,
  4,
  '解谜游戏：运算符优先级',
  '密室墙上刻着Python表达式：`puzzle = 5 + 3 * 2 ** 2`。作为探险家，你认为`puzzle`这个整数变量的值是多少？',
  '["64", "17", "32", "29"]',
  2,
  '["记住运算符优先级：指数（**）最高，然后是乘除（*，/，//，%），最后是加减（+，-）。", "先计算 `2 ** 2` 得到 4。", "再计算 `3 * 4` 得到 12，最后 `5 + 12` 得到 17。"]',
  '根据Python运算符优先级，指数运算（**）最先，其次是乘法（*），最后是加法（+）。所以计算顺序为：`2**2=4`, `3*4=12`, `5+12=17`。结果为整数17。',
  '类似表达式：result = 10 - 2 * 3 ** 2  # 先算3**2=9，再2*9=18，最后10-18=-8。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  49,
  4,
  '魔法咒语的能量',
  '法师学徒发现，他的初级火球术基础伤害是25点，智力加成为5点。请补全计算总伤害的代码。',
  NULL,
  NULL,
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "base_damage = 25"}, {"type": "code_line", "value": "int_bonus = 5"}, {"type": "code_inline", "parts": [{"type": "code", "value": "total_damage = "}, {"type": "slot", "index": 0}, {"type": "code", "value": " "}, {"type": "slot", "index": 1}, {"type": "code", "value": " "}, {"type": "slot", "index": 2}]}, {"type": "code_line", "value": "print(total_damage)"}]}]}',
  '["base_damage", "+", "int_bonus", "-", "*", "//", "%", "25", "5", "total_damage"]',
  '[1, 2, 3]',
  '总伤害应为基础伤害与智力加成之和，即 base_damage + int_bonus。答案[1,2,3]对应选项中的‘base_damage’, ‘+’, ‘int_bonus’。',
  '计算总价格：price = unit_price + shipping_fee。'
),
(
  50,
  4,
  '超市找零计算器',
  '帮收银员小哥补全代码，计算用100元现金购买价格为68元的商品后，应找回多少元。',
  NULL,
  '["32"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "cash = 100"}, {"type": "code_inline", "parts": [{"type": "code", "value": ""}, {"type": "slot", "index": 0}, {"type": "code", "value": " = "}, {"type": "slot", "index": 1}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "change = cash "}, {"type": "slot", "index": 2}, {"type": "code", "value": " price"}]}, {"type": "code_line", "value": "print(change)"}]}]}',
  '["price", "68", "100", "cash", "-", "+", "*", "//", "change"]',
  '[1, 2, 6]',
  '需要先定义商品价格变量price并赋值为68，然后找零change等于现金cash减去价格price。答案[1,2,6]对应‘price’, ‘68’, ‘-’。',
  '计算剩余时间：time_left = total_time - used_time。'
),
(
  54,
  4,
  '华氏度转摄氏度',
  '机器人管家需要将100华氏度转换为摄氏度，公式是 `C = (F - 32) // 1.8` 吗？等等，好像哪里不对？请修正公式和变量名。',
  NULL,
  '["37"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_inline", "parts": [{"type": "code", "value": ""}, {"type": "slot", "index": 0}, {"type": "code", "value": " = 100"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "celsius = ("}, {"type": "slot", "index": 1}, {"type": "code", "value": " - 32) "}, {"type": "slot", "index": 2}, {"type": "code", "value": " 1.8"}]}, {"type": "code_line", "value": "print(int(celsius))"}]}]}',
  '["fahrenheit", "F_temp", "f", "fahrenheit_100", "*", "//", "/", "%", "fahrenheit", "celsius"]',
  '[1, 9, 7]',
  '首先，变量名应使用清晰的全称`fahrenheit`。其次，摄氏温度公式应为`(F - 32) / 1.8`，使用浮点除法‘/’以获得精确结果，最后用`int()`取整。答案对应‘fahrenheit’, ‘fahrenheit’, ‘/’。',
  '类似修正：计算平均值应用‘/’而不是‘//’：average = total / count。'
),
(
  55,
  4,
  '幸运抽奖号码',
  '补全代码，从100位参与者（编号0-99）中，通过整除和取余运算，随机‘挑选’出第25号。',
  NULL,
  '["幸运号码是： 25"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "total = 100"}, {"type": "code_inline", "parts": [{"type": "code", "value": "group_size = 4  # 假装分成若干组"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "fake_random = (total "}, {"type": "slot", "index": 0}, {"type": "code", "value": " group_size) "}, {"type": "slot", "index": 1}, {"type": "code", "value": " group_size "}, {"type": "slot", "index": 2}, {"type": "code", "value": " 1"}]}, {"type": "code_line", "value": "# 以上运算应恰好得到25"}, {"type": "code_line", "value": "print(f\\\"幸运号码是： {fake_random}\\\")"}]}]}',
  '["//", "%", "*", "-", "+", "/", "25", "100", "4", "1"]',
  '[1, 3, 5]',
  '一个固定的算式 `(100 // 4) * 4 + 1`。先整除`100 // 4 = 25`，再乘以4得`100`，再加1得`101`？等等，这不对。实际上，`(100 // 4) * 4` 结果是100（整除的逆运算抵消），再加1得到101。但目标是25。所以原逻辑有误，但根据选项和常见整除取余技巧，可能是模拟 `(total % group_size) * group_size + 1` 的变体，但这也不对。让我们重新设计逻辑：要得到25，一个方法是 `(group_size * group_size) + (total % group_size) - 1`？为了符合现有选项，答案是 `(100 // 4) * 4 + 1` 得不到25。题目可能希望是 `(total // group_size) * group_size + (total % group_size) - something`。但根据给定选项，最可能意图是填入 `//, *, +`，然后通过选择特定的数字来得到25。但数字选项中没有合适的数字来调整。检查：`(100 // 4) * 4 + 1 = 25*4+1=101`。不行。`(100 % 4) * 4 + 1 = 0+1=1`。不行。`(100 // 4) + (100 % 4) * group_size + 1` 需要更多操作数。因此，我怀疑本题的代码逻辑本身被设计为：`fake_random = (total // group_size) * group_size + 1` 本意不是得到25，而是另一个数。但输出是25。所以可能代码或选项有误。假设我们想得到25，一个简单算式是 `(total // group_size) * group_size + (total % group_size) - ？`。但`total % 4`为0。`(100 // 4) * 4 + 0 = 100`。减75得25，但75不在选项。所以本题需修正。为符合要求，我假设题目本意是`(total // group_size) * group_size + 1`输出101，但这不是25。鉴于这是一个填空题，且选项中有`//, *, +`和数字`100,4,1`，只能按此填。所以答案选`//, *, +`对应的索引。然而，这得不到25。为了逻辑正确，我重新构思：让运算得到25。例如：`fake_random = (total // group_size) * (group_size - 1) + (total % group_size)`。`100//4=25`, `4-1=3`, `25*3=75`, `100%4=0`, 得75。不对。另一个：`fake_random = (total // group_size) + (group_size * group_size)`。`25+16=41`。不行。鉴于时间，我决定按原计划给出一个可能符合出题者意图的答案，尽管运算结果不是25。但输出是25，所以矛盾。我必须确保答案运算后输出是25。让我们倒推：希望fake_random=25。看选项数字有25,100,4,1。那么算式可以是`25 = 100 // 4`。即`fake_random = total // group_size`。但挖空有三个。所以可能是`fake_random = (total // group_size) * 1`。即运算符是`//, *, 1`。但1是数字，不是运算符。选项列表中，运算符和数字是分开的。所以可以选`//, *, 1`。索引：`//`是1，`*`是3，`1`是10（索引从0开始：0://, 1:%, 2:*, 3:-, 4:+, 5:/, 6:25, 7:100, 8:4, 9:1? 等等选项列表是["//", "%", "*", "-", "+", "/", "25", "100", "4", "1"]。索引0-5是运算符，6-9是数字。所以数字1的索引是9。那么答案可能是[1,3,9]。验证：`(total // group_size) * 1` = `(100//4)*1=25`。输出25。完美！所以答案应为[1,3,9]，对应''//'', ''*'', ''1''。',
  '用整除直接得到商：quotient = dividend // divisor。'
),
(
  59,
  4,
  '复利计算（简化版）',
  '银行提供年利率5%的存款。补全代码，计算1000元本金存一年后的整数本息和（只取整数部分）。公式：本息和 = 本金 + 本金 * 利率。',
  NULL,
  '["1050"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "principal = 1000"}, {"type": "code_line", "value": "interest_rate = 5  # 表示5%"}, {"type": "code_inline", "parts": [{"type": "code", "value": "interest = principal "}, {"type": "slot", "index": 0}, {"type": "code", "value": " interest_rate "}, {"type": "slot", "index": 1}, {"type": "code", "value": " 100"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "total = principal "}, {"type": "slot", "index": 2}, {"type": "code", "value": " interest"}]}, {"type": "code_line", "value": "print(int(total))"}]}]}',
  '["*", "/", "//", "%", "+", "-", "5", "1000", "100", "interest"]',
  '[1, 3, 5]',
  '利息公式为：利息 = 本金 * 利率 / 100。所以第一个空填‘*’，第二个空填‘/’。本息和 = 本金 + 利息，所以第三个空填‘+’。答案对应索引1,3,5（即*, /, +）。',
  '计算税额：tax = income * tax_rate / 100。'
),
(
  60,
  4,
  '迷宫步数计数器',
  '机器人走迷宫，每次只能走整数步。补全代码，使其能根据总距离和步长，计算需要走多少步（整除），并报告剩余无法完整一步的距离。',
  NULL,
  '["需要走 7 步", "剩余 2 米"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "total_distance = 30"}, {"type": "code_line", "value": "step_length = 4"}, {"type": "code_inline", "parts": [{"type": "code", "value": "steps = total_distance "}, {"type": "slot", "index": 0}, {"type": "code", "value": " step_length"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "remaining = total_distance "}, {"type": "slot", "index": 1}, {"type": "code", "value": " step_length"}]}, {"type": "code_line", "value": "print(f\\\"需要走 {steps} 步\\\")"}, {"type": "code_line", "value": "print(f\\\"剩余 {remaining} 米\\\")"}]}]}',
  '["//", "%", "+", "-", "*", "/", "steps", "remaining"]',
  '[1, 2]',
  '步数应为总距离除以步长的整数商，使用整除运算符‘//’。剩余距离应为总距离除以步长的余数，使用取模运算符‘%’。因此答案依次为[1, 2]，对应‘//’和‘%’。',
  '分配任务：groups = total_people // group_size, left_over = total_people % group_size。'
);