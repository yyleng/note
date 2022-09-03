# 闭包 (Closure)

> closure 是一种匿名函数，它可以赋值给变量也可以作为参数传递给其它函数，不同于函数的是，它允许捕获调用者作用域中的值

```rust
fn main() {
   let x = 1;
   // y 是参数, x 是作用域中的值
   let sum = |y| x + y;
   assert_eq!(3, sum(2));
   // x 是参数
   let func = |x| {
       println!("Hello");
       x
   };
   func(x);
   // 完整版closure
   let complete = |x: i32, y: i32| -> i32 { x + y };
   println!("{}", complete(1, 2));
   // 可以直接将一个函数赋值给变量
   let print_str = test;
   print_str(&String::from("Hello"));
}
fn test(x: &str) {
    println!("{}", x);
}

```

> closure 不是泛型，当编译器推导出一种类型后，它就会一直使用该类型

```rust
fn main() {
    let func = |x| x;
    println!("{}", func(1));
    // 下面这句会报错，因为经过第一次使用类型已经确定为 i32
    // println!("{}", func("hello"));
}
```

## 结构体中的 closure

```rust
struct Foo<T>
// T 必须实现标准库中的 Fn Trait
where T: Fn(i32) -> i32
{
    // 在这里, 形式为 |x| x + 1 的 closure 就是一个合法的 T
    // 在这里, 形式为 fn(x: i32) -> i32 的函数也是一个合法的 T
    closure: T,
    value: Option<i32>,
}

impl<T> Foo<T>
where T: Fn(i32) -> i32
{
    fn new(closure: T) -> Foo<T> {
        Foo {
            closure,
            value: None,
        }
    }

    fn call(&mut self, arg: i32) -> i32 {
        match self.value {
            Some(value) => value,
            None => {
                let v = (self.closure)(arg);
                self.value = Some(v);
                v
            }
        }
    }
}

fn main(){
    let foo = Foo::new(|x| x + 1).call(2);
    println!("{}", foo);
}
```

## closure 捕获作用域中的值

> 闭包捕获变量有三种途径，恰好对应函数参数的三种传入方式：
> 转移所有权(FnOnce)、可变借用(FnMut)、不可变借用(Fn)

> 一个闭包实现了哪种 Fn Trait 取决于该闭包如何使用被捕获的变量，而不是取决于闭包如何捕获它们

```txt
1. 所有的 closure 都自动实现了 FnOnce Trait，因此任何一个 closure 都至少可以被调用一次
2. 在1的基础上, 没有移出所捕获变量的所有权的 closure 自动实现了 FnMut 特征
3. 在2的基础上, 不需要对捕获变量进行修改的 closure 自动实现了 Fn Trait
```

## 不对捕获的变量进行修改

```rust
fn func<T>(f: T)
where
    T: Fn(usize) -> bool,
{
    // 可以调用多次 closure
    println!("{}", f(1));
    println!("{}", f(3));
}

fn func2<T>(f: T)
where
    T: FnOnce(usize) -> bool,
{
    // 只能调用一次 closure
    println!("{}", f(1));
    // 调用多次会报错
    // println!("{}", f(3));
}

fn func3<T>(f: T)
where
    // 同样是 FnOnce Trait, 如果为 closure 添加 Copy Trait，则可以调用多次
    T: FnOnce(usize) -> bool + Copy,
{
    println!("{}", f(1));
    println!("{}", f(3));
}

// 与普通的函数或方法不同，需要在 f 之前 添加关键字 mut 表示可变的
fn func4<T>(mut f: T)
where
    T: FnMut(usize) -> bool,
{
    // 可以调用多次 closure
    println!("{}", f(1));
    println!("{}", f(3));
}

fn main() {
    let v = vec![1, 2, 3];
    // () 中的 closure 没有对捕获的变量进行改变
    // 因此该 closure 实现了 FnOnce Trait ,Fnmut Trait 和 Fn Trait
    func(|x| x == v.len());
    func2(|x| x == v.len());
    func3(|x| x == v.len());
    func4(|x| x == v.len());
    // 可以看出 v 在 closure 中是不可变借用, 因为 v 没有转移所有权
    for i in &v {
        println!("{}", i);
    }
}
```

## 对捕获的变量进行修改或移动所有权

```rust
// 与普通的函数或方法不同，需要在 f 之前 添加关键字 mut 表示可变的
fn func<T>(mut f: T)
where
    T: FnMut(usize) -> (),
{
    // 可以调用多次 closure
    f(4);
    f(5);
}

fn func2<T>(f: T)
where
    T: FnOnce(usize) -> (),
{
    // 只能调用一次 closure
    f(6);
    // 调用多次会报错
    // f(7);
}

fn func3<T>(f: T)
where
    T: FnOnce(usize) -> Vec<usize>,
{
    // 只能调用一次 closure
    let moved_v = f(8);
    for i in &moved_v {
        println!("{}", i);
    }

    // 调用多次会报错
    // let moved_v2 = f(7);
}

fn main() {
    let mut v = vec![1, 2, 3];
    // () 中的 closure 对捕获的变量进行了改变, 但是没有移动
    // 因此该 closure 实现了FnOnce Trait 和 FnMut Trait
    func(|x| v.push(x));
    func2(|x| v.push(x));
    // 可以看出 v 在 closure 中是可变借用, 因为 v 没有转移所有权
    for i in &v {
        println!("{}", i);
    }
    // () 中的 closure 对捕获的变量进行了改变, 而且移动了捕获的变量的所有权
    // 因此该 closure 只实现了FnOnce Trait
    func3(|x| { v.push(x); v });
    // v 将所有权转入 closure 中了
    // for i in &v {
    //     println!("{}", i);
    // }
}
```

