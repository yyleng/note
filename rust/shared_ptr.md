# 智能指针

```txt
1. 智能指针, 主要就在于它实现了 Deref Trait 和 Drop Trait
2. Deref Trait 可以让智能指针像引用那样工作，这样你就可以写出同时支持智能指针和引用的代码，例如 *T
3. Drop Trait 允许智能指针超出作用域后自动执行的代码，例如做一些数据清除等收尾工作
```

## Box 堆对象分配

### 堆栈

**栈**

```txt
1. main 线程的栈大小是 8MB，普通线程是 2MB
2. 在函数调用时会在栈中创建一个临时栈空间, 调用结束后会让这个栈空间里的对象自动进入 Drop 流程, 最后栈顶指针自动移动到上一个调用栈顶
3. 栈内存申请和释放是非常高效的
4. 栈内存从高位地址向下增长, 且栈内存是连续分配的
```

**堆**

```txt
1. 堆内存是从低位地址向上增长, 而且通常是不连续的
2. 堆上对象在栈中都拥有一个所有者, 当赋值时, 发生的是所有权的转移(浅拷贝栈上的引用或智能指针)
```

**举例**

```rust
fn main() {
    // 当被从 foo 函数转移给 main 中的 b 变量时
    // 栈上的智能指针结构体被复制一份赋予给 b
    let b = foo("world");
    println!("{}", b);
}

fn foo(x: &str) -> String {
    // a 是 String 类型, 是智能指针结构体,
    // 该智能指针结构体存储在函数栈中，其中元素指向堆上的字符串数据
    let a = "Hello, ".to_string() + x;
    a
}
```

**性能比较**

> 栈的分配速度肯定比堆上快，但是读取速度往往取决于你的数据能不能放入寄存器或 CPU 高速缓存

```txt
1. 小型数据: 在栈上的分配性能和读取性能都要比堆上高
2. 中型数据: 栈上分配性能高, 但是读取性能和堆上并无区别, 因为无法利用寄存器或 CPU 高速缓存, 最终还是要经过一次内存寻址
3. 大型数据: 只建议在堆上分配和使用
```

### Box 智能指针

**应用场景**

```
1. 特意的将数据分配在堆上
2. 数据较大时, 又不想在转移所有权时进行数据拷贝
3. 类型的大小在编译期无法确定, 但是我们又需要固定大小的类型时
4. Trait 对象, 用于说明对象实现了一个特征，而不是某个特定的类型
```

#### 使用 Box<T> 将数据存储在堆上

```rust
fn main() {
    // 3 存储在堆上
    // Box<T> 智能指针 a 存储在栈上(其是就是一个元组结构体 struct Box<T>(T) ), 结构体中的指针指向存储在堆上的 3
    // 上述结构体自动实现了 Deref Trait 和 Drop Trait
    let a = Box::new(3);
    // 隐式调用 Deref Trait 中的 deref 方法对 a 进行解引用
    println!("a = {}", a); // a = 3
    // Box<T> 智能指针 a 将在作用域结束时被释放掉, 这是因为 Box<T> 实现了 Drop Trait
}
```

#### 避免栈上数据的拷贝

```rust
fn main() {
    // 在栈上创建一个长度为1000的数组
    let arr = [0;1000];
    // 将arr所有权转移arr1, 由于 arr 分配在栈上, 因此这里实际上是直接重新深拷贝了一份数据
    let arr1 = arr;

    // arr 和 arr1 都拥有各自的栈上数组
    println!("{:?}", arr.len());
    println!("{:?}", arr1.len());

    // 在堆上创建一个长度为1000的数组, 然后使用一个 Box<T> 智能指针指向它
    let arr = Box::new([0;1000]);
    // 将堆上数组的所有权转移给 arr1, 由于数据在堆上, 因此仅仅拷贝了 Box<T> 智能指针的结构体, 底层数据并没有被拷贝
    // 所有权顺利转移给 arr1, arr 不再拥有所有权
    let arr1 = arr;
    println!("{:?}", arr1.len());
    // 由于 arr 不再拥有底层数组的所有权, 因此下面代码将报错
    // println!("{:?}", arr.len());
}
```

