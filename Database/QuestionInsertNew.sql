USE `questions`;

-- ========= 【选择题示例插入数据】 ==========
INSERT INTO `que_choice_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  (1, 1, 'Python 基础语法', '以下哪个选项是正确的 Python 打印语句？',
   JSON_OBJECT('A', 'echo("Hello World")', 'B', 'printf("Hello World")', 'C', 'print("Hello World")', 'D', 'System.out.println("Hello World")'),
   3,
   JSON_ARRAY('注意 Python 不需要分号', 'Python 使用 print 输出', '语法区分大小写'),
   'Python 使用 print() 函数输出内容，例如 print("Hello World")。',
   '示例：print("Hello World")');

INSERT INTO `que_choice_cpp_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  (1, 1, 'C++ 输出语句', '以下哪个选项可以正确输出 "Hello World"？',
   JSON_OBJECT('A', 'print("Hello World")', 'B', 'cout << "Hello World";', 'C', 'System.out.println("Hello World")', 'D', 'echo "Hello World"'),
   2,
   JSON_ARRAY('C++ 使用 cout', '输出语句末尾需加分号', '需要包含 iostream 头文件'),
   'C++ 中的输出语句为 cout << "Hello World"; 需要 #include <iostream>。',
   '示例：#include <iostream>\nusing namespace std;\nint main() { cout << "Hello World"; }');

INSERT INTO `que_choice_c_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  (1, 1, 'C 语言输出语句', '以下哪个选项能正确输出 "Hello World"？',
   JSON_OBJECT('A', 'printf("Hello World");', 'B', 'cout << "Hello World";', 'C', 'System.out.println("Hello World")', 'D', 'echo "Hello World"'),
   1,
   JSON_ARRAY('C 语言使用 printf', '语句末尾需加分号', '注意 include 头文件 stdio.h'),
   'C 语言使用 printf 输出字符串，需要包含 stdio.h。',
   '示例：#include <stdio.h>\nint main() { printf("Hello World"); return 0; }');

INSERT INTO `que_choice_java_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `hints`, `explanation`, `example`)
VALUES
  (1, 1, 'Java 输出语句', '以下哪个选项能在控制台输出 "Hello World"？',
   JSON_OBJECT('A', 'print("Hello World")', 'B', 'echo("Hello World")', 'C', 'System.out.println("Hello World")', 'D', 'printf("Hello World")'),
   3,
   JSON_ARRAY('Java 使用 System.out.println', '注意大小写区分', '语句末尾必须有分号'),
   'Java 的标准输出语句为 System.out.println("Hello World");',
   '示例：public class Main { public static void main(String[] args) { System.out.println("Hello World"); } }');


-- ========== 【填空题示例插入数据】 ==========
INSERT INTO `que_fill_py_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `example`)
VALUES
  (1, 1, '字符串拼接', 
   JSON_ARRAY("把两个字符串 s1 和 s2 连接并赋给变量 result：result = ", " + "),
   JSON_ARRAY("s1", "s2"),
   JSON_ARRAY(1, 2),
   'Python 中可直接用 + 号拼接字符串，如 result = s1 + s2。',
   '示例：s1 = "Hello"; s2 = "World"; result = s1 + s2');

INSERT INTO `que_fill_cpp_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `example`)
VALUES
  (1, 1, 'C++ 字符串拼接', 
   JSON_ARRAY("使用 string 类拼接两个字符串：result = ", " + "),
   JSON_ARRAY("s1", "s2"),
   JSON_ARRAY(1, 2),
   'C++ 中 string 类支持使用 + 运算符拼接字符串。',
   '示例：string s1 = "Hello", s2 = "World"; string result = s1 + s2;');

INSERT INTO `que_fill_c_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `example`)
VALUES
  (1, 1, 'C 字符串拼接', 
   JSON_ARRAY("使用 strcat 函数拼接字符串：", "(s1, s2);"),
   JSON_ARRAY("strcat"),
   JSON_ARRAY(1),
   'C 语言中使用 strcat 函数拼接字符串。',
   '示例：char s1[20] = "Hello "; char s2[] = "World"; strcat(s1, s2);');

INSERT INTO `que_fill_java_1`
  (`q_id`, `unit_id`, `title`, `text`, `options`, `answer`, `explanation`, `example`)
VALUES
  (1, 1, 'Java 字符串拼接', 
   JSON_ARRAY("拼接字符串 s1 与 s2：String result = ", " + "),
   JSON_ARRAY("s1", "s2"),
   JSON_ARRAY(1, 2),
   'Java 可使用 + 运算符拼接字符串。',
   '示例：String s1 = "Hello"; String s2 = "World"; String result = s1 + s2;');


-- -------------------------------------------------------------------------------------
USE `questions`;

-- =========================
-- que_choice_py_1: 再新增 2 道选择题（q_id = 2,3）
-- =========================
INSERT INTO `que_choice_py_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`hints`,`explanation`,`example`)
VALUES
(2, 1, 'Python 列表方法', '下面哪个方法会在列表末尾追加元素？',
 JSON_OBJECT('A','append()','B','push()','C','add()','D','insert()'),
 1,
 JSON_ARRAY('提示1：想想列表的API','提示2：append 用于末尾追加','提示3：insert 可以指定位置'),
 '参考：list.append(x) 将 x 加到列表末尾。',
 '示例：lst = [1,2]; lst.append(3) -> [1,2,3]');

