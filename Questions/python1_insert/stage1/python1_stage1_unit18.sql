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
  ('1', 18, 'split 的基本功能', '小李正在整理一句用空格分隔的英文句子，他想把句子拆成单词列表，应使用哪个方法？', JSON_OBJECT('A', 'sentence.break()', 'B', 'sentence.split()', 'C', 'sentence.cut(" ")', 'D', 'sentence.divide()'), 2, JSON_ARRAY('Python 中用于拆分字符串的方法是固定的。', '默认按空格拆分。', '最常见的“切割字符串”方法就是 split。'), 'split() 会将字符串按空格拆成列表，是最常用的分割方法。', '例如："a b c".split() 结果为 ["a", "b", "c"]');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('2', 18, 'join 的用途', '小明有一个列表 ["a","b","c"]，他想把它变成 "a-b-c"，应如何做？', JSON_OBJECT('A', '"-".merge(["a","b","c"])', 'B', 'join(["a","b","c"], "-")', 'C', '"-".join(["a","b","c"])', 'D', '["a","b","c"].join("-")'), 3, JSON_ARRAY('注意 join 的调用者是谁。', 'join 是“分隔符”.join(列表)。', '哪个选项里分隔符在前面？'), 'join 的正确结构是 "分隔符".join(list)。', '例如：",".join(["x","y"]) → "x,y"');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('3', 18, 'split 的分隔符', '下面哪段代码会把字符串按逗号分割？', JSON_OBJECT('A', '"a,b,c".split()', 'B', '"a,b,c".split(",")', 'C', '"a,b,c".cut(",")', 'D', '"a,b,c".join(",")'), 2, JSON_ARRAY('split 默认按空格。', '如果想按指定符号拆分，需要传入该字符。', '只有一个选项使用 split(",")。'), 'split(",") 会按照逗号拆分字符串。', '例如："1|2|3".split("|") → ["1","2","3"]');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('6', 18, '复习 find：查找位置', '在字符串 "hello python" 中查找 "py"，应得到什么？', JSON_OBJECT('A', 'True', 'B', 'False', 'C', '6', 'D', '-1'), 3, JSON_ARRAY('find 返回“位置”，不是布尔值。', '从 0 开始计数。', 'h e l l o _ p → p 在第 6 位。'), 'find("py") 会返回起始索引 6。', '"abc".find("b") → 1');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('7', 18, '复习 replace：替换文本', '执行 "I love tea".replace("tea","coffee") 的结果是什么？', JSON_OBJECT('A', '"I love tea coffee"', 'B', '"I love coffee"', 'C', '"I love"', 'D', '"I love Tea"'), 2, JSON_ARRAY('replace 会直接替换旧字符串为新字符串。', '不会自动重复附加。', '注意大小写敏感。'), 'replace("tea","coffee") → "I love coffee"。', '"hello".replace("l","*") → "he**o"');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('8', 18, '复习 find：找不到情况', '"python".find("Java") 的返回值是什么？', JSON_OBJECT('A', '0', 'B', 'None', 'C', '-1', 'D', 'TypeError'), 3, JSON_ARRAY('找不到时不会报错。', '也不会返回 None。', '找不到 → -1。'), 'find() 未找到时返回 -1。', '"abc".find("z") → -1');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('11', 18, 'split 的结果类型', '"a b c".split() 的结果是什么类型？', JSON_OBJECT('A', '字符串', 'B', '元组', 'C', '列表', 'D', '整数'), 3, JSON_ARRAY('split 的目标是把字符串拆成多个片段的集合。', '集合的形式是什么？', 'split 返回 list。'), 'split() 永远返回列表。', '"x y".split() → ["x","y"]');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('12', 18, 'join 的限制', '下面哪个列表不能直接使用 ",".join()？', JSON_OBJECT('A', '["a","b"]', 'B', '["1","2","3"]', 'C', '["hello","world"]', 'D', '[1,2,3]'), 4, JSON_ARRAY('join 要求所有元素必须是字符串。', '列表里的类型很关键。', '数字不能直接 join。'), 'join 要求列表中所有元素均为 str。', '正确方法：",".join(map(str,[1,2,3]))');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('13', 18, 'split 的最大拆分数', '"a-b-c-d".split("-", 2) 的结果是什么？', JSON_OBJECT('A', '["a","b","c","d"]', 'B', '["a","b","c-d"]', 'C', '["a-b","c","d"]', 'D', '["a","b-c-d"]'), 2, JSON_ARRAY('第二个参数是最多拆分几次。', '拆两次后剩下的部分整体作为最后一项。', '按顺序拆两次即可。'), '拆两次得到 ["a","b","c-d"]。', '"1-2-3-4".split("-",1) → ["1","2-3-4"]');