## 使用场景

> Fn 获取 &self，FnMut 获取 &mut self，而 FnOnce 获取 self

## closure 作为函数返回值

> 就算一模一样的 closure，类型也是不同的

### 错误例子

```rust
// Fn Trait 作为返回值,只能返回同样的类型
fn factory(x:i32) -> impl Fn(i32) -> i32 {

    let num = 5;

    if x > 1{
        // |x| x + num 的类型和 |x| x - num 的类型是不一样的
        // |x| x + num 的类型和 |x| x + num 的类型也是不一样的
        move |x| x + num
    } else {
        move |x| x + num
        // move |x| x - num
    }
}
```

### 正确例子(使用 Box 智能指针)

```rust
// 返回 Box<dyn Trait> 可以用于接受不同类型的 Trait 实现
fn factory(x:i32) -> Box<dyn Fn(i32) -> i32 >{

    let num = 5;

    if x > 1{
        Box::new(move |x| x + num)
    } else {
        Box::new(move |x| x - num)
    }
}

fn main() {
    let f = factory(1);
    println!("{}", f(1));
}
```

# 迭代器 (Iterator)

> iterator 是惰性的，意味着如果你不使用它，那么它将不会发生任何事

```rust
fn main() {
    let arr = [1, 2, 3, 4, 5];
    // 创建迭代器不会有任何额外的性能损耗
    let iterator = arr.iter();
    // 只有使用时才会进行计算
    for i in iterator {
        println!("{}", i);
    }
}
```

## Iterator 组成

```txt
以 Vector 为例:
1. Vector 实现了 IntoIter Trait.
2. 而 IntoTrait 实现了 Iterator Trait.

隐式的:
实现了 Iterator Trait 的类型也实现了 IntoIter Trait

1. 而 IntoIter Trait 强调的是某一个类型如果实现了该 Trait，它可以通过
   into_iter(), iter() 等方法变成一个迭代器,进而调用 Iterator Trait
   中的方法，自定义时，这是可选。
2. Iterator 是迭代器的 Trait, 只有实现了 Iterator Trait 才能被称为迭代器,
   才能调用 next()等 方法,自定义时，这是关键
```

## 转换为迭代器的方法

```txt
这些转换为迭代器的方法是 IntoIter Trait 中的方法
1. into_iter() 会夺走所有权
2. iter() 是不可变借用
3. iter_mut() 是可变借用

调用 next() 返回的值:(next() 是 Iterator Trait 中的方法)
1. into_iter() 方法实现的迭代器，调用 next 方法返回的类型是 Some(T)
2. iter() 方法实现的迭代器，调用 next 方法返回的类型是 Some(&T)
3. iter_mut() 方法实现的迭代器，调用 next 方法返回的类型是 Some(&mut T)
```

```rust
fn main() {
    let values = vec![1, 2, 3];

    // into_iter() 会将 vec 转换为迭代器, 并且 vec 所有权转移给迭代器
    for v in values.into_iter() {
        println!("{}", v)
    }
    // 报错
    // println!("{:?}",values);

    // into_iter() 会将 vec 转换为迭代器
    let values = vec![1, 2, 3];
    let _values_iter = values.iter();

    // 不会报错，因为 values_iter 只是借用了 values 中的元素
    println!("{:?}", values);

    let mut values = vec![1, 2, 3];
    // 对 values 中的元素进行可变借用
    let mut values_iter_mut = values.iter_mut();

    // 取出第一个元素，并修改为0
    if let Some(v) = values_iter_mut.next() {
        *v = 0;
    }

    // 输出[0, 2, 3]
    println!("{:?}", values);
}
```

## Iterator Trait 方法

### 迭代者

> 如果某个方式会返回一个新的迭代器，那么该方法就是迭代者方法
> 比如: map(), filter(), zip(), 与消费者不同，迭代者是惰性的，
> 意味着需要一个消费者方法来收尾，最终将迭代器转换成一个具体的值

### 消费者

> 如果某个方式会消耗迭代器上的元素，那么该方法就是消费者方法
> 比如: next(), collect(), sum()

```rust
fn main() {
    let values = vec![1, 2, 3];
    // 这里还使用了 closure 作为 迭代者方法的参数
    let a: Vec<_> = values.iter().map(|x| x + 1).collect();
    println!("{:?}", a);
}
```

```rust
fn main() {
    let values = vec![1, 2, 3];
    let keys = vec!["1","2","3"];
    // 合并转换成 HashMap
    let a: Vec<(_,_)> = keys.iter().zip(values.iter()).collect();
    println!("{:?}", a);
}
```

## 自定义 Iterator

```rust
struct Count {
    value: i32,
}

impl Iterator for Count {
    // 关联类型
    type Item = i32;

    // next() 是迭代器的核心方法, 其他方法都是基于它实现的
    fn next(&mut self) -> Option<Self::Item> {
        if self.value < 5 {
            self.value += 1;
            Some(self.value)
        } else {
            None
        }
    }
}

impl Count {
    fn new() -> Count {
        Count { value: 0 }
    }
}

fn main() {
    let a = Count::new();
    let sum: i32 = a
        // zip() 合并, skip(1) 跳过前 1 个元素
        .zip(Count::new().skip(1))
        .map(|(a, b)| a * b)
        // 过滤
        .filter(|x| x % 3 == 0)
        // 求和
        .sum();

    println!("sum = {}", sum);
}
```
