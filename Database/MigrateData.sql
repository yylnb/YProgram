INSERT INTO questions.progress_java_1 (user_id, unit_id, current_index, completed, updated_at)
SELECT user_id, unit_id, current_index, completed, updated_at
FROM study_app.progress_java;