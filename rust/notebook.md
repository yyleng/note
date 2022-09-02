# 第三方库

| 名称       | 用途                    |
| ---------- | ----------------------- |
| num        | 处理复数等问题          |
| utf8_slice | 处理 UTF-8 字符串等问题 |
| ahash      | 高性能哈希函数库        |
| rand       | 随机数生成              |

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
    // f32 or f64 has implemented Debug Trait
    println!("{:?}", v);
    }

```

### 例子

```rust
fn main() {
    let abc: (f32, f32, f32) = (0.1, 0.2, 0.3);
    let xyz: (f64, f64, f64) = (0.1, 0.2, 0.3);

    println!("abc (f32)");
    // 输出无前缀 16 进制
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

> 仅可用于 i/u or char 类型

```rust
    for i in 1..5 {
        // => 1,2,3,4
        // i32 has implemented Display Trait
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

CHECK

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

> 当一个结构体中的数据是借用时，需要引入[生命周期](./rust_advanced.md#lifetime)

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
// T 必须实现了 PartialOrd Trait
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
// u16 实现了 TryInto Trait, 但如果需要使用 TryInto Trait 中的方法，需要 use std::convert::TryInto
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

## 为自定义类型实现 + 操作

> 相当于就是运算符重载

> 只有 std::ops 中的 Trait 才支持重载

```rust
use std::ops::Add;

// 为Point结构体派生Debug特征，用于格式化输出
#[derive(Debug)]
// 限制类型T必须实现了 Add Trait，否则无法进行 + 操作。
struct Point<T: Add<T, Output = T>> {
    x: T,
    y: T,
}

// 为 Point 实现 Add Trait, T 必须实现了 Add Trait
impl<T: Add<T, Output = T>> Add for Point<T> {
    type Output = Point<T>;

    fn add(self, p: Point<T>) -> Point<T> {
        Point{
            x: self.x + p.x,
            y: self.y + p.y,
        }
    }
}

fn add<T: Add<T, Output=T>>(a:T, b:T) -> T {
    a + b
}

fn main() {
    // 基本类型 f32 实现了 Add Trait
    let p1 = Point{x: 1.1f32, y: 1.1f32};
    let p2 = Point{x: 2.1f32, y: 2.1f32};
    println!("{:?}", add(p1, p2));

    let p3 = Point{x: 1i32, y: 1i32};
    let p4 = Point{x: 2i32, y: 2i32};
    println!("{:?}", add(p3, p4));
}
```

## 为自定义类型打印输出

```rust
#![allow(dead_code)]
use std::fmt;
use std::fmt::Display;

#[derive(Debug,PartialEq)]
enum FileState {
  Open,
  Closed,
}

#[derive(Debug)]
struct File {
  name: String,
  data: Vec<u8>,
  state: FileState,
}

impl Display for FileState {
   fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
     match *self {
         FileState::Open => write!(f, "OPEN"),
         FileState::Closed => write!(f, "CLOSED"),
     }
   }
}

impl Display for File {
   fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
      write!(f, "<{} ({})>",
             self.name, self.state)
   }
}

impl File {
  fn new(name: &str) -> File {
    File {
        name: String::from(name),
        data: Vec::new(),
        state: FileState::Closed,
    }
  }
}

fn main() {
  let f6 = File::new("f6.txt");
  //三种输出形式
  println!("{:?}", f6);
  println!("{}", f6);
  println!("{:#?}", f6);
}
```

## Trait 对象

```rust
#![allow(unused)]
pub trait Draw {
    fn draw(&self);
}

// 相当于是基类
pub struct Screen {
    // Box<T> 是智能指针
    // Box<dyn Draw> 是 Draw Trait 对象
    // Trait 对象，需要在运行时从 vtable 动态查找需要调用的方法
    // Box<dyn Draw> 底层存放了指向一个实现了Draw Trait的实例的指针 和 指向所有实现了 Draw Trait的实例的 Draw Trait 方法的数组指针
    pub components: Vec<Box<dyn Draw>>,
}

impl Screen {
    pub fn run(&self) {
        for component in self.components.iter() {
            component.draw();
        }
    }
}

struct Button {
    pub width: u32,
    pub height: u32,
    pub label: String,
}

impl Draw for Button {
    fn draw(&self) {
        println!("Drawing button with width: {} and height: {}", self.width, self.height);
    }
}

struct SelectBox {
    pub width: u32,
    pub height: u32,
    pub options: Vec<String>,
}

