> 该目录中的文件是经过拆分的钉钉安装包，用于 Fedora36+ 系统，需要合并后才能安装

```sh
# 合并命令如下
cat dingtalk_part_* > dingtalk-1.4.0-20829.fc36.x86_64.rpm
```

```sh
# 切分命令如下
split -b 10M dingtalk-1.4.0-20829.fc36.x86_64.rpm dingtalk_part_
```
