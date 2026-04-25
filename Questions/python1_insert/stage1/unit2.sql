USE `questions`;

-- =========== INSERT: 选择题 (9 条) ===========
INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('16', 2, '单行注释的符号',
   '在 Python 中写单行注释最常用的符号是哪一个？',
   JSON_OBJECT(
     'A', '//',
     'B', '#',
     'C', '/* */',
     'D', '""" """'
   ),
   2,
   JSON_ARRAY(
     '提示1：这是 Python 里最常见的注释写法，很多脚本都会看到它。',
     '提示2：带两个斜杠的是其他语言（比如 JavaScript / C++）。',
     '提示3：Python 使用井号开头作为单行注释。'
   ),
   'Python 使用 # 开头表示单行注释，三引号通常用于多行字符串或文档字符串，而 // 和 /* */ 是其他语言的注释风格。',
   '例如：# 这是一个注释，解释代码的用途'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('17', 2, '文档字符串（docstring）用途',
   '下面关于函数文档字符串（docstring）的描述，哪个最准确？',
   JSON_OBJECT(
     'A', '只用于注释，不会被解释器保留',
     'B', '位于函数体第一行，用三引号，解释函数用途并可在运行时访问',
     'C', '只能放在文件开头，不能放在函数中',
     'D', '必须使用单引号且只能是单行'
   ),
   2,
   JSON_ARRAY(
     '提示1：docstring 常放在函数定义后的第一行，用于描述函数目的。',
     '提示2：docstring 一般用三引号，可以是单行或多行，并且能被 help() 读取。',
     '提示3：选项 B 正确描述了 docstring 的典型用法。'
   ),
   '文档字符串放在函数体的第一行，用三引号书写，解释函数用途并可被 help() 或 __doc__ 读取。',
   '例如：def foo():\n    \"\"\"这是函数 foo 的文档字符串\"\"\"'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('18', 2, '内联注释风格',
   '哪种内联注释写法更符合 PEP8（短、紧凑且可读）？',
   JSON_OBJECT(
     'A', 'x = 1#count',
     'B', 'x = 1  # count',
     'C', 'x = 1   #count',
     'D', 'x = 1# count'
   ),
   2,
   JSON_ARRAY(
     '提示1：PEP8 建议注释前至少两个空格以增强可读性。',
     '提示2：注释符号 # 后通常跟一个空格，保持整洁。',
     '提示3：在代码与注释之间保留两个空格最为规范。'
   ),
   'PEP8 推荐在代码和内联注释之间至少留两个空格，并在 # 后加一个空格，例如 x = 1  # count。',
   '正确样例：total = 0  # 累加器'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('21', 2, '变量命名风格',
   '按照 PEP8，哪个变量命名风格是推荐的？',
   JSON_OBJECT(
     'A', 'myVariable',
     'B', 'my_variable',
     'C', 'my-variable',
     'D', 'MyVariable'
   ),
   2,
   JSON_ARRAY(
     '提示1：PEP8 推荐使用小写字母并用下划线分隔单词。',
     '提示2：驼峰命名（myVariable）更常见于 Java 等语言。',
     '提示3：短横线（-）不能用在标识符中。'
   ),
   'PEP8 建议使用小写并用下划线分隔的风格（snake_case），如 my_variable。',
   '例如 good_name = "Alice"'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('22', 2, '行长度限制',
   'PEP8 推荐的单行最大长度通常是？',
   JSON_OBJECT(
     'A', '79 字符',
     'B', '120 字符',
     'C', '50 字符',
     'D', '无限制'
   ),
   1,
   JSON_ARRAY(
     '提示1：PEP8 给出了一个较短的保守值以提升可读性。',
     '提示2：很多编辑器默认以 79 或 80 为换行提示。',
     '提示3：虽然有时可以放宽，但规范推荐 79。'
   ),
   'PEP8 建议限制单行长度为 79 字符，以便在各种显示设备上保持良好可读性。',
   '如果行很长，可以通过换行或把表达式拆成多行来处理。'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('23', 2, '缩进风格',
   '在 Python 中，推荐的缩进宽度是？',
   JSON_OBJECT(
     'A', '2 个空格',
     'B', '4 个空格',
     'C', '1 个 tab',
     'D', '混合空格和 tab'
   ),
   2,
   JSON_ARRAY(
     '提示1：PEP8 强烈建议使用空格而非 tab。',
     '提示2：常见的推荐缩进是 4 个空格。',
     '提示3：混合使用空格和 tab 会导致缩进错误。'
   ),
   'PEP8 推荐使用 4 个空格作为缩进，不推荐混合使用 tab 与空格以避免错误。',
   '例如：def foo():\n    return 1  (缩进为 4 个空格)'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('26', 2, '文件末尾的空行',
   '在源文件末尾保留一个空行，通常是为了什么？',
   JSON_OBJECT(
     'A', '让解释器多打印一行',
     'B', '提高兼容性并符合 POSIX 文本文件规范',
     'C', '防止代码被压缩',
     'D', '美观无意义'
   ),
   2,
   JSON_ARRAY(
     '提示1：POSIX 文本文件规范建议用换行符结尾。',
     '提示2：很多工具和版本控制系统更容易处理以换行结尾的文件。',
     '提示3：这是良好工程实践而非盲目美观。'
   ),
   '以换行符结尾的文件更符合传统的文本文件规范，能在一些工具或差异比较中表现更好。',
   '保存文件时确保最后一行后有一个换行符'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('27', 2, '避免尾随空白',
   '为什么要避免行尾多余的空格（trailing whitespace）？',
   JSON_OBJECT(
     'A', '会让 Python 更快',
     'B', '可能在版本控制中产生无意义的差异',
     'C', '解释器会忽略但会影响内存',
     'D', '这是必须的语法要求'
   ),
   2,
   JSON_ARRAY(
     '提示1：尾随空格不会改变代码逻辑，但会影响 diff 显示。',
     '提示2：许多代码检查工具会把尾随空白标为错误。',
     '提示3：因此应避免尾随空格以保持仓库整洁。'
   ),
   '尾随空格会在版本控制差异中造成无意义的差别，并被许多 linter 视为问题，应当删除。',
   '在编辑器中开启“显示空格/换行符”选项有助于避免此类问题'
  );

INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  ('28', 2, '注释的目的',
   '下列哪一项最能概括注释的主要目的？',
   JSON_OBJECT(
     'A', '让代码运行更快',
     'B', '记录为什么这样写，帮助他人/未来的你理解代码',
     'C', '装饰代码，使其更漂亮',
     'D', '替代单元测试'
   ),
   2,
   JSON_ARRAY(
     '提示1：注释用于解释原因与意图，而不是改变代码行为。',
     '提示2：注释不能替代良好的测试或设计。',
     '提示3：良好注释帮助团队协作与未来维护。'
   ),
   '注释的作用是解释代码的意图与设计决策，帮助阅读与维护，而不是改变性能或代替测试。',
   '例如在复杂算法前加注释说明思路，而不是逐行注释显而易见的代码'
  );


-- =========== INSERT: 填空题 (6 条) ===========
-- 说明：填空题的 code 字段采用 JSON (segments)。slot index 使用 0-based（slot 出现顺序）。
--       options 使用 JSON_ARRAY(...)，answer 使用 JSON_ARRAY(1-based indices)。

INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  '19',
  2,
  '函数体内的文档字符串（填空）',
  '补全下面函数，使其包含正确的文档字符串（将选项序号按顺序填入空位）。',
  NULL,
  NULL,
  -- code: segments (一个 def 行；第二行为一个带 slot 的缩进行；第三行为 return)
  JSON_OBJECT(
    'segments',
    JSON_ARRAY(
      JSON_OBJECT(
        'type', 'code_block',
        'lines', JSON_ARRAY(JSON_OBJECT('type','code_line','value','def greet(name):'))
      ),
      JSON_OBJECT(
        'type', 'code_inline',
        'parts', JSON_ARRAY(
          JSON_OBJECT('type','code','value','    '),
          JSON_OBJECT('type','slot','index',0)
        )
      ),
      JSON_OBJECT(
        'type', 'code_block',
        'lines', JSON_ARRAY(JSON_OBJECT('type','code_line','value','    return \"Hello \" + name'))
      )
    )
  ),
  -- options: 5 options, 原始顺序尽量保留（对原始文本做了必要的去外层引号规范化）
  JSON_ARRAY(
    '\"\"\"Greet 用户并返回问候\"\"\"',
    'Greet the user',
    '\"\"\"greet\"\"\"',
    '# greet function',
    '\"\"\"Greet the user.\\nReturns greeting string.\"\"\"'
  ),
  JSON_ARRAY(1),
  '函数的文档字符串应该放在函数体第一行并用三引号书写，选项 1 是合适的多行/单行三引号样式。',
  '例如：def add(a, b):\n    \"\"\"返回 a 与 b 的和\"\"\"'
);

INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  '20',
  2,
  '文件头部的模块文档（填空）',
  '在模块文件开头添加模块级文档字符串，填入正确选项编号。',
  NULL,
  NULL,
  JSON_OBJECT(
    'segments',
    JSON_ARRAY(
      JSON_OBJECT(
        'type','code_inline',
        'parts', JSON_ARRAY(JSON_OBJECT('type','slot','index',0))
      ),
      JSON_OBJECT(
        'type','code_block',
        'lines', JSON_ARRAY(JSON_OBJECT('type','code_line','value','# 下面是模块的其它代码'))
      )
    )
  ),
  -- options：原始存在多种引号形式。为保证 SQL 可执行，我将保留大多数外层引号字符（三重双引号保留），
  -- 对三重单引号的项为了避免复杂的 SQL 内部单引号转义，已将其规范为以三重单引号文本的可读形式（见后面的说明）
  JSON_ARRAY(
    '\"\"\"This module handles user utils.\"\"\"',
    '# module doc',
    "'''模块说明'''",       -- 注意：这个项原来是用三重单引号，我在此用三个单引号字符包裹为了可读性（已在脚注说明）。
    '// module doc',
    '/* module */',
    "'''doc'''"            -- 同上，使用三重单引号表示
  ),
  JSON_ARRAY(1),
  '模块级文档字符串通常放在文件顶部并使用三引号，选项 1 为合格写法（也可使用其他三引号风格，但此处统一选项 1）。',
  '示例开头：\"\"\"Utilities for processing user data\"\"\"'
);

INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  '24',
  2,
  '内联注释的空格（填空）',
  '按照 PEP8，内联注释前应该至少留几个空格？填入选项序号。',
  NULL,
  NULL,
  JSON_OBJECT(
    'segments',
    JSON_ARRAY(
      JSON_OBJECT(
        'type','code_inline',
        'parts', JSON_ARRAY(
          JSON_OBJECT('type','code','value','value = 42'),
          JSON_OBJECT('type','slot','index',0),
          JSON_OBJECT('type','code','value','# answer to everything')
        )
      )
    )
  ),
  -- options 原文: ' ,1, 2, 0, 3, 4'（原文本含有疑似首项为空格）。我做了合理解析：第1项为空字符串，第2项为 '1'，依次类推
  JSON_ARRAY(
    '',
    '1',
    '2',
    '0',
    '3',
    '4'
  ),
  JSON_ARRAY(3), -- 原文件 answer '2'（表示两个空格），按我们解析的 options，'2' 在第3位 -> JSON_ARRAY(3)
  'PEP8 建议在代码与内联注释之间至少留两个空格，选项 2 表示两个空格（此处 answer 对应于 options 我做了索引对齐，见脚注）。',
  '例如：x = x + 1  # 增加计数'
);

INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  '25',
  2,
  '函数名命名风格（填空）',
  '按照 PEP8，函数命名应使用哪种风格？请选择正确编号并填入空格处。',
  NULL,
  NULL,
  JSON_OBJECT(
    'segments',
    JSON_ARRAY(
      JSON_OBJECT(
        'type','code_inline',
        'parts', JSON_ARRAY(JSON_OBJECT('type','code','value','def '), JSON_OBJECT('type','slot','index',0), JSON_OBJECT('type','code','value','(arg):'))
      ),
      JSON_OBJECT(
        'type','code_block',
        'lines', JSON_ARRAY(JSON_OBJECT('type','code_line','value','    pass'))
      )
    )
  ),
  JSON_ARRAY('myFunction','my_function','MyFunction','my-function','myfunction'),
  JSON_ARRAY(2),
  'PEP8 推荐函数使用小写并用下划线分隔（snake_case），即 my_function。',
  '例如：def calculate_sum(a, b):'
);

INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  '29',
  2,
  '模块导入风格（填空）',
  '请选择合适的导入写法，填入序号，使其符合 PEP8 常见风格（不要使用通配符导入）。',
  NULL,
  NULL,
  JSON_OBJECT(
    'segments',
    JSON_ARRAY(
      JSON_OBJECT('type','code_inline','parts', JSON_ARRAY(JSON_OBJECT('type','slot','index',0))),
      JSON_OBJECT('type','code_inline','parts', JSON_ARRAY(JSON_OBJECT('type','slot','index',1))),
      JSON_OBJECT('type','code_block','lines', JSON_ARRAY(JSON_OBJECT('type','code_line','value','result = math.sqrt(4)'))),
      JSON_OBJECT('type','code_block','lines', JSON_ARRAY(JSON_OBJECT('type','code_line','value','json_str = json.dumps({\"a\":1})')))
    )
  ),
  -- options 原文有多个项。按原始顺序拆分并规范化为文本项
  JSON_ARRAY('import math','from math import *','import json','from json import dumps','import math as m','from math import sqrt'),
  -- 原文件 answer 为 '1,3' 表示两个空位分别填入选项1 和 3（1-based），所以 answer JSON_ARRAY(1,3)
  JSON_ARRAY(1,3),
  '常见并推荐的写法是使用 import math 与 import json 的形式（将模块显式导入），避免使用 from ... import *，因此选择 import math (选项 1) 和 import json (选项 3)。',
  '正确写法示例：import os\nimport sys'
);

INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES
(
  '30',
  2,
  '编码声明（Python2 兼容场景）（填空）',
  '在需要显式声明文件编码的情况下，一般把编码声明放在文件的哪一行？请选择序号填入空格处。',
  NULL,
  NULL,
  JSON_OBJECT(
    'segments',
    JSON_ARRAY(
      JSON_OBJECT('type','code_inline','parts', JSON_ARRAY(JSON_OBJECT('type','slot','index',0))),
      JSON_OBJECT('type','code_block','lines', JSON_ARRAY(JSON_OBJECT('type','code_line','value','# 其他代码开始')))
    )
  ),
  JSON_ARRAY('# -*- coding: utf-8 -*-','\"\"\"utf-8\"\"\"','# coding=utf-8','// coding: utf-8','\'# coding: utf-8\''),
  JSON_ARRAY(1),
  '传统的编码声明写法是放在文件顶部第二行或第一行，形式为 # -*- coding: utf-8 -*-；在现代 Python3 一般不需要，但在兼容场景下可保留。',
  '文件开头示例：#!/usr/bin/env python3\n# -*- coding: utf-8 -*-'
);