USE `questions`;
-- Unit 41 | Start ID: 601
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    601,
    41,
    '嵌套 if 的用途',
    '嵌套 if 常用于哪类问题？',
    JSON_OBJECT('A', '分步骤判断多个相关条件', 'B', '替代函数定义', 'C', '作为循环的替代', 'D', '提升性能的手段'),
    1,
    JSON_ARRAY('逐层判断不同条件', '按状态判断更清晰', '用于复杂决策树'),
    '嵌套 if 常用于按阶段或状态层级判断不同条件的场景。',
    'if logged_in:
    if is_admin: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    602,
    41,
    '避免深层嵌套',
    '当嵌套层次过深时应如何改进？',
    JSON_OBJECT('A', '用早退/guard clause 减少嵌套', 'B', '增加更多嵌套保持逻辑', 'C', '把所有逻辑放在一行', 'D', '使用全局变量'),
    1,
    JSON_ARRAY('早退降低缩进', '提高可读性', '把异常或边界条件先处理掉'),
    '使用 guard clause（早退）可以减少嵌套深度并提升可读性。',
    'if not cond: return
# then main logic'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    603,
    41,
    '状态机思维',
    '把复杂条件看成状态机有什么好处？',
    JSON_OBJECT('A', '便于分离状态和行为', 'B', '使程序更慢', 'C', '减少测试覆盖', 'D', '避免使用函数'),
    1,
    JSON_ARRAY('状态驱动逻辑更清晰', '易于单元测试', '便于维护和扩展'),
    '状态机把状态与状态转换清晰分离，利于设计复杂逻辑。',
    'state = "idle"
if state == "run": ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    604,
    41,
    '嵌套条件改写为早退',
    '补全：把嵌套 if 改为早退风格。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def f(x):"}, {"type": "code_line", "value": "    if x is None:"}, {"type": "code_line", "value": "        return"}, {"type": "code_line", "value": "    if x < 0:"}, {"type": "code_line", "value": "        return"}, {"type": "code_line", "value": "    # 处理有效 x"}, {"type": "code_line", "value": "    print(x)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '通过先处理异常/边界条件来减少后续嵌套。',
    '参见代码'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    605,
    41,
    '分支逻辑抽函数',
    '补全：把分支逻辑抽成函数以简化主流程。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def handle_admin():"}, {"type": "code_line", "value": "    pass"}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "def main(user):"}, {"type": "code_line", "value": "    if user.is_admin():"}, {"type": "code_line", "value": "        handle_admin()"}, {"type": "code_line", "value": "    else:"}, {"type": "code_line", "value": "        ___"}]}]}',
    JSON_ARRAY('handle_user()', 'return', 'pass', 'raise'),
    JSON_ARRAY(0),
    '把分支动作抽成函数能使主流程清晰。',
    '分离不同角色的处理函数'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    606,
    41,
    '可测试性',
    '如何提高嵌套条件代码的可测试性？',
    JSON_OBJECT('A', '把复杂逻辑拆成小函数并单元测试', 'B', '把逻辑写在一个大函数中', 'C', '不写测试', 'D', '仅用打印调试'),
    1,
    JSON_ARRAY('小函数易于隔离测试', '降低耦合提高复用', '保持接口简单'),
    '拆成小函数便于单元测试和维护。',
    'def validate(x): ...
def process(x): ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    607,
    41,
    '状态变量命名',
    '关于状态变量命名，下列建议哪项较好？',
    JSON_OBJECT('A', '使用描述性名称如 is_ready 或 state', 'B', '用单字母 a/b', 'C', '使用数字 1/2', 'D', '使用随机字符串'),
    1,
    JSON_ARRAY('描述性名称提高可读性', '便于团队理解', '避免歧义'),
    '使用描述性名称让状态含义清楚，利于维护。',
    'is_authenticated = True'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    608,
    41,
    '用字典替代多重 if',
    '当根据键选择处理函数时，建议使用？',
    JSON_OBJECT('A', '字典映射到处理函数', 'B', '长 if/elif 链', 'C', '多重嵌套 if', 'D', '使用全局变量串联'),
    1,
    JSON_ARRAY('字典映射更清晰', '易于扩展', '避免长链判断'),
    '字典把键映射到函数，处理分派更简洁。',
    'handlers = {"a": h_a, "b": h_b}
