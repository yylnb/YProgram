USE `questions`;

INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`)
VALUES
(
    15, 
    1,
    '输出 A B',
    '如何实现输出output？',
    NULL, -- input
    JSON_ARRAY('A', 'B'), -- output
    '{"segments": [
        {
            "type": "code_block",
            "lines": [
                {"type": "code_line", "value": "print(\\"A\\")"}
            ]
        },
        {
            "type": "code_inline",
            "parts": [
                {"type": "code", "value": "print(\\""},
                {"type": "slot", "index": 0},
                {"type": "code", "value": "\\")"}
            ]
        }
    ]}', -- code
    JSON_ARRAY('"B"', '" B"', 'B'),
    JSON_ARRAY(1),
    '通过补全代码，使程序依次输出 A 和 B。'
);