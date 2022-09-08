# 深入 Rust 类型

## newtype <span id="newtype"></span>

> 使用元组结构体的方式自定义类型

> 在为外部类型(比如 Vector)实现自定义或外部(其他模块) Trait 时, 必须这么做

### 为外部类型实现自定义 Trait

```rust
use std::fmt;

struct Wrapper(Vec<String>);

impl fmt::Display for Wrapper {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "[{}]", self.0.join(", "))
    }
}

fn main() {
    let w = Wrapper(vec![String::from("hello"), String::from("world")]);
    println!("w = {}", w);
}
```

### 自定义类型

```rust
// 这两个类型都是对 u32 的封装, 但是是不同类型
struct Meters(u32);
struct M(u32);
```

### 隐藏内部细节

```rust
struct Meters(u32);

fn main() {
    let i: u32 = 2;
    assert_eq!(i.pow(2), 4);

    let n = Meters(i);
    // 下面的代码将报错，因为`Meters`类型上没有`pow`方法
    // 但通过n.0.pow(2) 依旧可以调用, 小白看来是隐藏了的, 哈哈
    // assert_eq!(n.pow(2), 4);
}
```

## type

```rust
// 这两个类型都是对 u32 的别名, 依旧是相同类型
type Meters = u32;
type M = u32;

// more
type Result<T> = std::result::Result<T, std::io::Error>;
type Thunk = Box<dyn Fn() -> () + Send + 'static>;
```

## newtype 与 type 的区别总结

```txt
1. type 仅仅是别名，只是为了让可读性更好，并不是全新的类型，newtype 才是！
2. type 无法实现为外部类型实现外部 Trait 等功能，而 newtype 可以
```

## ! 永不返回类型

```rust
fn main() {
    let i = 2;
    let v = match i {
       // 返回类型是 i32
       0..=3 => i,
       // 理论上来说应该也返回 i32 类型
       // 因为 panic! 的返回类型是 ！, 永不返回类型, 所以这里是合法的
       _ => panic!("不合规定的值:{}", i)
    };
}
```

## 动态类型和固定类型

```txt
1. 固定类型: 这些类型的大小在编译时是已知的
2. 动态类型: 这些类型的大小只有到了程序运行时才能动态获知
```

### 动态类型

```txt
1. Vector、String、HashMap 都不是动态类型, 因为
   这些底层数据是保存在堆上，而在栈中还存有一个引用类型
   栈上的引用类型是固定大小的，因此它们依然是固定类型

2. 切片 [T] 是动态类型, 而 &[T] 是固定类型
3. str 是动态类型, 而 &str 是字符串切片, 是固定类型
4. dyn Trait 是动态类型
```

> 动态类型都无法单独被使用，必须要通过 & 或者 Box(智能指针) 来间接使用

## Sized Trait

```rust
#![allow(unused)]
fn main() {
    fn generic<T>(t: T) {
    // --snip--
    }
}
```

> generic 函数只能接受固定类型, T 类型自动添加了 Sized Trait 约束,
> 所有固定类型，都自动实现了 Sized Trait

> 每一个 Trait 都是一个可以通过名称来引用的动态类型。
> 因此如果想把 Trait 作为具体的类型来传递给函数，必须将其转换成一个 Trait 对象

## 在泛型中使用动态类型

```rust
#![allow(unused)]
fn main() {
    // ?Sized Trait 用于表明类型 T 既有可能是固定类型，也可能是动态类型
    // 函数参数类型从 T 变成了 &T，因为 T 可能是动态大小的，因此需要用一个固定大小的引用来指向它
    fn generic<T: ?Sized>(t: &T) {
    // --snip--
    }
}
```

## 将整数转换为 enum

TODO

### 使用第三方库 (推荐)

### TryFrom Trait

### std::mem::transmute

```rust
#[repr(i32)]
#[allow(unused)]
enum MyEnum {
    A = 1, B, C
}

fn main() {
    let x = MyEnum::C;
    let y = x as i32;
    // 如此使用, 必须要确保y 值在枚举范围内
    let z: MyEnum = unsafe { std::mem::transmute(y) };

    match z {
        MyEnum::A => { println!("Found A"); }
        MyEnum::B => { println!("Found B"); }
        MyEnum::C => { println!("Found C"); }
    }
}
```
