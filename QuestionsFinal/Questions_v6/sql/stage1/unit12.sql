-- Generated SQL for global_unit=12 (stage=1 unit_local=12 unit_id=12)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  166,
  12,
  '沙拉制作术',
  '小厨师阿强想做一份名为“果蔬沙拉”的菜品，他有两个字符串 `fruit = ''苹果''` 和 `vegie = ''黄瓜''`，想把它们拼成菜名，哪种做法无法得到“苹果黄瓜沙拉”？',
  '["fruit + vegie + ''沙拉''", "fruit + \\\"黄瓜\\\" + ''沙拉''", "''苹果'' + vegie + ''沙拉''", "fruit * vegie + ''沙拉''"]',
  4,
  '["运算符“*”是用来做什么的？", "乘号用于重复字符串，而非拼接两个字符串变量。", "`fruit * vegie` 会报错，因为 `vegie` 是字符串，不能作为整数重复次数。"]',
  '加号（+）用于拼接字符串。选项D尝试对两个字符串使用乘号（*），而乘号要求右侧操作数是整数（重复次数），字符串‘黄瓜’无法转换为整数，因此会引发TypeError。',
  '正确重复：`''-'' * 5` 得到 ‘-----’。错误尝试：`''hi'' * ''3''` 会报错。'
),
(
  167,
  12,
  '边界线魔法',
  '为了打印一条由 10 个‘=’组成的分隔线，魔法师小美念出了咒语 `line = ''=''`，接着她应该施展哪个法术？',
  '["print(line + 10)", "print(line * 10)", "print(10 * line)", "B和C都可以"]',
  4,
  '["需要的是“重复”还是“拼接”？", "字符串和整数用乘号运算是什么意思？", "乘法运算满足交换律吗？`''='' * 10` 和 `10 * ''=''` 结果一样吗？"]',
  '乘号（*）用于字符串重复时，操作数顺序不影响结果。`line * 10` 和 `10 * line` 都表示将字符串 `line`（值为‘=’）重复10次，得到‘==========’。',
  '类似地，`3 * ''Ha''` 和 `''Ha'' * 3` 都得到 ‘HaHaHa’。'
),
(
  168,
  12,
  '优先级大考验',
  '在表达式 `''喵'' * 3 + ''！'' * 2` 中，运算的最终结果是什么？',
  '["‘喵喵喵！！’", "‘喵喵喵！!’", "‘喵喵喵！！’", "‘喵喵喵！！！’"]',
  2,
  '["先做乘法还是先做加法？", "回忆一下，乘法和加法的优先级哪个高？", "相同优先级的运算，从左到右依次计算。"]',
  '乘号（*）和加号（+）的优先级相同，因此从左到右计算。先计算 `''喵'' * 3` 得‘喵喵喵’，再计算 `''！'' * 2` 得‘！！’，最后拼接得到‘喵喵喵！！’。',
  '类似地，`''A'' + ''B'' * 2 + ''C''` 会先计算 `''B''*2`，再从左到右拼接，得到 ‘ABBC’。'
),
(
  171,
  12,
  '混搭艺术家',
  '已知 `s = ‘Go!’`，执行 `result = (s * 2) + ‘Stop!’ + (‘-’ * 3)` 后，`result` 的值是？',
  '["‘Go!Go!Stop!---’", "‘Go!Go!Stop!-’", "‘Go!2Stop!-3’", "‘Go!*2Stop!-*3’"]',
  1,
  '["括号内的运算优先级最高，先算括号里的。", "`s * 2` 是重复，`‘-’ * 3` 也是重复。", "最后把所有部分用加号拼接起来。"]',
  '先计算括号内：`s * 2` 得‘Go!Go!’，`‘-’ * 3` 得‘---’。然后拼接：‘Go!Go!’ + ‘Stop!’ + ‘---’ = ‘Go!Go!Stop!---’。',
  '`(''Hi''*2) + ‘There’` 得到 ‘HiHiThere’。'
),
(
  172,
  12,
  '数字与文字',
  '阿乐想生成一条信息“我今年12岁”，他写了 `age = 12` 和 `msg = ''我今年'' + age + ''岁''`。运行会怎样？',
  '["成功打印“我今年12岁”", "打印“我今年age岁”", "打印“我今年12岁”，但age被转为字符串", "程序报错：TypeError"]',
  4,
  '["`age` 是什么类型？`‘我今年’`是什么类型？", "加号能直接把数字和字符串加起来吗？", "回忆一下，字符串拼接要求两边都是字符串。"]',
  '加号（+）用于字符串拼接时，要求操作数都是字符串。`age` 是整数（int），不能直接与字符串拼接，会引发 TypeError。需要先将数字转换为字符串，例如使用 `str(age)`。',
  '正确做法：`msg = ‘我今年’ + str(12) + ‘岁’` 或使用格式化字符串。'
),
(
  173,
  12,
  '格式化选择困难症',
  '哪种方法可以最简洁地将变量 `name=''小明''` 和 `score=95` 组合成字符串“小明得了95分”？',
  '["name + ‘得了’ + str(score) + ‘分’", "name + ‘得了’ + score + ‘分’", "f\\\"{name}得了{score}分\\\"", "‘%s得了%d分’ % (name, score)"]',
  3,
  '["选项B直接拼接整数会怎样？", "比较选项A、C、D的写法，哪个看起来最简单？", "f-string 是 Python 3.6 引入的现代格式化方法。"]',
  'f-string (格式化字符串字面值) 语法最简洁直观，直接在字符串前加 f，变量用花括号 `{}` 包裹，能自动处理类型转换。选项A需要手动转换 `score`，选项D是旧的格式化方法。选项B会因类型错误而报错。',
  '`f‘结果是 {3+5}’` 直接计算并嵌入，得到 ‘结果是 8’。'
),
(
  176,
  12,
  '高效连接者',
  '要把列表 `[‘A’, ‘B’, ‘C’]` 中的字母用连字符‘-’连接成‘A-B-C’，最高效的做法是？',
  '["`‘A’ + ‘-’ + ‘B’ + ‘-’ + ‘C’`", "`‘-’.join([‘A’, ‘B’, ‘C’])`", "`[‘A’, ‘B’, ‘C’][0] + ‘-’ + [‘A’, ‘B’, ‘C’][1] + ‘-’ + [‘A’, ‘B’, ‘C’][2]`", "`‘A-B-C’`"]',
  2,
  '["选项A和C在处理长列表时，代码会非常冗长。", "`join()` 是字符串的一个方法，专门用于拼接可迭代对象中的字符串。", "`str.join(iterable)` 使用 `str` 作为连接符。"]',
  '`‘-’.join([‘A’， ‘B’， ‘C’])` 是最高效和 Pythonic 的做法。`join()` 方法性能优于循环使用加号拼接，尤其是列表较长时。它用指定的连接符（‘-’）将列表中的所有字符串元素连接成一个新字符串。',
  '用空格连接单词：`‘ ’.join([‘Hello’， ‘World’])` 得到 ‘Hello World’。'
),
(
  177,
  12,
  '转义迷踪',
  '执行 `path = ‘C:\\’ + ‘Users\\’ + ‘Admin’` 后，`print(path)` 的输出是？',
  '["‘C:\\\\\\\\\Users\\\\\\\\\Admin’", "‘C:\\\\\\\\sers\\\\\\\\dmin’", "‘C:\\\\\\\\\Users\\\\\\\\\Admin’ (显示两个反斜杠)", "报错：语法错误"]',
  2,
  '["字符串中的 `\\\\\\\\\` 代表一个真正的反斜杠字符。", "拼接时，每个部分里的转义序列会被先解析。", "最终拼接成的完整字符串在打印时，反斜杠会如何显示？"]',
  '在字符串字面值中，`\\` 是一个转义序列，代表一个反斜杠字符。拼接时，三个部分分别是 ‘C:\’， ‘Users\’ 和 ‘Admin’。拼接结果为 ‘C:\Users\Admin’。打印时，每个 `\` 显示为一个反斜杠。',
  '`s = ‘Line1\nLine2’`， `print(s)` 会输出两行，因为 `\n` 被解析为换行符。'
),
(
  178,
  12,
  '性能大师',
  '在循环中构建一个很长的字符串（例如从空串开始，不断追加单词），从性能角度看，最好使用哪种方式？',
  '["用加号（+）不断拼接", "将单词放入列表，循环结束后用 `‘’.join(列表)`", "用乘号（*）一次性生成", "用字符串的 `+=` 操作符"]',
  2,
  '["字符串在Python中是不可变对象。每次用加号拼接都会创建新字符串。", "将中间结果存储在可变对象（如列表）中效率更高。", "`join()` 方法对长列表的拼接进行了高度优化。"]',
  '由于字符串不可变，在循环中使用加号拼接会反复创建新的字符串对象，开销大。先将子字符串收集到列表中（可变，追加高效），最后用 `‘’.join()` 一次性连接，这种方法（构建列表+join）性能最佳。',
  '高效构建：`parts = []`；循环中 `parts.append(word)`；最后 `result = ‘’.join(parts)`。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  169,
  12,
  '填空组队',
  '体育委员需要将三个同学的名字拼接成一个队名。请补全代码，让输出为“火箭飞人队”。',
  NULL,
  '["火箭飞人队"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "name1 = ''火箭''"}, {"type": "code_line", "value": "name2 = ''飞人''"}, {"type": "code_line", "value": "name3 = ''队''"}, {"type": "code_line", "value": "team_name = "}]}, {"type": "code_inline", "parts": [{"type": "code", "value": " "}, {"type": "slot", "index": 0}, {"type": "code", "value": " "}, {"type": "slot", "index": 1}, {"type": "code", "value": " "}, {"type": "slot", "index": 2}, {"type": "code", "value": " "}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(team_name)"}]}]}',
  '["name1", "name2", "name3", "+", "*", "''火箭''", "''飞人''", "''队''"]',
  '[0, 3, 1, 3, 2]',
  '正确的拼接方式是 `name1 + name2 + name3`。需要依次使用变量名和加号进行连接。',
  '将 `a=''Hello''`, `b=''World''` 拼接为 ‘HelloWorld’：`result = a + b`。'
),
(
  170,
  12,
  '重复造山',
  '程序员小张想用符号‘^’和‘_’画一座小山。请填空让代码输出目标图案。',
  NULL,
  '["  ^  ", " ^^^ ", "^^^^^"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "sym1 = ''^''"}, {"type": "code_line", "value": "sym2 = '' _ ''"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(''  '' + "}, {"type": "slot", "index": 0}, {"type": "code", "value": " + ''  '')"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print('' '' + "}, {"type": "slot", "index": 1}, {"type": "code", "value": " + '' '')"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 2}, {"type": "code", "value": ")"}]}]}',
  '["sym1", "sym1 * 1", "sym1 * 3", "sym1 * 5", "sym2", "sym2 * 1"]',
  '[1, 2, 3]',
  '第一行需要1个‘^’，第二行需要3个，第三行需要5个。使用 `sym1 * n` 可以重复字符‘^’ n次。',
  '画一条虚线：`line = ''-.'' * 5`，print(line) 输出 ‘-.-.-.-.-.’。'
),
(
  174,
  12,
  '句子生成器',
  '补全这个句子生成器，让它根据输入输出“疯狂的兔子跳了3次！”（假设输入是 animal=‘兔子’， verb=‘跳’， times=3）。',
  '["兔子", "跳", "3"]',
  '["疯狂的兔子跳了3次！"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "animal = input()"}, {"type": "code_line", "value": "verb = input()"}, {"type": "code_line", "value": "times = input()  # 输入是字符串''3''"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "sentence = \\\"疯狂的\\\" + "}, {"type": "slot", "index": 0}, {"type": "code", "value": " + \\\"了\\\" + "}, {"type": "slot", "index": 1}, {"type": "code", "value": " + \\\"次！\\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(sentence)"}]}]}',
  '["animal", "verb", "times", "str(times)", "verb + animal", "animal + verb"]',
  '[0, 5, 3]',
  '首先拼接‘疯狂的’和动物名 `animal`（兔子），然后拼接‘了’和动作 `verb`（跳），接着是次数 `times`（已是字符串‘3’），最后是‘次！’。',
  '生成“我喜欢Python”：`feeling=‘喜欢’; lang=‘Python’; msg=‘我’+feeling+lang`。'
),
(
  175,
  12,
  '密码强度模拟',
  '模拟生成一个“弱密码”：由用户名重复两次，再加三个感叹号组成。补全代码。',
  NULL,
  '["adminadmin!!!"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "username = ‘admin’"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "weak_pwd = "}, {"type": "slot", "index": 0}, {"type": "code", "value": " + "}, {"type": "slot", "index": 1}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(weak_pwd)"}]}]}',
  '["username", "username * 2", "username * 3", "''!''", "''!'' * 2", "''!'' * 3"]',
  '[1, 5]',
  '`username * 2` 将 ‘admin’ 重复两次得到 ‘adminadmin’。`‘!’ * 3` 得到 ‘!!!’。两者用加号拼接即可。',
  '用‘a’重复5次和‘#’重复2次组成密码：`pwd = ‘a’*5 + ‘#’*2`，得到 ‘aaaaa##’。'
),
(
  179,
  12,
  '购物清单生成',
  '补全代码，根据商品名和数量列表，生成格式化的购物清单字符串。',
  NULL,
  '["购物清单：苹果(x3)， 牛奶(x1)， 面包(x2)"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "items = [‘苹果’， ‘牛奶’， ‘面包’]"}, {"type": "code_line", "value": "quantities = [3， 1， 2]"}, {"type": "code_line", "value": "list_parts = []"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for i in range(len(items)):"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    part = items[i] + \\\"(x\\\" + "}, {"type": "slot", "index": 0}, {"type": "code", "value": " + \\\")\\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    list_parts.append(part)"}, {"type": "code_line", "value": ""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "shopping_list = \\\"购物清单：\\\" + "}, {"type": "slot", "index": 1}, {"type": "code", "value": " "}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(shopping_list)"}]}]}',
  '["str(quantities[i])", "quantities[i]", "\\\"， \\\".join(list_parts)", "\\\"、\\\".join(list_parts)", "list_parts[0]"]',
  '[0, 2]',
  '循环中，需要将数量 `quantities[i]` 转换为字符串才能拼接。循环结束后，用 `"， ".join(list_parts)` 将列表中的各个部分用逗号和空格连接成最终字符串。',
  '连接问候语：`greetings = [‘Hi’， ‘Hello’]; msg = ‘， ’.join(greetings)` 得到 ‘Hi， Hello’。'
),
(
  180,
  12,
  '艺术字生成',
  '补全代码，生成一个由‘*’组成、两边带有‘<’和‘>’装饰的边框文字，文字两边有空格。',
  NULL,
  '["<  *Welcome*  >"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "text = \\\"Welcome\\\""}, {"type": "code_line", "value": "decorator = \\\"*\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "left_side = \\\"< \\\" + "}, {"type": "slot", "index": 0}, {"type": "code", "value": " "}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "middle_part = "}, {"type": "slot", "index": 1}, {"type": "code", "value": " + text + "}, {"type": "slot", "index": 2}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "right_side = \\\" \\\">\\\""}, {"type": "code", "value": " "}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "banner = "}, {"type": "slot", "index": 3}, {"type": "code", "value": " "}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(banner)"}]}]}',
  '["decorator", "decorator * 1", "decorator * 2", "left_side", "middle_part", "right_side", "left_side + middle_part", "middle_part + right_side", "left_side + middle_part + right_side"]',
  '[1, 0, 0, 8]',
  '左边部分是‘< ’加上一个装饰符‘*’。中间部分是装饰符‘*’ + 文字‘Welcome’ + 装饰符‘*’。右边部分是固定字符串‘ >’。最后将左、中、右三部分拼接。',
  '生成装饰标题：`title = ‘[ ‘ + ‘=’*3 + ‘ TITLE ‘ + ‘=’*3 + ‘ ]’`，得到 ‘[ === TITLE === ]’。'
);