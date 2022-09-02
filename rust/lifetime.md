# 生命周期<span id="lifetime"></span>

```txt
1. 函数或者方法中，参数的生命周期被称为 输入生命周期，返回值的生命周期被称为 输出生命周期
2. 在存在多个引用时，编译器有时会无法自动推导生命周期，此时就需要我们手动去标注，通过为参数标注合适的生命周期来帮助编译器进行引用检查的分析
3. 生命周期的作用就是告诉编译器多个引用之间的关系
4. 生命周期标注并不会改变任何引用的实际作用域
5. 和泛型一样，使用生命周期参数，需要先声明 <'a>

```

```rust
// 编译器无法知道该函数返回值的生命周期到底引用 x 还是 y
// 因为编译器需要知道这些，来确保内存安全
fn longest(x: &str, y: &str) -> &str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```

## 函数中的生命周期

```rust
fn main() {
    let string1 = String::from("abcd");
    let string2 = "xyz";

    let result = longest(string1.as_str(), string2);
    println!("The longest string is {}", result);
}
// 不手动标注生命周期编译会出错
// 表示： 返回值的生命周期 == min( x 引用目标的生命周期,y 引用目标的生命周期)
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

// 当只需要返回 x 时, 就可以不对 y 进行生命周期标注了
fn longest<'a>(x: &'a str, y: & str) -> &'a str {
        x
}
```

### 生命周期来源

函数的返回值如果是一个引用类型，那么它的生命周期只会来源于：

```txt
1. 函数参数的生命周期(只有这种情况是可取的)
2. 函数体中某个新建引用的生命周期(不可取，会导致悬空引用，引发内存问题)
```

## 结构体中的生命周期

```rust
// 表示： 结构体对象所引用的字符串 str 必须比该结构体对象活得更久
struct ImportantExcerpt<'a> {
    part: &'a str,
}
```

## 生命周期消除规则

> 若编译器发现以下规则都不适用时，就会报错，提示你需要手动标注生命周期

### 应用在输入生命周期上

**每一个引用参数都会获得独自的生命周期标记**

```rust
fn foo(x: &i32){}
// => 编译器转变
fn foo(x: &'a i32){}
```

```rust
fn foo(x: &i32,y &i32){}
// => 编译器转变
fn foo(x: &'a i32, y: &'b i32){}
```

### 应用在输出生命周期上

**若只有一个输入生命周期(函数参数中只有一个引用类型)，那么该生命周期会被赋给所有的输出生命周期**

```rust
fn foo(x: &'a i32) -> &i32{}
// => 编译器转变
fn foo(x: &'a i32) -> &'a i32{}
```

**若存在多个输入生命周期，且其中一个是 &self 或 &mut self，则 &self 的生命周期被赋给所有的输出生命周期**

```rust
fn compute(&self, var &i32) -> &i32{}

// => 编译器转变
fn compute(&'a self, var &'b i32) -> &'a i32{}

```

## 方法中的生命周期

> impl 中必须使用结构体的完整名称，包括 <'a>，因为生命周期标注也是结构体类型的一部分

```rust
struct ImportantExcerpt<'a> {
    part: &'a str,
}

impl<'a> ImportantExcerpt<'a> {
    // 未手动标注生命周期，会成功匹配编译器的输入规则和第二条输出规则，有效
    fn announce_and_return_part(&self, announcement: &str) -> &str {
        println!("Attention please: {}", announcement);
        self.part
    }
}
```

### 若不想默认

```rust
struct ImportantExcerpt<'a> {
    part: &'a str,
}

impl<'a> ImportantExcerpt<'a> {
    // 此时编译器无法知道生命周期 'a 和 'b 的关闭，报错
    fn announce_and_return_part<'b>(&'a self, announcement: &'b str) -> &'b str {
        println!("Attention please: {}", announcement);
        self.part
    }
}
fn main() {
    let str = String::from("hello world");
    {
        let a = ImportantExcerpt { part: &str };
        println!("{}", a.announce_and_return_part(&str));
    }
}

// 修改

impl<'a> ImportantExcerpt<'a> {
    // 此时编译器无法知道生命周期 'a 和 'b 的关闭，报错
    fn announce_and_return_part<'b>(&'a self, announcement: &'b str) -> &'b str // 返回值是引用者
    // 'a: 'b，是生命周期约束语法，跟泛型约束非常相似，用于说明 'a 必须比 'b 活得久
    where 'a : 'b
    {
        println!("Attention please: {}", announcement);
        // 被引用者
        // 被引用者的生命周期要大于引用者的生命周期
        // 即 'a > 'b
        self.part
    }
}
// or
impl<'a: 'b, 'b> ImportantExcerpt<'a> {
    fn announce_and_return_part(&'a self, announcement: &'b str) -> &'b str {
        println!("Attention please: {}", announcement);
        self.part
    }
}
```

## 静态生命周期

```rust
// 生命周期 'static 意味着能和程序活得一样久，例如字符串字面量和特征对象
// 实在遇到解决不了的生命周期标注问题，可以尝试 T: 'static
let s: &'static str = "hello";
```

[详细说明](#static)

## 复杂例子

```rust

#![allow(unused)]
fn main() {
use std::fmt::Display;

fn longest_with_an_announcement<'a, T>(
    x: &'a str,
    y: &'a str,
    ann: T,
) -> &'a str
where
    T: Display,
{
    // T Display print must implemented Display Trait
    println!("Announcement! {}", ann);
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
}
```

## 深入生命周期

TODO

## &'static 和 T: 'static <span id="static"></span>

TODO
