USE `questions`;
-- Unit 79 | Start ID: 1171
-- Generated at 2025-12-24 18:05:44

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1171, 
    79, 
    '输入验证', 
    '在循环中处理用户输入前应先做？', 
    JSON_OBJECT('A', '验证与清洗', 'B', '直接使用', 'C', '只在出错时处理', 'D', '用 assert'), 
    1, 
    JSON_ARRAY('验证可以防止异常', '清洗保证数据格式一致'), 
    '对输入数据进行验证和预处理可以降低后续处理错误概率。', 
    's = s.strip(); if not s: continue'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1172, 
    79, 
    '正则使用', 
    '复杂字符串清洗适合使用？', 
    JSON_OBJECT('A', '正则表达式', 'B', '纯字符串方法总是优', 'C', 'eval', 'D', '手动字符拆分'), 
    1, 
    JSON_ARRAY('正则灵活适合复杂模式匹配', '注意可读性'), 
    '正则表达式适合复杂模式匹配和清洗任务，但注意性能与可读性。', 
    'import re'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1173, 
    79, 
    '空白处理', 
    '想删除每行首尾空白应使用？', 
    JSON_OBJECT('A', 'strip', 'B', 'split', 'C', 'replace', 'D', 'rstrip only'), 
    1, 
    JSON_ARRAY('strip 去除两端空白', '便于统一判断'), 
    'strip 是清理首尾空白的常用方法。', 
    'line = line.strip()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1174, 
    79, 
    '默认值', 
    '缺失字段用默认值应在何处处理？', 
    JSON_OBJECT('A', '在循环读取处补默认值', 'B', '在最后报告时补', 'C', '不补', 'D', '打印错误'), 
    1, 
    JSON_ARRAY('尽早处理能减少后续判断复杂性'), 
    '在读取或解析处立即补齐默认值可以让后续逻辑更简单。', 
    'value = data.get("k", default)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1175, 
    79, 
    '批量校验', 
    '大量数据需要校验时应首选？', 
    JSON_OBJECT('A', '流式校验并分批处理', 'B', '一次性校验所有数据', 'C', '手动人工检查', 'D', '只校验前 N 条'), 
    1, 
    JSON_ARRAY('分批处理更节省内存和时间', '方便分段回滚'), 
    '流式或分批校验可以降低内存占用并便于逐步处理错误数据。', 
    'process in chunks'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1176, 
    79, 
    '数据标准化', 
    '在循环中对字段进行标准化（如小写、去空格）应在什么时候做？', 
    JSON_OBJECT('A', '尽早标准化', 'B', '延迟到最后', 'C', '不需要标准化', 'D', '只在输出时标准化'), 
    1, 
    JSON_ARRAY('统一格式便于后续比较和处理'), 
    '标准化通常在数据读取阶段进行以便后续一致处理。', 
    's = s.strip().lower()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1177, 
    79, 
    '缺失值标识', 
    '常用的缺失值标识是？', 
    JSON_OBJECT('A', '空字符串或 None', 'B', '-99999', 'C', '0', 'D', '任意字符'), 
    1, 
    JSON_ARRAY('统一标识便于检测和替换'), 
    '使用空字符串或 None 更语义化，便于判断与替换。', 
    'if val == "" or val is None:'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1178, 
    79, 
    '多字段校验', 
    '校验多字段关联规则时应注意？', 
    JSON_OBJECT('A', '顺序和依赖关系', 'B', '只校验单字段', 'C', '不需要校验', 'D', '总是用正则'), 
    1, 
    JSON_ARRAY('某些字段值依赖于其他字段', '按依赖顺序校验更稳健'), 
    '当字段间存在依赖时需按正确顺序校验并处理。', 
    'if a and not b: error'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1179, 
    79, 
    '缺陷跟踪', 
    '遇到可复现的脏数据应？', 
    JSON_OBJECT('A', '记录样本并上报', 'B', '忽略', 'C', '直接删除所有数据', 'D', '重启服务'), 
    1, 
    JSON_ARRAY('保留样本便于分析根因并修复'), 
    '记录样本和上下文便于开发和运维定位并修复数据源问题。', 
    'write sample to log'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1180,
    79,
    '合法数字',
    '补全：判断字符串是否为整数并打印。',
    '1 a 2',
    JSON_ARRAY('1', '2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for s in input().split():"}, {"type": "code_line", "value": "    try:"}, {"type": "code_line", "value": "        print(int(s))"}, {"type": "code_line", "value": "    except ValueError:"}, {"type": "code_line", "value": "        continue"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用 try/except 检测能否转换为整数表示合法数字。',
    'except ValueError:'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1181,
    79,
    '去除重复',
    '补全：循环中去除重复行并保持原顺序。',
    'a b a',
    JSON_ARRAY('a b'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "seen=set()"}, {"type": "code_line", "value": "res=[]"}, {"type": "code_line", "value": "for s in input().split():"}, {"type": "code_line", "value": "    if s not in seen:"}, {"type": "code_line", "value": "        seen.add(s)"}, {"type": "code_line", "value": "        res.append(s)"}, {"type": "code_line", "value": "print(*res)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用集合记录已见元素以去除重复并用列表保持顺序。',
    'seen.add(x)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1182,
    79,
    '过滤非法字符',
    '补全：移除字符串中的非字母字符并打印。',
    'a1b!',
    JSON_ARRAY('ab'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "s=input()"}, {"type": "code_line", "value": "print(\"\".join(ch for ch in s if ch.isalpha()))"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 isalpha 筛选仅保留字母字符。',
    'ch.isalpha()'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1183,
    79,
    '字段拆分',
    '补全：把逗号分隔行拆分并打印第二列。',
    'a,1
b,2',
    JSON_ARRAY('1', '2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for line in input().splitlines():"}, {"type": "code_line", "value": "    parts=line.split(\",\")"}, {"type": "code_line", "value": "    if len(parts)>1:"}, {"type": "code_line", "value": "        print(parts[1])"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用 split 分割并检查列数避免越界。',
    'line.split(",")'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1184,
    79,
    '移除空字段',
    '补全：读取二列数据，若第二列为空则输出默认值。',
    'a,
b,c',
    JSON_ARRAY('a,default', 'b,c'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for line in input().splitlines():"}, {"type": "code_line", "value": "    k,v=(line.split(\",\") + [\"\"])[:2]"}, {"type": "code_line", "value": "    if not v:"}, {"type": "code_line", "value": "        v=\"default\""}, {"type": "code_line", "value": "    print(k+\",\"+v)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '通过补齐列表长度并判空实现默认值替换。',
    'parts = line.split(",") + [""]'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1185,
    79,
    '字段类型转换',
    '补全：把第二列转换为整数，失败时设为 0。',
    'a,1
b,x',
    JSON_ARRAY('1', '0'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "for line in input().splitlines():"}, {"type": "code_line", "value": "    parts=line.split(\",\")"}, {"type": "code_line", "value": "    try:"}, {"type": "code_line", "value": "        print(int(parts[1]))"}, {"type": "code_line", "value": "    except Exception:"}, {"type": "code_line", "value": "        print(0)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '用 try/except 处理转换失败并给出默认值。',
    'except ValueError: print(0)'
);