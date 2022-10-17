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
[[package]]
# 依赖名称
name = "aho-corasick"
# 依赖版本(toml指定)
version = "0.7.18"
# 拉取地址
source = "registry+https://github.com/rust-lang/crates.io-index"
# Git SHA256
checksum = "1e37cfd5e7657ada45f742d6e99ca5788580b5c529dc78faf11ece6dc702656f"
# 依赖项
dependencies = [
"memchr",
]
```

### 更新依赖

```sh
cargo update            # 更新所有依赖
cargo update -p regex   # 只更新 “regex”
```
