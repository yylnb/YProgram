USE `questions`;
-- Unit 86 | Start ID: 1276
-- Generated at 2025-12-24 23:25:15

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1276, 
    86, 
    '直接子串查找', 
    'Python 中查找子串最简单的方法是？', 
    JSON_OBJECT('A', 's.find(sub)', 'B', '手写循环比较', 'C', '用正则必须', 'D', '不可查找'), 
    1, 
    JSON_ARRAY('find 返回索引或 -1', '简单直接'), 
    '使用内建的 find 或 in 是查找子串的快捷方法。', 
    's.find("ab")'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1277, 
    86, 
    'in 操作', 
    '使用 in 判断子串是否存在会返回？', 
    JSON_OBJECT('A', '布尔值', 'B', '索引', 'C', '子串', 'D', '长度'), 
    1, 
    JSON_ARRAY('in 只判断存在性'), 
    'in 表达式返回 True/False，用于判断子串是否出现。', 
    '"a" in s'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1278, 
    86, 
    'KMP 作用', 
    'KMP 算法相比朴素搜索的优势是？', 
    JSON_OBJECT('A', '更少重复比较（线性时间）', 'B', '更难实现但慢', 'C', '空间更大', 'D', '只用于二进制'), 
    1, 
    JSON_ARRAY('KMP 利用前缀函数避免回退'), 
    'KMP 利用前缀函数在匹配失败时跳过不必要的比较，达到线性时间复杂度。', 
    'prefix function'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1279,
    86,
    '简单查找示例',
    '补全：判断子串存在并打印位置（首次）。',
    'abc
b',
    JSON_ARRAY('1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s=input().strip()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "sub=input().strip()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(s.find("}, {"type": "slot", "index": 0}, {"type": "code", "value": "))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'find 返回首次出现的索引或 -1。',
    's.find(sub)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1280,
    86,
    '使用 in',
    '补全：只判断是否存在并打印 Yes/No。',
    'hello
ll',
    JSON_ARRAY('Yes'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s=input().strip()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "sub=input().strip()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\"Yes\" if "}, {"type": "slot", "index": 0}, {"type": "code", "value": " in s else \"No\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    'in 用于判断子串存在性并返回布尔值。',
    'if sub in s:'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1281, 
    86, 
    '多次出现', 
    '要找出所有出现位置通常用？', 
    JSON_OBJECT('A', '循环 find 并指定起始位置', 'B', '一次 find 返回所有位置', 'C', '用 replace', 'D', 'in 即可'), 
    1, 
    JSON_ARRAY('可在上次索引基础上继续查找'), 
    '通过循环调用 find 并更新起始位置可找到所有出现位置。', 
    'pos = s.find(sub, pos+1)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1282, 
    86, 
    '正则优势', 
    '复杂模式匹配推荐使用？', 
    JSON_OBJECT('A', 're 模块', 'B', '手写循环', 'C', 'split', 'D', 'find'), 
    1, 
    JSON_ARRAY('正则支持复杂模式与分组'), 
    '对于复杂的模式匹配任务正则提供强大灵活的表达能力。', 
    'import re; re.findall()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1283, 
    86, 
    '边界条件', 
    '查找空子串的行为通常是？', 
    JSON_OBJECT('A', '认为存在并返回 0', 'B', '报错', 'C', '-1', 'D', 'None'), 
    1, 
    JSON_ARRAY('空串被认为在任何字符串中出现于索引 0'), 
    '空子串通常被认为在任何字符串中出现，find 返回 0。', 
    '"" in s -> True'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1284,
    86,
    '找全部位置',
    '补全：列出子串在主串中所有起始索引（空格分隔）。',
    'ababab
ab',
    JSON_ARRAY('0 2 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s=input().strip(); sub=input().strip();"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "pos= s.find("}, {"type": "slot", "index": 0}, {"type": "code", "value": ")"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "res=[]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "while pos!=-1:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    res.append(str(pos))"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "    pos = s.find("}, {"type": "slot", "index": 1}, {"type": "code", "value": ", pos+1)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\" \".join(res))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '循环查找并更新起始索引能获取所有出现位置。',
    'while find != -1'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1285,
    86,
    '重叠匹配',
    '补全：处理重叠匹配（如 "aaa" 中 "aa"）示例。',
    'aaa
aa',
    JSON_ARRAY('0 1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s=input().strip(); sub=input().strip();"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "res=[]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for i in range(len(s)-len(sub)+1):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    if s[i:i+len(sub)]==sub:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        res.append(str(i))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(\" \".join(res))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用滑动窗口可处理重叠匹配情形。',
    's[i:i+len(sub)]'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1286, 
    86, 
    '复杂度对比', 
    '朴素查找在最坏情况下时间复杂度为？', 
    JSON_OBJECT('A', 'O(n*m)', 'B', 'O(n)', 'C', 'O(log n)', 'D', 'O(1)'), 
    1, 
    JSON_ARRAY('n 为主串长度，m 为模式长度'), 
    '朴素的子串匹配在最坏情况会退回多次比较，复杂度为 O(n*m)。', 
    'nested loops'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1287, 
    86, 
    'KMP 前缀函数', 
    '前缀函数（next/π）用于？', 
    JSON_OBJECT('A', '跳过已匹配的前缀', 'B', '统计频率', 'C', '排序数组', 'D', '哈希'), 
    1, 
    JSON_ARRAY('前缀函数记录最长相等前后缀长度'), 
    '前缀函数用于在失配时决定模式应向右移动多少以继续匹配而不回溯主串。', 
    'compute lps array'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1288, 
    86, 
    '实现难度', 
    '相较于 find，KMP 的实现如何？', 
    JSON_OBJECT('A', '更复杂但更稳健', 'B', '更简单', 'C', '不能实现', 'D', '和 find 一样'), 
    1, 
    JSON_ARRAY('需要构造 lps 数组和状态机'), 
    'KMP 需构建前缀函数并实现状态迁移，代码复杂度高于内建 find。', 
    'compute lps'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1289,
    86,
    '使用 re',
    '补全：用正则查找所有匹配并打印位置。',
    'abab
ab',
    JSON_ARRAY('0 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "import re"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "s=input().strip()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "sub=input().strip()"}]}, {"type": "code_inline", "parts": [{"type": "code", "value": "print(\" \".join([str(m.start()) for m in re.finditer(\"(?={"}, {"type": "slot", "index": 0}, {"type": "code", "value": "})\".format(re.escape(sub)), s)]))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 lookahead 能发现重叠匹配的索引。',
    're.finditer'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1290,
    86,
    '简单 KMP 思路',
    '补全：构建前缀表（简略示例，伪代码）。',
    NULL,
    JSON_ARRAY('(none)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "# 伪代码示例"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "def prefix(s):"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    n=len(s)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    lps=[0]*n"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    # fill lps ..."}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    return lps"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '前缀表用于 KMP 的失配跳转，理解原理比记忆代码更重要。',
    'lps computation'
);