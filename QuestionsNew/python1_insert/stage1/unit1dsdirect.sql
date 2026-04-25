USE `questions`;

-- ---------- 创建选择题表 ----------
CREATE TABLE IF NOT EXISTS `que_choice_py_1` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `q_id` VARCHAR(50) NOT NULL COMMENT '原始题目ID',
  `unit_id` INT NOT NULL DEFAULT 1,
  `title` VARCHAR(255) NOT NULL,
  `text` TEXT NOT NULL COMMENT '题目正文',
  `options` JSON NOT NULL COMMENT '选项JSON对象',
  `answer` TINYINT NOT NULL COMMENT '正确答案索引: 1=A,2=B,3=C,4=D',
  `hints` JSON DEFAULT NULL COMMENT '提示数组',
  `explanation` TEXT DEFAULT NULL COMMENT '解析',
  `example` TEXT DEFAULT NULL COMMENT '示例',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_unit_id` (`unit_id`),
  INDEX `idx_q_id` (`q_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- 创建填空题表 ----------
CREATE TABLE IF NOT EXISTS `que_fill_py_1` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `q_id` VARCHAR(50) NOT NULL COMMENT '原始题目ID',
  `unit_id` INT NOT NULL DEFAULT 1,
  `title` VARCHAR(255) NOT NULL,
  `text` TEXT NOT NULL COMMENT '题目正文',
  `input` TEXT DEFAULT NULL COMMENT '输入说明',
  `output` JSON DEFAULT NULL COMMENT '期望输出',
  `code` JSON NOT NULL COMMENT '代码结构',
  `options` JSON NOT NULL COMMENT '选项数组',
  `answer` JSON NOT NULL COMMENT '正确答案索引数组(1-based)',
  `explanation` TEXT DEFAULT NULL COMMENT '解析',
  `example` TEXT DEFAULT NULL COMMENT '示例',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_unit_id` (`unit_id`),
  INDEX `idx_q_id` (`q_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- 插入选择题 ----------

-- 题目1
INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  (
    '1', 1, 'print 的最基本用途',
    '小明第一次学习 Python，他想在屏幕上输出"Hello"。他应该使用哪一条语句？',
    JSON_OBJECT(
      'A', 'print(Hello)',
      'B', 'print("Hello")',
      'C', 'echo "Hello"',
      'D', 'output("Hello")'
    ),
    2, -- B=2
    JSON_ARRAY(
      'Python 输出通常使用一个固定的函数。',
      '字符串必须被某种方式包裹。',
      '检查一下哪个选项既是 Python 语法又有正确的字符串写法。'
    ),
    'print("Hello") 是标准的 Python 输出语句，字符串必须用引号括起。',
    '例如你也可以输出你的名字：print("Leon")'
  );

-- 题目2
INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  (
    '2', 1, 'print 与括号',
    '学习中，小红忘记写括号，直接写 print "Hi"。这在 Python 中会怎样？',
    JSON_OBJECT(
      'A', '可以正常输出',
      'B', '输出但会警告',
      'C', '会报错，因为缺少括号',
      'D', '自动补上括号'
    ),
    3, -- C=3
    JSON_ARRAY(
      'Python3 是强制使用函数调用格式的。',
      'print 在 Python3 中不是关键字，而是函数。',
      '函数必须写括号。'
    ),
    '在 Python3 中 print 是函数，必须写 print("Hi") 才能运行。',
    '正确写法示例：print("学习 Python 真开心！")'
  );

-- 题目3
INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  (
    '3', 1, 'print 输出多个内容',
    '如果你想一次输出多个内容，例如名字和年龄，下列哪个写法是正确的？',
    JSON_OBJECT(
      'A', 'print("Tom" "18")',
      'B', 'print("Tom", 18)',
      'C', 'print("Tom" + 18)',
      'D', 'print(Tom, 18)'
    ),
    2, -- B=2
    JSON_ARRAY(
      'print 可以接受多个参数。',
      '多个参数之间用逗号分隔。',
      '注意字符串与数字不能直接相加。'
    ),
    'print("Tom", 18) 会输出两个内容，中间默认以空格分隔。',
    '例如：print("结果是", 3 + 5)'
  );

-- 题目6
INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  (
    '6', 1, 'print 与空格行为',
    'print("A", "B") 输出时，两者之间默认是什么？',
    JSON_OBJECT(
      'A', '没有间隔',
      'B', '一个空格',
      'C', '一个逗号',
      'D', '两个空格'
    ),
    2, -- B=2
    JSON_ARRAY(
      'print 会自动帮你处理分隔符。',
      '默认分隔符由一个参数控制：sep。',
      'sep 默认是空格。'
    ),
    'print 默认使用空格作为分隔符。',
    'print("Python", "Rocks") 会输出 Python Rocks'
  );

