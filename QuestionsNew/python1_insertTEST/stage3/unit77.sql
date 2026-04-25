USE `questions`;
-- Unit 77 | Start ID: 1141
-- Generated at 2025-12-24 18:05:49

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1141, 
    77, 
    '捕获异常位置', 
    '在循环中处理可能抛出异常的操作时应如何做？', 
    JSON_OBJECT('A', '在循环内部 try/except 捕获', 'B', '不捕获让程序退出', 'C', '外层 try 捕获所有', 'D', '使用 assert'), 
    1, 
    JSON_ARRAY('局部捕获更细粒度', '可跳过有问题的项'), 
    '在循环内对可能出错的操作局部捕获异常可以保证循环继续处理其他项。', 
    'for x in lst:
  try:
    do(x)
  except: pass'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1142, 
    77, 
    '异常信息', 
    '要记录异常信息便于调试应使用？', 
    JSON_OBJECT('A', 'logging.exception', 'B', 'print 不记录', 'C', 'pass 忽略', 'D', 'assert'), 
    1, 
    JSON_ARRAY('logging.exception 会记录堆栈信息', '便于排查'), 
    '使用 logging.exception 可以记录异常的堆栈信息，方便后续调试。', 
    'except Exception as e:
  logging.exception(e)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1143, 
    77, 
    '细粒度捕获', 
    '应避免捕获哪种异常范围？', 
    JSON_OBJECT('A', '过于宽泛的 Exception', 'B', '具体的 ValueError', 'C', 'IOError', 'D', 'KeyError'), 
    1, 
    JSON_ARRAY('过宽的 except 难以发现真实错误', '捕获具体异常更安全'), 
    '捕获具体异常类型可以避免吞掉不相关的错误，使问题更易定位。', 
    'except ValueError:'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1144, 
    77, 
    '清理操作', 
    '循环内如果使用资源需要在异常后做清理，应使用？', 
    JSON_OBJECT('A', 'with 或 finally', 'B', '不需要清理', 'C', '仅用 return', 'D', '重新启动程序'), 
    1, 
    JSON_ARRAY('with 管理资源自动清理', 'finally 可在异常后执行'), 
    '使用 with 或 finally 确保资源在异常后也能被释放。', 
    'try:
  ...
finally:
  cleanup()'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1145, 
    77, 
    '跳出循环', 
    '遇到不可恢复的异常想停止循环应使用？', 
    JSON_OBJECT('A', 'raise 再抛出', 'B', 'pass', 'C', 'continue', 'D', '忽略'), 
    1, 
    JSON_ARRAY('通过 re-raise 让上层处理或终止程序', '便于集中处理'), 
    '遇到严重错误可重新抛出异常以终止循环并由外层处理。', 
    'except Exception:
  raise'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1146, 
    77, 
    '异常类型判断', 
    '当只想处理特定错误应？', 
    JSON_OBJECT('A', 'except SpecificError as e', 'B', 'except:', 'C', 'if error in e', 'D', '使用 type(e) 比较字符串'), 
    1, 
    JSON_ARRAY('捕获具体异常更安全', '可获得异常对象'), 
    '使用 except 指定异常类型并绑定变量可以更精确地处理错误。', 
    'except ValueError as e:'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1147, 
    77, 
    '调试 vs 处理', 
    '在循环中临时调试时可用？', 
    JSON_OBJECT('A', 'print 并继续', 'B', '永久用 print 替代 logging', 'C', '移除异常处理', 'D', '用 assert 作为生产代码'), 
    1, 
    JSON_ARRAY('print 便于临时查看', '生产环境用 logging'), 
    '开发时可用 print 快速排查，生产环境应使用 logging 并删除临时输出。', 
    'print("debug", x)'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1148, 
    77, 
    '异常频率', 
    '若循环中大量项都抛异常，说明？', 
    JSON_OBJECT('A', '输入数据可能有问题', 'B', '只个别项有问题', 'C', '逻辑正确无需关注', 'D', 'Python 有 bug'), 
    1, 
    JSON_ARRAY('检查输入数据或处理逻辑', '不要忽略大量异常'), 
    '频繁异常常提示数据或前置处理存在问题，应定位根因。', 
    'validate inputs first'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1149, 
    77, 
    '日志级别', 
    '用于记录错误堆栈信息的 logging 函数是？', 
    JSON_OBJECT('A', 'logging.exception', 'B', 'logging.info', 'C', 'logging.debug', 'D', 'logging.warning'), 
    1, 
    JSON_ARRAY('exception 会记录堆栈信息', '便于调试'), 
    'logging.exception 在处理异常的 except 块中记录堆栈信息并会自动包含异常信息。', 
    'except Exception: logging.exception("err")'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1150,
    77,
    '忽略错误继续',
    '补全：循环中遇到异常打印并继续处理。',
    '1 0 2',
    JSON_ARRAY('1', 'Error', '2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "nums=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for x in nums:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    try:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        print(10//x)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    except Exception as e:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        print(\"Error\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '对可能失败的运算进行 try/except 并在异常时处理后继续循环。',
    'except ZeroDivisionError:'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1151,
    77,
    '记录并跳过',
    '补全：遇到错误时记录并跳过当前项。',
    'a b 1',
    JSON_ARRAY('(logs)', '1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "items=input().split()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "import logging"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for it in items:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    try:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        v=int(it)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        print(v)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    except Exception as e:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        logging.error(f\"bad {it}\")"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 logging 记录问题项，保证循环不中断。',
    'logging.error(msg)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1152,
    77,
    '安全转换',
    '补全：将字符串列表安全转换为整数列表，忽略无法转换项。',
    '1 a 2',
    JSON_ARRAY('1 2'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "res=[]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for s in input().split():"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    try:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        res.append(int(s))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    except ValueError:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        continue"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(*res)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 try/except 处理单个转换失败以继续其他项。',
    'except ValueError:'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1153,
    77,
    '打印异常信息',
    '补全：打印异常的类型和信息。',
    'a 0',
    JSON_ARRAY('(error info)'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "try:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    x=int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(10//x)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "except Exception as e:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    print(type(e).__name__, e)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '通过 type(e).__name__ 能得到异常类型名，e 为异常实例信息。',
    'print(type(e), e)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1154,
    77,
    '安全索引访问',
    '补全：安全访问列表索引，索引越界时返回 None。',
    '1 2
3',
    JSON_ARRAY('3'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "lst=list(map(int,input().split()))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "i=int(input())"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(lst[i] if 0<=i<len(lst) else None)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '通过范围判断防止越界异常。',
    'if i<len(lst): print(lst[i]) else: print(None)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1155,
    77,
    '收集错误项',
    '补全：将出错的项保存到列表以便后续分析。',
    '1 a 2',
    JSON_ARRAY('(print valid)', '[a]'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "items=input().split()"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "errs=[]"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "for it in items:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    try:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        print(int(it))"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "    except Exception:"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "        errs.append(it)"}]}, {"type": "code_block", "lines": [{"type": "code_line", "value": "print(errs)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '收集错误项便于后续人工或自动分析。',
    'errs.append(bad)'
);