impl Draw for SelectBox {
    fn draw(&self) {
        println!("Drawing select box with width: {} and height: {}", self.width, self.height);
    }
}

fn main() {
    let screen = Screen {
        components: vec![
            // 使用 Box::new() 将 Button 实例包装成一个 Box<dyn Draw> 对象
            Box::new(SelectBox {
                width: 75,
                height: 10,
                options: vec![
                    String::from("Yes"),
                    String::from("Maybe"),
                    String::from("No"),
                ],
            }),
            // 使用 Box::new() 将 任何实现了 Draw Trait 的实例包装成一个 Box<dyn Draw> 对象
            Box::new(Button {
                width: 50,
                height: 10,
                label: String::from("OK"),
            }),
        ],
    };

    // 多态运行
    screen.run();
}
```

### self 与 Self 的区别

```rust
#![allow(unused)
trait Draw {
    fn draw(&self) -> Self;
}

#[derive(Clone)]
struct Button;
impl Draw for Button {
    // self 和 Self 的区别:
    // self 指代的就是当前的实例对象
    // Self 则指代的是 Button 类型
    fn draw(&self) -> Self {
        return self.clone()
    }
}

fn main() {
    let button = Button;
    let newb = button.draw();
}
```

### Trait 对象的限制

> 只有对象安全的 Trait 才能拥有 Trait 对象

```txt
1. Trait 方法的返回类型不能是 Self
2. Trait 方法没有任何泛型参数
```

## 深入了解 Trait

TODO

# 集合类型

## Vector

```rust
#![allow(unused)]
fn main(){
    // 创建 capacity 为 10 的 Vector, T 根据上下文进行推导
    let mut v1 = Vec::with_capacity(10);
    v1.push(1); // 需要使 v1 为 mut, 才能 push
    println!("{:?}", v1.capacity());     // => 10
    println!("{:?}", v1.len());     // => 1
    // 创建 Vector，默认初始化为空, T 手动指定
    let v2: Vec<i32> = Vec::new();
    println!("{:?}", v2.capacity());     // => 0
    println!("{:?}", v2.len());     // => 0
    // 创建具有初始化值的 Vector
    let mut v3 = vec![1, 2, 3,4,5,6,7,8,9];
    println!("{:?}", v3.capacity());     // => 9
    println!("{:?}", v3.len());     // => 9
    let third = &v3[2]; // 通过 index 访问, 越界会报错
    // 出错： third 为不可变借用，v3 为可变借用，当 v3 push 之后可能会由于 capacity 不足重新申请一块内存，进而引发 third 指向无效内存地址的风险
    // v3.push(10); // 需要使 v3 为 mut, 才能 push
    println!("{:?}", third);     // => 3
    let third = v3.get(100); // 通过下表访问, 越界返回 None
    match third {
        Some(third) => println!("{:?}", third),
        None => println!("None"), // => None
    }
    // 迭代访问 Vector
    for i in &v3 {
        println!("{:?}", i); // 1, 2, 3, 4, 5, 6, 7, 8, 9
    }
    // Vector 的元素必需类型相同, 但可以通过使用 enum 和 Trait 对象来实现不同类型元素的存储
    // 在介绍 enum 和 Trait 的时候已实现
}
```

## HashMap

> HashMap 符合所有权原则

```txt
1. 若类型实现 Copy 特征，该类型会被复制进 HashMap，因此无所谓所有权
2. 若没实现 Copy 特征，所有权将被转移给 HashMap 中
```

> 一个类型能否作为 Key 的关键就是是否能进行相等比较，或者说该类型是否实现了 std::cmp::Eq Trait

### 新建

```rust
#![allow(unused)]
fn main() {
    use std::collections::HashMap;
    // Create a new HashMap with capacity 10
    let mut map1: HashMap<String, i32> = HashMap::with_capacity(10);
    map1.insert(String::from("first data"), 1);
    // Create a new HashMap with capacity 0
    let mut map = HashMap::new();
    map.insert("a", 1);
    let teams_list = vec![
        ("中国队".to_string(), 100),
        ("美国队".to_string(), 10),
        ("日本队".to_string(), 50),
    ];

    // 将 Vector 转换为 Interator 并调用 collect 方法转换为 集合类型
    // 由于 collect 方法支持转换成多种集合类型，因为需要指定转换的类型为 HashMap<_,_>，其中 _ 为占位符,表示编译器自动推断类型
    let teams_map: HashMap<_,_> = teams_list.into_iter().collect();

    println!("{:?}",teams_map)
}
```

### 更新

```rust
fn main() {
    use std::collections::HashMap;

    let mut scores = HashMap::new();

    scores.insert("Blue", 10);

    // 覆盖已有的值
    let old = scores.insert("Blue", 20);
    assert_eq!(old, Some(10));

    // 查询新插入的值
    let new = scores.get("Blue");
    assert_eq!(new, Some(&20));

    // 查询Yellow对应的值，若不存在则插入新值
    let v = scores.entry("Yellow").or_insert(5);
    assert_eq!(*v, 5); // 不存在，插入5

    // 查询Yellow对应的值，若不存在则插入新值
    let v = scores.entry("Yellow").or_insert(50);
    assert_eq!(*v, 5); // 已经存在，因此50没有插入
}
```

### 在已有值的基础上更新

```rust
// 统计文本单词数量
#![allow(unused)]
fn main() {
use std::collections::HashMap;

let text = "hello world wonderful world";

let mut map = HashMap::new();
// 根据空格来切分字符串(英文单词都是通过空格切分)
for word in text.split_whitespace() {
    // &mut V
    let count = map.entry(word).or_insert(0);
    *count += 1;
}

println!("{:?}", map);
}
```

# 类型转换

## as 转换

> as 转换不具有传递性 就算 e as U1 as U2 是合法的，也不能说明 e as U2 是合法的

```rust
#![allow(unused)]
fn main() {
    // 基本转换
    let a: i32 = 10;
    let b: u16 = 100;

    // u16 -> i32
    if a < (b as i32) {
        println!("Ten is less than one hundred.");
    }

    // 类型最值获取
    let i16_min = i16::MIN;
    let i16_max = i16::MAX;
    println!("i16_min: {}, i16_max: {}", i16_min, i16_max);

    // 字符转换
    let c = 'a' as u8;
    println!("c: {}", c);

    // 内存地址转换
    let mut values: [i32; 2] = [1, 2];
    let p1: *mut i32 = values.as_mut_ptr();
    let first_address = p1 as usize; // 将p1内存地址转换为一个整数
    println!("first_address: {}", first_address);
    let second_address = first_address + 4; // 4 == std::mem::size_of::<i32>()，i32类型占用4个字节，因此将内存地址 + 4
    println!("second_address: {}", second_address);
    let p2 = second_address as *mut i32; // 访问该地址指向的下一个整数p2
    unsafe {
        *p2 += 1;
    }
    assert_eq!(values[1], 3);
}
```

## TryInto 转换

> 使用 TryInto Trait 中的 try_into() 进行大范围转小范围转换时，会引起错误: 类型范围超出的转换是不被允许的

```rust
use std::convert::TryInto;

