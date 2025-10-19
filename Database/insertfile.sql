USE study_app;
INSERT INTO library
(lang, lb_id, difficulty, page, title, tags, summary, content, eg_in, eg_out)
VALUES
(
  'python',
  1,
  'beginner',
  1,
  'print函数入门',
  '[\"基础\", \"输出\"]',
  '学习如何使用print()在控制台输出内容。',
  '在Python中，print()函数用于输出文本或变量的值。',
  '[\"print(\\\"Hello World\\\")\"]',
  '[\"Hello World\"]'
);

INSERT INTO library
(lang, lb_id, difficulty, page, title, tags, summary, content, eg_in, eg_out)
VALUES
(
  'python',
  2,
  'beginner',
  1,
  '变量与赋值',
  '[\"基础\", \"变量\"]',
  '介绍如何定义变量并赋值。',
  '在Python中，可以直接通过 = 来给变量赋值，例如 x = 10。',
  '[\"x = 10\\nprint(x)\"]',
  '[\"10\"]'
);

INSERT INTO library
(lang, lb_id, difficulty, page, title, tags, summary, content, eg_in, eg_out)
VALUES
(
  'cpp',
  1,
  'beginner',
  1,
  'Hello World程序',
  '[\"基础\", \"输出\"]',
  '学习如何在C++中输出Hello World。',
  '使用iostream库中的cout对象来输出字符串。',
  '[\"#include <iostream>\\nusing namespace std;\\nint main(){ cout << \\\"Hello World\\\"; return 0; }\"]',
  '[\"Hello World\"]'
);

INSERT INTO library
(lang, lb_id, difficulty, page, title, tags, summary, content, eg_in, eg_out)
VALUES
(
  'python',
  3,
  'intermediate',
  1,
  'if条件语句',
  '[\"条件\", \"控制流\"]',
  '学习如何使用if语句控制程序执行。',
  'if语句用于根据条件是否为真来执行不同的代码块。',
  '[\"x = 5\\nif x > 3:\\n    print(\\\"大于3\\\")\"]',
  '[\"大于3\"]'
);

INSERT INTO library
(lang, lb_id, difficulty, page, title, tags, summary, content, eg_in, eg_out)
VALUES
(
  'python',
  4,
  'advanced',
  1,
  '装饰器函数',
  '[\"函数\", \"高级\"]',
  '介绍Python中的函数装饰器用法。',
  '装饰器是一种高阶函数，用于在不修改原函数代码的情况下扩展功能。',
  '[\"def decorator(func):\\n    def wrapper():\\n        print(\\\"开始执行\\\")\\n        func()\\n        print(\\\"执行结束\\\")\\n    return wrapper\\n\\n@decorator\\ndef hello():\\n    print(\\\"Hello\\\")\\n\\nhello()\"]',
  '[\"开始执行\", \"Hello\", \"执行结束\"]'
);