#### 将动态类型变为固定类型

```rust
#![allow(unused)]
fn main() {
    // 这种递归类型是动态类型
    // 大小无法在编译期间就确定
    // enum List {
    //     Cons(i32, List),
    //     Nil,
    // }

    // 因此, 只需要将 List 数据存放在堆上, 本地只保留 Box<T> 智能指针结构体即可
    // Box<T> 指针指针结构体具有固定大小, 可以在编译期间确定
    enum List {
        Cons(i32, Box<List>),
        Nil,
    }
}
```

#### Trait 对象

```rust
trait Draw {
    fn draw(&self);
}

struct Button {
    id: u32,
}
impl Draw for Button {
    fn draw(&self) {
        println!("这是屏幕上第{}号按钮", self.id)
    }
}

struct Select {
    id: u32,
}

impl Draw for Select {
    fn draw(&self) {
        println!("这个选择框贼难用{}", self.id)
    }
}

fn main() {
    let elems: Vec<Box<dyn Draw>> = vec![Box::new(Button { id: 1 }), Box::new(Select { id: 2 })];

    for e in elems {
        e.draw()
    }
}
```

### Box 内存布局

> 以 Vec<Box<i32>> 为例

```txt
                    (heap)
(stack)    (heap)   ┌───┐
┌──────┐   ┌───┐ ┌─→│ 1 │
│ vec2 │──→│B1 │─┘  └───┘
└──────┘   ├───┤    ┌───┐
           │B2 │───→│ 2 │
           ├───┤    └───┘
           │B3 │─┐  ┌───┐
           ├───┤ └─→│ 3 │
           │B4 │─┐  └───┘
           └───┘ │  ┌───┐
                 └─→│ 4 │
                    └───┘
智能指针 vec2 存储在栈上, 然后指针指向一个堆上的数组
该数组中每个元素都是一个 Box 智能指针, 最终 Box 智能指针又指向了存储在堆上的实际值
```

## Deref Trait

### 常规引用

```rust
fn main() {
    let x = 5;
    // y 为 x 的不可变引用
    let y = &x;
    assert_eq!(5, x);
    // 对 y 的解引用
    assert_eq!(5, *y);
}
```

### Box<T> 智能指针解引用

> Box<T> 智能指针自动实现了 Deref Trait, 因此支持自动解引用

```rust
fn main() {
    let x = Box::new(1);
    // 对Box<i32> 智能指针进行解引用
    let sum = *x + 1;
    println!("{}", sum);
}
```

### 定义类似于 Box<T> 的智能指针

> Box<T> 智能指针并没有包含类如长度、最大长度等信息，本身就是一个元组结构体

```rust
use std::ops::Deref;

struct Mybox<T>(T);

impl<T> Mybox<T> {
    fn new(x: T) -> Mybox<T> {
        Mybox(x)
    }
}

// 为 Mybox<T> 实现 Deref Trait, 使之可以被解引用
impl<T> Deref for Mybox<T> {
    // 定义关联类型, 提高可读性
    type Target = T;
    // 重载解引用运算符
    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

fn main() {
    let x = Mybox::new(1);
    // 相当于 *(x.deref())
    let sum = *x + 1;
    println!("{}", sum);
}
```

### 函数和方法中的隐式 Deref 转换

```txt
1. &s 形式会触发自动解引用
2. 函数调用形式会触发自动解引用
```

> Deref 隐式转换

```rust
fn main() {
    let s = String::from("hello world");
    // 必须通过 &s 的方式来触发 String 的自动解引用, 相当于传入类型为 &String
    // 即会自动触发 s.deref() 方法, 返回类型为 &str
    // 相当于 display(s.deref())
    display(&s);
}

fn display(s: &str) {
    println!("{}",s);
}
```

> Deref 隐式转换支持连续性

