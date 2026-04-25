USE `questions`;
-- Unit 88 | Start ID: 1306
-- Generated at 2025-12-24 22:14:38

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1306, 
    88, 
    '组合题目', 
    '复杂题通常由哪些知识点组合？', 
    JSON_OBJECT('A', '循环 + 条件 + 数据结构', 'B', '仅循环', 'C', '仅字符串', 'D', '仅数学'), 
    1, 
    JSON_ARRAY('综合题常融合多个知识点'), 
    '复杂题往往要求将循环、条件判断和数据结构等结合使用。', 
    'use list/dict in loops'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1307, 
    88, 
    '分解策略', 
    '遇到复杂循环问题首步应做什么？', 
    JSON_OBJECT('A', '分解为子步骤并逐步实现', 'B', '直接写一个超长循环', 'C', '用递归完全替代', 'D', '放弃'), 
    1, 
    JSON_ARRAY('分解能降低复杂度并便于调试'), 
    '分解问题有助于逐步实现并验证每个子步骤的正确性。', 
    'write small helper functions'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1308, 
    88, 
    '边界检查', 
    '在组合操作中忘记做边界检查通常会导致？', 
    JSON_OBJECT('A', '索引错误或异常', 'B', '更快执行', 'C', '内存减少', 'D', '无影响'), 
    1, 
    JSON_ARRAY('注意空列表和越界情况'), 
    '边界条件缺失常导致越界访问或异常，需要专门考虑。', 
    'if not lst: continue'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1309, 
    88, 
    '双指针', 
    '双指针技巧常用于？', 
    JSON_OBJECT('A', '有序数组的查找或窗口问题', 'B', '只适用于链表', 'C', '递归替代', 'D', '排序'), 
    1, 
    JSON_ARRAY('双指针能在 O(n) 内完成某些任务'), 
    '双指针在有序数组或字符串中常用于寻找满足条件的下标对或窗口。', 
    'i,j pointers'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1310, 
    88, 
    '频率映射', 
    '在循环中统计并查询频率推荐数据结构？', 
    JSON_OBJECT('A', '字典或 Counter', 'B', 'list 总是', 'C', 'set', 'D', 'tuple'), 
    1, 
    JSON_ARRAY('哈希表提供快速计数与查询'), 
    '字典用于频率统计并能在循环中快速查询和更新。', 
    'd[x]=d.get(x,0)+1'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1311, 
    88, 
    '分治与循环', 
    '复杂问题可以用分治替代循环吗？', 
    JSON_OBJECT('A', '有时可用但需权衡', 'B', '从不使用', 'C', '性能总更优', 'D', '等价'), 
    1, 
    JSON_ARRAY('分治可降低复杂度但实现更复杂'), 
    '分治可能带来算法复杂度改进，但需根据具体问题权衡实现复杂性。', 
    'merge sort idea'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1312, 
    88, 
    '避免重复', 
    '在组合问题中避免重复解常用技巧是？', 
    JSON_OBJECT('A', '排序并跳过相同元素', 'B', '不处理', 'C', '用 set 记录所有序列', 'D', '仅用于小数据'), 
    1, 
    JSON_ARRAY('排序 + 跳过是常见去重方法'), 
    '通过对输入排序并在循环中跳过相同元素可避免生成重复解。', 
    'if i>0 and a[i]==a[i-1]: continue'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1313, 
    88, 
    '贪心可行性', 
    '使用贪心策略前应先？', 
    JSON_OBJECT('A', '证明其正确性或贪心选择性质', 'B', '直接使用不考虑证明', 'C', '总是正确', 'D', '不需要验证'), 
    1, 
    JSON_ARRAY('贪心需证明局部最优导致全局最优'), 
    '在使用贪心前必须确认问题满足贪心选择性质或证明其正确性。', 
    'greedy proof sketch'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1314, 
    88, 
    '模拟题', 
    '复杂题型中模拟问题常指？', 
    JSON_OBJECT('A', '按题目规则逐步模拟状态变化', 'B', '用公式直接求解', 'C', '必须用递归', 'D', '不实用'), 
    1, 
    JSON_ARRAY('模拟可避免复杂数学推导'), 
    '模拟按规则迭代状态，适用于规则复杂但规模可控的题目。', 
    'simulate steps in loop'
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1315,
    88,
    '合并计数',
    '补全：统计每个单词出现频次并按频次输出。',
    'a b a',
    JSON_ARRAY('a 2', 'b 1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "from collections import Counter"}, {"type": "code_line", "value": "print(*Counter(input().split()).items())"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '使用 Counter 快速统计词频并输出。',
    'Counter(words)'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1316,
    88,
    '滑动窗口',
    '补全：计算长度为 k 的滑动窗口中最大和。',
    '5 2
1 3 2 5 4',
    JSON_ARRAY('9'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "n,k=map(int,input().split())"}, {"type": "code_line", "value": "arr=list(map(int,input().split()))"}, {"type": "code_line", "value": "cur=sum(arr[:k])"}, {"type": "code_line", "value": "mx=cur"}, {"type": "code_line", "value": "for i in range(k,n):"}, {"type": "code_line", "value": "    cur += arr[i]-arr[i-k]"}, {"type": "code_line", "value": "    mx = max(mx, cur)"}, {"type": "code_line", "value": "print(mx)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '滑动窗口可在 O(n) 时间内维护窗口和。',
    'sliding window'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1317,
    88,
    '合并有序列表',
    '补全：合并两个有序列表为有序结果。',
    '1 3
2 4',
    JSON_ARRAY('1 2 3 4'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "a=list(map(int,input().split()))"}, {"type": "code_line", "value": "b=list(map(int,input().split()))"}, {"type": "code_line", "value": "res=[]"}, {"type": "code_line", "value": "i=j=0"}, {"type": "code_line", "value": "while i<len(a) and j<len(b):"}, {"type": "code_line", "value": "    if a[i]<b[j]: res.append(a[i]); i+=1"}, {"type": "code_line", "value": "    else: res.append(b[j]); j+=1"}, {"type": "code_line", "value": "res += a[i:]+b[j:]"}, {"type": "code_line", "value": "print(*res)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '归并操作使用双指针实现线性时间合并。',
    'merge step'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1318,
    88,
    '计数子数组',
    '补全：统计和为 k 的长度为 2 的子数组数目（示例）。',
    '4 5 1 4
5',
    JSON_ARRAY('1'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "arr=list(map(int,input().split()))"}, {"type": "code_line", "value": "k=int(input())"}, {"type": "code_line", "value": "cnt=0"}, {"type": "code_line", "value": "for i in range(len(arr)-1):"}, {"type": "code_line", "value": "    if arr[i]+arr[i+1]==k:"}, {"type": "code_line", "value": "        cnt+=1"}, {"type": "code_line", "value": "print(cnt)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '枚举长度为 2 的子数组并计数满足条件的个数。',
    'sliding pairs'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1319,
    88,
    '窗口最大平均',
    '补全：计算长度为 k 的窗口最大平均值。',
    '5 2
1 2 3 4 5',
    JSON_ARRAY('4.5'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "n,k=map(int,input().split())"}, {"type": "code_line", "value": "arr=list(map(int,input().split()))"}, {"type": "code_line", "value": "cur=sum(arr[:k])"}, {"type": "code_line", "value": "mx=cur"}, {"type": "code_line", "value": "for i in range(k,n):"}, {"type": "code_line", "value": "    cur += arr[i]-arr[i-k]"}, {"type": "code_line", "value": "    mx = max(mx, cur)"}, {"type": "code_line", "value": "print(mx / k)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '滑动窗口维护窗口和并在每步更新最大和用于计算最大平均。',
    'sliding window average'
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1320,
    88,
    '复杂组合练习',
    '补全：判断序列中是否存在三数和为 0（简化版本）。',
    '-1 0 1 2 -1 -4',
    JSON_ARRAY('True'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "arr=list(map(int,input().split()))"}, {"type": "code_line", "value": "arr.sort()"}, {"type": "code_line", "value": "found=False"}, {"type": "code_line", "value": "for i in range(len(arr)-2):"}, {"type": "code_line", "value": "    l=i+1; r=len(arr)-1"}, {"type": "code_line", "value": "    while l<r:"}, {"type": "code_line", "value": "        s=arr[i]+arr[l]+arr[r]"}, {"type": "code_line", "value": "        if s==0: found=True; break"}, {"type": "code_line", "value": "        if s<0: l+=1"}, {"type": "code_line", "value": "        else: r-=1"}, {"type": "code_line", "value": "    if found: break"}, {"type": "code_line", "value": "print(found)"}]}]}',
    JSON_ARRAY('示例已给出'),
    JSON_ARRAY(0),
    '排序 + 双指针可在 O(n^2) 内查找三数和为 0 的组合。',
    'three sum'
);