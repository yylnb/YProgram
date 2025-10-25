-- 1) 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS `questions`
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

USE `questions`;

-- 公共约束说明：MySQL 5.7+ 支持 JSON 类型

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
CREATE TABLE `que_choice_py_1` (
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

DROP TABLE IF EXISTS `que_choice_cpp_1`;
CREATE TABLE `que_choice_cpp_1` LIKE `que_choice_py_1`;
-- 注意：CREATE TABLE ... LIKE 会复制结构，但不会复制 COMMENT；为了保证一致性，我们再设置 engine/charset（上面已定义）
ALTER TABLE `que_choice_cpp_1` ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `que_choice_c_1`;
CREATE TABLE `que_choice_c_1` LIKE `que_choice_py_1`;
ALTER TABLE `que_choice_c_1` ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `que_choice_java_1`;
CREATE TABLE `que_choice_java_1` LIKE `que_choice_py_1`;
ALTER TABLE `que_choice_java_1` ROW_FORMAT=DYNAMIC;


-- ---------- 填空题表模板 ----------
-- que_fill_py_1 / que_fill_cpp_1 / que_fill_c_1 / que_fill_java_1
-- 字段说明：
-- id            : 自增主键
-- q_id          : 题目全局 id（可与 study_app 中的 id 建关联或单独管理）
-- unit_id       : 单元/章节 id
-- title         : 题目短标题
-- text          : 题目正文（含若干空位说明）
-- options       : JSON，可选项（比如 ["x","y","z"]），也可为空
-- answer        : JSON，存储标准答案的顺序/数组（例如 ["A","B"] 或 [1,3]）——按你要求用 JSON 存储
-- explanation   : 题解或参考解析
-- example       : 示例
-- created_at/updated_at : 时间戳
-- 索引：q_id, unit_id

DROP TABLE IF EXISTS `que_fill_py_1`;
CREATE TABLE `que_fill_py_1` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `q_id` VARCHAR(100) NOT NULL COMMENT '题目外部id/编号（可与 study_app 关联）',
  `unit_id` INT UNSIGNED DEFAULT NULL,
  `title` VARCHAR(255) NOT NULL,
  `text` TEXT,
  `options` JSON DEFAULT NULL COMMENT '填空可选项，JSON 数组或对象',
  `answer` JSON NOT NULL COMMENT '答案顺序或多空答案，JSON 存储（例如 ["A","B"] 或 [1,2]）',
  `explanation` TEXT DEFAULT NULL,
  `example` TEXT DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX (`q_id`),
  INDEX (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `que_fill_cpp_1`;
CREATE TABLE `que_fill_cpp_1` LIKE `que_fill_py_1`;
ALTER TABLE `que_fill_cpp_1` ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `que_fill_c_1`;
CREATE TABLE `que_fill_c_1` LIKE `que_fill_py_1`;
ALTER TABLE `que_fill_c_1` ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `que_fill_java_1`;
CREATE TABLE `que_fill_java_1` LIKE `que_fill_py_1`;
ALTER TABLE `que_fill_java_1` ROW_FORMAT=DYNAMIC;

-- 可选：显示当前 tables
-- SHOW TABLES FROM `questions`;