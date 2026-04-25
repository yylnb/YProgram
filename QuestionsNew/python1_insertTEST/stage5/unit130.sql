USE `questions`;
-- Unit 130 | Start ID: 1936
-- Generated at 2025-12-24 18:20:17

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1936, 
    130, 
    '异常的基本处理', 
    '捕获异常的关键字是哪一个？', 
    JSON_OBJECT('A', 'try/except', 'B', 'catch', 'C', 'handle', 'D', 'ensure'), 
    1, 
    JSON_ARRAY('提示1：Python 使用 try/except', '提示2：可以使用 finally 做清理', '提示3：可针对特定异常类型捕获'), 
    '使用 try/except 来捕获和处理异常。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1937, 
    130, 
    '捕获特定异常', 
    '若只想捕获 ValueError，应写成？', 
    JSON_OBJECT('A', 'except ValueError:', 'B', 'except Exception:', 'C', 'except:', 'D', 'except ValueError as e:'), 
    1, 
    JSON_ARRAY('提示1：可以写 except ValueError as e 以获取异常对象', '提示2：except: 会捕获所有异常', '提示3：推荐精确捕获'), 
    '使用 except ValueError: 可以只捕获指定的异常类型。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1938, 
    130, 
    'finally 的用途', 
    'finally 子句通常用于？', 
    JSON_OBJECT('A', '清理资源，无论是否发生异常都会执行', 'B', '只在异常发生时执行', 'C', '替换 except', 'D', '定义错误类型'), 
    1, 
    JSON_ARRAY('提示1：finally 总是执行', '提示2：常用于关闭文件或释放锁', '提示3：无论是否有异常都会运行'), 
    'finally 用于确保清理代码在任何情况下都能执行。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1939, 
    130, 
    '捕获所有异常', 
    '使用 bare except: 有何风险？', 
    JSON_OBJECT('A', '会屏蔽所有异常包括 KeyboardInterrupt, SystemExit', 'B', '没有风险', 'C', '自动记录日志', 'D', '只能在交互式解释器中使用'), 
    1, 
    JSON_ARRAY('提示1：建议捕获特定异常', '提示2：bare except 会捕获系统退出信号', '提示3：尽量避免使用 bare except'), 
    'bare except 会拦截所有异常，包括不应捕获的系统级异常，需谨慎使用。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1940, 
    130, 
    '异常链', 
    '若在 except 中抛出新异常并保留原始异常信息，应使用什么语法？', 
    JSON_OBJECT('A', 'raise NewError from e', 'B', 'raise NewError, e', 'C', 'raise NewError(e)', 'D', 'throw NewError from e'), 
    1, 
    JSON_ARRAY('提示1：from 用于显式链式异常', '提示2：可以保留原始追踪信息', '提示3：便于调试'), 
    '使用 raise ... from ... 语法可以建立异常链，从而保留上下文。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1941, 
    130, 
    '自定义异常', 
    '定义自定义异常类通常继承自哪个基类？', 
    JSON_OBJECT('A', 'Exception', 'B', 'BaseException', 'C', 'object', 'D', 'RuntimeError'), 
    1, 
    JSON_ARRAY('提示1：继承 Exception 更利于被 except 捕获', '提示2：BaseException 用于系统级异常', '提示3：遵循惯例'), 
    '自定义异常通常继承自 Exception，从而能被大多数 except 捕获。', 
    'class MyError(Exception): pass'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1942, 
    130, 
    '设计异常接口', 
    '哪个做法有助于良好的异常设计？', 
    JSON_OBJECT('A', '定义清晰的异常层次并在文档中说明', 'B', '随处抛出字符串异常', 'C', '不使用异常以避免复杂性', 'D', '捕获所有异常然后忽略'), 
    1, 
    JSON_ARRAY('提示1：良好设计提高可维护性', '提示2：自定义异常便于区分错误类型', '提示3：记录并传播有助于诊断'), 
    '定义清晰异常体系并文档化，可提高代码的健壮性和可读性。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1943, 
    130, 
    '清理资源', 
    '下列哪种方式更可靠地确保资源被释放？', 
    JSON_OBJECT('A', 'with 上下文管理器', 'B', 'try/except 不用 finally', 'C', '手动调用 gc.collect', 'D', '在 except 中 return'), 
    1, 
    JSON_ARRAY('提示1：with 会自动调用 __exit__', '提示2：finally 也可做清理', '提示3：推荐使用上下文管理器'), 
    '上下文管理器是确保资源被正确释放的推荐方式。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1944, 
    130, 
    '异常信息传递', 
    '捕获异常并包装成另一个异常时，如何保留原始异常信息？', 
    JSON_OBJECT('A', '使用 raise NewError from e', 'B', '用 print 打印后抛新异常', 'C', '不能保留', 'D', '使用 logging.error'), 
    1, 
    JSON_ARRAY('提示1：from 关键字用于异常链', '提示2：保留上下文便于追踪问题', '提示3：推荐使用该语法'), 
    '通过 raise ... from ... 建立异常链以便追溯原始错误。', 
    ''
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1945,
    130,
    '抛出异常（填空）',
    '要主动抛出异常，应使用 __1__ 语句。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "if x<0:"}, {"type": "slot", "index": 0}, {"type": "code", "value": " ValueError(\"x must be >=0\")"}]}]}',
    JSON_ARRAY('raise', 'throw', 'except', 'assert'),
    JSON_ARRAY(1),
    '使用 raise 来抛出异常。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1946,
    130,
    '断言（填空）',
    'assert 表达式用于在条件不满足时抛出 __1__ 异常。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "assert x>0, \"x must >0\""}]}]}',
    JSON_ARRAY('AssertionError', 'ValueError', 'TypeError', 'RuntimeError'),
    JSON_ARRAY(1),
    'assert 触发 AssertionError，当表达式为 False 时抛出。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1947,
    130,
    'logging 与异常（填空）',
    '在 except 块中记录异常详情通常使用 logging.exception() 它会自动记录 __1__ 信息。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import logging"}, {"type": "code_line", "value": "try:"}, {"type": "code_line", "value": "    1/0"}, {"type": "code_line", "value": "except Exception as e:"}, {"type": "code_line", "value": "    logging.exception(\"err\")"}]}]}',
    JSON_ARRAY('traceback', 'message', 'code', 'type'),
    JSON_ARRAY(1),
    'logging.exception 会记录异常的 traceback 信息，便于排查。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1948,
    130,
    '重新抛出（填空）',
    '在 except 捕获后若要重新抛出相同异常，写法为 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "try:"}, {"type": "code_line", "value": "    pass"}, {"type": "code_line", "value": "except Exception:"}, {"type": "code_line", "value": "    __1__"}]}]}',
    JSON_ARRAY('raise', 'raise e', 'throw', 'raise Exception'),
    JSON_ARRAY(1),
    '使用 raise 在 except 中重新抛出当前异常，保持原始 traceback。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1949,
    130,
    '捕获多个异常（填空）',
    'except (AError, BError) as e: 可以同时捕获多个异常，括号内是 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "try:"}, {"type": "code_line", "value": "    pass"}, {"type": "code_line", "value": "except (__1__) as e:"}, {"type": "code_line", "value": "    pass"}]}]}',
    JSON_ARRAY('异常类型元组', '列表', '字典', '字符串'),
    JSON_ARRAY(1),
    'except 后可以跟异常类型元组来同时捕获多种异常。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1950,
    130,
    '总结（填空）',
    '异常处理的基本结构是 __1__。',
    NULL,
    JSON_ARRAY(),
    '{"segments": []}',
    JSON_ARRAY('try/except/finally', 'if/else', 'for/while', 'def/class'),
    JSON_ARRAY(1),
    '异常处理常用 try/except/finally 结构来捕获与清理。',
    ''
);