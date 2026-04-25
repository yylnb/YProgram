USE `questions`;
-- Unit 89 | Start ID: 1321
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1321,
    89,
    '模拟思想',
    '模拟题的核心通常是？',
    JSON_OBJECT('A', '按规则逐步更新状态', 'B', '找公式直接计算', 'C', '随机猜测', 'D', '使用数据库'),
    1,
    JSON_ARRAY('按规则迭代状态是模拟问题的本质'),
    '模拟问题通过逐步按规则更新状态来得到最终结果，适合规则明确的问题。',
    'for step in range(t): update(state)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1322,
    89,
    '状态表示',
    '表示状态时应优先选择？',
    JSON_OBJECT('A', '清晰且尽量紧凑的数据结构', 'B', '越复杂越好', 'C', '使用字符串总是最优', 'D', '不需要表示'),
    1,
    JSON_ARRAY('易于更新和检查的结构更利于模拟'),
    '选取合适的数据结构用于高效表示状态并方便更新与判断。',
    '使用元组/字典/list 表示状态'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1323,
    89,
    '步数限制',
    '若模拟步数非常大应考虑？',
    JSON_OBJECT('A', '找周期或数学简化', 'B', '直接模拟直到结束', 'C', '放弃求解', 'D', '增加内存'),
    1,
    JSON_ARRAY('周期性可用于跳跃式计算最终状态'),
    '当步数很大时寻找周期或模式以避免逐步模拟可显著提高效率。',
    'find cycle length'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1324,
    89,
    '简单自动机',
    '补全：基于规则的状态转移示例（轮流切换 A/B）。',
    JSON_ARRAY('3'),
    JSON_ARRAY('A B A'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "n=int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "state=\\"A\\""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for i in range(n):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(state, end=\\" \\")"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    state = \\"B\\" if state==\\"A\\" else \\""}, {"type": "slot", "index": 0}, {"type": "code", "value": "\\""}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '通过简单的状态切换逐步输出状态序列。',
    'state toggle'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1325,
    89,
    '边界处理',
    '补全：模拟时注意边界条件示例（环形）。',
    JSON_ARRAY('5 2'),
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "n,k=map(int,input().split())"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")%n)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '环形索引使用模运算处理越界。',
    '(i+1)%n'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1326,
    89,
    '状态压缩',
    '当状态空间过大时可用的技巧？',
    JSON_OBJECT('A', '状态压缩或哈希表示', 'B', '存全部历史', 'C', '展开为矩阵', 'D', '必须并行计算'),
    1,
    JSON_ARRAY('压缩能降低内存消耗并便于比较'),
    '通过压缩或哈希表示状态可节省内存并便于快速比较。',
    'bitmask representation'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1327,
    89,
    '循环内打印',
    '大规模模拟中频繁打印会导致？',
    JSON_OBJECT('A', '显著降低性能', 'B', '提高性能', 'C', '无影响', 'D', '只影响内存'),
    1,
    JSON_ARRAY('IO 是慢操作，尽量批量输出或记录'),
    '频繁 IO 会成为瓶颈，应尽可能减少打印或批量输出以提高效率。',
    'collect outputs and join'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1328,
    89,
    '调试模拟',
    '调试复杂模拟常用方法？',
    JSON_OBJECT('A', '缩小规模并打印中间状态', 'B', '直接交付', 'C', '不打印', 'D', '只运行完整样例'),
    1,
    JSON_ARRAY('逐步验证小规模能快速定位问题'),
    '通过缩小规模和打印中间状态能快速定位逻辑错误。',
    'debug small n'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1329,
    89,
    '周期检测',
    '补全：用字典记录状态第一次出现的步数以检测周期。',
    NULL,
    JSON_ARRAY('(none)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "seen={}"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "step=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "state=init"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while True:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if state in seen:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        print(\\"cycle\\", step - seen[state]); break"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    seen[state]="}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    # update state"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    step+=1"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '记录状态首次出现的步数可计算周期长度并快速跳跃到目标步数。',
    'seen[state]=step'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1330,
    89,
    '模拟与数学结合',
    '补全：若发现每 T 步状态重复，可用数学跳跃到目标步。',
    NULL,
    JSON_ARRAY('(none)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "# pseudo"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "if target>first_occurrence:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    remain = (target-first_occurrence) % "}, {"type": "slot", "index": 0}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    simulate remain steps"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '利用周期性质可把大步数问题降为小步数模拟。',
    'fast-forward using cycle'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1331,
    89,
    '状态存储',
    '存储历史状态以便回退常用的数据结构是？',
    JSON_OBJECT('A', 'list 或栈', 'B', 'set', 'C', 'dict 不能', 'D', 'tuple'),
    1,
    JSON_ARRAY('栈便于回退最近的状态'),
    '使用列表或栈可以按顺序存储历史状态并实现回退操作。',
    'history.append(state)
state = history.pop()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1332,
    89,
    '模拟复杂度',
    '模拟步数较多但每步开销小，时间复杂度常为？',
    JSON_OBJECT('A', 'O(steps)', 'B', 'O(1)', 'C', '取决于状态大小', 'D', '不可估计'),
    1,
    JSON_ARRAY('每步常量开销时整体线性增长'),
    '当每步开销为常量时，模拟总时间复杂度与步数线性相关。',
    'for _ in range(steps): update()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1333,
    89,
    '并行模拟',
    '若模拟的不同初始条件互不依赖，可否并行？',
    JSON_OBJECT('A', '可以并行以加速', 'B', '不能并行', 'C', '只可串行', 'D', '需要数据库'),
    1,
    JSON_ARRAY('独立任务可并行化以提升吞吐'),
    '相互独立的模拟任务可放到进程池并行执行以加速整体计算。',
    'Pool.map(simulate, params)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1334,
    89,
    '保存检查点',
    '补全：长时间模拟中定期保存检查点以便恢复。',
    NULL,
    JSON_ARRAY('(none)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if step % 1000 == 0:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    save("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '定期保存检查点可以在程序崩溃时从中恢复，避免重头运行。',
    'pickle.dump(state, f)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1335,
    89,
    '效率与准确性',
    '补全：在近似模拟中说明何时接受近似结果并停止细粒度模拟。',
    NULL,
    JSON_ARRAY('(none)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "# pseudo: 如果误差 < eps 则停止并返回近似结果"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '在能容忍误差的场景下可使用近似并在误差满足条件时提前终止模拟以节省资源。',
    'if abs(cur - target) < eps: break'
);