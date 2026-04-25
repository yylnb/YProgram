-- Generated SQL for global_unit=30 (stage=1 unit_local=30 unit_id=30)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  436,
  30,
  '变量命名大考验',
  '小华在编程游戏中想炫耀他的高分，但变量名选错了就尴尬了，哪个名字能让Python接受？',
  '["123score", "score-123", "_score123", "score 123"]',
  3,
  '["变量名不能以数字开头哦！", "连字符和空格是变量名的大忌。", "下划线开头是合法的，试试看。"]',
  'Python变量名必须以字母或下划线开头，只能包含字母、数字和下划线。选项C以''_''开头，是合法的。',
  '合法变量名举例：my_var, var1, _temp。'
),
(
  437,
  30,
  '字符串切蛋糕',
  '阿强想把字符串''PythonRocks''切成''Rock''部分，他该用哪把''刀''？',
  '["s[6:10]", "s[6:9]", "s[7:11]", "s[7:10]"]',
  1,
  '["字符串索引从0开始，数数看。", "切片结束索引不包含，要小心。", "''Rock''从第6个字符到第9个。"]',
  '在''PythonRocks''中，''Rock''的索引从6到9，切片s[6:10]正确包含6到9。',
  '类似地，s[0:6]得到''Python''。'
),
(
  438,
  30,
  'input的魔法',
  '阿珍用input()获取年龄，但需要当整数算，哪行代码能施展魔法？',
  '["age = input()", "age = int(input())", "age = str(input())", "age = float(input())"]',
  2,
  '["input()返回的是字符串，不是数字。", "要整数计算，得转换类型。", "int()能把字符串变整数。"]',
  'input()默认返回字符串，int()函数将其转换为整数，以便进行数值运算。',
  '类似地，float(input())可将输入转换为浮点数。'
),
(
  441,
  30,
  '逻辑判断迷宫',
  '在游戏中，角色需要年龄大于18且分数大于60才能晋级，哪个条件对？',
  '["age > 18 and score > 60", "age > 18 or score > 60", "age < 18 and score > 60", "age > 18 not score > 60"]',
  1,
  '["''且''表示两个条件都必须满足。", "Python中用and表示''且''。", "检查运算符是否用对。"]',
  '复合逻辑判断中，''且''使用and运算符，要求两个条件都为真。选项A正确。',
  '类似地，''或''使用or，如 age > 18 or score > 60。'
),
(
  442,
  30,
  '切片与变量',
  's = ''Programming''; start=3, end=7; s[start:end] 会切出什么？',
  '["''gram''", "''gramm''", "''ogra''", "''og ram''"]',
  1,
  '["代入变量值计算切片。", "切片包含start，不包含end。", "索引从0开始，数一数。"]',
  'start=3, end=7，切片索引3到6，在''Programming''中是''gram''。',
  '如果s=''Hello'', start=1, end=4, 则s[1:4]为''ell''。'
),
(
  443,
  30,
  '输入陷阱',
  '当用户输入''abc''时，int(input()) 会引发什么错误？',
  '["ValueError", "TypeError", "SyntaxError", "NameError"]',
  1,
  '["int()尝试转换字符串为整数。", "非数字字符串会导致转换失败。", "回忆Python异常类型。"]',
  'int()在转换无效整数字符串时引发ValueError，表示值错误。',
  '例如，int(''abc'') 会引发 ValueError。'
),
(
  446,
  30,
  '命名规则回顾',
  '下面哪个变量名会让Python皱眉头？',
  '["my_var", "2ndPlace", "_private", "global"]',
  2,
  '["变量名不能以数字开头。", "检查每个选项的第一个字符。", "回忆命名规则。"]',
  'Python变量名不能以数字开头。选项B以''2''开头，是非法的；其他选项都合法。',
  '合法变量名如：var1, _temp, myVar。'
),
(
  447,
  30,
  '类型转换技巧',
  '如果用户可能输入''3''或''3.14''，为了安全转换为数字，该用哪个函数？',
  '["int()", "float()", "str()", "eval()"]',
  2,
  '["int()只接受整数字符串。", "float()能处理整数和小数。", "考虑输入可能包含小数点。"]',
  'float()函数可以将表示整数或小数的字符串转换为浮点数，适用于多种数字输入。',
  'float(''3'')返回3.0, float(''3.14'')返回3.14。'
),
(
  448,
  30,
  '逻辑运算符优先级',
  '在表达式 not x > 5 or y < 10 中，哪个运算符最先计算？',
  '["not", ">", "or", "<"]',
  2,
  '["比较运算符优先级高于逻辑运算符。", "先计算比较，再应用逻辑。", "回忆Python运算符顺序。"]',
  '比较运算符（如>）优先级高于逻辑运算符（not, and, or），因此先计算x > 5，然后进行not运算。',
  '类似地，在 a > b and c < d 中，先计算比较，再进行and运算。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  439,
  30,
  '填空切片',
  '小机器人想从字符串''HelloPython''中切出''Python''，请帮它补全代码。',
  NULL,
  '["Python"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = \\\"HelloPython\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(s["}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}, {"type": "slot", "index": 1}, {"type": "code", "value": "])"}]}]}',
  '["0", "1", "2", "5", "6", "10", "11"]',
  '[4, 7]',
  '切片s[start:end]中，start包含，end不包含。''Python''在索引5到10，所以s[5:11]正确。',
  '类似地，s[0:5]输出''Hello''。'
),
(
  440,
  30,
  '类型转换填空',
  '阿强写了个求和程序，但输入是字符串，请帮他补全转换代码。',
  '["3", "5"]',
  '["8"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = input()"}, {"type": "code_line", "value": "b = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "sum = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(a) + "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(b)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(sum)"}]}]}',
  '["int", "str", "float", "eval", "num"]',
  '[1, 1]',
  'input()返回字符串，需用int()转换为整数才能进行加法运算。',
  '类似地，float()可将字符串转换为浮点数。'
),
(
  444,
  30,
  '逻辑填空',
  '完成代码，判断用户是否成年且有兴趣参加活动。',
  '["20", "yes"]',
  '["Welcome to the event!"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "age = int(input())"}, {"type": "code_line", "value": "interest = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if age >= 18 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " interest == ''yes'':"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"Welcome to the event!\\\")"}]}]}',
  '["and", "or", "not", "&&", "||"]',
  '[1]',
  '条件需要年龄和兴趣都满足，因此使用and运算符连接两个表达式。',
  '类似地，if x > 0 and y < 10: 表示两个条件都真。'
),
(
  445,
  30,
  '综合填空',
  '程序接收字符串和数字n，输出前n个字符，补全代码。',
  '["HelloWorld", "3"]',
  '["Hel"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}, {"type": "code_line", "value": "n = int(input())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "])"}]}]}',
  '[":n", "0:n", ":n-1", "n:", "0"]',
  '[1]',
  '要输出前n个字符，可以使用切片s[:n]，其中开始索引默认为0，结束索引为n。',
  '类似地，s[2:5]输出索引2到4的字符。'
),
(
  449,
  30,
  '综合复习填空',
  '编写程序检查字符串长度是否大于5且第一个字符是字母，补全代码。',
  '["Python"]',
  '["True"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = input()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "condition = len(s) > 5 "}, {"type": "slot", "index": 0}, {"type": "code", "value": " s[0].isalpha()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(condition)"}]}]}',
  '["and", "or", "not", "&&"]',
  '[1]',
  '条件需要两个都满足，因此使用and运算符连接len(s) > 5和s[0].isalpha()。',
  '类似地，检查字符串是否为空或长度为0：s == '''' or len(s) == 0。'
),
(
  450,
  30,
  '变量切片填空',
  '给定字符串和变量i=2, j=5，输出从索引i到j的子串，补全代码。',
  NULL,
  '["llo"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = \\\"HelloWorld\\\""}, {"type": "code_line", "value": "i = 2"}, {"type": "code_line", "value": "j = 5"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(s["}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}, {"type": "slot", "index": 1}, {"type": "code", "value": "])"}]}]}',
  '["i", "j", "0", "1", "2", "5"]',
  '[1, 2]',
  '切片使用变量i和j作为开始和结束索引，s[i:j]输出从索引i到j-1的子串。',
  '类似地，s[1:4]输出索引1到3的字符。'
);