USE `questions`;
-- Unit 57 | Start ID: 1291
-- Generated at 2025-12-24 17:37:57

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1291, 
    57, 
    '针对分支的单元测试', 
    '编写单元测试时应覆盖哪些情形？', 
    JSON_OBJECT('A', '所有分支路径与边界条件', 'B', '仅成功路径', 'C', '仅失败路径', 'D', '测试不必要'), 
    1, 
    JSON_ARRAY('覆盖更多路径保证行为', '包括异常及边界情况'), 
    '单元测试应覆盖各分支以保证不同分支的正确性。', 
    '测试 if/elif/else 各路径'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1292, 
    57, 
    '断点调试', 
    '调试复杂分支逻辑时常用方法是？', 
    JSON_OBJECT('A', '在关键分支处设断点观察变量', 'B', '随意插入 print', 'C', '删除分支', 'D', '重启系统'), 
    1, 
    JSON_ARRAY('观察运行时状态', '定位错综复杂的分支错误'), 
    '使用断点可逐步观察程序状态并定位问题。', 
    '在 IDE 中断点运行'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1293, 
    57, 
    '覆盖率工具', 
    '使用覆盖率工具可以帮助？', 
    JSON_OBJECT('A', '发现测试未覆盖的分支', 'B', '提高程序速度', 'C', '减少文件大小', 'D', '自动修复代码'), 
    1, 
    JSON_ARRAY('查看哪些行未被执行', '补充相应测试'), 
    '覆盖率报告能显示未执行到的分支，以便补充测试用例。', 
    'pytest --cov'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1294, 
    57, 
    '模拟边界条件', 
    '为覆盖边界分支测试应如何设计输入？', 
    JSON_OBJECT('A', '包含等于边界和紧邻边界的输入', 'B', '只测试边界外的值', 'C', '只测试极大值', 'D', '不需要边界测试'), 
    1, 
    JSON_ARRAY('等于边界的行为很重要', '包括 -1,0,1 等邻近值'), 
    '边界和邻近值常常暴露 off-by-one 错误。', 
    'test with n=0 and n=1'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1295, 
    57, 
    '使用断言 vs 异常', 
    '单元测试中用断言的优点是？', 
    JSON_OBJECT('A', '简洁且失败会直接暴露问题', 'B', '会隐藏错误', 'C', '无法自动化', 'D', '使测试慢'), 
    1, 
    JSON_ARRAY('断言是快速检查的好方法'), 
    '断言能直观表达预期并在不满足时抛出错误，便于自动化测试。', 
    'assert f(x)==y'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1296, 
    57, 
    '回放问题', 
    '定位复杂分支错误时，回放日志能帮助什么？', 
    JSON_OBJECT('A', '还原引发错误的输入与流程', 'B', '自动修复错误', 'C', '替代测试', 'D', '使问题更难'), 
    1, 
    JSON_ARRAY('日志记录输入和状态', '便于还原问题场景'), 
    '有详尽日志可以准确还原错误触发路径，利于定位问题。', 
    'log input and state'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1297, 
    57, 
    '边界条件自动化', 
    '自动化测试边界时应结合什么工具？', 
    JSON_OBJECT('A', '参数化测试框架（如 pytest param）', 'B', '手动运行每次测试', 'C', '只用 print 观察', 'D', '不测试边界'), 
    1, 
    JSON_ARRAY('参数化便于覆盖多个输入组合'), 
    '使用参数化可以方便地为同一测试函数传入多组边界数据。', 
    '@pytest.mark.parametrize("n", [0,1,2])'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1298, 
    57, 
    '回归测试', 
    '发现分支错误后应建立什么以防止复发？', 
    JSON_OBJECT('A', '覆盖该场景的回归测试', 'B', '忽略并重构', 'C', '删掉该功能', 'D', '只修复线上'), 
    1, 
    JSON_ARRAY('把错误场景加入测试用例', '保持后续变更不破坏行为'), 
    '回归测试能在未来修改中检测出同类错误是否再次出现。', 
    '新增测试用例后加入 CI'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1299, 
    57, 
    '模拟外部依赖', 
    '为测试分支逻辑如何处理网络或数据库？', 
    JSON_OBJECT('A', '使用 mock 模拟外部服务', 'B', '总是调用真实服务', 'C', '删除测试', 'D', '使用随机数据'), 
    1, 
    JSON_ARRAY('mock 有助于隔离单元测试', '控制返回值便于覆盖各种分支'), 
    '用 mock 可以稳定模拟外部依赖并覆盖不同返回情况。', 
    'with patch("requests.get") as m: ...'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1300,
    57,
    '写测试用例示例',
    '补全：为 is_even 函数添加简单断言。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def is_even(n):"}, {"type": "code_line", "value": "    return n%2==0"}, {"type": "code_line", "value": "assert is_even(2)"}, {"type": "code_line", "value": "assert not is_even(3)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用断言快速验证函数在典型输入上的行为。',
    'assert add(1,2)==3'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1301,
    57,
    '使用日志帮助调试',
    '补全：在关键分支记录日志信息。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import logging"}, {"type": "code_line", "value": "logging.info(\"enter branch A with x=%s\", x)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '在分支中记录必要上下文有助于线下排查问题。',
    'logger.debug(...)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1302,
    57,
    '断点示例',
    '补全：在调试时可用 pdb 设断点。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import pdb; pdb.set_trace()"}, {"type": "code_line", "value": "# 运行到此处进入调试控制台"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'pdb.set_trace 可在运行时进入交互式调试。',
    '使用 IDE 的断点功能'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1303,
    57,
    '模拟异常场景',
    '补全：用 with 捕获文件打开异常示例。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "try:"}, {"type": "code_line", "value": "    with open(\"nofile\") as f:"}, {"type": "code_line", "value": "        pass"}, {"type": "code_line", "value": "except FileNotFoundError:"}, {"type": "code_line", "value": "    print(\"missing\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '在测试中模拟异常可以验证异常处理路径。',
    'except Exception as e: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1304,
    57,
    '记录断言失败信息',
    '补全：断言失败时打印有助于定位的问题上下文。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "assert result==expected, f\"got {result}, expected {expected}\""}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '附带信息的断言能更快定位错误原因。',
    'assert x==y, "mismatch"'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1305,
    57,
    '用临时数据复现问题',
    '补全：准备小规模输入以复现分支错误。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "data = [edge_case1, edge_case2]"}, {"type": "code_line", "value": "for d in data:"}, {"type": "code_line", "value": "    run(d)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用代表性小样本快速定位并修复分支错误。',
    '构造最小复现样例'
);