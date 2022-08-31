# 第三方库

| 名称       | 用途                    |
| ---------- | ----------------------- |
| num        | 处理复数等问题          |
| utf8_slice | 处理 UTF-8 字符串等问题 |

# 基础语法

## 基本变量声明

```rust
    // 变量 y 不可变, 类型自动被推导为 i32
    let y = 2;
    // 在变量名前添加 '_' 来表示该变量未被使用
    let _m = 3;
    // 显示指定类型
    let z: u32 = 1;
    // 通过使用 mut 关键字，使得 x 可变
    // 通过在数值后添加 _u32 来表示这是一个 uint32 类型的数值
    let mut x = 5_u32;
    x = x + 1;
    // 变量遮蔽, 第一个变量是 str 类型, 第二个 space 是 usize 类型，
    // 两者使用不同的内存空间
    let space = "   ";
    let space = space.len();
```

## 常量声明

```rust
    // 命名规范 ABC_DEF
    // 必须指定数据类型
    // 数字字面量可以使用 '_' 连接以提高可读性
    const MAX_POINTS: u32 = 100_000;
```

## 基本函数声明与使用

```rust
fn add(x: i32, y: i32) -> i32 {
    // 可以省略 return, 但是在结尾不能用 ';'
    x + y
    // 常规写法
    return x + y;
}

// rust fn 可以有多个返回值, () 表示整体返回
fn test(a: bool, b: bool) -> (bool, bool) {
    // () 表示整体返回
    (a,b)
}
// 多个返回值可以这样使用
// 全获取
let a = test(true, false); // 之后通过 a.0 或 a.1 访问
let (a, mut b) = test(true, false);
// _ 用于单个匹配
// 只获取两个返回值中的第一个并绑定到 a
let (a, _) = test(true, false);
// 只获取两个返回值中的第二个并绑定到 a
let (_, a) = test(true, false);
// .. 用于多个匹配
// 只获取第一个值并绑定到 a
let (a, ..) = test(true, false);
// 只获取最后一个值并绑定到 a
let (..,a) = test(true, false);

fn plus_or_minus(x:i32) -> i32 {
    if x > 5 {
        // 在 if 语句块中 return 需要使用 return
        return x - 5;
    }

    // 最后不需要 return
    x + 5
}
```

## 数值类型

| 长度       | 有符号类型 | 无符号类型 |
| ---------- | ---------- | ---------- |
| 8 位       | i8         | u8         |
| 16 位      | i16        | u16        |
| 32 位      | i32        | u32        |
| 64 位      | i64        | u64        |
| 128 位     | i128       | u128       |
| 视架构而定 | isize      | usize      |

```rust
    // 数字字面量
    // 十进制	98_222
    // 十六进制	0xff
    // 八进制	0o77
    // 二进制	0b1111_0000
    // 字节 (仅限于 u8)	b'A'

//: 溢出可能的处理方式
// 使用 wrapping_* 方法在所有模式下都按照补码循环溢出规则处理，例如 wrapping_add
// 如果使用 checked_* 方法时发生溢出，则返回 None 值
// 使用 overflowing_* 方法返回该值和一个指示是否存在溢出的布尔值
// 使用 saturating_* 方法使值达到最小值或最大值
```

## 浮点类型

> 切记，永远不要对浮点类型数据做 == 比较

```rust
    // 默认为 f64
    let x = 3.0;
    // 手动指定为 f32
    let y: f32 = 4.0;
    // 浮点型无效数据数值为 NaN, 使用 is_nan() 来判断
    let v = (-4.0_f64).sqrt();
    if !v.is_nan() {
    println!("{:?}", v);
    }

```

### 例子

```rust
fn main() {
    let abc: (f32, f32, f32) = (0.1, 0.2, 0.3);
    let xyz: (f64, f64, f64) = (0.1, 0.2, 0.3);

    println!("abc (f32)");
    println!("   0.1 + 0.2: {:x}", (abc.0 + abc.1).to_bits());
    println!("         0.3: {:x}", (abc.2).to_bits());
    println!();

    println!("xyz (f64)");
    println!("   0.1 + 0.2: {:x}", (xyz.0 + xyz.1).to_bits());
    println!("         0.3: {:x}", (xyz.2).to_bits());
    println!();

    assert!(abc.0 + abc.1 == abc.2);
    assert!(xyz.0 + xyz.1 == xyz.2);
}
// 输出
//           0.1 + 0.2: 3e99999a
//                 0.3: 3e99999a
//           0.1 + 0.2: 3fd3333333333334
//                 0.3: 3fd3333333333333
```

