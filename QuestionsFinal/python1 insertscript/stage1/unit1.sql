INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`) 
VALUES (
    1,
    1,
    'print初体验',
    '阿珍想用Python在控制台点一份‘炸鸡’，下面哪种写法是正确的呢？',
    JSON_ARRAY(
        'print(炸鸡)', 
        'print("炸鸡")', 
        'print(‘炸鸡’)', 
        'print炸鸡'
    ),
    2,
    JSON_ARRAY(
        '想想看，直接写中文‘炸鸡’，计算机会认识它吗？',
        '在Python中，直接写中文单词（变量名除外）通常需要用引号包起来。',
        'print是一个函数，调用时需要括号。选项D缺少括号，而A和C的引号在中文输入法下可能是全角字符，正确的是半角双引号。'
    ),
    'print是一个函数，用于输出内容。要输出文本（字符串），必须用引号（单引号\'或双引号"均可）将其包裹起来，且引号必须是英文半角符号。选项A缺少引号；选项C使用了中文全角单引号；选项D缺少调用函数的括号。',
    '正确用法：print("Hello World") 或 print(\'Hello World\')。'
);

INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    5,
    1,
    '旅行明信片',
    '阿强正在写一张数字明信片。请补全代码，让程序根据变量`city`和`days`的值，输出完整的句子。',
    NULL,
    JSON_ARRAY('我在巴黎度过了3天美好的时光！'),
    "code_segments": 
        "{"type": "code_block", "lines": [
            {"type": "code_line", "value": \"city = \\\"巴黎\\\"\"}, 
            {\"type\": \"code_line\", \"value\": \"days = 3\"}, 
            {\"type\": \"code_line\", \"value\": \"print(\\\"我在\\\" + [0] + \\\"度过了\\\" + [1] + \\\"天美好的时光！\\\")\"}
            ]
        }",
    JSON_ARRAY('print', 'echo', 'output', 'println'),
    JSON_ARRAY(1),
    '只有 print 是 Python 的输出函数。',
    'print("今天写代码真顺利")'
);