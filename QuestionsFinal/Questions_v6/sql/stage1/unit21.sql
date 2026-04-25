-- Generated SQL for global_unit=21 (stage=1 unit_local=21 unit_id=21)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  301,
  21,
  '打招呼的困惑',
  '阿珍想让Python问她叫什么名字，并用''你好, [名字]！''来回应。她写出了下面哪个选项才能正确地接收输入呢？',
  '["name = input()\\nprint(''你好, '' + name + ''！'')", "name = input(''你叫什么名字？'')\\nprint(''你好, '' + name + ''！'')", "name = ''input()''\\nprint(''你好, '' + name + ''！'')", "name = input()\\nprint(你好, name, ！)"]',
  2,
  '["哪个选项能让程序在等待输入时显示友好的提示语呢？", "input()函数可以接收一个字符串参数，作为输入前的提示。", "选项A没有提示，不友好；选项C把input当成字符串存起来了；选项D的print参数没用引号包裹。"]',
  'input()函数可以接受一个可选参数，作为提示字符串显示给用户。选项B正确使用了这个功能。选项A虽然能运行，但不够友好；选项C将''input()''作为字符串赋值给name；选项D的''你好''和''！''没有加引号，会导致语法错误。',
  '标准用法：user_input = input("请输入：")，程序会先显示"请输入："，再等待用户输入。'
),
(
  302,
  21,
  '数字输入的陷阱',
  '小智想用input做一个加法计算器。用户输入两个数字，程序输出它们的和。下面哪个选项能正确实现？',
  '["a = input(''输入第一个数：'')\\nb = input(''输入第二个数：'')\\nprint(a + b)", "a = int(input(''输入第一个数：''))\\nb = int(input(''输入第二个数：''))\\nprint(a + b)", "a = int(''输入第一个数：'')\\nb = int(''输入第二个数：'')\\nprint(a + b)", "a = input(''输入第一个数：'')\\nb = input(''输入第二个数：'')\\nprint(''和是：'' + a + b)"]',
  2,
  '["input()返回的是什么类型？是字符串还是数字？", "字符串的''+''和数字的''+''行为一样吗？", "如果要进行数学计算，需要先将input得到的字符串转换成数字类型。"]',
  'input()函数始终返回字符串（str）。要进行数学加法运算，必须先用int()或float()等函数将字符串转换为数值类型。选项B正确地进行了转换。选项A和D进行的是字符串拼接；选项C试图将整个提示字符串转换为整数，会报错。',
  '计算用户输入的年龄加一岁：age = int(input("你的年龄：")); print("明年你", age+1, "岁")。'
),
(
  303,
  21,
  '未雨绸缪的input',
  '下面哪个关于input()函数的说法是正确的？',
  '["input()函数的返回值类型由用户输入的内容自动决定。", "input(''提示'')中的''提示''信息会在用户输入完毕后显示。", "如果用户直接按回车，input()会返回一个空字符串''''。", "input()函数可以一次性接收多个以空格分隔的输入值。"]',
  3,
  '["回忆一下，input()返回值的类型固定是什么？", "提示信息是在输入前出现还是输入后出现？", "用户什么都不输入直接回车，会得到什么？"]',
  'input()函数总是返回字符串（str），无论用户输入什么。提示信息在用户输入前显示。当用户直接按回车时，input()会返回一个空字符串。一次性接收多个值通常需要结合split()等方法，并非input()的默认行为。',
  'name = input("Enter your name: ")
如果直接回车，name的值就是空字符串''''。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  304,
  21,
  '组装温度转换器',
  '下面是一个将华氏温度转换为摄氏温度的程序，但关键的input部分被挖空了。请选择合适的代码片段填入，使其能正确运行。',
  '["100"]',
  '["100.0 华氏度等于 37.78 摄氏度。"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "# 温度转换程序"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "fahrenheit = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(''请输入华氏温度：'')"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "celsius = (fahrenheit - 32) * 5 / 9"}, {"type": "code_line", "value": "print(f\\\"{fahrenheit} 华氏度等于 {celsius:.2f} 摄氏度。\\\")"}]}]}',
  '["input", "int(input", "float(input", "input(float", "print(input", "input(int"]',
  '[2]',
  '由于转换公式涉及小数运算，应将用户输入的字符串转换为浮点数（float）。因此，需要填入`float(input`，它先获取输入字符串，再将其转换为浮点数。其他选项要么缺少类型转换，要么转换顺序或函数名错误。',
  '类似地，获取身高（米）：height = float(input("请输入身高(米)："))。'
),
(
  305,
  21,
  '补全欢迎程序',
  '小明的欢迎程序缺少接收用户输入的部分。请选择合适的代码片段填入挖空处，让程序能询问并打印用户的城市和爱好。',
  '["北京", "吃烤鸭"]',
  '["欢迎来自 北京 的朋友！你的爱好 吃烤鸭 真不错！"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "city = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "(''你来自哪个城市？'')"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "hobby = "}, {"type": "slot", "index": 1}, {"type": "code", "value": "(''你的爱好是什么？'')"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(f\\\"欢迎来自 {city} 的朋友！你的爱好 {hobby} 真不错！\\\")"}]}]}',
  '["input", "print", "int", "input(", "print(", "''input''", "input"]',
  '[3, 3]',
  '两个空都需要填入`input(`，因为程序只需要获取用户输入的字符串（城市名、爱好名），无需进行数学运算，所以直接使用input()函数即可。第一个选项`input`缺少了调用必须的括号`()`。',
  '获取用户名：username = input("请输入用户名：")，然后可以直接在字符串中使用它。'
);