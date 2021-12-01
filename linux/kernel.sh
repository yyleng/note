#!/bin/sh
#File Name    : kernel_info.sh
#Author       : aico
#Mail         : 2237616014@qq.com
#Github       : https://github.com/TBBtianbaoboy
#Site         : https://www.lengyangyu520.cn
#Create Time  : 2021-11-29 10:39:34
#Description  : 

#:for debugging and controlling script behavior
set -eu
#:check script but not execute,below is example.
#bash -n main.sh

# 最大进程数
vim /proc/sys/kernel/pid_max

# 指定进程的基本信息
vim /proc/<pid_num>/status

# 映射到进程内核空间的文件,该文件中的内容是内核符号的地址
/proc/kallsyms

# 指定进程启动的命令行
/proc/<pid_num>/cmdline
# 当前进程启动的命令行
/proc/self/cmdline

# 指定进程中的环境变量
/proc/<pid_num>/environ
# 当前进程中的环境变量
/proc/self/environ

# 开启路由转发
/proc/sys/net/ipv4/ip_forward
sysctl net.ipv4.ip_forward

# 开启网卡GRO，关闭网卡LRO
ethtool -k enp2s0 | grep offload
ethtool -K enp2s0 gro on

# 查看内核模块
lsmod 
# 查看内核模块信息
modinfo
# 安装内核模块
insmod *.ko
# 加载内核模块
modprobe ...
