-- Generated SQL for global_unit=19 (stage=1 unit_local=19 unit_id=19)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  271,
  19,
  'in操作符初探',
  '阿强想检查''apple''是否在''pineapple''中，下面哪个代码是正确的？',
  '["''apple'' in ''pineapple''", "''pineapple'' in ''apple''", "in(''apple'', ''pineapple'')", "''apple''.in(''pineapple'')"]',
  1,
  '["in操作符用于检查子字符串是否存在。", "语法是''substring'' in ''string''。", "注意顺序，子字符串在前，主字符串在后。"]',
  'in操作符用于检查一个字符串是否包含另一个字符串，语法是''substring'' in ''string''，返回布尔值True或False。',
  '例如：''cat'' in ''concatenate'' 返回True。'
),
(
  272,
  19,
  'not in的妙用',
  '小美想确认''bug''不在''debug''中，应该用哪个表达式？',
  '["''bug'' not in ''debug''", "''debug'' not in ''bug''", "not ''bug'' in ''debug''", "A和C都正确"]',
  4,
  '["not in是操作符，但not in和not ... in都可用。", "检查''bug''是否不在''debug''中。", "在Python中，''not in''是推荐用法，但''not ... in''也有效。"]',
  '在Python中，''not in''操作符用于检查子字符串是否不存在于字符串中。''not ''bug'' in ''debug''''等价于''bug'' not in ''debug''，但后者更清晰。',
  '例如：''spam'' not in ''eggs'' 返回True。'
),
(
  273,
  19,
  '字符串比较',
  '比较''Python''和''python''，哪个表达式会返回True？',
  '["''Python'' == ''python''", "''Python'' < ''python''", "''Python'' in ''python''", "以上都不是"]',
  2,
  '["字符串比较基于字典顺序或ASCII值。", "大写字母的ASCII值小于小写字母。", "in检查子字符串，这里''Python''不是''python''的子串。"]',
  '字符串比较使用操作符如==, <, >等，基于字符的Unicode码点。''P''的码点小于''p''，所以''Python'' < ''python''返回True。',
  '例如：''Apple'' < ''Banana'' 返回True，因为''A'' < ''B''。'
),
(
  276,
  19,
  'in与条件语句',
  '下面代码段中，如果str1为''hello''，str2为''world''，哪个条件会执行？',
  '["if ''he'' in str1: print(''found'')", "if ''or'' in str2: print(''found'')", "if ''low'' not in str1: print(''not found'')", "以上都会"]',
  4,
  '["检查子字符串''he''在''hello''中。", "''or''在''world''中。", "''low''不在''hello''中。"]',
  'in和not in返回布尔值，可用于条件语句。''he''在''hello''中为True，''or''在''world''中为True，''low''不在''hello''中为True，所以所有条件都会执行。',
  '例如：if ''a'' in ''apple'': print(''yes'') 会打印''yes''。'
),
(
  277,
  19,
  '字符串比较陷阱',
  '比较''10''和''2''，哪个表达式返回True？',
  '["''10'' < ''2''", "''10'' > ''2''", "''10'' == ''2''", "''10'' in ''2''"]',
  1,
  '["字符串比较是按字符逐个比较。", "第一个字符''1''和''2''比较。", "''1''的ASCII码小于''2''。"]',
  '字符串比较基于字符的Unicode码点。''10''和''2''比较时，先比较''1''和''2''，由于''1'' < ''2''，所以''10'' < ''2''返回True，即使数字上10>2。',
  '例如：''20'' < ''3'' 返回True，因为''2'' < ''3''。'
),
(
  278,
  19,
  'not in的用法',
  '下面哪个代码会检查''error''是否不在消息中？',
  '["if ''error'' not in message: print(''ok'')", "if not ''error'' in message: print(''ok'')", "if message not in ''error'': print(''ok'')", "A和B"]',
  4,
  '["not in是标准操作符。", "not ... in也有效。", "注意顺序，子字符串在前。"]',
  '在Python中，''not in''操作符用于检查不存在，语法''substring'' not in ''string''。''not substring in string''是等价写法，但前者更可读。',
  '例如：if ''spam'' not in text: print(''no spam'')'
),
(
  281,
  19,
  'in操作符与空字符串',
  '检查空字符串''''是否在另一个字符串中，例如在''hello''中，结果是什么？',
  '["True", "False", "错误", "取决于字符串"]',
  1,
  '["空字符串是什么？", "in操作符检查子字符串是否存在。", "空字符串总是被视为存在。"]',
  '在Python中，空字符串''''是任何字符串的子字符串，所以'''' in ''hello''返回True。',
  '例如：'''' in ''any'' 总是返回True。'
),
(
  282,
  19,
  'not in的返回值',
  '表达式''z'' not in ''apple''的返回值是？',
  '["True", "False", "错误", "None"]',
  1,
  '["检查''z''是否在''apple''中。", "not in返回布尔值。", "''z''不是''apple''的一部分。"]',
  'not in操作符检查子字符串是否不存在于字符串中。''z''不在''apple''中，所以返回True。',
  '例如：''x'' not in ''abc'' 返回True。'
),
(
  283,
  19,
  '字符串比较操作符',
  '下面哪个表达式比较''cat''和''dog''会返回True？',
  '["''cat'' == ''dog''", "''cat'' != ''dog''", "''cat'' < ''dog''", "B和C"]',
  4,
  '["!=检查不相等。", "<基于字典顺序。", "比较''c''和''d''。"]',
  '字符串比较中，''cat'' != ''dog''返回True，因为字符串不同。''cat'' < ''dog''也返回True，因为''c''的码点小于''d''。',
  '例如：''apple'' < ''banana'' 返回True。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  274,
  19,
  '填空检查邮箱',
  '帮助程序检查邮箱地址中是否包含''@''符号，让它输出True。',
  NULL,
  '["True"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "email = \\\"user@example.com\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "result = "}, {"type": "slot", "index": 0}, {"type": "code", "value": " in email"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(result)"}]}]}',
  '["\\\"@\\\"", "''@''", "@", "\\\"@\\\"", "''@@''", "\\\"a\\\""]',
  '[1]',
  '在Python中，字符串需要用引号包裹。in操作符检查子字符串，所以需要提供带引号的''@''作为字符串。',
  '类似地，检查''a'' in ''apple''，需要字符串''a''。'
),
(
  275,
  19,
  '填空验证密码',
  '程序检查密码是否包含数字1，帮助填空完成代码。',
  NULL,
  '["True"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "password = \\\"pass123word\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "has_digit = "}, {"type": "slot", "index": 0}, {"type": "code", "value": " in password"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(has_digit)"}]}]}',
  '["\\\"1\\\"", "''1''", "1", "\\\"123\\\"", "''0''", "\\\"digit\\\""]',
  '[1]',
  'in操作符检查字符是否存在，所以需要字符串''1''来检查密码中是否包含数字1。',
  '检查是否包含字母''a''：''a'' in password。'
),
(
  279,
  19,
  '填空过滤列表',
  '程序过滤出包含''py''的字符串，帮助填空完成列表推导式。',
  NULL,
  '["[''python'', ''pypy'']"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "words = [\\\"python\\\", \\\"java\\\", \\\"pypy\\\", \\\"c++\\\"]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "filtered = [w for w in words if "}, {"type": "slot", "index": 0}, {"type": "code", "value": " in w]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(filtered)"}]}]}',
  '["''py''", "\\\"py\\\"", "py", "\\\"python\\\"", "''p''", "\\\"y\\\""]',
  '[0]',
  '列表推导式中使用in操作符检查子字符串''py''是否在每个单词中，筛选出包含''py''的字符串。',
  '类似地，[s for s in list if ''a'' in s] 筛选包含''a''的字符串。'
),
(
  280,
  19,
  '填空检查多个条件',
  '程序检查用户名是否同时包含字母和数字，帮助填空连接条件。',
  NULL,
  '["True"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "username = \\\"user123\\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "has_letter = any(c.isalpha() for c in username)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "has_digit = any(c.isdigit() for c in username)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "is_valid = has_letter "}, {"type": "slot", "index": 0}, {"type": "code", "value": " has_digit"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(is_valid)"}]}]}',
  '["and", "or", "&", "|", "&&", "||"]',
  '[0]',
  '用户名需要同时包含字母和数字，所以使用and操作符连接两个条件，当两者都为True时返回True。',
  '例如：条件1 and 条件2 返回True当两者都为True。'
),
(
  284,
  19,
  '填空实现搜索功能',
  '程序检查用户输入是否包含关键词''world''，帮助填空完成条件语句。',
  '["hello world"]',
  '["Keyword found!"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "user_input = input(\\\"Enter text: \\\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "keyword = \\\"world\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"Keyword found!\\\")"}]}]}',
  '["keyword in user_input", "user_input in keyword", "keyword not in user_input", "user_input not in keyword"]',
  '[0]',
  '要检查关键词是否在用户输入中，使用''keyword in user_input''，因为in操作符检查子字符串，顺序正确。',
  '类似地，if ''hello'' in text: print(''greeting found'')'
),
(
  285,
  19,
  '填空验证电子邮件格式',
  '程序检查电子邮件是否同时包含''@''和''.''，帮助填空连接条件。',
  NULL,
  '["Valid email"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "email = \\\"test@example.com\\\""}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "if \\\"@\\\" in email "}, {"type": "slot", "index": 0}, {"type": "code", "value": " \\\".\\\" in email:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\\\"Valid email\\\")"}]}]}',
  '["and", "or", "&", "|", "&&", "||"]',
  '[0]',
  '有效的电子邮件需要同时包含''@''和''.''，所以使用and操作符连接两个条件，确保两者都为True。',
  '例如：if condition1 and condition2: 执行代码'
);