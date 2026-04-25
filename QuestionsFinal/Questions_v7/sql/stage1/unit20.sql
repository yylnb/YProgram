-- Generated SQL for global_unit=20 (stage=1 unit_local=20 unit_id=20)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  286,
  20,
  'in判断购物清单',
  '小明想用Python检查字符串''shopping_list = "苹果,香蕉,橙子"''中是否包含''苹果''，下面哪个写法是正确的？',
  '["if ''苹果'' in shopping_list:", "if shopping_list in ''苹果'':", "if shopping_list.contains(''苹果''):", "if ''苹果''.in(shopping_list):"]',
  1,
  '["in关键字用于检查子字符串是否在字符串中。", "注意in前后的顺序：子字符串 in 字符串。", "Python中字符串没有.contains方法，使用in操作符。"]',
  '在Python中，使用in操作符检查字符串是否包含子字符串，语法是''子字符串 in 字符串''。选项A正确；选项B顺序颠倒；选项C使用了不存在的方法；选项D语法错误。',
  '类似地，if ''a'' in ''apple'': 会返回True。'
),
(
  287,
  20,
  '切片取前五',
  '阿强有一个字符串s = ''HelloWorld''，他想获取前5个字符''Hello''，哪个切片最简洁？',
  '["s[:5]", "s[0:4]", "s[1:5]", "s[5:]"]',
  1,
  '["字符串切片从开始索引到结束索引（不包括）。", "如果省略开始索引，默认从0开始。", "s[:5]表示从索引0到5（不包括5），即前5个字符。"]',
  '字符串切片s[start:end]获取从start到end-1的字符。s[:5]省略start，默认0，获取索引0到4的字符，即''Hello''。',
  '对于s=''Python''，s[:3]返回''Pyt''。'
),
(
  288,
  20,
  '分割水果列表',
  '小美有一个字符串''apple,banana,cherry''，她想用逗号分割成列表，应该使用哪个方法？',
  '["split('','')", "split('', '')", "splitter('','')", "separate('','')"]',
  1,
  '["split方法用于按分隔符分割字符串。", "分隔符是逗号'',''，没有空格。", "Python中没有splitter或separate方法。"]',
  '字符串的split方法使用指定的分隔符将字符串分割成列表，例如''apple,banana,cherry''.split('','')返回[''apple'',''banana'',''cherry'']。',
  '''a b c''.split('' '')返回[''a'',''b'',''c'']。'
),
(
  291,
  20,
  '同时检查子串',
  '在字符串''hello world''中，检查是否同时包含''he''和''ld''，下面哪个代码正确？',
  '["if ''he'' in s and ''ld'' in s:", "if ''he'' and ''ld'' in s:", "if s.contains(''he'') and s.contains(''ld''):", "if ''he'' + ''ld'' in s:"]',
  1,
  '["使用in操作符需要为每个子字符串单独检查。", "选项B中''he''被当作True，只检查''ld'' in s。", "Python字符串没有.contains方法。"]',
  '要检查多个子字符串是否都在字符串中，必须对每个子字符串使用in操作符并用and连接，如''he'' in s and ''ld'' in s。',
  '类似地，if ''a'' in s and ''b'' in s: 检查s中是否同时有''a''和''b''。'
),
(
  292,
  20,
  '处理带空格CSV',
  '有一个字符串''apple, banana, cherry''，想去除空格后分割，然后连接用分号，哪个代码正确？',
  '["items = s.split('', ''); result = '';''.join(items)", "items = s.split('',''); result = '';''.join(items.strip())", "items = s.split('',''); result = '';''.join([item.strip() for item in items])", "result = s.replace('' '', '''').split('','').join('';'')"]',
  3,
  '["split('','')会保留空格，需要去除每个项目的空格。", "strip()方法去除字符串两端的空格。", "join方法需要字符串调用，列表没有join方法。"]',
  '正确做法是先按逗号分割得到列表，然后用列表推导式对每个项目使用strip()去除空格，最后用'';''.join连接。',
  ''' a , b ''.split('','')得到['' a '', '' b '']，经strip后连接成''a;b''。'
),
(
  293,
  20,
  '切片与相等检查',
  '给定字符串s = ''PythonProgramming''，想检查切片s[6:10]是否等于''Prog''，哪个代码正确？',
  '["if s[6:10] == ''Prog'':", "if s[6:10] in ''Prog'':", "if ''Prog'' in s[6:10]:", "if s[6:10].contains(''Prog''):"]',
  1,
  '["切片s[6:10]返回一个字符串，可以直接用==比较。", "in操作符用于检查子字符串，而不是相等。", "Python字符串没有.contains方法。"]',
  '字符串切片返回子字符串，可以使用==操作符直接与另一个字符串比较是否相等。',
  's=''hello''，s[1:4] == ''ell''返回True。'
),
(
  296,
  20,
  '步长切片',
  '字符串s = ''abcdefgh''，s[1:6:2]返回什么？',
  '["''bdf''", "''aceg''", "''bdfh''", "''ac eg''"]',
  1,
  '["切片s[start:end:step]从start到end-1，步长为step。", "索引1是''b''，步长2取下一个索引3、5。", "计算索引：1-b,3-d,5-f，所以是''bdf''。"]',
  's[1:6:2]从索引1开始到6结束（不包括6），步长2，取索引1、3、5的字符，即''b''、''d''、''f''，组成''bdf''。',
  's=''123456''，s[0:5:2]返回''135''。'
),
(
  297,
  20,
  '检查开头',
  '想用in操作符检查字符串s是否以''he''开头，哪个代码正确？',
  '["if ''he'' in s and s.find(''he'') == 0:", "if ''he'' in s[0:2]:", "if s[0:2] == ''he'':", "if ''he'' == s[:2]:"]',
  4,
  '["切片s[:2]获取前两个字符，可直接比较。", "in操作符在切片中检查，但切片可能不是完整子串。", "选项D使用==直接比较，最简洁。"]',
  '检查字符串是否以''he''开头，最简单的是使用切片s[:2]获取前两个字符，然后用==与''he''比较。',
  's=''hello''，s[:2] == ''he''返回True。'
),
(
  298,
  20,
  '连接列表错误',
  '有一个字符串列表[''a'',''b'',''c'']，想连接成''a,b,c''，下面哪个写法错误？',
  '["'',''.join(lst)", "''-''.join(lst).replace(''-'','','')", "str.join('','', lst)", "result = ''''; for item in lst: result += item + '',''; result = result[:-1]"]',
  3,
  '["join方法是字符串方法，调用方式是''分隔符''.join(可迭代对象)。", "str.join('','', lst)语法错误，str是类名。", "其他选项都能正确连接。"]',
  'join方法必须用字符串实例调用，如'',''.join(lst)，而str.join('','', lst)是错误的，因为str是类，且参数顺序不对。',
  '正确用法：''-''.join([''x'',''y''])返回''x-y''。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  289,
  20,
  '切片取Rock',
  '帮助小华完成代码，从字符串''PythonRocks''中提取''Rock''。',
  NULL,
  '["Rock"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = ''PythonRocks''"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(s["}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}, {"type": "slot", "index": 1}, {"type": "code", "value": "])"}]}]}',
  '["6", "7", "9", "10", "5", "11", "0", "4"]',
  '[1, 4]',
  '在字符串''PythonRocks''中，''Rock''从索引6开始到索引10结束（不包括10），所以切片为s[6:10]。',
  '类似地，s=''Hello''，s[1:4]返回''ell''。'
),
(
  290,
  20,
  '连接字母列表',
  '小李有一个列表[''a'',''b'',''c'']，他想用连字符连接成字符串''a-b-c''，补全代码。',
  NULL,
  '["a-b-c"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = [''a'', ''b'', ''c'']"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "result = "}, {"type": "slot", "index": 0}, {"type": "code", "value": ".join(lst)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(result)"}]}]}',
  '["''-''", "''-''", "-", "''+''", "'':''", "''''"]',
  '[1]',
  'join方法是字符串方法，用指定的分隔符字符串调用，如''-''.join(lst)将列表连接成以''-''分隔的字符串。',
  ''' ''.join([''hello'', ''world''])返回''hello world''。'
),
(
  294,
  20,
  '域名检查',
  '补全代码，从字符串''python.org''中提取扩展名并检查是否为''.org''。',
  NULL,
  '["It is an org domain"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = ''python.org''"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "extension = s["}, {"type": "slot", "index": 0}, {"type": "code", "value": ":]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if extension "}, {"type": "slot", "index": 1}, {"type": "code", "value": " ''.org'':"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(''It is an org domain'')"}]}]}',
  '["6", "7", "8", "in", "==", "!=", "not in"]',
  '[1, 5]',
  '在''python.org''中，从索引6开始切片得到''.org''，然后使用==操作符检查是否等于''.org''。',
  's=''example.com''，s[7:]得到''.com''，可用==检查。'
),
(
  295,
  20,
  'CSV转换',
  '补全代码，将逗号分隔的字符串转换为用分号分隔，并去除空格。',
  NULL,
  '["apple;banana;cherry"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = ''apple, banana, cherry''"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "items = s.split("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "items = [item."}, {"type": "slot", "index": 1}, {"type": "code", "value": "() for item in items]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "result = ''"}, {"type": "slot", "index": 2}, {"type": "code", "value": "''.join(items)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(result)"}]}]}',
  '[",", ", ", "strip", "trim", "lstrip", ";", ":", "-"]',
  '[2, 3, 6]',
  '首先用'', ''分割字符串去除空格，然后对每个项目使用strip()去除两端空格，最后用'';''连接列表。',
  '''a , b ''.split('', '')得到[''a'', ''b'']，经strip后连接成''a;b''。'
),
(
  299,
  20,
  'URL协议检查',
  '补全代码，处理URL字符串，提取协议并检查是否安全（为''https''）。',
  NULL,
  '["Secure"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = ''https://www.example.com''"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "protocol = s.split("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")[0]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if protocol "}, {"type": "slot", "index": 1}, {"type": "code", "value": " ''https'':"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(''Secure'')"}]}]}',
  '["''://''", "'':''", "''/''", "==", "!=", "in", "not in"]',
  '[1, 4]',
  '使用split(''://'')分割URL，第一部分是协议''https''，然后用==操作符检查是否等于''https''。',
  '''http://example.com''.split(''://'')[0]返回''http''。'
),
(
  300,
  20,
  '字符串反转',
  '补全代码，将字符串''hello''反转并打印。',
  NULL,
  '["olleh"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s = ''hello''"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "reversed_s = s["}, {"type": "slot", "index": 0}, {"type": "code", "value": "]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(reversed_s)"}]}]}',
  '["::-1", ":-1", ":0:-1", "-1::-1", ":]", "[::-1]"]',
  '[1]',
  '字符串切片s[::-1]使用步长-1从后向前切片，实现字符串反转。',
  's=''abc''，s[::-1]返回''cba''。'
);