fn main() {
   let a: u8 = 10;
   let b: u16 = 1500;

   // 使用 TryInto Trait 中的 try_into() 将 u16 -> u8 时，会引起错误: 类型范围超出的转换是不被允许的
   // let b_: u8 = b.try_into().unwrap();

   //这样使用
   let b_ = match b.try_into().ok() {
      Some(b_) => b_,
      None => 0,
   };

   //或这样使用
   let c_ = match b.try_into() {
      Ok(c_) => c_,
      Err(_) => 0,
   };

   if a > b_ {
     println!("Ten is less than one hundred.");
   }
   if a > c_ {
     println!("Ten is less than one hundred.");
   }
}
```

## 强制类型转换

TODO

## 点操作符的黑暗

TODO

## 变形记

TODO

# 返回值和错误处理

## panic! 与不可恢复错误

```txt
panic! 宏,程序会打印出一个错误信息，展开报错点往前的函数调用堆栈，最后退出程序
不可恢复的错误(梳理清楚当前场景的错误类型非常重要),一旦发生，只需让程序崩溃即可
```

## backtrace 栈展开

**缓冲区溢出**

```txt
如果有过 C 语言的经验，即使你越界了，问题不大，我依然尝试去访问
至于这个值是不是你想要的（100 号内存地址也有可能有值，只不过是其它变量或者程序的！）
抱歉，不归我管，我只负责取，你要负责管理好自己的索引访问范围
```

```sh
# debug
RUST_BACKTRACE=1 cargo run | less
# release
RUST_BACKTRACE=1 cargo run --release | less
```

## panic 时的两种终止方式

```txt
1. 栈展开
2. 直接终止
```

> 配置 Cargo.toml, 使得在 release 下 panic 时直接终止

```txt
[profile.release]
panic = 'abort'
```

## 何时使用

```txt
1. 你确切的知道你的程序是正确时，可以使用 panic, 因为不太可能 panic
2. 可预期的错误则可处理，则不需要 panic
3. 后续代码的运行会受到显著影响时需要对错误 panic