```rust
fn main() {
    let s = Box::new(String::from("hello world"));
    // 相当于 display(s.deref().deref());
    // 第一个 s.deref() 返回类型为 String
    // 第二个 s.deref() 返回类型为 &str
    display(&s);
}

fn display(s: &str) {
    println!("{}",s);
}
```

> 方法调用会自动解引用

```rust
fn main() {
    let s = Box::new(String::from("hello, world"));
    // 相当于 s.deref().deref();
    // 第一个 s.deref() 返回类型为 String
    // 第二个 s.deref() 返回类型为 &str
    let s1: &str = &s;
    // 方法调用会自动解引用
    // 进而触发连续解引用
    let s2: String = s.to_string();
    println!("s1: {}", s1);
    println!("s2: {}", s2);
}
```

### 引用归一化

```txt
1. 一个类型为 T 的对象 foo, 如果 T: Deref<Target=U>,
   那么, 相关 foo 的引用 &foo 在应用的时候会自动转换为 &U
2. Rust 会在解引用时自动把智能指针和 &&&&v 做引用归一化操作
   转换成 &v 形式，最终再对 &v 进行解引用
```

> 如下

```rust
// 标准库源码
// &T: Deref<Target=T>
// 也即 &&T 会被自动解引用为 &T
impl<T: ?Sized> Deref for &T {
    type Target = T;

    fn deref(&self) -> &T {
        *self
    }
}
```

### 三种 Deref 转换

```txt
1. 当 T: Deref<Target=U>，可以将 &T 转换成 &U
2. 当 T: DerefMut<Target=U>，可以将 &mut T 转换成 &mut U
3. 当 T: Deref<Target=U>，可以将 &mut T 转换成 &U

explanation

1. 要实现 DerefMut Trait 必须要先实现 Deref Trait , 因为 pub trait DerefMut: Deref
```

```rust
struct MyBox<T> {
    v: T,
}

impl<T> MyBox<T> {
    fn new(x: T) -> MyBox<T> {
        MyBox { v: x }
    }
}

use std::ops::Deref;

impl<T> Deref for MyBox<T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        &self.v
    }
}

use std::ops::DerefMut;

impl<T> DerefMut for MyBox<T> {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.v
    }
}

fn main() {
    let mut s = MyBox::new(String::from("hello, "));
    // 将 &mut MyBox<String> 隐式转换为 &mut String
    display(&mut s)
}

fn display(s: &mut String) {
    s.push_str("world");
    println!("{}", s);
}
```

## Drop Trait

```rust
struct HasDrop1;
struct HasDrop2;
impl Drop for HasDrop1 {
    // Drop Trait 中的 drop() 方法参数是可变借用
    fn drop(&mut self) {
        println!("Dropping HasDrop1!");
    }
}
impl Drop for HasDrop2 {
    fn drop(&mut self) {
        println!("Dropping HasDrop2!");
    }
}
struct HasTwoDrops {
    one: HasDrop1,
    two: HasDrop2,
}
// 即使 HasTwoDrops 没有实现 Drop Trait
// 其结构体中的元素依旧会按顺序自动调用相应的 drop() 方法
impl Drop for HasTwoDrops {
    fn drop(&mut self) {
        println!("Dropping HasTwoDrops!");
    }
}

struct Foo;

impl Drop for Foo {
    fn drop(&mut self) {
        println!("Dropping Foo!")
    }
}

fn main() {
    let _x = HasTwoDrops {
        two: HasDrop2,
        one: HasDrop1,
    };
    let _foo = Foo;
    println!("Running!");
}
// 变量级别，按照逆序的方式调用 drop() 方法
// 结构体内部，按照顺序的方式调用 drop() 方法
```

### 手动回收

```txt
1. 无法手动调用 Drop Trait 中的 drop() 方法
2. 如需手动回收, 只能调用 std::mem::drop() 函数,
   该函数会转移目标的所有权

```

