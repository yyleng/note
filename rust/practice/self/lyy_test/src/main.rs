use std::sync::mpsc;
use std::thread;

fn main() {
    let (tx, rx) = mpsc::channel();

    // 线程创建
    // 线程初始化需要时间
    thread::spawn(move || {
        tx.send(1).unwrap();
    });

    // println! 宏会先执行
    // 未接收到线程发送的消息, 返回 receive Err(Empty)
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    // 可能在这里接收到线程发送的消息
    // 输出
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
    println!("receive {:?}", rx.try_recv());
}
