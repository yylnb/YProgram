-- Generated SQL for global_unit=3 (stage=1 unit_local=3 unit_id=3)
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES

(
  31,
  3,
  '阿强的购物车',
  '阿强想用变量记录他购买的5个苹果，下面哪一行代码是正确的？',
  '["apple_count = 5", "5 = apple_count", "apple-count = 5", "apple count = 5"]',
  1,
  '["变量名应该在等号左边。", "变量名中不能包含空格或减号。", "等号是赋值，方向不能反。"]',
  'Python使用等号`=`为变量赋值，变量名在左侧，值在右侧。变量名只能包含字母、数字和下划线，且不能以数字开头。',
  '例如 `age = 18`，表示将18赋值给变量age。'
),
(
  32,
  3,
  '小猫的程序员名',
  '小猫‘喵喵’学习编程，它想出一些变量名，下面哪个是合法的？',
  '["2nd_place", "my_var", "for", "total-price"]',
  2,
  '["变量名不能以数字开头。", "小心，有些单词是Python的‘保留字’。", "变量名中只能使用字母、数字和下划线。"]',
  '合法的Python变量名由字母、数字和下划线组成，且不能以数字开头，也不能是关键字（如for）。连字符`-`是不允许的。',
  '`user_name`， `score1` 都是合法的变量名。'
),
(
  33,
  3,
  '粗心的命名员',
  '哪位粗心的程序员使用了Python的关键字来命名他的变量，导致程序出错？',
  '["class = \\\"入门班\\\"", "my_class = \\\"入门班\\\"", "className = \\\"入门班\\\"", "_class = \\\"入门班\\\""]',
  1,
  '["Python有一些具有特殊功能的单词，不能挪作他用。", "想想看，哪个选项的单词可能用来定义‘类’？", "`class`是Python用来定义类的关键字。"]',
  'Python的关键字（如`if`, `for`, `class`等）有特殊语法含义，不能用作变量名。选项A中的`class`就是关键字。',
  '应避开`and`, `def`, `import`, `return`等关键字用作变量名。'
),
(
  36,
  3,
  '狡猾的交换',
  '阿珍和阿强交换了他们杯子里的饮料（可乐和果汁）。下面哪段代码正确地模拟了这个交换？',
  '["azhen = ''可乐''\\naqiang = ''果汁''\\nazhen = aqiang\\naqiang = azhen", "azhen = ''可乐''\\naqiang = ''果汁''\\ntemp = azhen\\nazhen = aqiang\\naqiang = temp", "azhen = ''可乐''\\naqiang = ''果汁''\\naqiang = azhen\\nazhen = aqiang", "azhen, aqiang = ''可乐'', ''果汁''"]',
  2,
  '["直接相互赋值会丢失原来的值。", "需要一个‘空杯子’（临时变量）来帮忙。", "想想交换的经典三步：存A，A变B，B变存的A。"]',
  '交换两个变量的值需要一个临时变量存储其中一个的原值，否则直接`a=b; b=a`会导致`a`和`b`都变成原来的`b`。选项B正确使用了`temp`。',
  '交换x和y的值：`temp=x; x=y; y=temp` 或使用Python特有的 `x, y = y, x`。'
),
(
  37,
  3,
  '双胞胎的变量',
  '李雷定义了`score = 95`，然后写了`Score = 60`。最后打印`score`会输出什么？',
  '["95", "60", "报错，变量重复定义", "155"]',
  1,
  '["Python的变量名是区分大小写的。", "`score`和`Score`是两个不同的‘盒子’。", "想想哪个‘盒子’里装的是95？"]',
  'Python变量名区分大小写。`score`和`Score`是两个不同的变量。给`Score`赋值不影响`score`的值，因此`score`依然是95。',
  '`age`和`Age`是两个不同的变量。`age=20; Age=30; print(age)` 输出20。'
),
(
  38,
  3,
  '命名风格大比拼',
  '下列哪种命名方式更符合Python社区推荐的变量命名风格（蛇形命名法）？',
  '["userName", "UserName", "user_name", "username"]',
  3,
  '["Python偏爱小写字母和分隔符。", "想想如何分隔多个单词？用下划线。", "Java风格的`userName`（驼峰）在Python中不常用。"]',
  '对于普通变量，Python官方推荐使用小写字母，单词之间用下划线`_`连接的“蛇形命名法”（snake_case）。如`student_name`, `total_score`。',
  '推荐 `file_path` 而不是 `filePath` 或 `FilePath`。'
),
(
  41,
  3,
  '内外有别',
  '观察代码：`count = 10
def test():
    count = 20
    print(count)
test()
print(count)`。两个print分别输出什么？',
  '["20 然后 10", "10 然后 20", "20 然后 20", "10 然后 10"]',
  1,
  '["函数内部的`count`和外部的`count`是同一个吗？", "在函数内赋值会创建一个新的局部变量。", "函数内的`print`看到的是局部变量20。函数外的`print`看到的是全局变量10。"]',
  '函数`test`内部的`count=20`创建了一个新的局部变量，不影响外部的全局变量`count`。因此函数内打印20，函数外打印10。',
  '这体现了变量的作用域。局部变量只在函数内有效，不会覆盖外部的同名变量。'
),
(
  42,
  3,
  '变装变量',
  'Python变量像个‘变色龙’。执行`x = 100; x = "hello"; print(x)` 会怎样？',
  '["打印100", "打印hello", "报错，类型错误", "先打印100，再打印hello"]',
  2,
  '["Python变量本身没有固定的‘类型’。", "变量只是一个‘标签’，可以贴在任何‘值’上。", "第二次赋值`x = \\"hello\\"`，标签就换到字符串上了。"]',
  'Python是动态类型语言。变量可以随时被重新赋值为任何类型的值。`x`先指向整数100，后指向字符串"hello"，因此最终打印"hello"。',
  '`data = 42; data = [1,2,3]; data = "text"` 是完全合法的。'
),
(
  43,
  3,
  '好名字的价值',
  '以下两段代码都计算订单总价，哪段代码的可读性更好，更容易维护？',
  '["A: a = 10.5\\nb = 2\\nc = a * b\\nprint(c)", "B: unit_price = 10.5\\nquantity = 2\\ntotal_cost = unit_price * quantity\\nprint(total_cost)"]',
  2,
  '["代码是写给人看的，其次是给机器执行的。", "有意义的变量名就像代码的‘注释’。", "`unit_price`和`quantity`比`a`和`b`清楚多了。"]',
  '虽然两段代码功能相同，但代码B使用了有意义的变量名，清晰地表明了数据的含义（单价、数量、总成本），大大提升了代码的可读性和可维护性。',
  '对比 `s = l * w` 和 `area = length * width`，后者一目了然。'
);

INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES

(
  34,
  3,
  '欢迎新同学',
  '小码农的代码卡住了！请帮他完成这段欢迎新同学‘小明’的代码。',
  NULL,
  '["Welcome, 小明!"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": " "}, {"type": "slot", "index": 0}, {"type": "code", "value": " = \\\""}, {"type": "slot", "index": 1}, {"type": "code", "value": "\\\"\\n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"Welcome, \\\" + student_name + \\\"!\\\")"}]}]}',
  '["student_name", "小明", "student name", "name", "stuName", "小张"]',
  '[0, 1]',
  '第一空需要一个合法的变量名来存储同学的名字，`student_name`符合规则。第二空是变量的值，即字符串“小明”。',
  '类似地，`city = "北京"` 和 `print("I live in " + city)`。'
),
(
  35,
  3,
  '午餐结账',
  '帮小A完成午餐结账小程序，计算一份汉堡（15元）和一份薯条（8元）的总价。',
  NULL,
  '["总价: 23"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "burger_price = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\nfries_price = "}, {"type": "slot", "index": 1}, {"type": "code", "value": "\\n"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": " "}, {"type": "slot", "index": 2}, {"type": "code", "value": " = burger_price + fries_price\\n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"总价:\\\", total)"}]}]}',
  '["15", "8", "total", "sum", "burgerPrice", "price_total", "23"]',
  '[0, 1, 2]',
  '前两空分别给变量`burger_price`和`fries_price`赋数值。第三空需要一个变量名来存储总价，`total`是常见且有意义的选择。',
  '计算矩形面积：`width = 5`, `height = 3`, `area = width * height`。'
),
(
  39,
  3,
  '修复变量命名',
  '这段代码因为变量命名问题无法运行，请从选项中选出正确的片段替换掉错误的命名。',
  NULL,
  '["Python is fun!"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": " "}, {"type": "slot", "index": 0}, {"type": "code", "value": " = \\\"Python\\\"\\n"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "2word = \\\"is\\\"\\n# 请替换上一行中的变量名\\n"}, {"type": "slot", "index": 1}, {"type": "code", "value": " = \\\"fun!\\\"\\n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(lang, word2, feeling)"}]}]}',
  '["lang", "word2", "feeling", "2word", "first word", "first-word", "is"]',
  '[0, 1, 2]',
  '`2word`是非法的，因为变量名不能以数字开头，应改为`word2`。`first word`和`first-word`包含空格和连字符，也是非法的。需选择三个合法的变量名。',
  '非法名：`3d_model`；合法修改：`model_3d`。'
),
(
  40,
  3,
  '圆的魔术',
  '魔法师想用变量计算半径为5的圆的面积（π取3.14）。请补全他的魔法咒语（代码）。',
  NULL,
  '["面积是: 78.5"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "pi = 3.14\\n"}, {"type": "slot", "index": 0}, {"type": "code", "value": " = 5\\n"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "area = "}, {"type": "slot", "index": 1}, {"type": "code", "value": " * "}, {"type": "slot", "index": 2}, {"type": "code", "value": " ** 2\\n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"面积是:\\\", area)"}]}]}',
  '["radius", "r", "pi", "radius * pi", "3.14", "2", "area", "直径"]',
  '[0, 1, 2]',
  '第一空应为存储半径的变量名，`radius`比`r`更具描述性。面积公式是 `π * r²`，所以第二、三空应填入`pi`和`radius`。',
  '计算正方形面积：`side = 4; area = side ** 2`。'
),
(
  44,
  3,
  '格式化自我介绍',
  '请补全代码，让程序能使用变量生成一句格式工整的自我介绍。',
  NULL,
  '["大家好，我是张三，今年20岁，来自北京。"]',
  '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "name = \\\"张三\\\"\\nage = "}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\ncity = \\\"北京\\\"\\n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "# 使用f-string格式化字符串"}, {"type": "code_inline", "parts": [{"type": "code", "value": "intro = f\\\"大家好，我是{name}，今年"}, {"type": "slot", "index": 1}, {"type": "code", "value": "岁，来自{city}。\\\"\\n"}]}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(intro)"}]}]}',
  '["20", "age", "\\\"{age}\\\"", "{age}", "twenty", "年龄"]',
  '[0, 3]',
  '第一空给变量`age`赋一个整数值20。在f-string中，要嵌入变量的值，需要将变量名直接放在花括号`{}`内，所以第二空填`{age}`。',
  '`score=95; msg=f"我的得分是{score}"` 会生成“我的得分是95”。'
),
(
  45,
  3,
  '终极变量挑战',
  '综合挑战！补全这个模拟‘生命值’和‘攻击力’计算的迷你游戏代码。',
  NULL,
  '["英雄初始生命: 100", "受到伤害! 生命: 80.0", "发动攻击! 造成伤害: 24.0"]',
  '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "# 定义属性"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "hero_"}, {"type": "slot", "index": 0}, {"type": "code", "value": " = 100.0\\nattack_power = 20.0\\n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"英雄初始生命:\\\", hero_health)"}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "# 受到伤害（假设防御系数0.8）"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "damage_taken = 25.0 * 0.8\\nhero_health = "}, {"type": "slot", "index": 1}, {"type": "code", "value": " - damage_taken\\n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"受到伤害! 生命:\\\", hero_health)"}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "# 发动攻击（假设暴击系数1.2）"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "final_damage = "}, {"type": "slot", "index": 2}, {"type": "code", "value": " * 1.2\\n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\\\"发动攻击! 造成伤害:\\\", final_damage)"}]}]}',
  '["health", "life", "HP", "hero_health", "damage_taken", "attack_power", "25.0"]',
  '[0, 3, 5]',
  '第一空为变量名`hero_health`的后半部分，`health`比`life`更常见。第二空需要用当前生命值减去伤害，所以填变量`hero_health`。第三空是计算最终伤害的基础攻击力，填变量`attack_power`。',
  '游戏开发中常用`hp`代表生命值，`atk`代表攻击力，如：`hp = hp - enemy_atk`。'
);