```

```rust
#![allow(unused)]
fn main() {
    use std::net::IpAddr;
    // unwrap() 成功则返回值，失败则 panic
    // 符合第一条，panic 不太可能发生
    let home: IpAddr = "127.0.0.1".parse().unwrap();
    // expect(消息) 成功则返回值不打印消息，失败则 panic并打印消息
    let f = File::open("/dev/null").expect("Failed to open hello.txt");
    println!("{:?}", f);
}
```

## 线程 panic

```txt
如果是 main 线程，则程序会终止，如果是其它子线程，该线程会终止，但是不会影响 main 线程
```

## panic 原理

> 当调用 panic! 宏时，它会:

```txt
1. 格式化 panic 信息，然后使用该信息作为参数，调用 std::panic::panic_any() 函数
2. panic_any 会检查应用是否使用了 panic hook，如果使用了，该 hook 函数就会被调用（hook 是一个钩子函数，是外部代码设置的，用于在 panic 触发时，执行外部代码所需的功能）
3. 当 hook 函数返回后，当前的线程就开始进行栈展开：从 panic_any 开始，如果寄存器或者栈因为某些原因信息错乱了，那很可能该展开会发生异常，最终线程会直接停止，展开也无法继续进行
4. 展开的过程是一帧一帧的去回溯整个栈，每个帧的数据都会随之被丢弃，但是在展开过程中，你可能会遇到被用户标记为 catching 的帧（通过 std::panic::catch_unwind() 函数标记），此时用户提供的 catch 函数会被调用，展开也随之停止：当然，如果 catch 选择在内部调用 std::panic::resume_unwind() 函数，则展开还会继续。
```

# Result<T,E>

> 一种可处理正确值和错误的枚举

```rust
#![allow(unused)]
// 文件处理标准库
use std::fs::File;
// 错误类型标准库
use std::io::ErrorKind;

fn main() {
    let f = File::open("hello.txt");

    let f = match f {
        Ok(file) => file,
        Err(error) => match error.kind() {
            ErrorKind::NotFound => match File::create("hello.txt") {
                Ok(fc) => fc,
                Err(e) => panic!("Problem creating the file: {:?}", e),
            },
            other_error => panic!("Problem opening the file: {:?}", other_error),
        },
    };
}
```

> 高级[错误处理](TODO)请看这里

## 将错误向上传播(?)

> 好处：顶级处理错误 | 将错误封装发送给用户

### 复杂版

```rust
#![allow(unused)]
fn main() {
    use std::fs::File;
    use std::io::{self, Read};

    fn read_username_from_file() -> Result<String, io::Error> {
        // 打开文件，f是`Result<文件句柄,io::Error>`
        let f = File::open("hello.txt");

        let mut f = match f {
            // 打开文件成功，将file句柄赋值给f
            Ok(file) => file,
            // 打开文件失败，将错误返回(向上传播)
            Err(e) => return Err(e),
        };
        // 创建动态字符串s
        let mut s = String::new();
        // 从f文件句柄读取数据并写入s中
        match f.read_to_string(&mut s) {
            // 读取成功，返回Ok封装的字符串
            Ok(_) => Ok(s),
            // 将错误向上传播
            Err(e) => Err(e),
        }
    }
    let f = read_username_from_file().expect("Failed to read username");
    println!("{}", f);
}
```

### 简易版

```rust
#![allow(unused)]
fn main() {
    use std::error;
    use std::fs;
    use std::io;
    // 因为 read_to_string() 在 Read Trait 中实现，所以需要引入
    use std::io::Read;

    //: 简易版 60 分
    // ? 用于将错误向上传播
    // ? 的自定义使用：需要为自定义的 Error 实现 From<T> trait，并且实现 Display trait
    fn read_username_from_file() -> Result<String, io::Error> {
        // 如果结果是 Ok(T)，则把 T 赋值给 f，如果结果是 Err(E)，则 return 该错误(通用)
        let mut f = fs::File::open("hello.txt")?;
        let mut s = String::new();
        f.read_to_string(&mut s)?;
        Ok(s)
    }

    //: 简易版 80 分
    // 因为 impl error::Error for Error {}, 所以可以返回 error::Error 的 Trait 对象,这样只要实现了 error::Error 的类型都可以返回(打破局限性)
    fn read_username_from_file2() -> Result<String, Box<dyn error::Error>> {
        let mut s = String::new();
        // ? 还能实现链式调用，File::open 遇到错误就返回，没有错误就将 Ok 中的值取出来用于下一个方法调用
        fs::File::open("hello.txt")?.read_to_string(&mut s)?;
        Ok(s)
    }

    //: 简易版 100 分
    fn read_username_from_file3() -> Result<String, io::Error> {
        // 系统自带的方法，可以直接读取文件内容
        // 本质和上面一样
        fs::read_to_string("hello.txt")
    }
}
```

## ? 用于 Option<T>

```rust
#![allow(unused)]
fn main() {
    fn get(s: &[i32]) -> Option<&i32> {
        // 是这么用，但是多次一举
        let v = s.get(0)?;
        Some(v)
    }

    fn get2(s: &[i32]) -> Option<&i32> {
        // 直接返回即可
        s.get(0)
    }

    // ? 在 Option<T> 多用于链式调用
    fn last_char_of_first_line(text: &str) -> Option<char> {
        text.lines().next()?.chars().last()
    }
}
```

## 带有返回值的 main

```rust
#![allow(unused)]
use std::error::Error;
use std::fs::File;

