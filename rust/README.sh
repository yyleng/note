#!/bin/sh
# 1. download rustc and cargo and toolchains
curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh

# 2. download rust-analyzer
curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
# 3. config coc-rust-analyzer plugin (nvim coc)


# 4. command
rustup update # 更新 rust 到最新稳定版本
rustup self uninstall # 卸载 rust 和 rustup
rustup doc # 在浏览器打开 rust 英文文档

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

# 5. third-party mirrors tool
cargo install crm # Cargo registry manager
