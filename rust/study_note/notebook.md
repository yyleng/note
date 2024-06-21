# 第三方库

| 名称       | 用途                    |
| ---------- | ----------------------- |
| num        | 处理复数等问题          |
| utf8_slice | 处理 UTF-8 字符串等问题 |
| ahash      | 高性能哈希函数库        |
| indexmap   | 哈希表实现的有序 map    |
| rand       | 随机数生成              |
| num_enum   | 枚举与整型的转换        |

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