// std::error::Error is a trait that all standard errors implement.
fn main() -> Result<(), Box<dyn Error>> {
    let f = File::open("hello.txt")?;

    Ok(())
}
```

# 包和模块

```txt
1. 项目(Package)：可以用来构建、测试和分享包
2. 工作空间(WorkSpace)：对于大型项目，可以进一步将多个包联合在一起，组织成工作空间
3. 包(Crate)：一个由多个模块组成的树形结构，可以作为三方库进行分发，也可以生成可执行文件进行运行
4. 模块(Module)：可以一个文件多个模块，也可以一个文件一个模块，模块可以被认为是真实项目中的代码组织单元
```

## 包(Crate)

```txt
1. 是一个独立的可编译单元，它编译后会生成一个可执行文件或者一个库
2. 常作为第三方库使用: use rand
```

## 项目(Package)

> 包含有独立的 Cargo.toml 文件，以及因为功能性被组织在一起的一个或多个包

### 二进制 Package

> src/main.rs 是二进制包的根文件, 所有的代码执行都从该文件中的 fn main() 函数开始

### 库 Package

> 只能作为三方库被其它项目引用，而不能独立运行
> src/lib.rs 是库包的根文件(唯一)

## 目录结构

```txt
.
├── Cargo.toml
├── Cargo.lock
├── src
│   ├── main.rs
│   ├── lib.rs
│   └── bin
│       └── main1.rs
│       └── main2.rs
├── tests
│   └── some_integration_tests.rs
├── benches
│   └── simple_bench.rs
└── examples
    └── simple_example.rs

1. 唯一库包：src/lib.rs
2. 默认二进制包：src/main.rs，编译后生成的可执行文件与 Package 同名
3. 其余二进制包：src/bin/main1.rs 和 src/bin/main2.rs，它们会分别生成一个文件同名的二进制可执行文件
4. 集成测试文件：tests 目录下
5. 基准性能测试 benchmark 文件：benches 目录下
6. 项目示例：examples 目录下
```

## 模块(Module)

推荐使用 2018 版本的目录组织

```txt
.
├── lib.rs
├── foo.rs
└── foo/
    └── bar.rs
    └── test.rs
```

以下为 2015 版本的目录组织

> src/aico/mod.rs

```rust
#![allow(unused)]
// 嵌套 mod
//public
pub mod test_mod {
    // public
    pub mod v1 {
        // pravate
        fn test_fn() {
            println!("v1 test_fn");
        }
        // public
        pub fn test_fn_with_param(param: i32) {
            // 同一 mod 中可以直接调用
            test_fn();
            println!("v2 test_fn_with_param: {}", param);
        }
    }

    // private
    mod v2 {
        // private
        fn test_fn() {
            println!("v1 test_fn");
        }
        // public
        pub fn test_fn_with_param(param: i32) {
            test_fn();
            println!("v2 test_fn_with_param: {}", param);
        }
    }
}

