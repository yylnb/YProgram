USE study_app;

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

ALTER TABLE questions_favorites_py
  ADD COLUMN lang VARCHAR(16) NOT NULL DEFAULT 'python';

ALTER TABLE questions_favorites_cpp
  ADD COLUMN lang VARCHAR(16) NOT NULL DEFAULT 'cpp';

ALTER TABLE questions_favorites_java
  ADD COLUMN lang VARCHAR(16) NOT NULL DEFAULT 'java';

SET @tbl = 'questions_favorites_py';
SELECT CONCAT('ALTER TABLE `', TABLE_NAME, '` DROP FOREIGN KEY `', CONSTRAINT_NAME, '`;') AS stmt
INTO @drop_stmt
FROM information_schema.REFERENTIAL_CONSTRAINTS rc
JOIN information_schema.KEY_COLUMN_USAGE kcu 
  ON rc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME AND rc.CONSTRAINT_SCHEMA = kcu.CONSTRAINT_SCHEMA
WHERE rc.CONSTRAINT_SCHEMA = DATABASE()
  AND rc.TABLE_NAME = @tbl
  AND (rc.REFERENCED_TABLE_NAME LIKE 'questions\_%');

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

CALL drop_fks_for_table('questions_favorites_py');
CALL drop_fks_for_table('questions_favorites_cpp');
CALL drop_fks_for_table('questions_favorites_java');

DROP PROCEDURE IF EXISTS drop_fks_for_table;

ALTER TABLE questions_favorites_py
  ADD CONSTRAINT fk_qfav_py_idx FOREIGN KEY (lang, q_id) REFERENCES questions_index(lang, q_id) ON DELETE CASCADE;

ALTER TABLE questions_favorites_cpp
  ADD CONSTRAINT fk_qfav_cpp_idx FOREIGN KEY (lang, q_id) REFERENCES questions_index(lang, q_id) ON DELETE CASCADE;

ALTER TABLE questions_favorites_java
  ADD CONSTRAINT fk_qfav_java_idx FOREIGN KEY (lang, q_id) REFERENCES questions_index(lang, q_id) ON DELETE CASCADE;

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

ALTER TABLE questions_favorites_py
  DROP INDEX uniq_user_question,
  ADD UNIQUE KEY uniq_user_question_py (user_id, lang, q_id);

ALTER TABLE questions_favorites_cpp
  DROP INDEX uniq_user_question,
  ADD UNIQUE KEY uniq_user_question_cpp (user_id, lang, q_id);

ALTER TABLE questions_favorites_java
  DROP INDEX uniq_user_question,
  ADD UNIQUE KEY uniq_user_question_java (user_id, lang, q_id);


-- ---------------
-- USE study_app;

-- ALTER TABLE `questions_py`   ADD INDEX ux_questions_py_qid (q_id);
-- ALTER TABLE `questions_cpp`  ADD INDEX ux_questions_cpp_qid (q_id);
-- ALTER TABLE `questions_java` ADD INDEX ux_questions_java_qid (q_id);

-- ALTER TABLE `questions_favorites_py`   DROP FOREIGN KEY `questions_favorites_py_ibfk_2`;


-- ALTER TABLE `questions_favorites_py`   MODIFY COLUMN q_id INT NOT NULL;
-- ALTER TABLE `questions_favorites_cpp`  MODIFY COLUMN q_id INT NOT NULL;
-- ALTER TABLE `questions_favorites_java` MODIFY COLUMN q_id INT NOT NULL;

-- ALTER TABLE `questions_favorites_py`
--   ADD CONSTRAINT `fk_fav_py_qid` FOREIGN KEY (q_id) REFERENCES `questions_py`  (q_id) ON DELETE CASCADE;

-- ALTER TABLE `questions_favorites_cpp`
--   ADD CONSTRAINT `fk_fav_cpp_qid` FOREIGN KEY (q_id) REFERENCES `questions_cpp` (q_id) ON DELETE CASCADE;

-- ALTER TABLE `questions_favorites_java`
--   ADD CONSTRAINT `fk_fav_java_qid` FOREIGN KEY (q_id) REFERENCES `questions_java`(q_id) ON DELETE CASCADE;

-- ALTER TABLE `questions_favorites_py`   ADD UNIQUE KEY `uniq_user_question` (user_id, q_id);
-- ALTER TABLE `questions_favorites_cpp`  ADD UNIQUE KEY `uniq_user_question` (user_id, q_id);
-- ALTER TABLE `questions_favorites_java` ADD UNIQUE KEY `uniq_user_question` (user_id, q_id);
