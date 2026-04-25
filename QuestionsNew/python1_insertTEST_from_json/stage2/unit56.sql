USE `questions`;
-- Unit 56 | Start ID: 826
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    826,
    56,
    '重构目的一般包括',
    '对复杂多分支逻辑进行重构的主要目的是什么？',
    JSON_OBJECT('A', '提高可读性与可维护性', 'B', '增加代码行数', 'C', '隐藏逻辑', 'D', '使其更慢'),
    1,
    JSON_ARRAY('代码更清晰易理解', '便于添加新分支'),
    '通过重构降低复杂度，提高可读性与后期维护效率。',
    '提取函数、使用映射表'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    827,
    56,
    '替代长 if 链',
    '将长 if/elif 链替换成更好结构的常见方法是？',
    JSON_OBJECT('A', '使用映射字典或策略模式', 'B', '保持不变', 'C', '嵌套更多 if', 'D', '抛弃功能'),
    1,
    JSON_ARRAY('字典映射便于扩展', '策略模式对复杂逻辑有帮助'),
    '映射或策略模式可以把分支逻辑分离到独立可管理的单元。',
    'actions = {"a": fn_a, "b": fn_b}
actions[k]()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    828,
    56,
    '小函数提取',
    '把一段分支逻辑提取为函数能带来？',
    JSON_OBJECT('A', '改善测试性和可复用性', 'B', '让代码更混乱', 'C', '减少可读性', 'D', '阻止重构'),
    1,
    JSON_ARRAY('小函数便于单元测试', '逻辑更清晰'),
    '提取函数可以降低每个函数的复杂度并便于单独测试。',
    'def is_vowel(c): ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    829,
    56,
    '用映射替代分支',
    '补全：将选项映射到函数调用。',
    JSON_ARRAY('opt="b"'),
    JSON_ARRAY('B'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def a():"}, {"type": "code_line", "value": "    print(\\"A\\")"}, {"type": "code_line", "value": "def b():"}, {"type": "code_line", "value": "    print(\\"B\\")"}, {"type": "code_line", "value": "map = {\\"a\\": a, \\"b\\": b}"}, {"type": "code_line", "value": "map.get(opt, lambda: print(\\"invalid\\"))()"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用字典映射可以替代多个 if 分支。',
    'actions.get(cmd, noop)()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    830,
    56,
    '简化条件表达式',
    '补全：使用任何内建函数判断是否匹配集合。',
    JSON_ARRAY('ch="x"'),
    JSON_ARRAY('no'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if ch in (\\"a\\",\\"b\\",\\"c\\"):"}, {"type": "code_line", "value": "    print(\\"yes\\")"}, {"type": "code_line", "value": "else:"}, {"type": "code_line", "value": "    print(\\"no\\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 in 运算符可简洁表达多值判断。',
    'if x in values: ...'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    831,
    56,
    '提前返回',
    '在函数中使用提前返回的优点是？',
    JSON_OBJECT('A', '减少嵌套层级并提高可读性', 'B', '增加嵌套', 'C', '隐藏错误', 'D', '让函数更长'),
    1,
    JSON_ARRAY('减少 elif 嵌套', '使逻辑更扁平化'),
    '提前返回可以避免深层嵌套，代码更清晰。',
    'if invalid: return None
# 后续正常逻辑'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    832,
    56,
    '策略模式',
    '策略模式在分支重构中提供了？',
    JSON_OBJECT('A', '把算法封装成可替换对象', 'B', '使代码不可测试', 'C', '强制使用面向对象', 'D', '无法复用'),
    1,
    JSON_ARRAY('封装变化点', '便于扩展与替换'),
    '策略模式将可变的部分封装，便于在运行时选择并替换行为。',
    'strategy = strategies[key]
strategy.execute()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    833,
    56,
    '测试驱动重构',
    '重构前应先做什么以降低风险？',
    JSON_OBJECT('A', '编写或确认存在单元测试', 'B', '直接改代码不做测试', 'C', '删除旧功能', 'D', '重命名变量'),
    1,
    JSON_ARRAY('测试保证行为不变', '写测试再重构是好习惯'),
    '有覆盖的测试可以在重构时确保行为保持一致。',
    'assert func(x)==y'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    834,
    56,
    '提取判断函数',
    '补全：把复杂判断提取为函数 is_valid。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "def is_valid(x):"}, {"type": "code_line", "value": "    return x>0 and x<10"}, {"type": "code_line", "value": "if is_valid(n):"}, {"type": "code_line", "value": "    print(\\"ok\\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '提取判断逻辑有助于重用与单元测试。',
    'def check(x): return x.isdigit()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    835,
    56,
    '使用枚举或常量',
    '补全：用常量提高可读性而非魔法数字。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "STATUS_OK = 1"}, {"type": "code_line", "value": "if status == STATUS_OK:"}, {"type": "code_line", "value": "    print(\\"ok\\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '常量或枚举比魔法数字更具可读性和可维护性。',
    'from enum import Enum'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    836,
    56,
    '避免重复代码',
    '重构时减少重复代码的常见方法是？',
    JSON_OBJECT('A', '抽取公共函数或模块', 'B', '复制粘贴多份', 'C', '增加更多 if 分支', 'D', '不做任何改变'),
    1,
    JSON_ARRAY('抽取公共部分', '封装为单元测试函数'),
    '将重复逻辑抽取成函数或模块可以降低维护成本。',
    'def helper(): ...
helper()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    837,
    56,
    '可配置化',
    '将规则从代码提取到配置的优点是？',
    JSON_OBJECT('A', '无需改代码即可调整行为', 'B', '增加编译时间', 'C', '让程序更慢', 'D', '破坏兼容性'),
    1,
    JSON_ARRAY('配置驱动更灵活', '便于非开发人员调整'),
    '配置化使得修改行为无需改动源码并重新部署。',
    'load_rules("rules.json")'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    838,
    56,
    '文档与注释',
    '重构后应补充什么以便他人理解？',
    JSON_OBJECT('A', '函数说明与使用示例', 'B', '删掉所有注释', 'C', '只写代码不写说明', 'D', '隐藏接口'),
    1,
    JSON_ARRAY('写明输入输出', '提供示例使用场景'),
    '文档与示例能帮助他人快速理解重构后的接口。',
    'def f(x): """说明"""'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    839,
    56,
    '将条件表驱动化',
    '补全：用列表保存规则并循环匹配。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "rules = [(lambda x: x%2==0, \\"even\\"), (lambda x: True, \\"other\\")]"}, {"type": "code_line", "value": "for cond, val in rules:"}, {"type": "code_line", "value": "    if cond(n):"}, {"type": "code_line", "value": "        print(val)"}, {"type": "code_line", "value": "        break"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用规则表可以把判定逻辑数据化，便于管理。',
    'for r in rules: if r.match(x): ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    840,
    56,
    '重构后测试示例',
    '补全：确保提取函数行为不变的断言。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "assert is_valid(5) == True"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '通过断言或单元测试验证重构前后行为一致性。',
    'assert func(x)==expected'
);