## 位运算

```rust
// i32 和 u32 左右移都补0
```

## 序列

> 仅可用于 数值 和 字符 类型

```rust
    for i in 1..5 {
        // => 1,2,3,4
        println!("{}", i);
    }
    for i in 1..=5 {
        // => 1,2,3,4,5
        println!("{}", i);
    }
    for i in 'a'..'d' {
        // => a,b,c
        println!("{}", i);
    }
    for i in 'a'..='d' {
        // => a,b,c,d
        println!("{}", i);
    }
```

## 使用第三方库

```rust
// 编辑Cargo.toml 添加 num 第三方库
// [dependencies]
// num = "0.4.0"

// 计算复数
use num::complex::Complex;
fn main() {
    let a = Complex { re: 2.1, im: -1.2 };
    let b = Complex::new(11.1, 22.2);
    let result = a + b;
    println!("{} + {}i", result.re, result.im);
}
```

## 数据类型转换

```rust
fn main() {
    let x = 5.2_f32;
    // 数据类型转换必须是显示的
    let y = (x as f64);
    // => 5.2
    println!("{}", y);
    // 使用 round() 对 f 类型进行取整
    let y = (x as f64).round() as i32;
    // => 5.0
    println!("{}", y);
}
```

## 字符类型

> 所有的 Unicode 值都可以作为 Rust 字符。字符类型占用 4 个字节。

```rust
fn main() {
    let y = 'z';
    let x = '😀';
    // => 😀
    println!("{}", x);
    // => 4
    println!("{}", std::mem::size_of_val(&y));
}
```

> 字符串类型是 UTF-8 编码，也就是字符串中的字符所占的字节数是变化的(1 - 4)

> 常用字符串主要指 String 类型和 &str 字符串切片类型，这两个类型都是 UTF-8 编码

## 单元类型

> (), main 函数的返回值就是 ()。

> 比如，() 也可以作为 map 的值用于占位，但是完全不占用任何内存空间。

## Lamada 表达式仿形

> 一切源于 表达式 和 语句 的划分

```rust
fn main() {
    // 被 {} 包括的就是 表达式
    let y = {
        let x = 3;
        x + 1
    };
    println!("The value of y is: {}", y);

    // if 语句也是 表达式
    let flag = false;
    let y = if flag {
        let x = 3;
        x + 1
    } else {
        2
    };

    println!("The value of y is: {}", y);
}
```

## 无返回值函数

```rust
fn test(){

}
fn main() {
    // 无返回值的函数会隐式地返回 ()
    assert_eq!(test(), ());
}
```

## 基本泛型

```rust
fn test<T>(v: T) -> T{
    v
}
```

## 发散函数

```rust
// 返回值类型为 '!'
// 该函数永不返回
fn test() -> ! {
    let mut _x = 1;
    loop {
        println!("{}", _x);
        _x += 1;
    };
}
// 多用于会导致程序崩溃的函数
fn dead_end() -> ! {
  panic!("你已经到了穷途末路，崩溃吧！");
}

```

## 所有权

```txt
1. Rust 中每一个值都被一个变量所拥有，该变量被称为值的所有者
2. 一个值同时只能被一个变量所拥有，或者说一个值只能拥有一个所有者
3. 当所有者(变量)离开作用域范围时，这个值将被丢弃(drop)
```

```rust
fn main() {
    // s 为栈上数据(堆指针、length、capacity)
    let s = String::from("hello");
    // 将 s move 给 _s_move, 此时 s 失效
    // 如果真的需要进行深拷贝(即不是 move), 可以调用 s.clone()
    let _s_move = s;
    println!("{}", _s_move);
    // 当 _s_move 离开作用域时，rust 调用 drop 函数释放堆空间
}

```

> 不可变引用 &T ，例如转移所有权中的最后一个例子，但是注意: 可变引用 &mut T 是不可以 Copy 的。

```rust
fn main() {
    // s1 是 &str(引用)，并不是 "hello world" 的所有者
    let s1 = "hello world";
    // 这里仅仅是 copy 引用
    let s2 = s1;
    println!("{}", s1);
    println!("{}", s2);
}
```

### 函数传值与返回

> 同样遵循所有权的全部规则(颠覆性)

## 引用

```rust
    let a = 3_u32;
    // 引用
    let b = &a;
    // *b 为解引用, 即可以获取 b 所指向的整型值
    assert_eq!(5,*b)
```

### 不可变引用