-- 题目7
INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  (
    '7', 1, '换行行为',
    'print 默认在输出末尾添加什么？',
    JSON_OBJECT(
      'A', '一个空格',
      'B', '一个换行',
      'C', '一个 tab',
      'D', '什么都不加'
    ),
    2, -- B=2
    JSON_ARRAY(
      'print 的"end"参数控制末尾行为。',
      '默认不会是空的。',
      '通常输出后自动换到下一行。'
    ),
    'print 默认以换行结尾，如果想去掉可以写 end="".',
    'print("A", end=""); print("B") 输出 AB'
  );

-- 题目8
INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  (
    '8', 1, 'print 输出数字',
    '想输出 3 + 4 的结果，正确写法是哪种？',
    JSON_OBJECT(
      'A', 'print("3 + 4")',
      'B', 'print(3 + 4)',
      'C', 'print("3" + 4)',
      'D', 'print(3, +, 4)'
    ),
    2, -- B=2
    JSON_ARRAY(
      '字符串不会自动计算表达式。',
      'print 可以输出表达式的结果。',
      '数字之间运算无需加引号。'
    ),
    '3 + 4 是表达式，会被计算为 7。',
    'print(10 * 5) 会输出 50'
  );

-- 题目11
INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  (
    '11', 1, 'sep 的作用',
    'print("A", "B", sep="-") 会输出什么？',
    JSON_OBJECT(
      'A', 'A-B',
      'B', 'A B',
      'C', 'A--B',
      'D', 'AB'
    ),
    1, -- A=1
    JSON_ARRAY(
      'sep 是分隔符。',
      '默认是空格，这里被改成了 "-"。',
      '看起来像 A 和 B 之间加了一个连字符。'
    ),
    'sep="-" 会在多个参数之间使用短横线。',
    'print("year", "2025", sep=":") → year:2025'
  );

-- 题目12
INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  (
    '12', 1, 'print 输出中文',
    '想输出中文"你好"，应该怎么写？',
    JSON_OBJECT(
      'A', 'print(你好)',
      'B', 'print("你好")',
      'C', 'print(\'你好")',
      'D', 'print(hello)'
    ),
    2, -- B=2
    JSON_ARRAY(
      '中文也是字符串。',
      '字符串必须加引号。',
      'Python 完全支持中文字符。'
    ),
    'print("你好") 是正确写法。',
    'print("我正在学习 Python")'
  );

-- 题目13
INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  (
    '13', 1, '打印转义字符',
    'print("A\\nB") 会输出什么？',
    JSON_OBJECT(
      'A', 'A n B',
      'B', 'A\\nB',
      'C', 'A 换行 B',
      'D', 'AB'
    ),
    3, -- C=3
    JSON_ARRAY(
      '\\n 在字符串中表示换行。',
      '不是两个字符，而是一个"换行符号"。',
      '注意题目是打印效果，而不是字面内容。'
    ),
    '字符串中的 \\n 会产生换行。',
    'print("Hello\\nWorld")'
  );

-- ---------- 插入填空题 ----------

-- 题目4
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  '4',
  1,
  '基础输出结构',
  '补全代码，使其正确输出一句完整的话。',
  NULL,
  JSON_ARRAY('I love Python'),
  JSON_OBJECT(
    'segments', JSON_ARRAY(
      JSON_OBJECT(
        'type', 'code_inline',
        'parts', JSON_ARRAY(
          JSON_OBJECT('type', 'slot', 'index', 0),
          JSON_OBJECT('type', 'code', 'value', '("I love Python")')
        )
      )
    )
  ),
  JSON_ARRAY('print', 'echo', 'output', 'println'),
  JSON_ARRAY(1),
  '只有 print 是 Python 的输出函数。',
  'print("今天写代码真顺利")'
);

-- 题目5
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  '5',
  1,
  '输出变量内容',
  '根据给定变量，补全输出句子。',
  'name = "Lucy"',
  JSON_ARRAY('Hello Lucy'),
  JSON_OBJECT(
    'segments', JSON_ARRAY(
      JSON_OBJECT(
        'type', 'code_inline',
        'parts', JSON_ARRAY(
          JSON_OBJECT('type', 'slot', 'index', 0),
          JSON_OBJECT('type', 'code', 'value', '("Hello", '),
          JSON_OBJECT('type', 'slot', 'index', 1),
          JSON_OBJECT('type', 'code', 'value', ')')
        )
      )
    )
  ),
  JSON_ARRAY('print', 'name', 'output', 'echo'),
  JSON_ARRAY(1, 2),
  'print 是输出函数，name 是变量，组合后输出 Hello Lucy。',
  '例如你也可以输出 print("Hello", username)'
);

-- 题目9
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  '9',
  1,
  '输出表达式结果',
  '补全代码，使其输出计算结果。',
  NULL,
  JSON_ARRAY('12'),
  JSON_OBJECT(
    'segments', JSON_ARRAY(
      JSON_OBJECT(
        'type', 'code_inline',
        'parts', JSON_ARRAY(
          JSON_OBJECT('type', 'slot', 'index', 0),
          JSON_OBJECT('type', 'code', 'value', '(3 * '),
          JSON_OBJECT('type', 'slot', 'index', 1),
          JSON_OBJECT('type', 'code', 'value', ')')
        )
      )
    )
  ),
  JSON_ARRAY('print', '4', '"4"', 'echo'),
  JSON_ARRAY(1, 2),
  'print 输出内容；3 * 4 等于 12。',
  '你也可以 print(6 * 7)'
);

