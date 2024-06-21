## Cargo.toml vs Cargo.lock

```txt
1. Cargo.toml: 用户编写, 用于描述项目信息和进行依赖管理
2. Cargo.lock: Cargo 自动生成, 包含了依赖的精确描述信息
```

### Cargo.lock

```txt
1. 发布时, 第三方库不应该包含 Cargo.lock
2. 发布时, 可执行库应该包含 Cargo.lock
```

> 字段描述

```toml
[package]
name = "world_hello" # 项目名称
version = "0.1.0" # 项目版本
edition = "2021" # 项目使用的 Rust 版本
[dependencies]
rand = "0.3" # 依赖 rand crate, 版本 0.3, 从 crates.io 下载
hammer = { version = "0.5.0"} # 依赖 hammer crate, 版本 0.5, 从 crates.io 下载
color = { git = "https://github.com/bjz/color-rs" } # 依赖 color crate, 从 github 上下载
geometry = { path = "crates/geometry" } # 依赖 geometry crate, 从本地路径下载

```

### 更新依赖

```sh
cargo update            # 更新所有依赖
cargo update -p regex   # 只更新 “regex”
cargo new <project-name> # 创建一个新的binary项目
    --lib # 创建一个新的library项目
    --vcs git # 自动初始化 git 仓库
cargo build  # 编译项目 debug 版本 (编译快，运行慢)
    -r # 编译项目 release 版本 (编译慢，运行快)
cargo run  # 编译并运行项目 debug 版本 (编译快，运行慢)
    -r # 编译并运行项目 release 版本 (编译慢，运行快)
cargo check # 检查项目是否能 debug 编译通过，但不生成可执行文件
    -r # 检查项目是否能 release 编译通过，但不生成可执行文件
cargo doc [--open]
cargo test
```
