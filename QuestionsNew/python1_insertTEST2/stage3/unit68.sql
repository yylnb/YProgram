USE `questions`;
-- Unit 68 | Start ID: 1006
-- Generated at 2025-12-24 23:20:00

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1006, 
    68, 
    '误区：continue 导致退出循环', 
    'continue 会退出循环吗？', 
    JSON_OBJECT('A', '不会，只跳过本次', 'B', '会退出所有循环', 'C', '会退出函数', 'D', '退出程序'), 
    1, 
    JSON_ARRAY('仅跳过本次迭代', '区别于 break', '影响后续逻辑'), 
    'continue 仅跳过本次剩余语句并进入下一次迭代。', 
    'if cond: continue'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1007, 
    68, 
    '误区：continue 不需更新计数器', 
    '使用 continue 是否可省略计数器更新？', 
    JSON_OBJECT('A', '不可以，可能导致无限循环', 'B', '可以', 'C', '只在 for 中可以', 'D', '只在 while 中可以'), 
    1, 
    JSON_ARRAY('更新发生位置要注意', '确保每次迭代都能前进'), 
    '即使使用 continue 也应保证计数器在合适位置更新以避免死循环。', 
    'update early'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1008, 
    68, 
    '误区：continue 会跳到循环外', 
    '下面哪个说法错误？ continue 跳到循环外部继续执行', 
    JSON_OBJECT('A', '错误', 'B', '正确', 'C', '有时正确', 'D', '取决于解释器'), 
    1, 
    JSON_ARRAY('continue 只是继续下一次迭代', '不会退出循环'), 
    'continue 不会导致跳出循环，仅进入下一次迭代。', 
    'continue semantics'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1009,
    68,
    '误区修正示例',
    '补全：确保计数器在可执行路径被更新。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while i<3:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if cond:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        continue"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    do()"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '把计数器更新放在可能执行 continue 之前，避免跳过更新。',
    'update first'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1010,
    68,
    '统计跳过',
    '补全：记录被跳过项目的索引。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "skips=[]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while i<len(lst):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if skip_cond(lst[i]):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        skips.append(i)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        i+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        continue"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '在跳过前记录索引并更新计数器。',
    'collect skipped indices'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1011, 
    68, 
    'continue 与嵌套', 
    '内层 continue 会影响外层循环吗？', 
    JSON_OBJECT('A', '不会，只影响内层', 'B', '会影响外层', 'C', '退出所有循环', 'D', '报错'), 
    1, 
    JSON_ARRAY('行为与 break 类似的层级限制', '可能需 flag 交互'), 
    '内层的 continue 只影响内层循环，不会直接影响外层。', 
    'nested continue'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1012, 
    68, 
    '替代 continue', 
    '不希望使用 continue，可用哪种写法代替？', 
    JSON_OBJECT('A', '用条件把后续逻辑包裹起来', 'B', '删除后续逻辑', 'C', '用 break', 'D', '用异常'), 
    1, 
    JSON_ARRAY('显式条件通常更易读', '避免跳转'), 
    '将需要执行的逻辑放在 if 块中可以替代 continue，控制流更直观。', 
    'if not cond: do()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1013, 
    68, 
    '可读性建议', 
    '在复杂循环中使用 continue 时，建议？', 
    JSON_OBJECT('A', '尽量保持简单并注释原因', 'B', '随处使用', 'C', '不需注释', 'D', '用更多嵌套'), 
    1, 
    JSON_ARRAY('注明原因便于维护', '避免过多跳转点'), 
    '在复杂逻辑处使用 continue 时应加注释并考虑重构。', 
    '# skip empty entry'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1014,
    68,
    '避免跳过更新',
    '补全：示例中先更新索引再 continue。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while i<n:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if cond:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        continue"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '在可能 continue 的位置之前更新索引能避免无限循环。',
    'update before skip'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1015,
    68,
    '跳过并记录值',
    '补全：跳过时保存被跳过的值。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "skipped=[]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for v in lst:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if cond(v):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        skipped.append(v)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        continue"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '在跳过时记录值可用于后续处理。',
    'collect then continue'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1016, 
    68, 
    '边界情况', 
    '使用 continue 时要特别注意哪些边界？', 
    JSON_OBJECT('A', '计数器更新与条件可达性', 'B', '注释数量', 'C', '函数名长度', 'D', '缩进空格'), 
    1, 
    JSON_ARRAY('重点关注循环控制变量', '测试边界场景'), 
    '计数器与退出条件是使用 continue 时的关键边界问题。', 
    'test edge cases'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1017, 
    68, 
    '调试技巧', 
    '调试被 continue 跳过的分支可做什么？', 
    JSON_OBJECT('A', '在跳过点打印或断点', 'B', '删除 continue', 'C', '增加更多 continue', 'D', '不调试'), 
    1, 
    JSON_ARRAY('观察被跳过的输入状态', '用小样本复现'), 
    '在跳过点添加日志或断点有助于理解为何被跳过。', 
    'print debug info'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1018, 
    68, 
    '性能考虑', 
    '大量使用 continue 会带来什么？', 
    JSON_OBJECT('A', '主要影响可读性，性能影响小', 'B', '显著降低速度', 'C', '提高内存', 'D', '修改变量类型'), 
    1, 
    JSON_ARRAY('continue 本身开销小', '循环体操作决定性能'), 
    'continue 对性能影响微小，主要需注意逻辑清晰性。', 
    'profile if needed'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1019,
    68,
    '说明跳过原因',
    '补全：在代码中写明跳过理由注释。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if invalid:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    # invalid format, skip"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    continue"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '注释帮助维护者快速理解跳过原因。',
    '# reason'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1020,
    68,
    '测试跳过路径',
    '补全：为跳过路径添加测试用例。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def test_skip():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    assert process([bad_item]) == expected"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '对跳过分支写测试可避免回归问题。',
    'unit test for skip'
);