USE `questions`;
-- Unit 106 | Start ID: 1576
-- Generated at 2025-12-24 23:31:57

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1576, 
    106, 
    'map 返回类型', 
    '在 Python 3 中 map 返回什么类型？', 
    JSON_OBJECT('A', 'map 对象（可迭代），需转换为列表以显示全部', 'B', '列表', 'C', '字符串', 'D', '生成器且不可重用'), 
    1, 
    JSON_ARRAY('提示1：map 在 Python3 返回可迭代对象', '提示2：可用 list(map(...)) 得到列表', '提示3：与生成器类似但类型不同'), 
    'Python3 中 map 返回一个惰性可迭代的 map 对象，需 list() 才列出全部元素。', 
    'list(map(lambda x:x+1, [1,2]))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1577, 
    106, 
    'filter 用途', 
    'filter(fn, iterable) 的作用是？', 
    JSON_OBJECT('A', '返回满足 fn 条件的元素序列', 'B', '对每个元素应用 fn 并返回结果', 'C', '把 iterable 转为列表', 'D', '删除 iterable 中所有元素'), 
    1, 
    JSON_ARRAY('提示1：filter 会筛选元素', '提示2：结果是可迭代对象', '提示3：结合 lambda 很常用'), 
    'filter 返回满足指定函数条件的元素（惰性迭代）。', 
    'list(filter(lambda x: x>0, lst))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1578, 
    106, 
    'reduce 位置', 
    '从哪个模块导入 reduce？', 
    JSON_OBJECT('A', 'functools', 'B', 'itertools', 'C', 'collections', 'D', '内置函数直接可用'), 
    1, 
    JSON_ARRAY('提示1：reduce 在 functools 中', '提示2：Python 2 时 reduce 是内置的', '提示3：要 import functools.reduce'), 
    'reduce 在 Python3 被移到 functools 模块中，需导入使用。', 
    'from functools import reduce'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1579,
    106,
    'map 转列表（填空）',
    '把输入数字乘 2 并以列表形式打印。',
    '1 2',
    JSON_ARRAY('2 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "res = map(lambda x: x*2, lst)"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(*list("}, {"type": "slot", "index": 0}, {"type": "code", "value": "))"}]}]}',
    JSON_ARRAY('res', 'lst', 'map', 'iterable'),
    JSON_ARRAY(1),
    'map 返回可迭代对象，使用 list(res) 将其转换为列表后打印。',
    'print(*list(map(lambda x: x*2, [1,2])))'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1580,
    106,
    'filter 示例（填空）',
    '筛选出大于 0 的元素并打印。',
    '-1 2 -3 4',
    JSON_ARRAY('2 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(*list(filter(lambda x: "}, {"type": "slot", "index": 0}, {"type": "code", "value": ", lst)))"}]}]}',
    JSON_ARRAY('x>0', 'x<0', 'x==0', 'x!=0'),
    JSON_ARRAY(1),
    'filter 的 lambda 返回 True 时保留该元素。',
    'list(filter(lambda x: x>0, lst))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1581, 
    106, 
    'map 与列表推导对比', 
    'map(lambda x: x*2, lst) 与 [x*2 for x in lst] 相比，通常怎样选择？', 
    JSON_OBJECT('A', '推导可读性更好，map 在简单函数时也可用', 'B', 'map 永远更快', 'C', '推导无法用在可迭代对象上', 'D', 'map 返回列表'), 
    1, 
    JSON_ARRAY('提示1：列表推导语法更直观', '提示2：map 在函数已存在时可复用', '提示3：两者性能差异视情况'), 
    '列表推导通常更具可读性，而 map 在复用函数或与其他迭代器组合时也很有用。', 
    '[x*2 for x in lst]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1582, 
    106, 
    'reduce 用途', 
    'reduce 常用于什么操作？', 
    JSON_OBJECT('A', '将序列规约为单个值（如累加）', 'B', '过滤元素', 'C', '生成器创建', 'D', '列表复制'), 
    1, 
    JSON_ARRAY('提示1：reduce 接受二元函数累积结果', '提示2：用于求和、求乘积等', '提示3：与 sum 功能类似但更通用'), 
    'reduce 通过二元函数把序列规约为单个累计值。', 
    'reduce(lambda a,b: a+b, [1,2,3])'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1583, 
    106, 
    '惰性评估', 
    'map/filter 在 Python3 中为何被称为惰性？', 
    JSON_OBJECT('A', '它们返回惰性可迭代对象，按需生成元素', 'B', '它们延迟导入', 'C', '它们不会执行任何操作', 'D', '只有在打印时才有效'), 
    1, 
    JSON_ARRAY('提示1：只有消费时才会计算元素', '提示2：可以节省内存', '提示3：与生成器概念相似'), 
    'map/filter 返回惰性迭代器，只有在被遍历或转换为列表时才计算元素。', 
    'm = map(f, data)  # 未执行'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1584,
    106,
    '链式使用（填空）',
    '先 map 再 filter 并打印结果。',
    '1 2 3',
    JSON_ARRAY('4 8'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "res = map(lambda x: x*2, lst)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "res2 = filter(lambda x: x%4==0, res)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*list(res2))"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(),
    'map 生成的可迭代对象可直接被 filter 使用，最终转换为列表打印。',
    'list(filter(..., map(...)))'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1585,
    106,
    'reduce 求积（填空）',
    '用 reduce 计算列表元素乘积并打印。',
    '2 3 4',
    JSON_ARRAY('24'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from functools import reduce"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "from operator import mul"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(reduce("}, {"type": "slot", "index": 0}, {"type": "code", "value": ", lst))"}]}]}',
    JSON_ARRAY('mul', 'add', 'lambda a,b: a*b', 'lambda a,b: a+b'),
    JSON_ARRAY(1, 3),
    'reduce(mul, lst) 或 reduce(lambda a,b: a*b, lst) 可计算乘积。',
    'reduce(lambda a,b: a*b, [2,3,4])'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1586, 
    106, 
    'map 与多参数', 
    'map 可以接受多个可迭代对象吗？', 
    JSON_OBJECT('A', '可以，会并行取元素作为参数传入函数', 'B', '不可以，只能接受一个', 'C', '仅在 Python2 支持', 'D', '需要 itertools 才能实现'), 
    1, 
    JSON_ARRAY('提示1：map(f, a, b) 会把 a 和 b 对应元素作为 f 的参数', '提示2：短的可迭代导致提前终止', '提示3：常用于并行处理两个序列'), 
    'map 可接受多个可迭代对象，函数会接收对应位置的多个参数。', 
    'list(map(lambda x,y: x+y, [1,2], [3,4]))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1587, 
    106, 
    'filter None 作用', 
    'filter(None, iterable) 的行为是？', 
    JSON_OBJECT('A', '过滤掉所有 False 值（如 0, "", None）', 'B', '抛出异常', 'C', '返回同样的 iterable', 'D', '仅保留 None'), 
    1, 
    JSON_ARRAY('提示1：None 表示使用真值测试作为筛选条件', '提示2：常用于去除空元素', '提示3：保留真值元素'), 
    'filter(None, iterable) 会保留真值元素，过滤掉 falsey 值。', 
    'list(filter(None, [0,1,False,2,"",3]))'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1588, 
    106, 
    '可读性建议', 
    '当 map/filter 的 lambda 很复杂时应如何？', 
    JSON_OBJECT('A', '把逻辑抽成命名函数再使用', 'B', '保持在 lambda 中写所有逻辑', 'C', '改用匿名类', 'D', '用 eval 处理'), 
    1, 
    JSON_ARRAY('提示1：命名函数更易读与调试', '提示2：lambda 应保持简单', '提示3：文档化有助于维护'), 
    '复杂逻辑应封装为命名函数，提高可读性和可测试性。', 
    'def f(x): ...; map(f, lst)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1589,
    106,
    '组合示例（填空）',
    '用 map 和 filter 得到输入中偶数的两倍并打印。',
    '1 2 3 4',
    JSON_ARRAY('4 8'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "res = map(lambda x: x*2, filter(lambda x: x%2==0, lst))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*list(res))"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(),
    '先 filter 出偶数，再 map 乘以 2，最后转换为列表打印。',
    'list(map(lambda x: x*2, filter(lambda x: x%2==0, lst)))'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1590,
    106,
    'map with multiple iterables（填空）',
    '并行相加两列表并打印结果。',
    '1 2
3 4',
    JSON_ARRAY('4 6'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "b = list(map(int, input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*list(map(lambda x,y: x+y, a, b)))"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(),
    'map 可以接受多个可迭代对象并并行传递元素给函数。',
    'list(map(lambda x,y: x+y, [1,2],[3,4]))'
);