```rust
fn main() {
    let s1 = String::from("hello");
    // & 符号即是引用，它们允许你使用值，但是不获取所有权
    let len = calculate_length(&s1);
    println!("The length of '{}' is {}.", s1, len);
}

fn calculate_length(s: &String) -> usize {
    // 正如变量默认不可变一样，引用指向的值默认也是不可变的
    // 所以这里只能读取，不可修改
    s.len()
}
```

### 可变引用

```rust
fn main() {
    let mut s1 = String::from("hello");
    // & 符号即是引用，它们允许你使用值，但是不获取所有权
    let len = calculate_length(&mut s1);
    println!("The length of '{}' is {}.", s1, len);
}

fn calculate_length(s: &mut String) -> usize {
    s.len()
}
```

```rust
// 基本类型与复杂类型的可变引用区别
fn main() {
    let mut num = 10;
    let num_ref = &mut num;
    *num_ref = 20;               // i32没实现Deref，需要手动解引用
    println!("num: {}", num);

    let mut s = String::from("hello");
    let s_ref = &mut s;
    s_ref.push_str(" world");    // String默认实现Deref，不需要手动解引用
    (*s_ref).push_str("!!!");    // 手动解引用也可以
    println!("s: {}", s);
}
```

**注意**

```txt
1. 引用的作用域从创建开始，一直持续到它最后一次使用的地方，这个跟变量的作用域有所不同，变量的作用域从创建持续到某一个花括号 }
2. 同一作用域，特定数据只能有一个可变引用(因为有多个可能导致数据竞争)
3. 可变引用与不可变引用不能同时存在(因为不可变引用不希望读取到修改后的数据)
```

### 悬空引用

> 在 Rust 中编译器可以确保引用永远也不会变成悬空状态(悬空状态很危险，编译器不允许)
> 当你拥有一些数据的引用，编译器可以确保数据不会在其引用之前被释放，要想释放数据，必须先停止其引用的使用。

```rust
fn main() {
    let reference_to_nothing = dangle();
}

// 错误的代码
fn dangle() -> &String {
    let s = String::from("hello");
    &s
}
```

### 总结

```txt
1. 同一作用域，你只能拥有要么一个可变引用, 要么任意多个不可变引用
2. 引用必须总是有效的
```

# 复合类型

## 编译器属性标记

> #![...] 将对整个文件有效, #[...]只对该行下面的块有效

## 字符串和切片

> 字符串字面量也是切片, 因为 &str 表示字符串切片类型

```rust
    // String 类型有切片
    let s = String::from("hello world");
    // 在切片数据结构内部会保存开始的位置和切片的长度，其中长度是通过 终止索引 - 开始索引 的方式计算得来的
    let hello = &s[0..5];
    let world = &s[6..11];
```

```rust
fn main() {
    // 数组类型也有切片
    let a = [1, 2, 3, 4, 5];
    let slice = &a[1..3];
    assert_eq!(slice, &[2, 3]);
}
```

### String 类型与 &str 类型转换

```rust
fn main() {
    let s = String::from("hello world");
    // 将 String 转换为 &str 的三种方式, 得益于 deref 隐式强制转换
    say_hello(&s);
    say_hello(&s[..]);
    say_hello(s.as_str());
}
fn say_hello(message: &str) {
    println!("{}", message);
}
```

### 字符串索引

> 字符串的底层的数据存储格式实际上是 u8，一个字节数组。

```rust
fn main() {
    let s = String::from("hello world");
    // 无法使用索引的方式访问字符串的某个字符
    // 需使用切片
    println!("{}", &s[..1]);
    let s = String::from("中国");
    // 使用如下也 ok
    // let s = "中国人";
    // 中文字符 UTF-8, 占用三个字节
    // 需使用切片
    println!("{}", &s[..3]);
    // 无法使用索引的方式访问字符串的某个字符
    // 需使用切片
    println!("{}", &"中国人"[..3]);
}
```

### 操作字符串

```rust
// 以 Unicode 字符的方式遍历字符串
fn main() {
for c in "中国人".chars() {
    println!("{}", c);
}
}
```

```rust
// 返回字符串的底层字节数组表现形式
fn main() {
for b in "中国人".bytes() {
    println!("{}", b);
}
}
```

## 元组

> 元组是用括号将多个类型组合到一起

```rust
fn main() {
    // 元组
    let tup: (i32, f64, u32) = (500, 6.4, 1);
    // 用模式匹配解构(_,..)
    let (x, y, z) = tup;
    let (.., j, _) = tup;
    // (.) 访问
    println!("{} {} {}", tup.0, tup.1, tup.2);
    println!("The value of tup is: {:?}", tup);
    println!("The value of x is: {}", x);
    println!("The value of y is: {}", y);
    println!("The value of z is: {}", z);
    println!("The value of j is: {}", j);
}
```