-- ---------- 插入填空题 ----------
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('4', 18, '用 split 拆分 CSV 数据', '把一行用逗号分隔的字符串拆成列表。', 'row = "Tom,20,Student"', JSON_ARRAY('[''Tom'',''20'',''Student'']'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "result = row."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\",\")"}]}]}', JSON_ARRAY('split', 'join', 'replace', 'find', 'upper', 'lower'), JSON_ARRAY(1), 'split(",") 能将字符串按逗号拆分成列表。', '例如："a,b,c".split(",") → ["a","b","c"]');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('5', 18, '使用 join 组装路径', '把路径片段列表组合成 URL。', 'parts = ["api","v1","users"]', JSON_ARRAY('"api/v1/users"'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "url = "}, {"type": "slot", "index": 0}, {"type": "code", "value": " ."}, {"type": "slot", "index": 1}, {"type": "code", "value": "(parts)"}]}]}', JSON_ARRAY('"/"', 'join', 'split', '"-"', 'replace', 'find'), JSON_ARRAY(1, 2), '"/".join(parts) 会使用 / 拼出路径字符串。', '例如："-".join(["2024","01","01"]) → "2024-01-01"');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('9', 18, '复习 replace：替换敏感词', '把评论中的 "bad" 替换为 "***"。', 'text = "This is bad behavior!"', JSON_ARRAY('"This is *** behavior!"'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "cleaned = text."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"bad\", "}, {"type": "slot", "index": 1}, {"type": "code", "value": ")"}]}]}', JSON_ARRAY('find', 'replace', '"***"', 'split', 'join', '"bad behavior"'), JSON_ARRAY(2, 3), 'replace("bad","***") 即可替换敏感词。', '"oh no".replace("no","yes") → "oh yes"');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('10', 18, '复习 find：判断内容是否出现', '判断字符串里是否出现关键字。', 'msg = "Error: network timeout"', JSON_ARRAY('True'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "has_error = msg."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"Error\") != "}, {"type": "slot", "index": 1}]}]}', JSON_ARRAY('find', 'replace', '-1', '0', 'split'), JSON_ARRAY(1, 3), 'find("Error") 若找到不会返回 -1，因此 != -1 表示出现。', '"abc".find("a") != -1 → True');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('14', 18, '混合使用 split 和 join', '把句子拆成单词，再重新用下划线连接。', 'text = "Python is fun"', JSON_ARRAY('"Python_is_fun"'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "words = text."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()\nresult = \""}, {"type": "slot", "index": 1}, {"type": "code", "value": "\"."}, {"type": "slot", "index": 2}, {"type": "code", "value": "(words)"}]}]}', JSON_ARRAY('split', 'join', '"_"', '"-"', 'replace', 'find'), JSON_ARRAY(1, 3, 2), 'words = text.split()；"_" .join(words) → "Python_is_fun"。', '"a b c".split() → ["a","b","c"] 再用 "-".join → "a-b-c"');
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('15', 18, '按单词首字母重新组合', '提取单词首字母并拼接成缩写。', 'name = "United Nations Development Programme"', JSON_ARRAY('"UNDP"'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "parts = name."}, {"type": "slot", "index": 0}, {"type": "code", "value": "()\nabbr = \"\" ."}, {"type": "slot", "index": 1}, {"type": "code", "value": "([p[0] for p in parts])"}]}]}', JSON_ARRAY('split', 'join', 'upper', '"_"', 'replace', 'find'), JSON_ARRAY(1, 2), '先用 split() 拆成单词，再用 "".join 拼成缩写。', '"World Health Organization" → "WHO"');