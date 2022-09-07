# 多线程

## 基本

### 创建运行等待线程

```rust
use std::thread;
use std::time::Duration;
fn main() {
    // 使用 spawn() 关联函数生成线程
    let a = thread::spawn(|| {
        for i in 1..10 {
            println!("hi number {} from the spawned thread!", i);
            thread::sleep(Duration::from_millis(1));
        }
    // 使用 join() 等待线程返回
    // 使用 unwarp() 处理返回结果
    }).join().unwrap();
    println!("{:?}", a);
}
```

---

### 在线程中访问外部变量

```rust
use std::thread;

fn main() {
    let v = vec![1, 2, 3];

    // The move closure captures the entire vector and moves it into the thread.
    let handle = thread::spawn(move || {
        println!("Here's a vector: {:?}", v);
    });

    handle.join().unwrap();
    // error[E0382]: use of moved value: `v`
    // println!("Here's a vector: {:?}", v);
}
```

---

### 线程存活

```txt
1. 假设子线程 A 创建了子线程 B, 如果子线程 A 退出了, 子线程 B 依旧存活
2. 假设 main 线程 A 创建了子线程 B, 如果 main 线程 A 退出了, 子线程 B 也会退出
```

```rust
use std::thread;
use std::time::Duration;
fn main() {
    // 创建一个线程A, 并等待线程 A 执行完毕
    let new_thread = thread::spawn(move || {
        // 再创建一个线程B, 创建完成后线程 A 结束
        thread::spawn(move || {
            loop {
                println!("I am a new thread.");
            }
        })
    }).join();
    println!("Child thread is finish!: {:?}", new_thread);

    // 看子线程创建的子线程是否还在运行
    // 线程 B 依旧在运行
    thread::sleep(Duration::from_millis(1));
}
```

---

### 自定义线程

```rust
use std::thread;
use std::time::Duration;
fn main() {
    // 自定义线程
    let thread1 = thread::Builder::new()
        // 名称
        .name("thread1".to_string())
        // 栈大小
        .stack_size(1024 * 1024)
        .spawn(|| {
            println!("thread1 name: {:?}", thread::current().name());
            thread::sleep(Duration::from_secs(1));
        })
        .unwrap();
        thread1.join().unwrap();
}
```

---
