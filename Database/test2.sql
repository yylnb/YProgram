-- ========== STEP 0: 使用数据库 ==========
USE study_app;
-- （确认当前连接用户对 study_app 有足够权限）

-- ========== STEP 1: 创建/填充 questions_index 表 ==========
CREATE TABLE IF NOT EXISTS questions_index (
  lang VARCHAR(16) NOT NULL,
  q_id INT NOT NULL,
  source_table VARCHAR(64) NOT NULL,
  source_id INT NOT NULL,
  unit_id INT DEFAULT NULL,
  title VARCHAR(512) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (lang, q_id),
  INDEX idx_questions_index_source (source_table, source_id),
  INDEX idx_questions_index_lang_unit (lang, unit_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 将已存在题库的索引行写入 questions_index（按语言与两类表）
INSERT IGNORE INTO questions_index (lang, q_id, source_table, source_id, unit_id, title, created_at)
SELECT 'python', q_id, 'questions_py', id, unit_id, title, created_at FROM questions_py WHERE q_id IS NOT NULL;

INSERT IGNORE INTO questions_index (lang, q_id, source_table, source_id, unit_id, title, created_at)
SELECT 'python', q_id, 'questions_py_exec', id, unit_id, title, created_at FROM questions_py_exec WHERE q_id IS NOT NULL;

INSERT IGNORE INTO questions_index (lang, q_id, source_table, source_id, unit_id, title, created_at)
SELECT 'cpp', q_id, 'questions_cpp', id, unit_id, title, created_at FROM questions_cpp WHERE q_id IS NOT NULL;

INSERT IGNORE INTO questions_index (lang, q_id, source_table, source_id, unit_id, title, created_at)
SELECT 'cpp', q_id, 'questions_cpp_exec', id, unit_id, title, created_at FROM questions_cpp_exec WHERE q_id IS NOT NULL;

INSERT IGNORE INTO questions_index (lang, q_id, source_table, source_id, unit_id, title, created_at)
SELECT 'java', q_id, 'questions_java', id, unit_id, title, created_at FROM questions_java WHERE q_id IS NOT NULL;

INSERT IGNORE INTO questions_index (lang, q_id, source_table, source_id, unit_id, title, created_at)
SELECT 'java', q_id, 'questions_java_exec', id, unit_id, title, created_at FROM questions_java_exec WHERE q_id IS NOT NULL;

-- ========== STEP 3: 删除旧的外键（按表名自动遍历并删除所有引用 questions_% 的 FK） ==========
-- 注意：我们使用 KEY_COLUMN_USAGE 来生成要执行的 ALTER 语句（用 kcu 前缀避免歧义）
DROP PROCEDURE IF EXISTS drop_fks_for_table;
DELIMITER $$
CREATE PROCEDURE drop_fks_for_table(IN in_tbl VARCHAR(128))
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cur_stmt TEXT;
  DECLARE cur CURSOR FOR
    SELECT CONCAT('ALTER TABLE `', kcu.TABLE_NAME, '` DROP FOREIGN KEY `', kcu.CONSTRAINT_NAME, '`;') AS stmt
    FROM information_schema.KEY_COLUMN_USAGE kcu
    WHERE kcu.CONSTRAINT_SCHEMA = DATABASE()
      AND kcu.TABLE_NAME = in_tbl
      AND kcu.REFERENCED_TABLE_NAME LIKE 'questions\_%';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO cur_stmt;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SET @s = cur_stmt;
    PREPARE ps FROM @s;
    EXECUTE ps;
    DEALLOCATE PREPARE ps;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 调用存储过程分别处理三张 favorites 表
-- CALL drop_fks_for_table('questions_favorites_py');
-- CALL drop_fks_for_table('questions_favorites_cpp');
-- CALL drop_fks_for_table('questions_favorites_java');

-- DROP PROCEDURE IF EXISTS drop_fks_for_table;


-- ========== STEP 4: 添加新的外键（引用 questions_index(lang, q_id)） ==========
-- 注意：在添加外键前请确保 questions_index 已包含这些 (lang, q_id)；否则 ADD CONSTRAINT 会失败。
-- ALTER TABLE questions_favorites_py
--   ADD CONSTRAINT fk_qfav_py_idx FOREIGN KEY (lang, q_id) REFERENCES questions_index(lang, q_id) ON DELETE CASCADE;

-- ALTER TABLE questions_favorites_cpp
--   ADD CONSTRAINT fk_qfav_cpp_idx FOREIGN KEY (lang, q_id) REFERENCES questions_index(lang, q_id) ON DELETE CASCADE;

-- ALTER TABLE questions_favorites_java
--   ADD CONSTRAINT fk_qfav_java_idx FOREIGN KEY (lang, q_id) REFERENCES questions_index(lang, q_id) ON DELETE CASCADE;
  
-- ========== STEP 5: 检查是否有 favorites 指向不存在的 index（如果有，需要先修正这些行） ==========
SELECT 'MISSING_INDEX_PY' AS kind, f.* 
FROM questions_favorites_py f
LEFT JOIN questions_index idx ON idx.lang = f.lang AND idx.q_id = f.q_id
WHERE idx.q_id IS NULL;

SELECT 'MISSING_INDEX_CPP' AS kind, f.* 
FROM questions_favorites_cpp f
LEFT JOIN questions_index idx ON idx.lang = f.lang AND idx.q_id = f.q_id
WHERE idx.q_id IS NULL;

SELECT 'MISSING_INDEX_JAVA' AS kind, f.* 
FROM questions_favorites_java f
LEFT JOIN questions_index idx ON idx.lang = f.lang AND idx.q_id = f.q_id
WHERE idx.q_id IS NULL;

-- ========== STEP 6: 调整唯一索引（把原来 user_id,q_id 的唯一约束改为 user_id,lang,q_id） ==========
-- 说明：如果原来的 uniq_user_question 名称存在则需要先删除；若不存在直接添加新唯一索引也通常没问题。
-- 如果 DROP INDEX 出错（因为索引名不存在），请忽略该错误并直接执行下一条 ADD UNIQUE。
ALTER TABLE questions_favorites_py
  DROP INDEX uniq_user_question,
  ADD UNIQUE KEY uniq_user_question_py (user_id, lang, q_id);

ALTER TABLE questions_favorites_cpp
  DROP INDEX uniq_user_question,
  ADD UNIQUE KEY uniq_user_question_cpp (user_id, lang, q_id);

ALTER TABLE questions_favorites_java
  DROP INDEX uniq_user_question,
  ADD UNIQUE KEY uniq_user_question_java (user_id, lang, q_id);