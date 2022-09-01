#!/bin/sh
# download rust and cargo and toolchains
curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh
# download rust-analyzer
curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
# config coc-rust-analyzer plugin
# ok


#### command
# rustup update
# rustup self uninstall
# cargo new <project-name> [--lib]
# cargo build [--release]
# cargo run [--release]
# cargo check
# cargo doc [--open]
# cargo test

#### tool
# Cargo registry manager
cargo install crm