handlers.get(k, default)()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    609,
    41,
    '状态转换写法',
    '补全：定义状态转换字典并调用。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "trans = {\\"start\\": \\"run\\", \\"run\\": \\"stop\\"}"}, {"type": "code_line", "value": "state = \\"start\\""}, {"type": "code_line", "value": "state = trans.get(state, ___)"}]}]}',
    JSON_ARRAY('state', 'None', '"start"', '"done"'),
    JSON_ARRAY(0),
    '当找不到时返回 None 或默认状态以避免 KeyError。',
    'state = transitions.get(state, None)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    610,
    41,
    '分支重构练习',
    '补全：把复杂判断提取为函数。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def check(x):"}, {"type": "code_line", "value": "    return x>0 and x%2==0"}, {"type": "code_line", "value": ""}, {"type": "code_line", "value": "if check(a):"}, {"type": "code_line", "value": "    ___"}]}]}',
    JSON_ARRAY('print("OK")', 'return', 'pass', 'raise'),
    JSON_ARRAY(0),
    '提取判断后直接使用函数结果可提高可读性。',
    'if is_valid(user): handle(user)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    611,
    41,
    '分离副作用与判断',
    '为何要把副作用（如打印、写文件）从判断逻辑中分离？',
    JSON_OBJECT('A', '便于测试并减少耦合', 'B', '让程序更慢', 'C', '避免使用函数', 'D', '增加全局变量'),
    1,
    JSON_ARRAY('分离关注点', '便于模拟副作用', '逻辑更纯粹易测试'),
    '把副作用抽离使核心逻辑易测试且更稳定。',
    'result = compute(x)
log(result)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    612,
    41,
    '可维护性的技巧',
    '哪种做法能提升复杂条件的可维护性？',
    JSON_OBJECT('A', '添加注释与示例', 'B', '故意省略注释', 'C', '把所有逻辑合并成一行', 'D', '用魔法数字'),
    1,
    JSON_ARRAY('注释和示例帮助阅读', '清晰的命名也重要', '测试覆盖很关键'),
    '在复杂逻辑处添加注释和示例能帮助未来维护。',
    '# 如果用户是 admin，则...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    613,
    41,
    '设计决策记录',
    '记录为何选择某种分支实现有何好处？',
    JSON_OBJECT('A', '有利于代码审查与后续维护', 'B', '增加文件大小', 'C', '让代码运行更慢', 'D', '无实际意义'),
    1,
    JSON_ARRAY('文档帮助团队理解原因', '便于未来改动时评估影响', '能减少误改'),
    '记录设计决策有助于团队理解并减少误操作。',
    '在注释或 PR 描述中说明理由'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    614,
    41,
    '用字典实现分派',
    '补全：使用 dict 分派到不同函数处理。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "handlers = {\\"a\\":handle_a, \\"b\\":handle_b}"}, {"type": "code_line", "value": "cmd = input()"}, {"type": "code_line", "value": "handlers.get(cmd, ___)()"}]}]}',
    JSON_ARRAY('lambda:None', 'None', 'default', 'print'),
    JSON_ARRAY(0),
    '使用默认 lambda 函数避免 NoneType 调用错误。',
    'handlers.get(k, lambda: print("unknown"))()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    615,
    41,
    '实践：状态驱动流程',
    '补全：根据 state 执行不同动作。',
    JSON_ARRAY('state="run"'),
    JSON_ARRAY('running'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if state == \\"start\\":"}, {"type": "code_line", "value": "    print(\\"starting\\")"}, {"type": "code_line", "value": "elif state == \\"run\\":"}, {"type": "code_line", "value": "    print(\\"running\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\"stopped\\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '直接用分支处理不同状态，代码简单明了。',
    'state machines 常见写法'
);