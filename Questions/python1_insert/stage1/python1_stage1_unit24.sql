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
  ('1', 24, '数字格式化：保留小数', 'price = 3.4567，想用 f-string 显示为 "3.46"，下列哪个写法正确？', JSON_OBJECT('A', 'f"{price:.2f}"', 'B', 'f"{price:.2}"', 'C', 'f"{price:2f}"', 'D', 'f"{price:.02f}"'), 1, JSON_ARRAY('保留小数通常使用 . 后跟位数。', '语法是 {变量:格式}。', '".2f" 是常见的浮点格式说明。'), 'f"{price:.2f}" 会把浮点数格式化为两位小数并做四舍五入。', '例如 f"{3.14159:.3f}" → "3.142"。');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('2', 24, '字符串对齐：左/右/居中', 'name = "Amy"，想用 f-string 在宽度 10 中右对齐显示，应使用哪种格式？', JSON_OBJECT('A', 'f"{name:>10}"', 'B', 'f"{name:<10}"', 'C', 'f"{name:^10}"', 'D', 'f"{name:10}"'), 1, JSON_ARRAY('> 表示右对齐，< 表示左对齐，^ 表示居中。', '宽度直接写在冒号后面。', '检查哪个选项用了 >。'), 'f"{name:>10}" 会在总宽 10 中把 name 右对齐。', '例如 f"{"x":^5}" → "  x  "。');
INSERT INTO `que_choice_py_1` (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) VALUES
  ('3', 24, '数字填充与对齐', 'n = 7，想用 f-string 显示为三位宽并在左边补零 "007"，正确写法是？', JSON_OBJECT('A', 'f"{n:03d}"', 'B', 'f"{n:0>3}"', 'C', 'f"{n:03}"', 'D', 'f"{n:3d}"'), 1, JSON_ARRAY('整数格式化常用 d。', '0 填充通常写成 0 后跟宽度。', '选项 A 是常见正确写法。'), 'f"{n:03d}" 使用零填充并指定整数格式 d，得到 "007"。', '例如 f"{5:04d}" → "0005"。');

-- ---------- 插入填空题 ----------
INSERT INTO `que_fill_py_1` (`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`) VALUES
  ('4', 24, '在 f-string 中格式化百分比', '把 0.8532 显示为 "85.32%"（保留两位小数并乘 100）', 'rate = 0.8532', JSON_ARRAY('85.32%'), '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": "\"{"}, {"type": "slot", "index": 1}, {"type": "code", "value": " * 100:.__f}%\" )"}]}]}', JSON_ARRAY('f', 'rate', '2', '.2f', '.2', ':.2f', '100'), JSON_ARRAY(1, 2, 6, 4), '需要 f-string：f"{rate * 100:.2f}%"；选项顺序对应 f, rate, : .2f, .2f（题中替换为相应编号）。', '例如 f"{0.5 * 100:.1f}%" → "50.0%"');