> 元组在函数返回值场景很常用

```rust
fn main() {
    let s1 = String::from("hello");

    let (s2, len) = calculate_length(s1);

    println!("The length of '{}' is {}.", s2, len);
}

fn calculate_length(s: String) -> (String, usize) {
    let length = s.len(); // len() 返回字符串的长度

    (s, length)
}
```

## 结构体

```rust
// 结构体声明，结尾无(;)
// 这种形式的结构体数据所有权都归自己
struct User {
    active: bool,
    username: String,
    email: String,
    sign_in_count: u64,
}

fn main() {
    // 初始化结构体时每个字段都需要进行初始化
    let mut _user1 = User {
        active: true,
        username: String::from("someone"),
        email: String::from("2237616014@qq.com"),
        sign_in_count: 1,
    };
    let user2 = build_user(String::from("someone"), String::from("2237616014"));
    // 根据已有的结构体更新旧的结构体
    // 必须要将结构体实例声明为 mut
    // ..user2 必须在结构体的尾部使用
    _user1 = User {
        email: String::from("123"),
        // 结构体更新语法跟赋值语句 = 非常相像
        // 所有权转移
        ..user2
    };
    // 可以通过结构体的(.)来访问字段
    println!("{}", _user1.username);
    println!("{}", _user1.email);
    println!("{}", _user1.sign_in_count);
    println!("{}", _user1.active);
    // user2.username 所有权转移，无法访问
    //println!("{}", user2.username);
    // 但其他 copy 还可以访问
    println!("{}", user2.email);
    println!("{}", user2.sign_in_count);
    println!("{}", user2.active);
}

fn build_user(email: String, username: String) -> User {
    // 如果同名，可以直接使用缩略的方式进行初始化
    User {
        active: true,
        username,
        email,
        sign_in_count: 1,
    }
}
```

### 元组结构体

```rust
// 元组结构体声明
#[derive(Debug)]
struct Point(i32,i32,i32);

fn main() {
    let origin = Point(1,2,3);
    println!("{:?}",origin);
}
```

### 单元结构体

> 当我们不关心结构体元素名称时有用

```rust
struct AlwaysEqual;

fn main() {
    let sum = AlwaysEqual;
    // Trait impl
    impl PartialEq for AlwaysEqual {
        fn eq(&self, _: &AlwaysEqual) -> bool {
            true
        }
        fn ne(&self, _: &AlwaysEqual) -> bool {
            false
        }
    }
    println!("{:?}", sum.eq(&sum));
}
```

### 结构体数据所有权

> 当一个结构体中的数据是借用时，需要引入[生命周期](TODO)

```rust
struct User {
    active: bool,
    username: &str,
    email: &str,
    sign_in_count: u64,
}
```

### 结构体标记输出

```rust
// 添加这个 Debug 派生标记，这样就不需要自己去实现 Debug Trait
// 当结构体较大时，我们可能希望能够有更好的输出表现，此时可以使用 {:#?} 来替代 {:?}
#[derive(Debug)]
struct User {
    active: bool,
    username: String,
    email: String,
    sign_in_count: u64,
}
```

> 以下为自己实现 Debug

```rust
use std::fmt;

struct Rectangle {
    width: u32,
    height: u32,
}

impl fmt::Debug for Rectangle {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Rectangle {\
            {
                width: {},
                height: {}
            }}", self.width, self.height)
    }
}

fn main() {
    let rect1 = Rectangle {
        width: 30,
        height: 50,
    };

    println!("rect1 is {:?}", rect1);
}
```

### 宏调试

> 该宏会拿走表达式的所有权，然后打印出相应的文件名、行号等 debug 信息，当然还有我们需要的表达式的求值结果,
> 除此之外，它最终还会把表达式值的所有权返回！

```rust
#[derive(Debug)]
struct Rectangle {
    _width: u32,
    _height: u32,
}

fn main() {
    let scale = 2;
    let rect1 = Rectangle {
        _width: dbg!(30 * scale),
        _height: 50,
    };
    println!("rect1 is {:?}", rect1);
    dbg!(&rect1);
}
```

## 枚举

### 基本枚举

