USE `questions`;
-- Unit 78 | Start ID: 1156
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1156,
    78,
    '避免重复计算',
    '当循环中多次使用同一表达式结果时应？',
    JSON_OBJECT('A', '提前计算并缓存', 'B', '每次重复计算', 'C', '使用递归替代', 'D', '编译为 C'),
    1,
    JSON_ARRAY('缓存结果减少重复开销', '局部变量更快'),
    '将不变计算移出循环或缓存到局部变量可以显著提高性能。',
    'v = expensive(); for x in items: use(v)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1157,
    78,
    '内建函数',
    '在循环内使用内建函数与手写循环相比，通常？',
    JSON_OBJECT('A', '更快或相当', 'B', '总是更慢', 'C', '不可用', 'D', '编译错误'),
    1,
    JSON_ARRAY('内建函数用 C 实现通常更快', '尽量使用 map/sum 等内建函数'),
    '内建函数在多数情况下比 Python 级的逐项处理更高效。',
    'sum(lst) vs loop'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1158,
    78,
    '甚少重新分配',
    '在循环中频繁扩展列表会导致？',
    JSON_OBJECT('A', '可能多次重新分配导致性能下降', 'B', '没有影响', 'C', 'Python 自动优化', 'D', '内存泄露'),
    1,
    JSON_ARRAY('预分配或使用生成器可减少 realloc 次数'),
    '频繁修改可变容器可能触发多次内存重新分配，影响性能。',
    'use append but consider size'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1159,
    78,
    '局部变量速度',
    '补全：在循环中引用局部变量比全局变量更快的理由。',
    NULL,
    JSON_ARRAY('(none)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "# 将全局 g 赋给本地变量以加速"}, {"type": "code_line", "value": "g = 0"}, {"type": "code_line", "value": "for i in range(100000):"}, {"type": "code_line", "value": "    local_g = g"}, {"type": "code_line", "value": "    x = local_g + i"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '局部变量访问比全局变量快，可减少查找开销。',
    'local = global_var'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1160,
    78,
    '使用列表推导',
    '补全：用列表推导替代循环构建列表示例。',
    JSON_ARRAY('1 2 3'),
    JSON_ARRAY('2 4 6'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}, {"type": "code_line", "value": "res=[x*2 for x in lst]"}, {"type": "code_line", "value": "print(*res)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '列表推导通常比显式循环更简洁且性能更好。',
    '[f(x) for x in it]'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1161,
    78,
    '生成器节省内存',
    '需要逐个处理而无需随机访问序列时应使用？',
    JSON_OBJECT('A', '生成器', 'B', 'list', 'C', 'tuple', 'D', 'set'),
    1,
    JSON_ARRAY('生成器按需产出元素', '节省内存'),
    '生成器惰性生成元素，适合流式处理大数据集。',
    '(x for x in range(1000000))'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1162,
    78,
    'profile 优先',
    '在优化前应先做什么？',
    JSON_OBJECT('A', '用 profiler 找瓶颈', 'B', '直接优化代码', 'C', '猜测热点优化', 'D', '增加注释'),
    1,
    JSON_ARRAY('测量胜于猜测', '定位真正耗时部分'),
    '先用 profiler 找到真正的性能瓶颈再针对性优化。',
    'import cProfile'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1163,
    78,
    '避免过早优化',
    '何时应避免过早优化？',
    JSON_OBJECT('A', '需求未明确或代码尚未正确', 'B', '任何时候都应优化', 'C', '永远不优化', 'D', '只有在 C 中优化'),
    1,
    JSON_ARRAY('先保证正确，再优化', '优化前需有测量结果'),
    '先实现正确逻辑并有性能数据再优化，可避免无谓工作。',
    'profile then optimize'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1164,
    78,
    '用 join 优化',
    '补全：在循环中构造多段文本最后输出的推荐方法。',
    JSON_ARRAY('a b c'),
    JSON_ARRAY('a b c'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "parts=input().split()"}, {"type": "code_line", "value": "print(\\" \\".join(parts))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '收集片段后用 join 一次性输出比频繁 print 更高效。',
    '" ".join(list)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1165,
    78,
    '避免重复方法查找',
    '补全：将对象方法绑定到局部变量以加速循环。',
    JSON_ARRAY('1 2 3'),
    JSON_ARRAY('(doubled)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}, {"type": "code_line", "value": "ap=lst.append"}, {"type": "code_line", "value": "for x in [1,2,3]:"}, {"type": "code_line", "value": "    ap(x)"}, {"type": "code_line", "value": "print(lst)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '把方法绑定为局部变量减少属性查找开销。',
    'm = obj.method; for ...: m()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1166,
    78,
    'numpy 使用场景',
    '大量数值运算用原生 Python 循环 vs numpy，推荐？',
    JSON_OBJECT('A', 'numpy 向量化', 'B', '原生循环总是更好', 'C', '两者一样', 'D', 'numpy 只适用于图像'),
    1,
    JSON_ARRAY('numpy 用 C 实现向量化更快', '适合大规模数值计算'),
    '对大规模数值运算，numpy 向量化通常远快于 Python 循环。',
    'import numpy as np'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1167,
    78,
    '算法复杂度',
    '对大 N 问题，优化循环更重要还是优化算法更重要？',
    JSON_OBJECT('A', '优化算法通常更关键', 'B', '循环优化总能解决问题', 'C', '微优化优先', 'D', '都无关紧要'),
    1,
    JSON_ARRAY('算法级别降阶收益更大', '先考虑算法复杂度'),
    '通常改进算法复杂度带来的性能提升要远超微观循环优化。',
    '从 O(n^2) 到 O(n log n)'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1168,
    78,
    '缓存技巧',
    '在循环中复用计算结果时常用的技巧是？',
    JSON_OBJECT('A', '字典缓存（memoization）', 'B', '每次都计算', 'C', '写成注释', 'D', '换语言'),
    1,
    JSON_ARRAY('memoization 可降低重复计算开销'),
    '利用字典缓存中间结果能避免重复的昂贵计算。',
    'cache = {}; if x in cache: ...'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1169,
    78,
    '简单并行化',
    '补全：利用 multiprocessing 简单并行化循环任务。',
    NULL,
    JSON_ARRAY('(none)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from multiprocessing import Pool"}, {"type": "code_line", "value": "def f(x): return x*2"}, {"type": "code_line", "value": "with Pool() as p:"}, {"type": "code_line", "value": "    print(p.map(f, [1,2,3]))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '对 CPU 密集型任务可考虑进程池并行化循环处理。',
    'Pool().map(func, data)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1170,
    78,
    '避免全局锁',
    '补全：多线程中 GIL 对 CPU 密集型循环的影响，推荐？',
    NULL,
    JSON_ARRAY('(none)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "# 对于 CPU 密集型任务建议使用 multiprocessing 而非 threading"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'Python 的 GIL 限制了多线程的 CPU 并行，CPU 密集型推荐多进程。',
    'use multiprocessing'
);