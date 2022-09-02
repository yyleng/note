# 闭包 (closure)

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