```rust
#[derive(Debug)]
enum PokerSuit {
  _Clubs,
  _Spades,
  Diamonds,
  Hearts,
}
fn main() {
    let heart = PokerSuit::Hearts;
    let diamond = PokerSuit::Diamonds;

    print_suit(heart);
    print_suit(diamond);
}
fn print_suit(card: PokerSuit) {
println!("{:?}",card);
}
```

> 可以直接将数据信息关联到枚举成员上,任何类型的数据都可以放入枚举成员中

```rust
enum PokerCard {
    _Clubs(u8),
    Spades(u8),
    Diamonds(char),
    _Hearts(char),
}
impl PokerCard {
    fn get_suit(&self) -> &str {
        // 匹配枚举值并处理枚举值关联的数据
        match self {
            PokerCard::_Clubs(_) => "Clubs",
            PokerCard::Spades(v) => {
                if *v == 5 {
                    "Ace of Spades"
                } else {
                    "Spades"
                }
            }
            PokerCard::Diamonds(_) => "Diamonds",
            PokerCard::_Hearts(_) => "Hearts",
        }
    }
}
fn main() {
   let _c1 = PokerCard::Spades(5);
   let _c2 = PokerCard::Diamonds('A');
   // => Ace of Spades
   println!("{}", _c1.get_suit());
}
```

### Option 枚举

> 为了拥有一个可能为空的值，你必须要显式的将其放入对应类型的 Option<T> 中

```rust
fn main() {
    let a = 1;
    let mut o: Option<i32> = None;
    if o.is_none() {
        println! ("is none");
    }
    o = Some(a);
    if o.is_some() {
        println!("{}", o.unwrap());
    }
}
```

## 数组

> array 为定长数组,是基本类型，vector 为动态数组, 是集合类型

### array

```rust
fn main() {
    // 初始化
    // 编译器会根据上下文自动推断变量类型
    let _arr = [1, 2, 3, 4, 5];
    let _arr3 = [3; 5]; // [3, 3, 3, 3, 3]

    let _arr2: [u8; 5] = [1, 2, 3, 4, 5];
    let _blank2: [u8; 5] = [0; 5]; // [0, 0, 0]

    // 二维数组
    let _arrays: [[u8; 5]; 4]  = [_arr, _arr2, _arr3, _blank2];

    // array 可以直接通过下标访问
    println!("{}", _arr[0]);

    // 当访问数组的下表超出数组的范围时，会 panic
    // println!("{}", _arr[6]);

    // 可以使用 slice 来访问数组的一部分
    // 创建切片的代价非常小，因为切片只是针对底层数组的一个引用
    // 切片类型[T]拥有不固定的大小，而切片引用类型&[T]则具有固定的大小
    let _slice = &_arr[0..2];
    assert_eq!(_slice, &[1, 2]);

    // 借用arrays的元素用作循环中
    for a in &_arrays {
        for b in a.iter() {
            println!("{}", b);
        }
    }
}
```

# 流程控制

## if

> 和 CPP 大同小异，唯一不同的就是 if 语句可以作为表达式

```rust
fn main() {
    let false_value = false;
    // 作为表达式
    let num = if false_value {
        1
    } else {
        2
    };
    dbg!(num);
}
```

## continue & break

> 和 CPP 大同小异
> break 可以单独使用，也可以带一个返回值，有些类似 return

## 循环

### for

> 用于循环集合中的元素(most population)

```rust
fn main() {
    for i in 1..=5 {
        // => 1,2,3,4,5
        println!("{}", );
    }
}
```

```rust
fn main() {
    let a = [4, 3, 2, 1];
    // `.iter()` 方法把 `a` 数组变成一个迭代器
    // `.enumerate()` 方法把迭代器变成一个元组，元组的第一个元素是下标，第二个元素是值
    // 使用迭代这种方式访问是连续的，不会被可变借用打断
    // for 并不会使用索引去访问数组，因此更安全也更简洁，同时避免 运行时的边界检查，性能更高。
    for (i, v) in a.iter().enumerate() {
        println!("第{}个元素是{}", i + 1, v);
    }
}
```

| 使用方法                    | 等价使用方式                                    | 所有权     |
| --------------------------- | ----------------------------------------------- | ---------- |
| for item in collection      | for item in IntoIterator::into_iter(collection) | 转移所有权 |
| for item in &collection     | for item in collection.iter()                   | 不可变借用 |
| for item in &mut collection | for item in collection.iter_mut()               | 可变借用   |

### while

> 和 CPP 大同小异

### loop

> 无条件循环, loop 是一个表达式