pub struct TestStruct {
    name: String,
}

impl TestStruct {
    pub fn new(name: String) -> TestStruct {
        TestStruct { name }
    }

    pub fn get_name(&self) -> &String {
        &self.name
    }
}
```

> src/lib.rs

```rust
// 声明 mod
// 当外部的模块项 aico 被引入到当前模块中时，它的可见性自动被设置为私有的, 需要手动设置 pub
pub mod aico;

// 引入 mod 中的数据到当前域
pub use crate::aico::{test_mod, TestStruct};
// 需要外部访问，设为 pub
pub fn call_test_fn() {
    test_mod::v1::test_fn_with_param(1);
    // 无法访问 mod v2, 因为其为 private
    // crate::test_mod::v2::test_fn_with_param(2);
}
```

> src/main.rs

```rust
// 使用自定义库函数(包名::函数名)
// 使用 as 起别名
use hello_world::call_test_fn as A;
// 使用自定义结构体(包名::结构体名)
use hello_world::TestStruct;
fn main(){
    A();
    let test_struct = TestStruct::new(String::from("test2"));
    println!("test_struct.name: {}", test_struct.get_name());
}
```

### struct & enum 的可见性

```txt
1. 将 struct 设置为 pub，但它的所有字段依然是私有的
2. 将 enum 设置为 pub，它的所有字段也将对外可见
```

### 引入模块的 self 形式

```rust
use std::io;
use std::io::Write;

// 等价于
use std::io::{self, Write};
```

### 所有引入 \*

```rust
// 写项目不推荐使用
use std::collections::*;
```

### 限制性语法

```txt
1. pub 意味着可见性无任何限制
2. pub(crate) 表示在当前包可见
3. pub(self) 在当前模块可见
4. pub(super) 在父模块可见
5. pub(in <path>) 表示在某个路径代表的模块中可见，其中 path 必须是父模块或者祖先模块
```

# 注释和文档

## 代码注释

```rust
// this is a comment

// or

/*
this
is
a
comment
*/
```

### 文档注释

```txt
1. 文档注释需要位于 lib 类型的包中，例如 src/lib.rs 中
2. 文档注释可以使用 markdown语法！例如 # Examples 的标题，以及代码块高亮
3. 被注释的对象需要使用 pub 对外可见，记住：文档注释是给用户看的，内部实现细节不应该被暴露出去

```

```rust
/// this is a doc comment

//or

/**
this
is
a
doc
comment
*/

```

### 模块注释

```rust
//! this is module or crate comment

//or

