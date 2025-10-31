-- 1) 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS `questions`
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

USE `questions`;

-- ----------------------------------------------题目表格----------------------------------------------

-- ---------- 选择题表模板 ----------
-- que_choice_py_1 / que_choice_cpp_1 / que_choice_c_1 / que_choice_java_1
-- 字段说明：
-- id            : 自增主键
-- q_id          : 题目全局 id（可与 study_app 中的 id 建关联或单独管理）
-- unit_id       : 单元/章节 id（便于分组）
-- title         : 题目短标题
-- text          : 题目正文（支持 HTML/Markdown）
-- options       : JSON，存放选项 A/B/C/D（例如: [{"key":"A","text":"..."} , ...] 或 {"A":"...","B":"...",...}）
-- answer        : INT，表示正确选项序号（1,2,3,4）或按你习惯的编号
-- hints         : JSON，三个提示，如 ["提示1","提示2","提示3"]
-- explanation   : 题解或参考解析（text）
-- example       : 示例（例如样例输入/输出或示例说明）
-- created_at/updated_at : 时间戳
-- 索引：q_id, unit_id

DROP TABLE IF EXISTS `que_choice_py_1`;
CREATE TABLE IF NOT EXISTS `que_choice_py_1` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `q_id` VARCHAR(100) NOT NULL COMMENT '题目外部id/编号（可与 study_app 关联）',
  `unit_id` INT UNSIGNED DEFAULT NULL,
  `title` VARCHAR(255) NOT NULL,
  `text` TEXT,
  `options` JSON NOT NULL COMMENT 'JSON 格式存储 ABCD 四个选项',
  `answer` TINYINT UNSIGNED NOT NULL COMMENT '正确选项序数：1,2,3,4',
  `hints` JSON DEFAULT NULL COMMENT '选错后提示，JSON 数组，最多 3 条',
  `explanation` TEXT DEFAULT NULL,
  `example` TEXT DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX (`q_id`),
  INDEX (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `que_choice_cpp_1` LIKE `que_choice_py_1`;

ALTER TABLE `que_choice_cpp_1` ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `que_choice_c_1` LIKE `que_choice_py_1`;
ALTER TABLE `que_choice_c_1` ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `que_choice_java_1` LIKE `que_choice_py_1`;
ALTER TABLE `que_choice_java_1` ROW_FORMAT=DYNAMIC;


-- ======= 填空题表：模板 (修改后) =======
-- 字段说明：
-- id          : 自增主键
-- q_id        : 题目全局 id（整型，用于与其他表关联）
-- unit_id     : 单元/章节 id
-- title       : 题目短标题
-- text        : JSON 数组，每个元素为一段文本。空位以空字符串 "" 或 null 作为分隔（序列化表达填空位置）
-- options     : JSON 数组，每个元素为可选填入的字符串（例如 ["s1","s2","s3"]）
-- answer      : JSON 数组，按空位顺序存放 options 的索引（1-based），例如 [1,2]
-- explanation : 题解（TEXT）
-- example     : 示例（TEXT）
-- created_at/updated_at : 时间戳
-- 索引：q_id, unit_id


-- -- 创建 Python 填空表
CREATE TABLE IF NOT EXISTS `que_fill_py_1` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `q_id` INT UNSIGNED NOT NULL COMMENT '题目外部id/编号（整型，与 study_app 关联）',
  `unit_id` INT UNSIGNED DEFAULT NULL,
  `title` VARCHAR(255) NOT NULL,
  `text` JSON NOT NULL COMMENT 'JSON 数组：文本段落与空位分隔，例如 ["a", "b"]',
  `options` JSON DEFAULT NULL COMMENT '可选填项，JSON 数组，例如 ["s1","s2"]',
  `answer` JSON NOT NULL COMMENT '答案序列，1-based 索引，例如 [1,2]',
  `explanation` TEXT DEFAULT NULL,
  `example` TEXT DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX (`q_id`),
  INDEX (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `que_fill_cpp_1` LIKE `que_fill_py_1`;
ALTER TABLE `que_fill_cpp_1` ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `que_fill_c_1` LIKE `que_fill_py_1`;
ALTER TABLE `que_fill_c_1` ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `que_fill_java_1` LIKE `que_fill_py_1`;
ALTER TABLE `que_fill_java_1` ROW_FORMAT=DYNAMIC;


-- ----------------------------------------------进度表格----------------------------------------------

-- Python 进度表
CREATE TABLE IF NOT EXISTS progress_py_1 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  unit_id INT NOT NULL,
  current_index INT NOT NULL,
  completed INT NOT NULL DEFAULT 0,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS progress_py_2 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  unit_id INT NOT NULL,
  current_index INT NOT NULL,
  completed INT NOT NULL DEFAULT 0,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- C 进度表
CREATE TABLE IF NOT EXISTS progress_c_1 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  unit_id INT NOT NULL,
  current_index INT NOT NULL,
  completed INT NOT NULL DEFAULT 0,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS progress_c_2 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  unit_id INT NOT NULL,
  current_index INT NOT NULL,
  completed INT NOT NULL DEFAULT 0,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- C++ 进度表
CREATE TABLE IF NOT EXISTS progress_cpp_1 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  unit_id INT NOT NULL,
  current_index INT NOT NULL,
  completed INT NOT NULL DEFAULT 0,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS progress_cpp_2 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  unit_id INT NOT NULL,
  current_index INT NOT NULL,
  completed INT NOT NULL DEFAULT 0,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Java 进度表
CREATE TABLE IF NOT EXISTS progress_java_1 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  unit_id INT NOT NULL,
  current_index INT NOT NULL,
  completed INT NOT NULL DEFAULT 0,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS progress_java_2 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  unit_id INT NOT NULL,
  current_index INT NOT NULL,
  completed INT NOT NULL DEFAULT 0,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);