```rust
fn main() {
    let mut counter = 0;

    let result = loop {
        counter += 1;
        // loop 可以结合 if & break 来实现有条件循环
        if counter == 10 {
            // 类似 return 用法, 别遗漏分号
            break counter * 2;
        }
    };

    println!("The result is {}", result);
}
```

# 模式匹配

## match

> match 用于多模式匹配，match 是一个表达式

### 基本用法

```rust
enum Direction {
    East,
    West,
    North,
    South,
}

fn main() {
    let dire = Direction::South;
    // 所有分支的表达式最终返回值的类型必须相同
    match dire {
        // 模式 => 表达式(返回())
        Direction::East => println!("East"),
        // 模式 | 模式 => {}({}中返回表达式())
        Direction::North | Direction::South => {
            println!("South or North");
        },
        // 通配符(_) => 表达式(返回())
        // 用 (_) 来代表未列出的所有可能性
        _ => println!("West"),
    };
}
```

### 使用 match 表达式赋值

```rust
enum IpAddr {
   Ipv4,
   Ipv6
}

fn main() {
    let ip1 = IpAddr::Ipv6;
    let ip_str = match ip1 {
        IpAddr::Ipv4 => "127.0.0.1",
        _ => "::1",
    };

    println!("{}", ip_str);
}
```

### 模式绑定

```rust
enum IpAddr {
   _Ipv4,
   Ipv6(String),
}

fn main() {
    let ip1 = IpAddr::Ipv6(String::from("::1"));
    let ip_str = match ip1 {
        // 枚举值未绑定数据
        IpAddr::_Ipv4 => String::from("IPv4"),
        // 处理枚举值绑定的数据
        IpAddr::Ipv6(ip) => ip,
    };

    println!("{}", ip_str);
}
```

## if let 用于单模式匹配

```rust
// Some 单个匹配
fn main() {
    let a = Some(1);
    // a 是否匹配 Some(1)
    if let Some(1) = a {
        println!("{}", 1);
    }
}
// None 单个匹配
fn main() {
    let a: Option<i32> = None;
    if let None = a {
        println!("{}", 1);
    }
}
```

### matches! 匹配

```rust
enum MyEnum {
    Foo,
    Bar
}

fn main() {
    let v = vec![MyEnum::Foo,MyEnum::Bar,MyEnum::Foo];
    // matches! 将一个表达式跟模式进行匹配
    let filter = v.iter().filter(|x| matches!(x,MyEnum::Foo)).map(|x| match x {
        MyEnum::Foo => "foo",
        MyEnum::Bar => "bar",
    }).collect::<Vec<_>>();
    for x in filter {
        println!("{}",x);
    }
}
```

```rust
// 更多用法
#![allow(unused)]
fn main() {
    let foo = 'f';
    // 范围匹配
    assert!(matches!(foo, 'A'..='Z' | 'a'..='z'));

    let bar = Some(4);
    // 匹配守卫
    assert!(matches!(bar, Some(x) if x > 2));
}
```

### 变量覆盖在 match 中的用法

> 可以有效用于提取 Option<T> 有效值, 当然，还可以有更多用法

```rust
// if let
fn main() {
   // Some<T> 和 None 都是 Option<T> 下的枚举值
   let age = Some(30);
   println!("在匹配前，age是{:?}",age);
   // age => 30
   if let Some(age) = age {
       println!("匹配出来的age是{}",age);
   }

   println!("在匹配后，age是{:?}",age);
}
```

```rust
fn main() {
   let age = Some(30);
   println!("在匹配前，age是{:?}",age);
   match age {
       // age => 30
       Some(age) =>  println!("匹配出来的age是{}",age),
       _ => ()
   }
   println!("在匹配后，age是{:?}",age);
}
```

### 匹配守卫

> 匹配守卫（match guard）是一个位于 match 分支模式之后的额外 if 条件，它能为分支模式提供更进一步的匹配条件

```rust
#![allow(unused)]
fn main() {
let num = Some(4);

match num {
    // 匹配守卫
    Some(x) if x < 5 => println!("less than five: {}", x),
    Some(x) => println!("{}", x),
    None => (),
}
}
```

### @绑定

> 当你既想要限定分支范围，又想要使用分支的变量时，就可以用 @ 来绑定到一个新的变量上

**助记**

> @ 符号右侧是一个模式(pattern), 如果这个模式匹配就把匹配值绑定到 @ 符号左侧的变量上。