/*!
this
is
module
or
crate
comment
*/
```

## 编写单元测试

````rust
    /** `new` is used to generate `Test` object
    # Example
    ```rust
    use lyy_test::Test;
    let test = Test::new(1);
    println!("{}", test.x());
    ```
    */
````

### 如果遇到单元测试中存在 panic

````rust
    /** `new` is used to generate `Test` object
    # Example
    ```rust,should_panic
    panic("hahaha")
    ```
    */
````

## 文档特性

### 文档中不显示单元测试代码

````rust
    /** `new` is used to generate `Test` object
    # Example
    ```rust
    # // # 与后面的代码必须空一行
    # use lyy_test::Test;
    # let test = Test::new(1);
    # println!("{}", test.x());
    ```
    */
````

### 文档注释跳转

````rust
    // 采用 [`xxx`] 的形式可以使得跳转
    // 比如: xxx 可以为标准库中的 Option
    // 比如: xxx 可以为标准库中的 std::future::Future
    // 比如: xxx 可以为自定义库中的 crate::Test
    // 比如: xxx 可以为自定义库中的 A
    /** `new` is used to generate [`Test`] object
    # Example
    ```rust
    # // # 与后面的代码必须空一行
    # use lyy_test::Test;
    # let test = Test::new(1);
    # println!("{}", test.x());
    ```
    */

````

### 为文档定义搜索别名

```rust
#[doc(alias("test","x"))]
pub struct Test {
    x: i32,
}
```

# 格式化输出

## 三大金刚

```txt
1. print! 将格式化文本输出到标准输出，不带换行符
2. println! 同上，但是在行的末尾添加换行符 (用于调试)
3. format! 将格式化文本输出到 String 字符串 (用于生成格式化字符串)
```

```rust
fn main() {
    let a = 1;
    println!("{}", a);

    // String
    let s = format!("{}", a);
    println!("{}", s);
}
```

## 两大护法

```txt
1. eprint! 将格式化文本输出到标准错误，不带换行符
2. eprintln! 同上，但是在行的末尾添加换行符 (用于输出错误信息和进度信息)
```

## {} & {:?} & {:#?}

```txt
1. {} 适用于实现了 std::fmt::Display Trait 的类型，用来以更优雅、更友好的方式格式化文本，例如展示给用户
2. {:?},{:#?} 适用于实现了 std::fmt::Debug Trait 的类型，用于调试场景
```

### Debug Trait

```rust
#[derive(Debug)]
struct Test {
    a: String;
}
```

### Display Trait

```txt
1. 为自定义类型实现 Display 特征
2. 使用 newtype 为外部类型实现 Display 特征, 比如 Vector 就是外部类型
```

> 有关[newtype](TODO)在这里

```rust
// 用元组包装就是 newtype
struct Array(Vec<i32>);

use std::fmt;
impl fmt::Display for Array {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "数组是：{:?}", self.0)
    }
}
fn main() {
    let arr = Array(vec![1, 2, 3]);
    println!("{}", arr);
}
```

## 格式化输出

### 小数点保留

```rust
fn main() {
    let v = 3.1415926;
}
fn main() {
    let v = 3.1415926;
    // 保留两位小数 Display => 3.14
    println!("{:.2}", v);
    // 保留两位小数 Debug => 3.14
    println!("{:.2?}", v);
    // 带符号保留小数点后两位 => +3.14
    println!("{:+.2}", v);
    // 不带小数 => 3
    println!("{:.0}", v);
    // 通过参数来设定精度 => 3.1416，相当于{:.4}
    println!("{:.1$}", v, 4);

    let s = "hi我是Sunface孙飞";
    // 保留字符串前三个字符 => hi我
    println!("{:.3}", s);
    // {:.*}接收两个参数，第一个是精度或字符数，第二个是被格式化的值 => Hello abc!
    println!("Hello {:.*}!", 3, "abcdefg");
}
```

### 填充

```rust
fn main() {
    // 宽度是5 => Hello     5!
    // 默认右对齐
    //{:[什么符号][用什么填充][对齐方式(< | ^ | >)][宽度是多少][?(表示Debug Trait)]}
    println!("Hello {:5}!", 5);
    // 显式的输出正号 => Hello +5!
    println!("Hello {:+}!", 5);
    // 宽度5，使用0进行填充 => Hello 00005!
    println!("Hello {:05}!", 5);
    // 负号也要占用一位宽度 => Hello -0005!
    println!("Hello {:&<5}!", -5);
}

```

### 进制

```txt
1. #b, 二进制
2. #o, 八进制
3. #x, 小写十六进制
4. #X, 大写十六进制
5. x, 不带前缀的小写十六进制
```

```rust
fn main() {
    // 二进制 => 0b11011!
    // 默认右对齐
    // {:#[用什么填充][宽度是多少][什么进制]}
    println!("{:#b}!", 27);
    // 八进制 => 0o33!
    println!("{:#o}!", 27);
    // 十进制 => 27!
    println!("{}!", 27);
    // 小写十六进制 => 0x1b!
    println!("{:#x}!", 27);
    // 大写十六进制 => 0x1B!
    println!("{:#X}!", 27);

    // 不带前缀的十六进制 => 1b!
    println!("{:x}!", 27);

    // 使用0填充二进制，宽度为10 => 0b00011011!
    println!("{:#010b}!", 27);
}
```

### 指数

```rust
fn main() {
    println!("{:2e}", 1000000000); // => 1e9
    println!("{:2E}", 1000000000); // => 1E9
}
```

### 指针地址

```rust
    let v= vec![1, 2, 3];
    println!("{:p}", v.as_ptr()) // => 0x600002324050
```

### 转义{}

```rust
fn main() {
    // {使用{转义，}使用} => Hello {}
    // 必须同时转义
    println!("Hello {{}}");

    // 下面代码会报错，因为占位符{}只有一个右括号}，左括号被转义成字符串的内容
    // println!("{{ Hello }");
}
```

## 格式化字符串时捕获环境中的值

```rust
#![allow(unused)]
fn main() {
let (width, precision) = get_format();
for (name, score) in get_scores() {
  // width$ 表示这是格式化参数
  println!("{name}: {score:width$.precision$}");
}
}
```