INSERT INTO `que_choice_py_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`hints`,`explanation`,`example`)
VALUES
(3, 2, 'Python 字典访问', '获取字典中 key 对应值的安全方法是？',
 JSON_OBJECT('A','d[key]','B','d.get(key)','C','d.pop(key)','D','d.fetch(key)'),
 2,
 JSON_ARRAY('提示1：考虑 key 不存在的情况','提示2：get 可以设置默认值','提示3：pop 会移除键'),
 '解释：d.get(key, default) 在 key 不存在时返回 default，不抛异常。',
 '示例：d = {\"a\":1}; d.get(\"b\", 0) -> 0');

-- =========================
-- que_choice_cpp_1: 再新增 2 道选择题（q_id = 2,3）
-- =========================
INSERT INTO `que_choice_cpp_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`hints`,`explanation`,`example`)
VALUES
(2, 1, 'C++ 引用与指针', '下列哪项关于指针和引用的说法是正确的？',
 JSON_OBJECT('A','引用可以为 null','B','指针可以重新指向其他变量','C','引用占用不同大小内存','D','指针不能做算术运算'),
 2,
 JSON_ARRAY('提示1：引用初始化后不可改变绑定','提示2：指针可以指向不同地址','提示3：指针支持算术运算'),
 '解析：指针可以改变所指地址，引用一经绑定不可再绑定到其他对象。',
 '示例：int *p; int &r = x;');

INSERT INTO `que_choice_cpp_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`hints`,`explanation`,`example`)
VALUES
(3, 2, 'C++ STL 容器', '哪个容器支持随机访问并且连续存储？',
 JSON_OBJECT('A','std::list','B','std::vector','C','std::forward_list','D','std::map'),
 2,
 JSON_ARRAY('提示1：想想底层存储方式','提示2：vector 在内存中连续排列元素','提示3：list 使用链表结构'),
 '解析：std::vector 提供连续内存和随机访问（operator[]）。',
 '示例：std::vector<int> v = {1,2,3}; v[1] -> 2');

-- =========================
-- que_choice_c_1: 再新增 2 道选择题（q_id = 2,3）
-- =========================
INSERT INTO `que_choice_c_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`hints`,`explanation`,`example`)
VALUES
(2, 1, 'C 指针与数组', '表达式 arr 与 &arr[0] 的区别是什么？',
 JSON_OBJECT('A','类型不同但地址相同','B','完全相同','C','arr 返回值是数组拷贝','D','&arr[0] 是非法表达式'),
 1,
 JSON_ARRAY('提示1：关注类型和值类别','提示2：arr 在表达式中退化为指针','提示3：&arr[0] 的类型是指向元素的指针'),
 '解析：arr 在大多数表达式中退化为指向首元素的指针，类型语义上有区别但地址相同。',
 '示例：int arr[3]; arr == &arr[0] 为真');

INSERT INTO `que_choice_c_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`hints`,`explanation`,`example`)
VALUES
(3, 2, 'C 字符串操作', '以下哪个函数是安全地复制字符串（带长度限制）的示例？',
 JSON_OBJECT('A','strcpy','B','strncpy','C','gets','D','scanf(\"%s\")'),
 2,
 JSON_ARRAY('提示1：注意边界检查','提示2：strncpy 接受长度参数','提示3：避免使用 gets'),
 '解析：strncpy 可以限制复制长度（仍需注意终止符处理）。',
 '示例：strncpy(dest, src, n);');

-- =========================
-- que_choice_java_1: 再新增 2 道选择题（q_id = 2,3）
-- =========================
INSERT INTO `que_choice_java_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`hints`,`explanation`,`example`)
VALUES
(2, 1, 'Java 集合框架', '下面哪个集合允许重复元素并且是有序的（插入顺序保留）？',
 JSON_OBJECT('A','HashSet','B','TreeSet','C','ArrayList','D','HashMap'),
 3,
 JSON_ARRAY('提示1：ArrayList 有索引并按插入顺序保存','提示2：Set 不允许重复','提示3：HashSet 无序'),
 '解析：ArrayList 允许重复并按插入顺序访问。',
 '示例：ArrayList<String> a = new ArrayList<>(); a.add(\"x\");');

