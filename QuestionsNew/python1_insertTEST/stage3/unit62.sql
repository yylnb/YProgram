USE `questions`;
-- Unit 62 | Start ID: 916
-- Generated at 2025-12-24 18:00:47

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    916, 
    62, 
    '计数器作用', 
    '循环计数器通常用于？', 
    JSON_OBJECT('A', '控制迭代次数', 'B', '存储字符串', 'C', '定义函数', 'D', '格式化输出'), 
    1, 
    JSON_ARRAY('记录迭代次数', '用于停止循环', '常用 i 或 j 名称'), 
    '计数器用于控制和记录当前迭代次数。', 
    'i=0; while i<5: i+=1'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    917, 
    62, 
    '计数器初始值', 
    '若要打印 1..n，计数器应如何初始化？', 
    JSON_OBJECT('A', '1', 'B', '0', 'C', 'n', 'D', '-1'), 
    1, 
    JSON_ARRAY('从 1 开始保证第一个值为 1', '选择与需求一致'), 
    '打印 1..n 时从 1 初始化最为直观。', 
    'i=1'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    918, 
    62, 
    '步长调整', 
    '改变计数器步长可以做什么？', 
    JSON_OBJECT('A', '按固定间隔跳过值', 'B', '影响函数定义', 'C', '无意义', 'D', '使循环结束'), 
    1, 
    JSON_ARRAY('步长为 2 可跳过奇偶', '控制迭代粒度'), 
    '通过改变步长可以控制循环迭代的增量。', 
    'i+=2'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    919, 
    62, 
    '计数器命名', 
    '常见计数器命名风格是？', 
    JSON_OBJECT('A', '用简短变量如 i, j', 'B', '使用长句子', 'C', '使用中文变量', 'D', '使用常量'), 
    1, 
    JSON_ARRAY('短名常用于局部迭代', '避免与重要变量混淆'), 
    'i, j 是常见计数器名，但在复杂场景应用更具描述性的名。', 
    'for i in range(5): ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    920, 
    62, 
    '计数器边界', 
    '要包括最后一个值应如何写条件？', 
    JSON_OBJECT('A', '<= b', 'B', '< b', 'C', '> b', 'D', '== b only'), 
    1, 
    JSON_ARRAY('闭区间需要 +1', '注意 off-by-one 错误'), 
    '使用 <= 可以包含边界值。', 
    'while i<=n: ...'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    921, 
    62, 
    '计数器类型', 
    '计数器可以是什么类型？', 
    JSON_OBJECT('A', '整数最常用', 'B', '列表', 'C', '字典', 'D', '函数'), 
    1, 
    JSON_ARRAY('整数便于 +1 增加', '步长应为数值类型'), 
    '计数器通常为整数以便进行算术递增。', 
    'i=0; i+=1'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    922, 
    62, 
    '计数器错误示例', 
    '下列哪种做法会常导致无限循环？', 
    JSON_OBJECT('A', '在循环中忘记增加计数器', 'B', '初始化计数器在外部', 'C', '使用正确的条件', 'D', '使用 break 退出'), 
    1, 
    JSON_ARRAY('忘记更新变量', '循环条件永远为真', '检查循环体'), 
    '忘记在循环体改变计数器会导致循环条件永远成立。', 
    'missing i += 1'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    923, 
    62, 
    '计数器与浮点', 
    '计数器使用浮点时应注意？', 
    JSON_OBJECT('A', '精度问题导致条件判断不精确', 'B', '没有区别', 'C', '更快', 'D', '自动转换为 int'), 
    1, 
    JSON_ARRAY('浮点精度可能引发比较问题', '尽量用整数作为计数器'), 
    '浮点计数器在比较时可能出现精度误差，建议用整数。', 
    'i += 0.1 可能不精确'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    924, 
    62, 
    '计数器复位', 
    '有时需要在循环中复位计数器，这时应？', 
    JSON_OBJECT('A', '小心并确保逻辑正确', 'B', '随意复位', 'C', '总是复位为 0', 'D', '删除计数器'), 
    1, 
    JSON_ARRAY('复位会影响后续判断', '应明确意图并注释'), 
    '复位计数器需要谨慎，明确意图以避免错误。', 
    'reset when needed'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    925,
    62,
    '计数器示例',
    '补全：使用计数器累加和。',
    NULL,
    JSON_ARRAY('6'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=1"}, {"type": "code_line", "value": "s=0"}, {"type": "code_line", "value": "while i<=3:"}, {"type": "code_line", "value": "    s += i"}, {"type": "code_line", "value": "    i +=1"}, {"type": "code_line", "value": "print(s)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '累加 1+2+3 的结果为 6。',
    'sum loop'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    926,
    62,
    '避免混淆',
    '补全：不要在循环体内重置计数器。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}, {"type": "code_line", "value": "while i<3:"}, {"type": "code_line", "value": "    print(i)"}, {"type": "code_line", "value": "    # 不要写 i = 0"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '重置计数器会导致无限循环或逻辑错误。',
    'update counter properly'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    927,
    62,
    '用计数器打印偶数',
    '补全：打印 2,4,6。',
    NULL,
    JSON_ARRAY('2', '4', '6'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=2"}, {"type": "code_line", "value": "while i<=6:"}, {"type": "code_line", "value": "    print(i)"}, {"type": "code_line", "value": "    i += 2"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '以步长 2 遍历偶数。',
    'i+=2'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    928,
    62,
    '计数器与条件',
    '补全：循环直到计数器达到 10。',
    NULL,
    JSON_ARRAY(),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}, {"type": "code_line", "value": "while i<10:"}, {"type": "code_line", "value": "    i+=1"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '简单计数器条件控制循环。',
    'while i<10: i+=1'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    929,
    62,
    '计数器打印索引',
    '补全：打印列表每个元素索引和值。',
    NULL,
    JSON_ARRAY('0 a', '1 b'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=[\"a\",\"b\"]"}, {"type": "code_line", "value": "i=0"}, {"type": "code_line", "value": "while i<len(lst):"}, {"type": "code_line", "value": "    print(i, lst[i])"}, {"type": "code_line", "value": "    i+=1"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用计数器访问序列索引。',
    'while with index'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    930,
    62,
    '倒序计数器',
    '补全：从 3 倒数到 1。',
    NULL,
    JSON_ARRAY('3', '2', '1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=3"}, {"type": "code_line", "value": "while i>0:"}, {"type": "code_line", "value": "    print(i)"}, {"type": "code_line", "value": "    i-=1"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '通过递减计数器实现倒序。',
    'i-=1 loop'
);