-- 题目10
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  '10',
  1,
  '控制换行',
  '用 end 参数让两个输出写在同一行。',
  NULL,
  JSON_ARRAY('HelloWorld'),
  JSON_OBJECT(
    'segments', JSON_ARRAY(
      JSON_OBJECT(
        'type', 'code_inline',
        'parts', JSON_ARRAY(
          JSON_OBJECT('type', 'code', 'value', 'print("Hello", '),
          JSON_OBJECT('type', 'slot', 'index', 0),
          JSON_OBJECT('type', 'code', 'value', '="")')
        )
      ),
      JSON_OBJECT(
        'type', 'code_block',
        'lines', JSON_ARRAY(
          JSON_OBJECT('type', 'code_line', 'value', 'print("World")')
        )
      )
    )
  ),
  JSON_ARRAY('end', 'sep', 'finish', 'stop'),
  JSON_ARRAY(1),
  'end 控制输出末尾行为；end="" 表示不换行。',
  'print("A", end=""); print("B")'
);

-- 题目14
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  '14',
  1,
  '组合文本与表达式',
  '补全代码，使其输出：Result: 9',
  NULL,
  JSON_ARRAY('Result: 9'),
  JSON_OBJECT(
    'segments', JSON_ARRAY(
      JSON_OBJECT(
        'type', 'code_inline',
        'parts', JSON_ARRAY(
          JSON_OBJECT('type', 'code', 'value', 'print("Result:", '),
          JSON_OBJECT('type', 'slot', 'index', 0),
          JSON_OBJECT('type', 'code', 'value', ' + '),
          JSON_OBJECT('type', 'slot', 'index', 1),
          JSON_OBJECT('type', 'code', 'value', ')')
        )
      )
    )
  ),
  JSON_ARRAY('4', '5', '"4"', 'print', '"5"'),
  JSON_ARRAY(1, 2),
  '4 + 5 等于 9；不能用字符串 "4" 和 "5" 做加法。',
  'print("Sum:", 10 + 2)'
);

-- 题目15
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  '15',
  1,
  'print 的多参数与 sep',
  '补全代码，使其输出 A|B|C',
  NULL,
  JSON_ARRAY('A|B|C'),
  JSON_OBJECT(
    'segments', JSON_ARRAY(
      JSON_OBJECT(
        'type', 'code_inline',
        'parts', JSON_ARRAY(
          JSON_OBJECT('type', 'code', 'value', 'print("A", "B", "C", '),
          JSON_OBJECT('type', 'slot', 'index', 0),
          JSON_OBJECT('type', 'code', 'value', '="|")')
        )
      )
    )
  ),
  JSON_ARRAY('sep', 'end', 'join', 'cut'),
  JSON_ARRAY(1),
  'sep 指定多个参数之间的分隔符。',
  'print("x", "y", "z", sep=":")'
);

-- ====================== 机械性规范化与假设说明 ======================

/*
本次转换遵循以下规范化原则：

一、通用规则
1. 所有题目使用默认 unit_id = 1
2. q_id 保留原始题目ID（字符串格式）
3. 所有字符串内容保持原样，未修改语义

二、选择题（que_choice_py_1）
1. answer 映射规则：A=1, B=2, C=3, D=4
2. options 使用 MySQL JSON_OBJECT 构建
3. hints 使用 MySQL JSON_ARRAY 构建
4. 转义策略：所有字符串使用单引号包裹，内部单引号使用双写转义(''')
   例如："print("Hello")" 在 SQL 中写为 'print("Hello")'

三、填空题（que_fill_py_1）
1. code 字段使用 MySQL JSON_OBJECT/JSON_ARRAY 函数直接构建，避免手动转义问题
2. segments 结构规则：
   - 每个填空题视为一个或多个 segment
   - 单行代码使用 code_inline 类型
   - 多行代码使用 code_block 类型
   - slot 使用 0-based 索引
3. options 使用 JSON_ARRAY 构建
4. answer 使用 JSON_ARRAY 构建，使用 1-based 索引指向 options
5. output 使用 JSON_ARRAY 构建，即使单行输出也放入数组
6. 对于包含多行的代码，按行拆分为 code_line 对象

四、字段处理
1. 所有填空题的 input 字段：原数据为空字符串，转换为 NULL
2. 所有 output 字段：原为单行字符串，转换为 JSON_ARRAY
3. 所有 example/explanation 字段中的双引号保持原样，使用单引号包裹 SQL 字符串

五、特殊处理
1. 题目13中选项包含转义字符，保持原样插入
2. 填空题中原始 code 字符串的 ___ 被转换为 slot 结构
3. 填空题的 answer 已按规则从逗号分隔字符串转换为 JSON_ARRAY
   例如："1,2" 转换为 JSON_ARRAY(1,2)

注意：此脚本可直接在 MySQL 5.7+ 中执行，所有 JSON 字段均为合法 JSON 格式。
*/