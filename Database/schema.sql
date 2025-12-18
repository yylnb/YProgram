-- schema.sql
-- Run: execute this file on a fresh MySQL instance to create study_app schema and tables.
CREATE DATABASE IF NOT EXISTS study_app
  DEFAULT CHARACTER SET = utf8mb4
  DEFAULT COLLATE = utf8mb4_unicode_ci;
USE study_app;


-- =========================== 
-- 用户表 
-- ===========================
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,           -- 存 bcrypt/hash
  user_color VARCHAR(20) DEFAULT NULL,      -- 头像背景色，例如 '#2563eb'
  user_emoji VARCHAR(10) DEFAULT NULL,      -- 头像 emoji，例如 '😄'
  checkin_days INT UNSIGNED DEFAULT 0,      -- 用户总打卡天数（累计）
  max_streak_days INT UNSIGNED DEFAULT 0,   -- 最大连续打卡天数
  lang JSON DEFAULT NULL,                   -- 学习语言（JSON 格式），例如 '["python","cpp"]'
  energy INT DEFAULT 30,                    -- 能量值
  last_energy_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  contact VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ===========================
-- 题目表：选择题（Python / C++ / Java）
-- ===========================
-- CREATE TABLE IF NOT EXISTS questions_py (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   q_id INT NOT NULL,
--   unit_id INT NOT NULL,
--   title VARCHAR(255) DEFAULT NULL,
--   energy INT DEFAULT 3,
--   question_text TEXT NOT NULL,
--   options JSON NOT NULL,
--   answer INT NOT NULL,
--   hints JSON DEFAULT NULL,
--   explanation TEXT DEFAULT NULL,
--   example TEXT DEFAULT NULL,
--   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   UNIQUE KEY uq_questions_py_qid (q_id),
--   INDEX idx_questions_py_unit (unit_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CREATE TABLE IF NOT EXISTS questions_cpp (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   q_id INT NOT NULL,
--   unit_id INT NOT NULL,
--   title VARCHAR(255) DEFAULT NULL,
--   energy INT DEFAULT 3,
--   question_text TEXT NOT NULL,
--   options JSON NOT NULL,
--   answer INT NOT NULL,
--   hints JSON DEFAULT NULL,
--   explanation TEXT DEFAULT NULL,
--   example TEXT DEFAULT NULL,
--   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   UNIQUE KEY uq_questions_cpp_qid (q_id),
--   INDEX idx_questions_cpp_unit (unit_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CREATE TABLE IF NOT EXISTS questions_java (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   q_id INT NOT NULL,
--   unit_id INT NOT NULL,
--   title VARCHAR(255) DEFAULT NULL,
--   energy INT DEFAULT 3,
--   question_text TEXT NOT NULL,
--   options JSON NOT NULL,
--   answer INT NOT NULL,
--   hints JSON DEFAULT NULL,
--   explanation TEXT DEFAULT NULL,
--   example TEXT DEFAULT NULL,
--   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   UNIQUE KEY uq_questions_java_qid (q_id),
--   INDEX idx_questions_java_unit (unit_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===========================
-- 实操题表（exec）
-- ===========================
-- CREATE TABLE IF NOT EXISTS questions_py_exec (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   q_id INT NOT NULL,
--   unit_id INT NOT NULL,
--   title TEXT NOT NULL,
--   energy INT NOT NULL DEFAULT 3,
--   question_text TEXT NOT NULL,
--   hints JSON DEFAULT NULL,
--   link JSON NOT NULL,
--   eg_in1 TEXT NULL,
--   eg_out1 TEXT NULL,
--   eg_in2 TEXT NULL,
--   eg_out2 TEXT NULL,
--   eg_in3 TEXT NULL,
--   eg_out3 TEXT NULL,
--   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   UNIQUE KEY uq_questions_py_exec_qid (q_id),
--   INDEX idx_questions_py_exec_unit (unit_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- CREATE TABLE IF NOT EXISTS questions_cpp_exec (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   q_id INT NOT NULL,
--   unit_id INT NOT NULL,
--   title TEXT NOT NULL,
--   energy INT NOT NULL DEFAULT 3,
--   question_text TEXT NOT NULL,
--   hints JSON DEFAULT NULL,
--   link JSON NOT NULL,
--   eg_in1 TEXT NULL,
--   eg_out1 TEXT NULL,
--   eg_in2 TEXT NULL,
--   eg_out2 TEXT NULL,
--   eg_in3 TEXT NULL,
--   eg_out3 TEXT NULL,
--   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   UNIQUE KEY uq_questions_py_exec_qid (q_id),
--   INDEX idx_questions_py_exec_unit (unit_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CREATE TABLE IF NOT EXISTS questions_java_exec (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   q_id INT NOT NULL,
--   unit_id INT NOT NULL,
--   title TEXT NOT NULL,
--   energy INT NOT NULL DEFAULT 3,
--   question_text TEXT NOT NULL,
--   hints JSON DEFAULT NULL,
--   link JSON NOT NULL,
--   eg_in1 TEXT NULL,
--   eg_out1 TEXT NULL,
--   eg_in2 TEXT NULL,
--   eg_out2 TEXT NULL,
--   eg_in3 TEXT NULL,
--   eg_out3 TEXT NULL,
--   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   UNIQUE KEY uq_questions_py_exec_qid (q_id),
--   INDEX idx_questions_py_exec_unit (unit_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===========================
-- 题目索引表（统一索引，用于 favorites 外键与快速查找）
-- 说明：主键为 (lang, q_id)；source_table 和 source_id 指向真实存放题目的表/主键
-- ===========================
-- CREATE TABLE IF NOT EXISTS questions_index (
--   lang VARCHAR(16) NOT NULL,      -- 'python' / 'cpp' / 'java' 等
--   q_id INT NOT NULL,              -- 逻辑题号（在同一语言中唯一）
--   source_table VARCHAR(64) NOT NULL, -- e.g. 'questions_py' / 'questions_py_exec'
--   source_id INT NOT NULL,         -- 对应 source_table 的 id（物理主键）
--   unit_id INT DEFAULT NULL,
--   title VARCHAR(512) DEFAULT NULL,
--   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   PRIMARY KEY (lang, q_id),
--   INDEX idx_questions_index_source (source_table, source_id),
--   INDEX idx_questions_index_lang_unit (lang, unit_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===========================
-- 收藏表（每种语言一张） — UPDATED: 包含 lang 字段，并且外键指向 questions_index (lang,q_id)
-- 注意：在新建 schema 中我们直接让外键引用 questions_index
-- ===========================
-- CREATE TABLE IF NOT EXISTS questions_favorites_py (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   user_id INT NOT NULL,
--   lang VARCHAR(16) NOT NULL DEFAULT 'python',
--   q_id INT NOT NULL,
--   unit_id INT NOT NULL,
--   page_id INT NOT NULL,
--   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
--   -- 外键指向 questions_index(lang,q_id)
--   CONSTRAINT fk_qfav_py_idx FOREIGN KEY (lang, q_id) REFERENCES questions_index(lang, q_id) ON DELETE CASCADE,
--   UNIQUE KEY uniq_user_question_py (user_id, lang, q_id),
--   INDEX idx_qfav_py_user (user_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CREATE TABLE IF NOT EXISTS questions_favorites_cpp (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   user_id INT NOT NULL,
--   lang VARCHAR(16) NOT NULL DEFAULT 'cpp',
--   q_id INT NOT NULL,
--   unit_id INT NOT NULL,
--   page_id INT NOT NULL,
--   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
--   CONSTRAINT fk_qfav_cpp_idx FOREIGN KEY (lang, q_id) REFERENCES questions_index(lang, q_id) ON DELETE CASCADE,
--   UNIQUE KEY uniq_user_question_cpp (user_id, lang, q_id),
--   INDEX idx_qfav_cpp_user (user_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CREATE TABLE IF NOT EXISTS questions_favorites_java (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   user_id INT NOT NULL,
--   lang VARCHAR(16) NOT NULL DEFAULT 'java',
--   q_id INT NOT NULL,
--   unit_id INT NOT NULL,
--   page_id INT NOT NULL,
--   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
--   CONSTRAINT fk_qfav_java_idx FOREIGN KEY (lang, q_id) REFERENCES questions_index(lang, q_id) ON DELETE CASCADE,
--   UNIQUE KEY uniq_user_question_java (user_id, lang, q_id),
--   INDEX idx_qfav_java_user (user_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===========================
-- 进度表（每语言）
-- ===========================
-- CREATE TABLE IF NOT EXISTS progress_py (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   user_id INT NOT NULL,
--   unit_id INT NOT NULL,
--   current_index INT DEFAULT 0,
--   completed TINYINT(1) DEFAULT 0,
--   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--   FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
--   UNIQUE KEY uniq_user_unit_py (user_id, unit_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CREATE TABLE IF NOT EXISTS progress_cpp (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   user_id INT NOT NULL,
--   unit_id INT NOT NULL,
--   current_index INT DEFAULT 0,
--   completed TINYINT(1) DEFAULT 0,
--   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--   FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
--   UNIQUE KEY uniq_user_unit_cpp (user_id, unit_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CREATE TABLE IF NOT EXISTS progress_java (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   user_id INT NOT NULL,
--   unit_id INT NOT NULL,
--   current_index INT DEFAULT 0,
--   completed TINYINT(1) DEFAULT 0,
--   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--   FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
--   UNIQUE KEY uniq_user_unit_java (user_id, unit_id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===========================
-- memberships, library, favorites etc. (保留你原有的定义，略微调整索引)
-- ===========================
CREATE TABLE IF NOT EXISTS memberships (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  start_at DATETIME NOT NULL,
  end_at DATETIME NOT NULL,
  source VARCHAR(64) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX (user_id),
  INDEX (end_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 主表：存储知识点
CREATE TABLE IF NOT EXISTS library (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  lang VARCHAR(32) NOT NULL,
  lb_id INT NOT NULL,
  difficulty ENUM('beginner','intermediate','advanced') NOT NULL DEFAULT 'beginner',
  page INT DEFAULT NULL,
  title VARCHAR(255) NOT NULL,
  tags JSON DEFAULT NULL,
  summary TEXT DEFAULT NULL,
  content LONGTEXT DEFAULT NULL,
  eg_in JSON DEFAULT NULL,   -- JSON array of input examples
  eg_out JSON DEFAULT NULL,  -- JSON array of output examples
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- 保证在同一语言下 lb_id 唯一
  UNIQUE KEY ux_lang_lbid (lang, lb_id),
  -- 常用索引
  INDEX idx_lang (lang),
  INDEX idx_lang_page (lang, page)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

-- 收藏表：可以引用主表（可选外键）
CREATE TABLE IF NOT EXISTS library_favorites (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,        -- 每条收藏归属哪个用户（非空）
  lang VARCHAR(32) NOT NULL,
  lb_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  page INT DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_fav_user (user_id),
  INDEX idx_fav_lang (lang),
  INDEX idx_fav_lang_lbid (lang, lb_id),
  UNIQUE KEY ux_user_lang_lbid (user_id, lang, lb_id),
  -- 保持对 library (lang, lb_id) 的外键约束（可选）
  CONSTRAINT fk_fav_library FOREIGN KEY (lang, lb_id)
    REFERENCES library (lang, lb_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci;
ALTER TABLE library_favorites
  ADD UNIQUE KEY ux_user_lang_lbid (user_id, lang, lb_id);

CREATE TABLE IF NOT EXISTS friend_requests (
  id INT AUTO_INCREMENT PRIMARY KEY,
  from_id INT NOT NULL,
  to_id INT NOT NULL,
  status ENUM('pending','accepted','rejected') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY unique_request (from_id, to_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS friends (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  friend_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_friendship (user_id, friend_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS energy_daily (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  cost_today INT NOT NULL DEFAULT 0,
  last_update DATE NOT NULL DEFAULT (CURDATE()),
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY ux_energy_daily_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS checkin_records (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  date DATE NOT NULL,
  color VARCHAR(20) DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY ux_checkin_user_date (user_id, date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 最后：创建应用用户并授权（按你的原样）
CREATE USER IF NOT EXISTS 'study_user'@'localhost' IDENTIFIED BY 'StrongPasswordHere!';
GRANT SELECT, INSERT, UPDATE, DELETE ON study_app.* TO 'study_user'@'localhost';
FLUSH PRIVILEGES;

USE study_app;