USE `questions`;
-- Unit 119 | Start ID: 1771
-- Generated at 2025-12-24 18:17:27

INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1771, 
    119, 
    '缓存的目标', 
    '使用缓存（caching）的主要目的是？', 
    JSON_OBJECT('A', '减少重复计算或重复 I/O，从而提高响应速度', 'B', '增加内存占用无收益', 'C', '确保数据最新', 'D', '替代数据库'), 
    1, 
    JSON_ARRAY('缓存保存之前计算的结果', '重复请求命中缓存可节省时间', '需权衡一致性与空间'), 
    '缓存通过保存昂贵操作的结果提高性能，但需处理缓存失效与一致性问题。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1772, 
    119, 
    'lru_cache', 
    'Python 的 functools.lru_cache 默认按什么策略回收？', 
    JSON_OBJECT('A', '最近最少使用（LRU）', 'B', '随机', 'C', '先进先出（FIFO）', 'D', '最长时间未访问'), 
    1, 
    JSON_ARRAY('lru_cache 意为最近最少使用缓存', '容量满时驱逐 LRU 条目', '可配置 maxsize'), 
    'functools.lru_cache 使用 LRU 策略来管理缓存条目，适合具有局部性访问模式的函数。', 
    '@lru_cache(maxsize=128)
