USE `questions`;
-- Unit 67 | Start ID: 991
-- Generated at 2025-12-25 17:41:14

INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    991,
    67,
    'continue 的基本作用',
    '在循环中使用 continue 会？',
    JSON_OBJECT('A', '跳过本次剩余并进入下一次迭代', 'B', '退出循环', 'C', '终止程序', 'D', '回到函数开头'),
    1,
    JSON_ARRAY('跳过本次后续语句', '继续判断条件'),
    'continue 会立即开始下一次循环判断并跳过当前迭代剩余代码。',
    'if cond: continue'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    992,
    67,
    'continue 与 break 区别',
    '下面哪项是正确的区别？',
    JSON_OBJECT('A', 'continue 跳过本次，break 退出循环', 'B', '两者相同', 'C', 'continue 退出函数', 'D', 'break 跳过本次'),
    1,
    JSON_ARRAY('继续 vs 终止', '不同控制流影响'),
    'continue 跳过后续语句进入下一次循环，break 则直接退出循环。',
    'continue vs break'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    993,
    67,
    '使用场景',
    'continue 常用于？',
    JSON_OBJECT('A', '过滤不需要处理的情况', 'B', '提前退出函数', 'C', '替代 return', 'D', '声明变量'),
    1,
    JSON_ARRAY('如跳过无效数据', '保持循环结构简单'),
    '当要跳过某些不需要处理的迭代时使用 continue 更清晰。',
    'if invalid: continue'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    994,
    67,
    '跳过示例',
    '补全：遇到负数跳过打印。',
    JSON_ARRAY('1 -1 2'),
    JSON_ARRAY('1', '2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while i<3:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    v=int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if v<0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        continue"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'continue 跳过当前迭代中的打印语句。',
    'skip negative'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    995,
    67,
    '避免死循环',
    '补全：使用 continue 时也要保证更新计数器。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while i<3:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if cond:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        continue"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    do("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '即使使用 continue，计数器也应被更新以避免无限循环。',
    'update before continue'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    996,
    67,
    '可读性',
    '频繁使用 continue 会怎样？',
    JSON_OBJECT('A', '可能降低可读性', 'B', '没有影响', 'C', '提高逻辑透明度', 'D', '提升性能'),
    1,
    JSON_ARRAY('跳跃点过多使理解困难', '适度使用更佳'),
    '过多的 continue 会使代码执行路径跳跃，影响可读性。',
    'limit continue use'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    997,
    67,
    '与 for 一起用',
    '在 for 循环中使用 continue 会？',
    JSON_OBJECT('A', '跳到下一个迭代项', 'B', '退出整个循环', 'C', '报错', 'D', '重置迭代'),
    1,
    JSON_ARRAY('继续下一个元素', '常用于过滤'),
    '在 for 中 continue 用于跳过当前元素并进入下一个元素的处理。',
    'for x in seq: if cond: continue'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    998,
    67,
    '跟踪跳过次数',
    '若想统计被 continue 跳过的次数，应该？',
    JSON_OBJECT('A', '在跳过处增加计数器', 'B', '忽略', 'C', '在循环外统计', 'D', '无法统计'),
    1,
    JSON_ARRAY('在 continue 前递增计数', '记录跳过情形'),
    '在判断到跳过条件时递增计数器便能统计跳过次数。',
    'skips += 1; continue'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    999,
    67,
    '统计示例',
    '补全：统计负数个数并跳过它们。',
    JSON_ARRAY('1 -1 2 -2'),
    JSON_ARRAY('2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "skips=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while i<4:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    v=int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if v<0:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        skips+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        continue"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '在跳过处累加 skips 可以统计负数数量。',
    'count then continue'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1000,
    67,
    '位置重要性',
    '补全：将更新计数器放在合适位置避免跳过更新。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "i=0"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while i<3:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    i+=1"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if cond:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        continue"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    do("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '在可能 continue 的路径前更新计数器以保证不会无限循环。',
    'update counter early'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1001,
    67,
    '循环体复杂度',
    '当循环体很复杂时使用 continue 会？',
    JSON_OBJECT('A', '可能隐藏逻辑分支', 'B', '减少代码行数', 'C', '提高可读性', 'D', '自动化测试通过率提高'),
    1,
    JSON_ARRAY('跳过路径众多使逻辑难以全局把握'),
    '复杂循环中过度使用 continue 会使逻辑路径难以追踪，需谨慎。',
    'consider refactor'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1002,
    67,
    '替代方案',
    '不想用 continue 时可用？',
    JSON_OBJECT('A', '用条件分支将余下逻辑包起来', 'B', '删除循环', 'C', '增加更多 continue', 'D', '用异常'),
    1,
    JSON_ARRAY('显式条件可读性更高', '减少跳转点'),
    '用条件块包裹需要执行的逻辑能替代 continue，代码更直观。',
    'if not cond: do()'
);
INSERT INTO `que_choice_py_1`
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1003,
    67,
    'continue 与性能',
    '使用 continue 对性能有何影响？',
    JSON_OBJECT('A', '通常无明显负面影响', 'B', '会显著变慢', 'C', '会占用更多内存', 'D', '会抛错'),
    1,
    JSON_ARRAY('主要影响是可读性而非性能'),
    'continue 本身开销小，主要需关注循环体的操作。',
    'micro-bench not needed'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1004,
    67,
    '使用注释说明',
    '补全：在 continue 前写注释说明跳过原因。',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if invalid:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    # skip invalid entries"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    "}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '注释有助于后续维护者理解为什么跳过该分支。',
    '# reason for skip'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1005,
    67,
    '结合 break 使用',
    '补全：有时需要在满足条件时既跳过又退出，合理写法是？',
    NULL,
    NULL,
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "if cond_skip:"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    "}, {"type": "slot", "index": 0}, {"type": "code", "value": ""}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "elif cond_exit:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    break"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '通过明确分支分别处理跳过与退出使逻辑清晰。',
    'separate branches'
);