```rust
#[allow(unused)]
struct Foo {
    v: i32,
}

impl Drop for Foo {
    fn drop(&mut self) {
        println!("Dropping {}", self.v);
    }
}

fn main(){
    let f = Foo { v: 1 };
    // 手动调用 Drop Trait 中的 drop () 方法, 该方法为空实现
    // std::mem::drop()
    // 该函数会转移目标的所有权, 使之无法再被访问
    // 在 drop() 方法中, 会调用 Drop Trait 中的 drop() 方法进行回收
    drop(f);
    // 编译出错
    // println!("{}", f.v);
}
```

### Copy Trait 和 Drop Trait 不能同时存在

```txt
无法为一个类型同时实现 Copy 和 Drop Trait
因为实现了 Copy Trait 会被编译器隐式的复制
因此非常难以预测 Drop Trait 中的 drop() 方法执行的时间和频率
因此这些实现了 Copy Trait 的类型无法实现 Drop Trait。
```

## 引用计数

```txt
1. 通过引用计数(Rc & Arc)的方式, 允许一个数据资源在同一时刻拥有多个所有者(打破了所有权机制)
2. Rc/Arc 是不可变引用, 无法修改它指向的值, 只能进行读取,
   如果要修改, 需要配合内部可变性 RefCell<T> 或互斥锁 Mutex<T>
3. 一旦最后一个所有者消失, 则资源会自动被回收, 这个生命周期是在编译期就确定下来的
4. Rc<T> 只能用于同一线程内部,因为 Rc<T> 没有实现 Send Trait,
   再者, 由于 Rc<T> 需要管理引用计数, 但是 Rc<T> 计数器并没有使用任何并发原语,
   因此无法实现原子化的计数操作, 最终会导致计数错误,
5. 想要用于线程之间的对象共享, 需要使用 Arc<T>, Arc<T> 是多线程安全的,
   Arc<T> 就是原子化(Automic)的 Rc<T> 智能指针
6. Rc<T> 和 Arc<T> 是智能指针，实现了 Deref Trait
7. Arc<T> 在 std::sync::Arc 模块中, Rc<T> 在 std::rc::Rc 模块中
```

### Rc<T> 应用场景

```txt
以 Rc 为例, 当我们希望在堆上分配一个对象供程序的多个部分使用且无法确定哪个部分最后一个结束时
就可以使用 Rc 成为数据值的所有者
```

```rust
// 想要使 a, b 同时成为数据的所有者
// 使用 Box<T> 智能指针就会出错
// 因为 Box<T> 智能指针会转移所有权
#[allow(unused)]
fn main() {
    let s = String::from("hello, world");
    // s在这里被转移给a
    let a = Box::new(s);
    // 报错！此处继续尝试将 s 转移给 b
    // let b = Box::new(s);
}
```

```rust
use std::rc::Rc;
fn main() {
    // Rc<T> 智能指针结构体中的指针指向堆上的数据
    // Rc<T> 智能指针结构体中的引用计数器用于记录 Rc<T> 智能指针结构体的引用次数
    // 引用计数在创建时 + 1
    let a = Rc::new(String::from("hello, world"));
    // Rc<T> 智能指针结构体自动实现了 Clone Trait
    // 这里的 clone 仅仅复制了 Rc<T> 智能指针结构体并增加了引用计数，并没有克隆底层数据
    let b = Rc::clone(&a);

    // 关联函数Rc::strong_count() 用于获取 Rc<T> 引用计数
    assert_eq!(2, Rc::strong_count(&a));
    // 两者引用计数相同
    assert_eq!(Rc::strong_count(&a), Rc::strong_count(&b))
}
```

### Arc<T> 简单应用

```rust
use std::sync::Arc;
use std::thread;

fn main() {
    let s = Arc::new(String::from("多线程漫游者"));
    for _ in 0..10 {
        let s = Arc::clone(&s);
        let handle = thread::spawn(move || {
           println!("{}", s)
        });
        match handle.join() {
            // _ 自动由编译器推导
            Ok(_) => (),
            Err(_) => println!("Error"),
        }
    }
}
```