```rust
#![allow(unused)]
fn main() {
enum Message {
    Hello { id: i32 },
}

let msg = Message::Hello { id: 5 };

match msg {
    // 范围匹配，同时将 id 值赋给 id_variable 变量
    // 如果这里直接访问 id 值的话会出错
    Message::Hello { id: id_variable @ 3..=7 } => {
        println!("Found an id in range: {}", id_variable)
    },
    Message::Hello { id: 10..=12 } => {
        println!("Found an id in another range")
    },
    Message::Hello { id } => {
        println!("Found some other id: {}", id)
    },
}
}
```

#### @前绑定后解构

> 使用 @ 还可以在绑定新变量的同时，对目标进行解构

```rust
#[derive(Debug)]
struct Point {
    x: i32,
    y: i32,
}
fn main() {
    // 绑定新变量 `p`，同时对 `Point` 进行解构
    let p @ Point {x: px, y: py } = Point {x: 10, y: 23};
    println!("x: {}, y: {}", px, py);
    println!("{:?}", p);


    let point = Point {x: 10, y: 5};
    if let p @ Point {x: 10, y} = point {
        println!("x is 10 and y is {} in {:?}", y, p);
    } else {
        println!("x was not 10 :(");
    }
}
```

#### 模式绑定新变量

```rust
fn main() {
    match 1 {
        // 模式绑定新变量
        num @ (1 | 2) => {
            println!("{}", num);
        }
        _ => {}
    }
}
```

```rust
fn main() {
    let a = Some(42);
    match a {
        // 模式绑定新变量
        // 同时进行变量覆盖
        num @ Some(a) if a > 10 => {
            println!("{}", num.unwrap());
            println!("{}", a);
        }
        _ => {}
    }
}
```

## while let

```rust
fn main(){
    let mut vec = vec![1, 2, 3];
    // 匹配则继续循环(这是出栈)
    while let Some(x) = vec.pop() {
        println!("{}", x);
    }
}
```

# 方法 Method

> Rust 的方法往往跟 struct 、enum 、特征(Trait)一起使用

## struct

```rust
#![allow(unused)]
// 默认当前文件可访问, 可以通过pub声明公开
pub struct Rectangle {
    width: u32,
    height: u32,
}

// 可以有多个 impl 定义, 方便代码组织而已(效果一样)
impl Rectangle {
    // Self 就是 Rectangle struct 类型
    // 这就是构造函数, 也称为关联函数
    // 有一个约定俗成的规则，使用 new 来作为构造函数的名称
    pub fn new(width: u32, height: u32) -> Self {
        Rectangle { width, height }
    }
    // self 是 Rectangle struct 的实例
    // self 也具有所有权的特征(self | &self | &mut self)
    pub fn width(&self) -> u32 {
        self.width
    }
    pub fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height
    }
}

fn main() {
    // 类似 cpp 中调用静态成员函数，因为此时还未实例化 Rectangle struct
    let rect1 = Rectangle::new(30, 50);
    let rect2 = Rectangle::new(10, 40);

    // rect1 会根据调用函数的第一个self类型自动解引用
    println!("{}", rect1.width());
    println!("{}", rect1.height);
    println!("{}", rect1.can_hold(&rect2));
}
```

## enum

```rust
// 方法实现和结构体也一样, 只是数据用法不同
#![allow(unused)]
#[derive(Debug)]
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}

impl Message {
    fn call(&self) {
        match self {
            Message::Quit => {
                println!("Quit");
            }
            Message::Move { x, y } => {
                println!(
                    "Move to: {}, {}",
                    x,
                    y
                );
            }
            Message::Write(text) => {
                println!("Write: {}", text);
            }
            Message::ChangeColor(r, g, b) => {
                println!(
                    "Change color to: {}, {}, {}",
                    r,
                    g,
                    b
                );
            }
        }
    }
}

fn main() {
    let m = Message::Write(String::from("hello"));
    m.call();
}
```

# 泛型和特征

## struct 中使用范型

```rust
#[derive(Debug)]
#[allow(unused)]
// x,y 不同类型时
struct Point<T,U> {
    x: T,
    y: U,
}

fn main() {
    let p = Point{x: 1, y :1.1};
    println!("{:?}", p);
}
```

## enum 中使用范型

```rust
// 卧龙(值存在否应用)
enum Option<T> {
    Some(T),
    None,
}
// 凤雏(值正确否应用)
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

## Method 方法中使用范型

```rust
#[allow(unused)]
struct Point<T> {
    x: T,
    y: T,
}

impl<T> Point<T> {
    fn x(&self) -> &T {
        &self.x
    }
}

fn main() {
    let p = Point { x: 5, y: 10 };

    println!("p.x = {}", p.x());
}
```

## Method 方法中定义范型

```rust
struct Point<T, U> {
    x: T,
    y: U,
}

