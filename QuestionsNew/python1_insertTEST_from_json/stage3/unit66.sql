USE `questions`;
-- Unit 66 | Start ID: 976
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    976,
    66,
    '误区：认为 break 退出所有循环',
    '下列说法正确吗？ break 会退出所有嵌套循环。',
    JSON_OBJECT('A', '错误', 'B', '正确', 'C', '视 Python 版本而定', 'D', '仅在函数中为真'),
    1,
    JSON_ARRAY('break 仅退出当前循环', '要退出外层需其他手段', '可用 flag 或异常实现外层退出'),
    'break 只退出包含它的最近一层循环。',
    'inner break only'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    977,
    66,
    '误区：break 必然优雅',
    '过度使用 break 总是好的做法吗？',
    JSON_OBJECT('A', '不是，总要权衡可读性', 'B', '是，越多越好', 'C', '只在小脚本中适用', 'D', '在函数外可用'),
    1,
    JSON_ARRAY('可能降低可读性', '应按需使用', '注释明确退出理由'),
    'break 会改变控制流，使用时应确保清晰的退出意图。',
    'use sparingly'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    978,
    66,
    '误区：break 会回收资源',
    '使用 break 后资源会自动释放吗？',
    JSON_OBJECT('A', '不一定，需显式管理', 'B', '总会释放', 'C', '在 Windows 下释放', 'D', '在 Linux 下释放'),
    1,
    JSON_ARRAY('资源需用 with 或 finally 管理', 'break 不会自动清理外部资源'),
    'break 不会替代资源管理，仍需在合适位置释放资源。',
    'with open() as f'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    979,
    66,
    '误区示例修正',
    '补全：用 flag 退出外层示例。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "done=False"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for i in range(3):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    for j in range(3):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        if cond:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "            done=True"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "            break"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if done:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        break"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 flag 明确退出外层循环的意图。',
    'flag pattern'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    980,
    66,
    'break 与 finally',
    '补全：确保 finally 块执行的写法。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "try:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    while True:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        if cond:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "            break"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "finally:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    cleanup()"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'finally 会在 break 后仍然执行，因此可在其中释放资源。',
    'ensure cleanup'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    981,
    66,
    '内部异常',
    '在循环内捕获异常后用 break 是合适的吗？',
    JSON_OBJECT('A', '视情况，有时合适', 'B', '永远不合适', 'C', '总是合适', 'D', '只能在 for 中'),
    1,
    JSON_ARRAY('记录并合理退出', '考虑是否需要重试'),
    '在不可恢复异常时记录并用 break 退出是合理的策略。',
    'except: log; break'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    982,
    66,
    '测试覆盖',
    '对使用 break 的代码应该如何测试？',
    JSON_OBJECT('A', '覆盖触发 break 与不触发的情形', 'B', '只测试触发情形', 'C', '只看不测试', 'D', '只测试异常'),
    1,
    JSON_ARRAY('测试不同路径', '包括边界情况'),
    '测试应覆盖 break 被触发和未触发的路径以验证行为一致。',
    'unit tests for both cases'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    983,
    66,
    'break 与可读性',
    '为提高可读性使用 break 时应？',
    JSON_OBJECT('A', '加注释说明退出原因', 'B', '不需注释', 'C', '写成一行', 'D', '删除其他代码'),
    1,
    JSON_ARRAY('说明退出条件', '便于维护者理解'),
    '在复杂地方使用 break 应给出注释说明其退出意图。',
    '# found match, break'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    984,
    66,
    '找到后处理',
    '补全：找到目标前先处理再 break。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for x in lst:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if check(x):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        handle(x)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        break"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '在退出前做必要处理能保证重要逻辑被执行。',
    'process then break'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    985,
    66,
    '避免重复代码',
    '补全：用函数提取重复处理后 break。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def proc(x):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    do(x)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x in lst:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if cond(x):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        proc(x)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        break"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '提取函数可减少重复并明确职责。',
    'extract handler'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    986,
    66,
    'break 与逻辑复杂度',
    '在高度复杂分支处使用 break 可能导致？',
    JSON_OBJECT('A', '控制流不清晰', 'B', '自动优化', 'C', '减少错误', 'D', '增加类型检查'),
    1,
    JSON_ARRAY('跳转点太多难以跟踪', '建议重构简化逻辑'),
    '过多跳转会增加理解成本，应考虑重构。',
    'refactor if many breaks'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    987,
    66,
    '替代 break 的模式',
    '若希望显式控制退出，常用何种模式？',
    JSON_OBJECT('A', '修改循环条件或使用 flag', 'B', '增加更多 break', 'C', '用全局变量', 'D', '用 print'),
    1,
    JSON_ARRAY('更显式更易理解', 'flag 清晰表达意图'),
    '通过修改循环条件或使用 flag 提高可读性与可测试性。',
    'running = False'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    988,
    66,
    '代码审查关注点',
    '审查使用 break 的代码应关注？',
    JSON_OBJECT('A', '是否会跳过必要清理或逻辑', 'B', '是否减少行数', 'C', '变量名长度', 'D', '注释数量'),
    1,
    JSON_ARRAY('检查清理逻辑是否仍然执行', '查看 finally 或上下文管理'),
    '审查时要确保 break 不会导致必须执行的清理逻辑被跳过。',
    'ensure cleanup in finally'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    989,
    66,
    '将 break 变为条件',
    '补全：用条件修改循环以避免 break。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "running=True"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while running:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if cond:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        running=False"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '通过修改条件使得退出意图更显式而非跳转。',
    'set flag to false'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    990,
    66,
    '注释 break 原因',
    '补全：在 break 上方写注释说明。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "# found target, exit loop"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if found:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    break"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '注释能帮助他人在后续维护中理解为何退出循环。',
    'explanation before break'
);