USE `questions`;

-- ---------- 插入选择题（que_choice_py_1） ----------
INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('1', 1, 'print 的最基本用途',
   '小明第一次学习 Python，他想在屏幕上输出“Hello”。他应该使用哪一条语句？',
   JSON_OBJECT(
     'A', 'print(Hello)',
     'B', 'print("Hello")',
     'C', 'echo "Hello"',
     'D', 'output("Hello")'
   ),
   2,
   JSON_ARRAY(
     'Python 输出通常使用一个固定的函数。',
     '字符串必须被某种方式包裹。',
     '检查一下哪个选项既是 Python 语法又有正确的字符串写法。'
   ),
   'print(\"Hello\") 是标准的 Python 输出语句，字符串必须用引号括起。',
   '例如你也可以输出你的名字：print(\"Leon\")'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('2', 1, 'print 与括号',
   '学习中，小红忘记写括号，直接写 print \"Hi\"。这在 Python 中会怎样？',
   JSON_OBJECT(
     'A', '可以正常输出',
     'B', '输出但会警告',
     'C', '会报错，因为缺少括号',
     'D', '自动补上括号'
   ),
   3,
   JSON_ARRAY(
     'Python3 是强制使用函数调用格式的。',
     'print 在 Python3 中不是关键字，而是函数。',
     '函数必须写括号。'
   ),
   '在 Python3 中 print 是函数，必须写 print(\"Hi\") 才能运行。',
   '正确写法示例：print(\"学习 Python 真开心！\")'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('3', 1, 'print 输出多个内容',
   '如果你想一次输出多个内容，例如名字和年龄，下列哪个写法是正确的？',
   JSON_OBJECT(
     'A', 'print(\"Tom\" \"18\")',
     'B', 'print(\"Tom\", 18)',
     'C', 'print(\"Tom\" + 18)',
     'D', 'print(Tom, 18)'
   ),
   2,
   JSON_ARRAY(
     'print 可以接受多个参数。',
     '多个参数之间用逗号分隔。',
     '注意字符串与数字不能直接相加。'
   ),
   'print(\"Tom\", 18) 会输出两个内容，中间默认以空格分隔。',
   '例如：print(\"结果是\", 3 + 5)'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('6', 1, 'print 与空格行为',
   'print(\"A\", \"B\") 输出时，两者之间默认是什么？',
   JSON_OBJECT(
     'A', '没有间隔',
     'B', '一个空格',
     'C', '一个逗号',
     'D', '两个空格'
   ),
   2,
   JSON_ARRAY(
     'print 会自动帮你处理分隔符。',
     '默认分隔符由一个参数控制：sep。',
     'sep 默认是空格。'
   ),
   'print 默认使用空格作为分隔符。',
   'print(\"Python\", \"Rocks\") 会输出 Python Rocks'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('7', 1, '换行行为',
   'print 默认在输出末尾添加什么？',
   JSON_OBJECT(
     'A', '一个空格',
     'B', '一个换行',
     'C', '一个 tab',
     'D', '什么都不加'
   ),
   2,
   JSON_ARRAY(
     'print 的“end”参数控制末尾行为。',
     '默认不会是空的。',
     '通常输出后自动换到下一行。'
   ),
   'print 默认以换行结尾，如果想去掉可以写 end=\"\".',
   'print(\"A\", end=\"\"); print(\"B\") 输出 AB'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('8', 1, 'print 输出数字',
   '想输出 3 + 4 的结果，正确写法是哪种？',
   JSON_OBJECT(
     'A', 'print(\"3 + 4\")',
     'B', 'print(3 + 4)',
     'C', 'print(\"3\" + 4)',
     'D', 'print(3, +, 4)'
   ),
   2,
   JSON_ARRAY(
     '字符串不会自动计算表达式。',
     'print 可以输出表达式的结果。',
     '数字之间运算无需加引号。'
   ),
   '3 + 4 是表达式，会被计算为 7。',
   'print(10 * 5) 会输出 50'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('11', 1, 'sep 的作用',
   'print(\"A\", \"B\", sep=\"-\") 会输出什么？',
   JSON_OBJECT(
     'A', 'A-B',
     'B', 'A B',
     'C', 'A--B',
     'D', 'AB'
   ),
   1,
   JSON_ARRAY(
     'sep 是分隔符。',
     '默认是空格，这里被改成了 “-”。',
     '看起来像 A 和 B 之间加了一个连字符。'
   ),
   'sep=\"-\" 会在多个参数之间使用短横线。',
   'print(\"year\", \"2025\", sep=\":\") → year:2025'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('12', 1, 'print 输出中文',
   '想输出中文“你好”，应该怎么写？',
   JSON_OBJECT(
     'A', 'print(你好)',
     'B', 'print(\"你好\")',
     'C', 'print(\\\'你好\")',
     'D', 'print(hello)'
   ),
   2,
   JSON_ARRAY(
     '中文也是字符串。',
     '字符串必须加引号。',
     'Python 完全支持中文字符。'
   ),
   'print(\"你好\") 是正确写法。',
   'print(\"我正在学习 Python\")'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('13', 1, '打印转义字符',
   'print(\"A\\nB\") 会输出什么？',
   JSON_OBJECT(
     'A', 'A n B',
     'B', 'A\\nB',
     'C', 'A 换行 B',
     'D', 'AB'
   ),
   3,
   JSON_ARRAY(
     '\\n 在字符串中表示换行。',
     '不是两个字符，而是一个“换行符号”。',
     '注意题目是打印效果，而不是字面内容。'
   ),
   '字符串中的 \\n 会产生换行。',
   'print(\"Hello\\nWorld\")'
  );

-- ---------- 插入填空题（que_fill_py_1） ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  4,
  1,
  '基础输出结构',
  '补全代码，使其正确输出一句完整的话。',
  NULL,
  JSON_ARRAY('I love Python'),
  '{ "segments": [
      {
        "type": "code_inline",
        "parts": [
          { "type": "slot", "index": 0 },
          { "type": "code", "value": "(\\\"I love Python\\\")" }
        ]
      }
    ] }',
  JSON_ARRAY('print','echo','output','println'),
  JSON_ARRAY(1),
  '只有 print 是 Python 的输出函数。',
  'print(\"今天写代码真顺利\")'
);

INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  5,
  1,
  '输出变量内容',
  '根据给定变量，补全输出句子。',
  JSON_ARRAY('name = \"Lucy\"'),
  JSON_ARRAY('Hello Lucy'),
  '{ "segments": [
      {
        "type": "code_inline",
        "parts": [
          { "type": "code", "value": "" },
          { "type": "slot", "index": 0 },
          { "type": "code", "value": "(\\\"Hello\\\", " },
          { "type": "slot", "index": 1 },
          { "type": "code", "value": ")" }
        ]
      }
    ] }',
  JSON_ARRAY('print','name','output','echo'),
  JSON_ARRAY(1,2),
  'print 是输出函数，name 是变量，组合后输出 Hello Lucy。',
  '例如：print(\"Hello\", username)'
);

INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  9,
  1,
  '输出表达式结果',
  '补全代码，使其输出计算结果。',
  NULL,
  JSON_ARRAY('12'),
  '{ "segments": [
      {
        "type": "code_inline",
        "parts": [
          { "type": "slot", "index": 0 },
          { "type": "code", "value": "(3 * " },
          { "type": "slot", "index": 1 },
          { "type": "code", "value": ")" }
        ]
      }
    ] }',
  JSON_ARRAY('print','4','\"4\"','echo'),
  JSON_ARRAY(1,2),
  'print 输出内容；3 * 4 等于 12。',
  '例如：print(6 * 7)'
);

INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  10,
  1,
  '控制换行',
  '用 end 参数让两个输出写在同一行。',
  NULL,
  JSON_ARRAY('HelloWorld'),
  '{ "segments": [
      {
        "type": "code_inline",
        "parts": [
          { "type": "code", "value": "print(\\\"Hello\\\", " },
          { "type": "slot", "index": 0 },
          { "type": "code", "value": "=\\\"\\\")" }
        ]
      },
      {
        "type": "code_block",
        "lines": [
          { "type": "code_line", "value": "print(\\\"World\\\")" }
        ]
      }
    ] }',
  JSON_ARRAY('end','sep','finish','stop'),
  JSON_ARRAY(1),
  'end 控制输出末尾行为；end=\"\" 表示不换行。',
  'print(\"A\", end=\"\"); print(\"B\")'
);

INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  14,
  1,
  '组合文本与表达式',
  '补全代码，使其输出：Result: 9',
  NULL,
  JSON_ARRAY('Result: 9'),
  '{ "segments": [
      {
        "type": "code_inline",
        "parts": [
          { "type": "code", "value": "print(\\\"Result:\\\", " },
          { "type": "slot", "index": 0 },
          { "type": "code", "value": " + " },
          { "type": "slot", "index": 1 },
          { "type": "code", "value": ")" }
        ]
      }
    ] }',
  JSON_ARRAY('4','5','\"4\"','print','\"5\"'),
  JSON_ARRAY(1,2),
  '4 + 5 等于 9；不能用字符串 \"4\" 和 \"5\" 做加法。',
  'print(\"Sum:\", 10 + 2)'
);

INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  15,
  1,
  'print 的多参数与 sep',
  '补全代码，使其输出 A|B|C',
  NULL,
  JSON_ARRAY('A|B|C'),
  '{ "segments": [
      {
        "type": "code_inline",
        "parts": [
          { "type": "code", "value": "print(\\\"A\\\", \\\"B\\\", \\\"C\\\", " },
          { "type": "slot", "index": 0 },
          { "type": "code", "value": "=\\\"|\\\")" }
        ]
      }
    ] }',
  JSON_ARRAY('sep','end','join','cut'),
  JSON_ARRAY(1),
  'sep 指定多个参数之间的分隔符。',
  'print(\"x\", \"y\", \"z\", sep=\":\")'
);