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

### 线程屏障

> 用于控制让多个线程都执行到某个点后，才继续一起往后执行

```rust
use std::sync::{Arc, Barrier};
use std::thread;

fn main() {
    let mut handles = Vec::with_capacity(6);
    // Create a barrier that can block a total of 6 threads.
    let barrier = Arc::new(Barrier::new(6));

    for _ in 0..6 {
        let b = barrier.clone();
        handles.push(thread::spawn(move|| {
            println!("before wait");
            b.wait();
            println!("after wait");
        }));
    }

    for handle in handles {
        handle.join().unwrap();
    }
}
```

### 条件变量和互斥锁

```rust
use std::sync::{Arc, Condvar, Mutex};
use std::thread;

fn main() {
    let pair = Arc::new((Mutex::new(false), Condvar::new()));
    let pair2 = pair.clone();

    thread::spawn(move || {
        let (lock, cvar) = &*pair2;
        let mut started = lock.lock().unwrap();
        println!("changing started");
        *started = true;
        cvar.notify_one();
    });

    let (lock, cvar) = &*pair;
    let mut started = lock.lock().unwrap();
    while !*started {
        started = cvar.wait(started).unwrap();
    }

    println!("started changed");
}
```

### 多线程只调用一次函数

```rust
use std::thread;
use std::sync::Once;

// 假设这就是全局配置
static mut VAL: usize = 0;
static INIT: Once = Once::new();

fn main() {
    // 这两个线程中的call_once closure 二选一
    let handle1 = thread::spawn(move || {
        INIT.call_once(|| {
            unsafe {
                VAL = 1;
            }
        });
    });

    let handle2 = thread::spawn(move || {
        INIT.call_once(|| {
            unsafe {
                VAL = 2;
            }
        });
    });

    handle1.join().unwrap();
    handle2.join().unwrap();

    println!("{}", unsafe { VAL });
}
```

### 加锁性能

```rust
use std::ops::Sub;
use std::sync::{Mutex, Arc};
use std::thread::{self, JoinHandle};
use std::time::Instant;
const N_TIMES: u64 = 10_000_000;
const N_THREADS: usize = 10;

fn add_n_times(n: u64, counter: Arc<Mutex<u64>>) -> JoinHandle<()> {
    thread::spawn(move || {
        // 控制线程加锁即可
        let mut num = counter.lock().unwrap();
        for _ in 0..n {
        // 不应该在这里加锁，因为这样会导致每次都要加锁，这样会导致性能下降
        // let mut num = counter.lock().unwrap();
            *num += 1;
        }
    })
}


fn main() {
    let counter = Arc::new(Mutex::new(0));
    // 用于计算时间
    let s = Instant::now();
    let mut threads = Vec::with_capacity(N_THREADS);
    for _ in 0..N_THREADS {
        threads.push(add_n_times(N_TIMES, counter.clone()))
    }

    for thread in threads {
        thread.join().unwrap();
    }
    assert_eq!(N_TIMES * N_THREADS as u64, *counter.lock().unwrap());
    // 获取时间差
    println!("{:?}",Instant::now().sub(s));
}
```

## 线程同步

### 消息传递

> 以消息通道(channel)的形式进行消息传递, 对应标准库中的 std::sync::mpsc
> mpsc 的含义是 multiple producer, signle consumer, 即多生产者, 单消费者

#### 基本用法

**单生产者, 单消费者**

```rust
use std::sync::mpsc;
fn main() {
    // 类型由编译器根据上下文推导, 一经确定就不可变
    let (producer, consumer) = mpsc::channel();
    // 也可以手动指定类型
    // let (producer, consumer): (Sender<&str>, Receiver<&str>) = mpsc::channel();

    producer.send("lyy yo yo yo!").expect("send failed");
    // 错误, 类型已经被推导为 &str
    // producer.send(1).expect("send failed");

    // move 会将 consumer 的所有权转移给另一个线程
    std::thread::spawn(move || {
        // recv() 会阻塞当前线程, 直到接受到一条数据或者通道被关闭(所有生产者 drop)
        let msg = consumer.recv().expect("recv failed");
        println!("{}", msg);
    })
    .join()
    .unwrap();
}
```

**try_recv() 函数**

> 消费者(consumer) 在调用 recv() 函数接受数据时会阻塞, 在某些场景下不可取, 因此
> try_recv() 应运而生

```rust
use std::sync::mpsc;
use std::thread;

fn main() {
    let (producer, consumer) = mpsc::channel();

    // 线程创建后需要初始化, 因此下面的 println! 会先行执行
    // producer 所有权会被移动到线程中
    thread::spawn(move || {
        producer.send(1).unwrap();
        // 发送数据后, tx 离开作用域, 会自动调用 Drop Trait 中的 drop() 方法
        // 释放 producer
    });

    // 由于此时生产者还没有发送数据, 因此 => Err(Empty)
    println!("{:?}", consumer.try_recv());
    println!("{:?}", consumer.try_recv());
    // 可能在这里可以成功接受数据 => 1
    println!("{:?}", consumer.try_recv());
    // 由于 producer 被 drop 了, 导致通道被关闭, 因此 => Err(Disconnected)
    println!("{:?}", consumer.try_recv());

}
```

**传输具有所有权的数据**

> 取决于该数据类型是否实现了 Copy Trait,
> 如果实现了, 会直接 Copy, 相当于调用 Clone Trait 中的 clone() 方法,
> 否则就会移动所有权

```rust
use std::sync::mpsc;
use std::thread;

#[derive(Debug, Clone, Copy)]
struct Test {
    a: i32,
    b: i32,
}

fn main() {
    let (producer, consumer) = mpsc::channel();

    thread::spawn(move || {
        let test = Test { a: 1, b: 2 };
        //: 以 String 为例
        // let message = String::from("this is a test message");
        // 以 clone() 的方式将 message 发送到 channel 中
        // 这样就不会移动 message 的所有权
        // producer.send(message.clone()).unwrap();
        // message 为 String 类型, 并未实现 Copy Trait
        // println!("{:?}", message);

        // 由于 Test 实现了 Copy trait，所以可以直接将 test 发送到 channel 中
        // 此时直接 Copy, 不会移动所有权
        producer.send(test).unwrap();
        // 依旧可以使用 test
        println!("{:?}", test);

        // 发送数据后, producer 离开作用域, 会自动调用 Drop Trait 中的 drop() 方法
        // 释放 producer

        // message 在这里被 drop
    });
    let recv_message = consumer.recv().unwrap();

    println!("{:?}", recv_message);

    // recv_message 在这里被 drop
}
```

###