INSERT INTO `que_choice_java_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`hints`,`explanation`,`example`)
VALUES
(3, 2, 'Java 异常层级', '下面关于 checked 异常的说法正确的是？',
 JSON_OBJECT('A','必须捕获或声明抛出','B','可以随意忽略','C','只在运行时抛出','D','与 Throwable 无关'),
 1,
 JSON_ARRAY('提示1：checked 异常是编译时强制处理的','提示2：查看 throws 声明','提示3：RuntimeException 属于 unchecked'),
 '解析：checked 异常必须在方法签名中 throws 或在方法内捕获。',
 '示例：public void foo() throws IOException { ... }');

-- =========================
-- 填空题（每个 fill 表再新增 2 道题，q_id = 2,3）
-- 注意：text 为 JSON_ARRAY 且不包含空字符串元素
-- =========================

-- que_fill_py_1: +2
INSERT INTO `que_fill_py_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`explanation`,`example`)
VALUES
(2, 1, '列表切片填空',
 JSON_ARRAY("给定列表 lst，获取从索引 1 到 3 的子列表可写为 ", "[1:4]"),
 JSON_ARRAY("lst","lst[1:4]","lst[1:3]"),
 JSON_ARRAY(2),
 '解释：Python 切片语法是 start:stop，stop 是不包含边界的索引。',
 '示例：lst = [0,1,2,3,4]; lst[1:4] -> [1,2,3]');

INSERT INTO `que_fill_py_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`explanation`,`example`)
VALUES
(3, 2, '字典取值填空',
 JSON_ARRAY("从字典 d 安全取 key 的值可用 ", ".get(key, default)"),
 JSON_ARRAY("d[key]","d.get(key, default)","d.pop(key)"),
 JSON_ARRAY(2),
 '解释：d.get 在 key 不存在时返回默认值而不抛异常。',
 '示例：d.get(\"x\", 0)');

-- que_fill_cpp_1: +2
INSERT INTO `que_fill_cpp_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`explanation`,`example`)
VALUES
(2, 1, '引用声明填空',
 JSON_ARRAY("声明一个整型引用 r 绑定到变量 x：", "&x;"),
 JSON_ARRAY("int &r = x","int r = &x","int *r = &x"),
 JSON_ARRAY(1),
 '解析：引用用 & 声明并直接初始化，例如 int &r = x;',
 '示例：int x = 5; int &r = x;');

INSERT INTO `que_fill_cpp_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`explanation`,`example`)
VALUES
(3, 2, 'vector 初始化填空',
 JSON_ARRAY("使用初始化列表创建 vector：std::vector<int> v = ", "{1,2,3};"),
 JSON_ARRAY("{1,2,3}","(1,2,3)","[1,2,3]"),
 JSON_ARRAY(1),
 '示例：std::vector<int> v = {1,2,3};',
 '示例用法：v.size() -> 3');

-- que_fill_c_1: +2
INSERT INTO `que_fill_c_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`explanation`,`example`)
VALUES
(2, 1, 'scanf 格式化填空',
 JSON_ARRAY("使用 scanf 读取整数的格式化字符串为 ", "\"%d\""),
 JSON_ARRAY("\"%d\"","\"%s\"","\"%f\""),
 JSON_ARRAY(1),
 '说明：%d 用于读取整数类型。',
 '示例：int x; scanf(\"%d\", &x);');

INSERT INTO `que_fill_c_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`explanation`,`example`)
VALUES
(3, 2, '指针取值填空',
 JSON_ARRAY("给定 int *p; 访问 p 指向的值用表达式 ", "*p"),
 JSON_ARRAY("*p","p*","p->val"),
 JSON_ARRAY(1),
 '说明：*p 解引用指针以获取其指向的值。',
 '示例：int a = 5; int *p = &a; *p -> 5');

-- que_fill_java_1: +2
INSERT INTO `que_fill_java_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`explanation`,`example`)
VALUES
(2, 1, '主函数签名填空',
 JSON_ARRAY("Java 应用入口 main 函数的标准签名为 ", "String[] args)"),
 JSON_ARRAY("public static void main(String[] args","public void main(String[] args)","static main(String[] args)"),
 JSON_ARRAY(1),
 '解析：标准签名为 public static void main(String[] args)。',
 '示例：public static void main(String[] args) { System.out.println(\"Hi\"); }');

INSERT INTO `que_fill_java_1`
(`q_id`,`unit_id`,`title`,`text`,`options`,`answer`,`explanation`,`example`)
VALUES
(3, 2, '数组声明填空',
 JSON_ARRAY("声明长度为 5 的整型数组：", " = new int[5];"),
 JSON_ARRAY("int[] a","int a[]","int a(5)"),
 JSON_ARRAY(1),
 '说明：Java 中数组声明可用 int[] a = new int[5];',
 '示例：int[] a = new int[5]; a.length -> 5');