def f(x): return x*x'
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1773, 
    119, 
    'Cache key 设计', 
    '为函数缓存设计 key 时，应优先考虑？', 
    JSON_OBJECT('A', '可哈希且能唯一标识调用参数', 'B', '尽量复杂以防碰撞', 'C', '只用对象 id', 'D', '随意字符串'), 
    1, 
    JSON_ARRAY('key 应该是可哈希的', '能唯一表示参数组合', '使用序列化或元组表示参数'), 
    '缓存 key 必须唯一且可哈希，以确保相同输入命中相同缓存。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1774, 
    119, 
    '分布式缓存', 
    '使用 Redis 等分布式缓存的好处是？', 
    JSON_OBJECT('A', '跨进程与跨机器共享缓存', 'B', '自动提高一致性', 'C', '永远不需要失效策略', 'D', '总比本地缓存更快'), 
    1, 
    JSON_ARRAY('Redis 可被多个服务实例共享', '需要考虑网络延迟与可用性', '适合横向扩展场景'), 
    '分布式缓存支持多实例共享数据，但需考虑网络开销、序列化与一致性方案。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1775, 
    119, 
    '缓存穿透', 
    '缓存穿透通常指什么问题？', 
    JSON_OBJECT('A', '大量请求绕过缓存打到后端，造成压力', 'B', '缓存被恶意清空', 'C', '内存泄漏', 'D', '缓存自动修复'), 
    1, 
    JSON_ARRAY('请求的 key 从未缓存或频繁失效', '可能因参数多样化导致低命中率', '可通过布隆过滤器等缓解'), 
    '缓存穿透指缓存失效或未命中的请求直接到达后端，可能引发压垮后端的问题。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1776, 
    119, 
    'Cache Aside 模式', 
    'Cache Aside 模式的关键步骤是？', 
    JSON_OBJECT('A', '应用先查缓存，未命中再查数据库并回填缓存', 'B', '数据库主动推送到缓存', 'C', '缓存承担主存储', 'D', '禁用数据库'), 
    1, 
    JSON_ARRAY('先读缓存再落库', '写操作需同步更新或删除缓存', '简单且常用'), 
    'Cache Aside 模式由应用控制缓存读写，未命中时回源并回填缓存。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1777, 
    119, 
    'memoization 风险', 
    '使用 memoization（记忆化）缓存函数结果时需注意？', 
    JSON_OBJECT('A', '缓存大小与内存增长，慎重处理可变参数', 'B', '一定提高性能', 'C', '能自动管理失效', 'D', '不适合纯函数'), 
    1, 
    JSON_ARRAY('memoization 适合纯函数', '可变参数不能直接作为 key', '需考虑缓存清理策略'), 
    'memoization 要求 key 设计合理且须控制缓存大小以避免内存问题。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1778, 
    119, 
    '缓存击穿', 
    '缓存击穿通常发生在什么情况下？', 
    JSON_OBJECT('A', '热点 key 在缓存失效瞬间大量并发请求同时回源', 'B', '缓存命中率极高', 'C', '缓存从未被访问', 'D', '数据一致'), 
    1, 
    JSON_ARRAY('热点 key 失效会造成短时间洪峰', '可用互斥锁或单线程回源避免', '预热或错峰失效可缓解'), 
    '缓存击穿是热点 key 过期导致短时间大量回源，需用互斥回源或互斥锁防护。', 
    ''
);
INSERT INTO `que_choice_py_1` 
(`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES (
    1779, 
    119, 
    '本地缓存 vs 分布式', 
    '本地内存缓存相对于分布式缓存的优点是？', 
    JSON_OBJECT('A', '访问延迟低、实现简单', 'B', '可跨实例共享', 'C', '天然一致性', 'D', '无限容量'), 
    1, 
    JSON_ARRAY('本地访问速度快', '受限于单实例内存', '需处理跨实例一致性'), 
    '本地缓存提供最低延迟但无法跨实例共享，适合低一致性或单机场景。', 
    ''
);

-- ---------- 填空题 ----------
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1780,
    119,
    '缓存代价（填空）',
    '引入缓存会带来的代价主要包括？',
    NULL,
    JSON_ARRAY('内存使用、缓存维护与一致性管理'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"内存使用、缓存维护与一致性管理\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '缓存占用额外内存并可能需要过期/失效策略，以及缓存命中率低时浪费资源。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1781,
    119,
    '失效策略（填空）',
    '常见的缓存失效策略包括哪些？',
    NULL,
    JSON_ARRAY('TTL、LRU、手动清理、写时回收'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"TTL、LRU、手动清理、写时回收\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    'TTL（过期时间）、LRU、基于大小的回收或应用触发的清理是常见策略。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1782,
    119,
    '缓存雪崩（填空）',
    '缓存雪崩是指什么情况？',
    NULL,
    JSON_ARRAY('大量缓存同时失效导致后端瞬时洪峰'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"大量缓存同时失效导致后端瞬时洪峰\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '当大量缓存条目同时过期或被清空，会有大量请求打到后端，造成雪崩效应。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1783,
    119,
    '缓存一致性（填空）',
    '对写操作保持缓存一致性的常见策略包括？',
    NULL,
    JSON_ARRAY('写入时更新/删除缓存或使用消息通知失效'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"写入时更新/删除缓存或使用消息通知失效\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '常见策略有写时更新、写时删除、异步失效通知或短 TTL。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1784,
    119,
    '实践建议（填空）',
    '在引入缓存前应先做什么？',
    NULL,
    JSON_ARRAY('识别热点、基准测试并评估一致性需求'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"识别热点、基准测试并评估一致性需求\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '在设计缓存前应识别热点、评估一致性需求并通过基准测试验证收益。',
    ''
);
INSERT INTO `que_fill_py_1`
(`q_id`, `unit_id`, `title`, `text`, `input`, `output`, `code`, `options`, `answer`, `explanation`, `example`)
VALUES (
    1785,
    119,
    '总结（填空）',
    '缓存设计的核心权衡点是？',
    NULL,
    JSON_ARRAY('性能、内存与一致性之间的权衡'),
    '{"segments": [{"type": "code_block", "lines": [{"type": "code_line", "value": "print(\"性能、内存与一致性之间的权衡\")"}]}]}',
    JSON_ARRAY(),
    JSON_ARRAY(0),
    '缓存需在性能提升、内存占用与数据一致性之间做权衡，并设计失效策略。',
    ''
);