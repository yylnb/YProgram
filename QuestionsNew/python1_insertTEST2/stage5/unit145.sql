USE `questions`;
-- Unit 145 | Start ID: 2161
-- Generated at 2025-12-24 23:42:08

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2161, 
    145, 
    '异常基类', 
    'Python 中所有异常的基类是？', 
    JSON_OBJECT('A', 'BaseException', 'B', 'Exception', 'C', 'ValueError', 'D', 'RuntimeError'), 
    1, 
    JSON_ARRAY('提示1：Exception 继承自 BaseException', '提示2：KeyboardInterrupt 直接继承 BaseException', '提示3：一般捕获 Exception 即可'), 
    'BaseException 是所有异常的基类，日常捕获通常使用 Exception。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2162, 
    145, 
    '捕获异常', 
    '捕获并处理异常通常使用哪个语句？', 
    JSON_OBJECT('A', 'try/except', 'B', 'if/else', 'C', 'for/else', 'D', 'with/as'), 
    1, 
    JSON_ARRAY('提示1：try 块放可能抛出的代码', '提示2：except 用于捕获特定异常', '提示3：finally 总会执行'), 
    'try/except 用于捕获并处理异常，finally 可用于清理。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2163, 
    145, 
    'finally 块', 
    'finally 块在何时执行？', 
    JSON_OBJECT('A', '无论是否发生异常都会执行', 'B', '仅在发生异常时执行', 'C', '仅在没有异常时执行', 'D', '只有在 except 中调用时执行'), 
    1, 
    JSON_ARRAY('提示1：用于清理资源', '提示2：finally 总会运行', '提示3：无论 try/except 结果如何'), 
    'finally 块用于执行清理代码，保证总会执行。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2164,
    145,
    '捕获特定异常（填空）',
    '要只捕获 ValueError，可以写为 except __1__:',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "try:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    int(\"a\")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "except __1__:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(\"value error\")"}]}]}',
    JSON_ARRAY('ValueError', 'Exception', 'BaseException', 'RuntimeError'),
    JSON_ARRAY(1),
    '在 except 后指定异常类即可只捕获该类型异常。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2165,
    145,
    '获取异常信息（填空）',
    '使用 except Exception as __1__ 可以获取异常对象以访问详情。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "try:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    1/0"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "except Exception as "}, {"type": "slot", "index": 0}, {"type": "code", "value": ":"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('e', 'err', 'exc', 'ex'),
    JSON_ARRAY(1),
    '惯例常用 e 或 ex 来表示捕获的异常对象。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2166, 
    145, 
    '抛出异常', 
    '在代码中手动抛出异常使用哪个关键字？', 
    JSON_OBJECT('A', 'raise', 'B', 'throw', 'C', 'fail', 'D', 'error'), 
    1, 
    JSON_ARRAY('提示1：raise Exception("msg")', '提示2：可在函数中抛出以上层捕获', '提示3：常用于输入校验'), 
    '使用 raise 来主动抛出异常，触发异常处理流。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2167, 
    145, 
    '异常链', 
    '在 except 中重新抛出新异常但保留原始异常信息可使用哪个语法？', 
    JSON_OBJECT('A', 'raise NewError from e', 'B', 'raise NewError with e', 'C', 'raise NewError, e', 'D', 'raise NewError(e)'), 
    1, 
    JSON_ARRAY('提示1：from 用于异常链', '提示2：可保留上下文信息', '提示3：方便调试'), 
    '使用 raise ... from ... 可保留原始异常作为上下文。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2168, 
    145, 
    '抑制异常', 
    'contextlib.suppress 用于？', 
    JSON_OBJECT('A', '临时抑制特定异常', 'B', '增加日志', 'C', '重新抛出异常', 'D', '捕获所有异常并忽略'), 
    1, 
    JSON_ARRAY('提示1：with suppress(FileNotFoundError):', '提示2：仅抑制指定类型', '提示3：用于清理类似操作'), 
    'suppress 可以在 with 块中忽略特定异常类型。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2169,
    145,
    '自定义异常（填空）',
    '自定义异常通常通过 class MyError(__1__): 继承基类。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "class MyError("}, {"type": "slot", "index": 0}, {"type": "code", "value": "):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    pass"}]}]}',
    JSON_ARRAY('Exception', 'BaseException', 'object', 'RuntimeError'),
    JSON_ARRAY(1),
    '自定义异常通常继承自 Exception 以便被常规 except 捕获。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2170,
    145,
    '断言（填空）',
    '使用 assert 表达式可以在条件不满足时抛出 __1__ 异常。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "assert x > 0, \"x must > 0\""}]}]}',
    JSON_ARRAY('AssertionError', 'ValueError', 'RuntimeError', 'TypeError'),
    JSON_ARRAY(1),
    'assert 触发 AssertionError，通常用于调试检查。',
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2171, 
    145, 
    '清理资源', 
    '若需确保资源释放，即使发生异常也要执行清理，应使用？', 
    JSON_OBJECT('A', 'finally 或 with 上下文管理', 'B', '仅 try', 'C', '仅 except', 'D', 'pass'), 
    1, 
    JSON_ARRAY('提示1：finally 总会执行', '提示2：with 自动管理资源', '提示3：结合使用更稳健'), 
    '使用 finally 或 with 可以保证资源清理。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    2172, 
    145, 
    '最佳实践', 
    '关于异常处理的最佳实践，下列哪项更合适？', 
    JSON_OBJECT('A', '只捕获你能处理的异常并记录详细信息', 'B', '捕获所有异常并忽略', 'C', '在每个函数内都使用 broad except', 'D', '避免日志记录'), 
    1, 
    JSON_ARRAY('提示1：不要吞掉异常', '提示2：记录上下文信息', '提示3：为用户提供有用的错误反馈'), 
    '应只捕获并处理预期异常，记录足够信息并向上抛未处理的异常。', 
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2173,
    145,
    '日志与异常（填空）',
    '在 except 中记录异常常用 logging.__1__() 函数来输出异常信息。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import logging"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "logging."}, {"type": "slot", "index": 0}, {"type": "code", "value": "(\"error occurred\", exc_info=True)"}]}]}',
    JSON_ARRAY('exception', 'error', 'warning', 'info'),
    JSON_ARRAY(1),
    'logging.exception 会记录堆栈信息，等价于 logging.error(..., exc_info=True)。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2174,
    145,
    '自定义消息（填空）',
    '抛出异常时可传入消息，如 raise ValueError("__1__")。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "raise ValueError(\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\")"}]}]}',
    JSON_ARRAY('invalid input', 'ok', 'done', 'error'),
    JSON_ARRAY(1),
    '为异常提供描述性消息有助于调试和日志记录。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    2175,
    145,
    '总结（填空）',
    '异常处理的目标是 __1__ 程序的稳定性并提供可诊断的信息。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('提高', '降低', '终止', '隐藏'),
    JSON_ARRAY(1),
    '良好的异常处理提高程序鲁棒性并帮助排查问题。',
    ''
);