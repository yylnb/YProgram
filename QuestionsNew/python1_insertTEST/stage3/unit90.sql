USE `questions`;
-- Unit 90 | Start ID: 1336
-- Generated at 2025-12-24 22:14:21

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1336, 
    90, 
    '复习要点', 
    '学习循环与相关主题的核心要点包括？', 
    JSON_OBJECT('A', '理解迭代、边界、复杂度与数据结构配合', 'B', '只记语法', 'C', '只用库函数', 'D', '抛弃循环'), 
    1, 
    JSON_ARRAY('关注语义、性能与边界处理'), 
    '掌握循环的语法同时要理解何时使用、边界与复杂度，以及如何与数据结构搭配使用。', 
    'practice problems'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1337, 
    90, 
    'debug 技巧', 
    '循环出错调试时优先做什么？', 
    JSON_OBJECT('A', '写小样例并打印中间状态', 'B', '直接重写全部代码', 'C', '增加大量注释', 'D', '忽略错误'), 
    1, 
    JSON_ARRAY('小样例快速定位问题'), 
    '通过最小可复现样例和中间输出能快速定位逻辑错误。', 
    'print intermediate states'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1338, 
    90, 
    '性能复查', 
    '复习性能时要关注？', 
    JSON_OBJECT('A', '时间复杂度与内存占用', 'B', '代码注释长度', 'C', '变量名长度', 'D', '文件名'), 
    1, 
    JSON_ARRAY('关注大 O 与内存峰值'), 
    '在复习性能时主要关注算法复杂度与运行时的内存占用。', 
    'profile code'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1339, 
    90, 
    '复习正则', 
    '正则复习应关注？', 
    JSON_OBJECT('A', '常用模式、分组、转义与性能陷阱', 'B', '只学 match', 'C', '全部用 find', 'D', '忽略'), 
    1, 
    JSON_ARRAY('掌握常用分组与转义并注意性能陷阱'), 
    '复习正则时应掌握分组、转义以及避免回溯爆炸等性能陷阱。', 
    're.sub, re.finditer'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1340, 
    90, 
    '复习数据结构', 
    '复习时应把重点放在？', 
    JSON_OBJECT('A', '何时使用 list/deque/heap/dict 等', 'B', '只记 API', 'C', '写入数据库', 'D', '纯理论'), 
    1, 
    JSON_ARRAY('理解适用场景比记 API 更重要'), 
    '复习数据结构时要理解每种结构的特性与适用场景。', 
    'deque for queue'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1341, 
    90, 
    '复习并发', 
    '并发复习要关注什么？', 
    JSON_OBJECT('A', '何时使用线程/进程/协程及共享数据的同步问题', 'B', '只用线程', 'C', '只用进程', 'D', '不需要复习'), 
    1, 
    JSON_ARRAY('理解适用场景和同步成本'), 
    '并发话题要理解不同模型的适用场景与同步通信代价。', 
    'GIL effects'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1342, 
    90, 
    '复习策略', 
    '高效复习编程题的策略包括？', 
    JSON_OBJECT('A', '做题+总结模板+复盘错误', 'B', '只看题解', 'C', '只背答案', 'D', '不做练习'), 
    1, 
    JSON_ARRAY('主动练习并总结提高最快'), 
    '通过练习、总结及复盘能有效提升解题能力。', 
    'maintain cheat-sheet'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1343, 
    90, 
    '测试重要性', 
    '编写测试用例在复习中重要么？', 
    JSON_OBJECT('A', '重要，可覆盖边界和特殊情况', 'B', '无关紧要', 'C', '只在生产中做', 'D', '仅写单元测试'), 
    1, 
    JSON_ARRAY('测试能帮助发现边界与异常情况'), 
    '测试能提高代码健壮性并帮助验证各种边界与异常输入。', 
    'create sample cases'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1344, 
    90, 
    '刷题节奏', 
    '刷题时建议节奏是？', 
    JSON_OBJECT('A', '稳步持续，注重反思', 'B', '一口气刷大量不回看', 'C', '只刷易题', 'D', '每天不做'), 
    1, 
    JSON_ARRAY('持续与反思比短期冲刺更有效'), 
    '稳定的练习并及时复盘错误能带来持续进步。', 
    'schedule practice'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1345,
    90,
    '回顾 enumerate',
    '补全：用 enumerate 打印索引和值（从 1 开始）。',
    'a b',
    JSON_ARRAY('1 a', '2 b'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "for i,v in enumerate(input().split(),"}, {"type": "slot", "index": 0}, {"type": "code", "value": "):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(i, v)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'enumerate 支持指定起始索引，常用于编号输出。',
    'enumerate(lst,1)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1346,
    90,
    '回顾 join',
    '补全：把多行合并为一字符串输出。',
    'a
b',
    JSON_ARRAY('a
b'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lines=[input() for _ in range(2)]"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\".join(lines))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'join 用于高效合并多个字符串片段。',
    '"\n".join(lines)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1347,
    90,
    '综合练习 1',
    '补全：输入数字，输出其因子个数（简单版）。',
    '6',
    JSON_ARRAY('4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "n=int(input())"}, {"type": "code_line", "value": "cnt=0"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "for i in range("}, {"type": "slot", "index": 0}, {"type": "code", "value": ",n+1):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if n%i==0:"}, {"type": "code_line", "value": "        cnt+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(cnt)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '枚举所有可能因子并计数。',
    'divisors loop'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1348,
    90,
    '综合练习 2',
    '补全：统计字符串中元音字母数。',
    'hello',
    JSON_ARRAY('2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s=input().lower()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(sum("}, {"type": "slot", "index": 0}, {"type": "code", "value": " for ch in s if ch in \"aeiou\"))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用生成器表达式和 sum 可以简洁统计满足条件的元素。',
    'sum cond'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1349,
    90,
    '综合复现',
    '补全：实现一个简单的统计每个单词出现次数的小程序。',
    'a b a',
    JSON_ARRAY('a 2', 'b 1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from collections import Counter"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(*Counter(input().split())."}, {"type": "slot", "index": 0}, {"type": "code", "value": "())"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'Counter 提供快速统计功能，适合这种任务。',
    'Counter(words)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1350,
    90,
    '下一步学习建议',
    '补全：推荐的后续进阶方向（简短列举）。',
    NULL,
    JSON_ARRAY('(none)'),
    '{"segments": [{"type": "code_inline", "parts": [{"type": "code", "value": "# 建议：算法与数据结构进阶、系统设计、并发与性能调优"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '掌握算法、系统与并发可提升到更高工程能力。',
    'study algorithms and systems'
);