-- Generated SQL for global_unit=14 (stage=1 unit_local=14 unit_id=14)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  196,
  14,
  '快递切片',
  '快递员小派有个字符串‘Room202’，他想取出‘Room’。哪行代码像正确的快递单一样指明了正确范围？',
  '["‘Room202’[0:3]", "‘Room202’[0:4]", "‘Room202’[1:4]", "‘Room202’[:3]"]',
  2,
  '["字符串索引从0开始，‘R’是位置0。", "切片规则是[开始:结束]，包含开始，不包含结束。", "要取‘Room’，是从0到4，但不包括索引4的字符。"]',
  '字符串切片语法为str[start:end]，包含起始索引，不包含结束索引。‘Room’对应索引0(''R'')、1(''o'')、2(''o'')、3(''m'')，因此正确的范围是[0:4]。',
  '对于‘Python’，[0:2]得到‘Py’。'
),
(
  197,
  14,
  '迷宫历险',
  '字符串‘ABCDEFG’是一条迷宫路径。指令path[2:5]会让探险家走到哪个房间？',
  '["‘CDE’", "‘BCDE’", "‘CDEF’", "‘DEF’"]',
  1,
  '["索引从0开始，A=0，B=1，C=2...", "切片[2:5]从索引2开始，到5结束。", "记住规则：包含开始，不包含结束。"]',
  '在字符串‘ABCDEFG’中，索引2是‘C’，索引5是‘F’。切片[2:5]包含索引2的‘C’，不包含索引5的‘F’，因此结果是‘CDE’。',
  '‘Hello’[1:4]得到‘ell’，因为包含索引1的‘e’，不包含索引4的‘o’。'
),
(
  198,
  14,
  '倒着拿文件',
  '文件名是‘report.pdf’，你想用切片取出它的扩展名‘pdf’。下面哪个负索引切片是正确的？',
  '["‘report.pdf’[-4:-1]", "‘report.pdf’[-3:]", "‘report.pdf’[-4:]", "‘report.pdf’[:-4]"]',
  3,
  '["负索引从-1开始，-1是‘f’。", "扩展名‘.pdf’是从点号开始的最后4个字符。", "想想哪个切片能包含点号并取到最后。"]',
  '使用负索引时，-1代表最后一个字符‘f’，-2是‘d’，-3是‘p’，-4是‘.’。切片[-4:]表示从索引-4（即‘.’）开始，一直到字符串末尾，因此结果是‘.pdf’。选项B[-3:]会得到‘pdf’，但题目要求带点号，故C为佳。本题强调识别包含起止点的完整范围。',
  '对于‘photo.jpg’，[-4:]得到‘.jpg’。'
),
(
  201,
  14,
  '跳跃取字',
  '间谍想从密文‘AaBbCcDd’中每隔一个字符提取大写字母做成密码。他应该使用哪个带步长的切片？',
  '["‘AaBbCcDd’[0::1]", "‘AaBbCcDd’[0::2]", "‘AaBbCcDd’[1::2]", "‘AaBbCcDd’[::3]"]',
  2,
  '["大写字母‘A’，‘B’，‘C’，‘D’在索引0,2,4,6。", "步长是切片中第三个参数，表示每隔几个字符取一个。", "从索引0开始，每隔一个取，步长应该是2。"]',
  '完整切片语法为[start:end:step]。字符串‘AaBbCcDd’中，大写字母位于索引0(‘A’)、2(‘B’)、4(‘C’)、6(‘D’)。从索引0开始，每隔一个字符（步长2）取一次，即可得到‘ABCD’。',
  '对于‘12345678’，[::2]得到‘1357’，因为从开始每隔一个取。'
),
(
  202,
  14,
  '鹦鹉学舌（部分）',
  '鹦鹉的词汇是‘HelloHello’。如果你写代码word[:5]，它会重复说哪一部分？',
  '["‘HelloHello’", "‘Hello’", "‘elloH’", "‘’ (空字符串)"]',
  2,
  '["切片[:5]省略了起始索引。", "省略起始索引时，默认从0开始。", "所以这是从开头取到索引5（不包含5）。"]',
  '切片中如果省略起始索引，则默认从0开始。[:5]等价于[0:5]，表示从索引0取到索引5（不包含索引5），因此从‘HelloHello’中取出前5个字符‘Hello’。',
  '对于字符串‘World’，[:3]得到‘Wor’。'
),
(
  203,
  14,
  '贪吃蛇吃字符串',
  '贪吃蛇面对字符串‘ABCD’，它执行了操作s = ‘ABCD’[-2:-4:-1]。蛇吃了什么？',
  '["‘DC’", "‘CB’", "‘BA’", "‘’ (空字符串，因为方向反了)"]',
  2,
  '["负索引：-1是‘D’，-2是‘C’，-3是‘B’，-4是‘A’。", "切片[-2:-4:-1]中，步长-1表示从右向左。", "起始-2(‘C’)，结束-4(‘A’)，不包含结束索引。"]',
  '当步长为负数时，切片从起始索引（较大的索引）向结束索引（较小的索引）反向移动。[-2:-4:-1]从索引-2(‘C’)开始，反向移动到索引-4(‘A’)但不包含它，因此结果是‘CB’。',
  '对于‘1234’，[3:0:-1]得到‘432’（不包含索引0的‘1’）。'
),
(
  206,
  14,
  '切片大挑战',
  '字符串 s = ‘PythonRocks’。请问 s[1:7:2] + s[-5:-1] 的结果是什么？',
  '["‘yhnRck’", "‘yhnRock’", "‘yhnRocks’", "‘yhnRoc’"]',
  2,
  '["先算 s[1:7:2]: 从索引1(‘y’)到7(‘R’)，步长2。", "再算 s[-5:-1]: 负索引-1是‘s’，-5是‘o’。", "把两个结果用加号连接起来。"]',
  's[1:7:2] 从索引1(‘y’)到7(‘R’)每隔一个取字符，得到‘yhn’。s[-5:-1] 从索引-5(‘o’)到-1(‘s’)但不包含-1，得到‘Rock’。两者拼接为‘yhnRock’。',
  '对于‘ABCDEF’，[1:5:2]得‘BD’，[-3:-1]得‘DE’，拼接为‘BDDE’。'
),
(
  207,
  14,
  '缺省值陷阱',
  '关于字符串切片，以下哪个说法是绝对错误的？',
  '["s[:] 会创建整个字符串的一个副本。", "s[::] 和 s[:] 的效果是相同的。", "如果省略结束索引，如 s[2:]，切片会一直取到字符串末尾。", "s[开始:结束] 中，结束索引必须大于开始索引，否则结果为空。"]',
  4,
  '["回想一下第10题关于起始大于结束的情况。", "当步长为负数时，起始索引可以大于结束索引。", "例如 s[4:1:-1] 是有效的。"]',
  '说法D是错误的。当步长为正数时，起始索引大于结束索引才会得到空字符串。但当步长为负数时（反向切片），起始索引可以且通常大于结束索引，这是有效且能返回非空结果的。',
  's = ‘1234’; s[3:0:-1] 得到 ‘432’，起始3大于结束0，但结果非空。'
),
(
  208,
  14,
  '切片侦探',
  '已知字符串 text = ‘I love Python!’。哪个切片可以得到单词 ‘love’？',
  '["text[2:5]", "text[2:6]", "text[1:6]", "text[1:5]"]',
  2,
  '["字符串包含空格。‘I’后有一个空格。", "索引从0开始。‘I’是0，空格是1，‘l’是2。", "‘love’是4个字母，从索引2开始，需要取到索引6。"]',
  '字符串 ‘I love Python!’ 中，‘I’是索引0，空格是索引1，‘l’是索引2，‘o’(3),‘v’(4),‘e’(5)，索引6是空格。要得到‘love’，需要包含索引2到索引6（不包含6），即[2:6]。',
  '在‘A B C’中取‘B’，需要考虑前后的空格，可能是[2:3]。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  199,
  14,
  '诗句拆解',
  '诗人写了‘白日依山尽’，想把‘山水’二字（‘山’和‘水’）分割出来装进镜框。请补全代码。',
  NULL,
  '["山水"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "poem = ''白日依山尽''"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 目标：取出第3和第4个字（‘山’和‘水’）"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "framed_word = poem["}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}, {"type": "slot", "index": 1}, {"type": "code", "value": "]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(framed_word)"}]}]}',
  '["0", "1", "2", "3", "4", "5", "6"]',
  '[3, 5]',
  '在字符串‘白日依山尽’中，‘山’是索引3，‘水’是索引4。切片需要包含起始索引3，不包含结束索引5，因此切片应为[3:5]。',
  '从‘Python’取‘th’，使用[2:4]，因为‘t’索引2，‘h’索引3。'
),
(
  200,
  14,
  '组合密码',
  '秘密指令‘OpenSesame’被分段隐藏了。你需要先取‘Open’，再取‘Sesame’，然后把它们拼起来。补全代码。',
  NULL,
  '["OpenSesame"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "code = ''OpenSesame''"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "part1 = code["}, {"type": "slot", "index": 0}, {"type": "code", "value": "]  # 获取‘Open’"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 提示：''Sesame'' 从第4个字符开始"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "part2 = code["}, {"type": "slot", "index": 1}, {"type": "code", "value": ":"}, {"type": "slot", "index": 2}, {"type": "code", "value": "]  # 获取‘Sesame’"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "password = part1 + part2"}, {"type": "code_line", "value": "print(password)"}]}]}',
  '[":4", "4:", "4:10", "0:4", "0:", ":10", "10", "0"]',
  '[3, 1, 5]',
  '第一部分‘Open’对应索引0到4，但不包括4，所以是[:4]或[0:4]。第二部分‘Sesame’从索引4开始到结尾，所以是[4:]或[4:10]。答案中选择了最简洁的[:4]和[4:]。',
  '‘HelloWorld’[:5]为‘Hello’，[5:]为‘World’，拼接得‘HelloWorld’。'
),
(
  204,
  14,
  '时光倒流',
  '需要将年份‘2023’倒序显示为‘3202’。请补全使用负步长的切片代码。',
  NULL,
  '["3202"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "year = ''2023''"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "reversed_year = year["}, {"type": "slot", "index": 0}, {"type": "code", "value": "]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(reversed_year)"}]}]}',
  '["::-1", ":0:-1", "-1::-1", "3::-1", "::-2", ":"]',
  '[0]',
  '[::-1]是最常见的字符串逆序切片写法。它省略了起始和结束索引，步长为-1，表示从字符串末尾开始，一直反向取到开头，从而得到完整的逆序字符串。',
  '‘Python’[::-1]得到‘nohtyP’。'
),
(
  205,
  14,
  '神秘的区间',
  '对于字符串‘Python’，切片s[4:1]的结果是什么？请选择正确的描述来填空。',
  NULL,
  '[""]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = ''Python''"}, {"type": "code_line", "value": "result = s[4:1]"}, {"type": "code_line", "value": "print(result)  # 输出会是？"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 请在下列选项中选择最准确的描述："}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "当起始索引大于结束索引且步长为默认值1时，切片会返回 "}, {"type": "slot", "index": 0}]}]}',
  '["一个包含部分字符的字符串，如‘oht’", "一个空字符串‘‘", "引发一个IndexError错误", "字符串‘Pyt’", "字符串‘no’"]',
  '[1]',
  '当切片操作的起始索引大于结束索引，且未指定步长或步长为正数时，Python无法从起始索引“正向”遍历到结束索引，因此会直接返回一个空字符串，而不会报错。',
  '对于‘Hello’，[3:1]返回空字符串‘‘。'
),
(
  209,
  14,
  '构造新词',
  '单词‘Beautiful’，我们需要用切片取出‘Beau’和‘ful’，然后中间插入‘ti’，形成新词‘BeautifuL’（注意最后L大写）。请补全代码。',
  NULL,
  '["BeautifuL"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "word = ''Beautiful''"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "part1 = word["}, {"type": "slot", "index": 0}, {"type": "code", "value": "]  # ‘Beau’"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "part2 = word["}, {"type": "slot", "index": 1}, {"type": "code", "value": "]  # ‘ful’"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "new_word = part1 + ''ti'' + part2"}, {"type": "code_line", "value": "# 但要求最后字符‘L’大写，所以我们需要把最后一个字符变成大写"}, {"type": "code_line", "value": "# 假设我们无法直接修改字符串，可以再切片重组"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "final_word = new_word["}, {"type": "slot", "index": 2}, {"type": "code", "value": "] + ''L''"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(final_word)"}]}]}',
  '[":4", "4:", "6:", "6:9", ":9", ":-1", ":8", "7:"]',
  '[0, 6, 6]',
  'part1取‘Beau’用[:4]。part2取‘ful’用[6:9]或[6:]。new_word为‘Beauti-ful’。要得到‘BeautifuL’，需取new_word除最后一个字符‘l’外的所有部分[:-1]，然后拼接‘L’。',
  '对于‘abc’，[:-1]得‘ab’，可用于去掉最后一个字符。'
),
(
  210,
  14,
  '终极解码',
  '密文是‘a1b2c3d4’。解码规则：先取所有偶数索引字符，再逆序取所有奇数索引字符，最后拼接。请补全过程。',
  NULL,
  '["acbd2143"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "cipher = ''a1b2c3d4''"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "# 第一步：取偶数索引 (0,2,4,6...) 字符"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "even_part = cipher["}, {"type": "slot", "index": 0}, {"type": "code", "value": "]  # 期望得到 ‘abcd’"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 第二步：取奇数索引 (1,3,5,7...) 字符并逆序"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "odd_part_reversed = cipher["}, {"type": "slot", "index": 1}, {"type": "code", "value": "]  # 期望得到 ‘4321’"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 第三步：拼接"}, {"type": "code_line", "value": "plain_text = even_part + odd_part_reversed"}, {"type": "code_line", "value": "print(plain_text)"}]}]}',
  '["::2", "1::2", "1::2[::-1]", "[::2]", "[1::2]", "[1::2][::-1]", "[::2][::-1]"]',
  '[0, 5]',
  '第一步取偶数索引字符使用[::2]，从开头每隔一个取，得到‘abcd’。第二步取奇数索引字符使用[1::2]，得到‘1234’，再逆序[::-1]得到‘4321’。选项[1::2][::-1]是将这两个操作合并在一起的写法。',
  '对于‘012345’，[::2]得‘024’，[1::2]得‘135’，逆序得‘531’。'
);