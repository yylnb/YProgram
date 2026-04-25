USE `questions`;

CREATE TABLE IF NOT EXISTS `que_choice_py_1` (
  `q_id` VARCHAR(255) NOT NULL,
  `unit_id` INT NOT NULL,
  `title` VARCHAR(255),
  `text` TEXT,
  `options` JSON,
  `answer` INT,
  `hints` JSON,
  `explanation` TEXT,
  `example` TEXT,
  PRIMARY KEY (`q_id`, `unit_id`)
);

CREATE TABLE IF NOT EXISTS `que_fill_py_1` (
  `q_id` VARCHAR(255) NOT NULL,
  `unit_id` INT NOT NULL,
  `title` VARCHAR(255),
  `text` TEXT,
  `input` TEXT,
  `output` JSON,
  `code` JSON,
  `options` JSON,
  `answer` JSON,
  `explanation` TEXT,
  `example` TEXT,
  PRIMARY KEY (`q_id`, `unit_id`)
);

-- ---------- 插入选择题 ----------
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('1', 17, '找位置的基本用法', '小王正在检查用户输入中有没有"@"符号，他使用 s.find("@")。如果找不到，会返回什么？', JSON_OBJECT('A', '-1', 'B', '0', 'C', 'None', 'D', '报错'), 1, JSON_ARRAY('find 的返回值是一个整数。', '当找不到时，它不会报错。', '找不到时的返回值是一个特殊数字，而不是 None。'), 'find() 找不到时返回 -1，这能让程序知道搜索失败但不中断。', '例如 "hello".find("x") 会返回 -1。');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('2', 17, 'replace 的基础替换逻辑', '字符串 s = "hello world"，执行 s.replace("o","O") 会发生什么？', JSON_OBJECT('A', '只替换第一个 o', 'B', '替换全部 o', 'C', '报错，因为大小写不同', 'D', '只替换最后一个 o'), 2, JSON_ARRAY('replace 的默认行为不会只替换一个。', '它会替换所有匹配的部分。', '注意 replace 不会修改原字符串，而是生成新字符串。'), 'replace("o","O") 会把所有的 o 全部替换成 O。', '例如 "banana".replace("a","A") → "bAnAnA"。');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('3', 17, 'find 的起始搜索位置', '执行 "pythonpython".find("py", 3) 会从哪里开始找？', JSON_OBJECT('A', '从头开始', 'B', '从下标 3 开始', 'C', '从下标 2 开始', 'D', '从下标 1 开始'), 2, JSON_ARRAY('find 可以指定起始位置。', '指定起始后会忽略之前的内容。', '下标从 0 开始计算。'), 'find("py", 3) 会从下标 3 开始搜索匹配。', '例如 "abcabc".find("a",2) 会返回 3。');

-- ---------- 插入填空题 ----------
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('4', 17, '使用 find 找到关键字位置', '补全代码，找到子字符串第一次出现的位置。', 'text = "welcome to python world"', JSON_ARRAY('11'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "pos = text."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"to\")\nprint(pos)"}]}]}', JSON_ARRAY('len', 'lower', 'upper', 'find', 'replace', '11', 'to'), JSON_ARRAY(4), 'find("to") 会返回子串在字符串中的位置。', '例如 "abcde".find("cd") 返回 2。');