impl<T, U> Point<T, U> {
    // 原有基础上的 T,U 扩充
    fn mixup<V, W>(self, other: Point<V, W>) -> Point<T, W> {
        Point {
            x: self.x,
            y: other.y,
        }
    }
}

fn main() {
    let p1 = Point { x: 5, y: 10.4 };
    let p2 = Point { x: "Hello", y: 'c'};

    let p3 = p1.mixup(p2);

    println!("p3.x = {}, p3.y = {}", p3.x, p3.y);
}

```

## 为具体的泛型类型实现方法

```rust
// 只有 T 为 f32 的 Point 实例才可以调用该方法
impl Point<f32> {
    fn distance_from_origin(&self) -> f32 {
        (self.x.powi(2) + self.y.powi(2)).sqrt()
    }
}
```

## const 泛型

TODO

# Trait

> Trait 定义了一个可以被共享的行为，只要实现了 Trait，你就能使用该行为(类似接口)

> 关于特征实现与定义的位置，有一条非常重要的原则：如果你想要为类型 A 实现特征 T，那么 A 或者 T 至少有一个是在当前作用域中定义的

```rust
#![allow(unused)]
// 定义 Trait 接口为公开
pub trait Summary {
    // 具有默认实现的 Trait 接口
    fn summize(&self) -> String {
        String::from("read more...")
    }
}

struct Post {
    content: String,
}

struct Web {
    content: String,
}

impl Summary for Web {
    // 使用默认实现的 Trait 接口方法
}

// 为Post struct 实现 Trait 接口
impl Summary for Post {
    // 重写 Trait 接口中的方法
    fn summize(&self) -> String {
        format!("{}", self.content)
    }
}

// String 定义在标准库中,咱们使用自定义的 trait Summary 为 String 添加Trait
impl Summary for String {
    fn summize(&self) -> String {
        format!("{}", self)
    }
}

// i32 定义在标准库中,咱们使用自定义的 trait Summary 为 i32 添加Trait
impl Summary for i32 {
    fn summize(&self) -> String {
        format!("{}", self)
    }
}

fn main() {
    let post = Post {
        content: String::from("Post Summary"),
    };
    let web = Web {
        content: String::from("Web Summary"),
    };
    let content = String::from("String Summary");
    let i32_content = i32::from(1);
    notify(&post);
    notify(&web);
    notify(&content);
    notify(&i32_content);
}


// 任何实现了 Summary 特征的类型作为该函数的参数，下面这种是语法糖
// fn notify(item: &impl Summary) {
//     println!("Breaking news! {}", item.summize());
// }

// 接上，notify 真正的语法形式如下:
// T: Summary 说明了 T 必须实现 Summary Trait
// 其中，T 是泛型，会自动根据传入的参数类型推导出 T 类型
fn notify<T: Summary>(item: &T) {
    println!("Breaking news! {}", item.summize());
}
```

## 多重 Trait

> 参数必须实现所有 Trait

```rust
// 语法糖形式
fn notify(item: &(impl Summary + Display)) {}
// 真正语法形式
fn notify<T: Summary + Display>(item: &T){}
```

## where Trait

```rust
use std::fmt::Debug;
use std::fmt::Display;
// where 的存在用于改进多重 Trait 引起到语法复杂性
fn some_function<T>(t: &T) -> i32
    where T: Display + Debug,
{
    println!("{}", t);
    1
}

fn main(){
    let _ = some_function(&"hello");
}
```

## 条件 Trait

```rust
// 为实现了 Display Trait 的 T 实现 ToString
impl<T: Display> ToString for T {
    // --snip--
}
```

## 获取数组中最大值

```rust
// NoCopy
fn largest<T: PartialOrd>(list: &[T]) -> &T {
    let mut index = 0;

    for (i,item) in list.iter().enumerate() {
        if item > &list[index] {
            index = i;
        }
    }

    &list[index]
}

fn main() {
    let number_list = vec![34, 50, 25, 100, 65];

    let result = largest(&number_list);
    println!("The largest number is {}", result);

    let char_list = vec!['y', 'm', 'a', 'q'];

    let result = largest(&char_list);
    println!("The largest char is {}", result);
}
```

## 调用方法需要引入 Trait

```rust
// TODO
// 不解
use std::convert::TryInto;

fn main() {
  let a: i32 = 10;
  let b: u16 = 100;
  let b_ = b.try_into().unwrap();
  if a < b_ {
    println!("Ten is less than one hundred.");
  }
}
```
