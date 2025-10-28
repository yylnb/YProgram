USE `questions`;

-- ========== 【选择题示例插入数据】 ==========
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