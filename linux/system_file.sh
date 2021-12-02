#!/bin/sh
#File Name    : system.sh
#Author       : aico
#Mail         : 2237616014@qq.com
#Github       : https://github.com/TBBtianbaoboy
#Site         : https://www.lengyangyu520.cn
#Create Time  : 2021-11-30 15:40:44
#Description  : 

#:for debugging and controlling script behavior
set -eu
#:check script but not execute,below is example.
#bash -n main.sh

#在该目录下配置的脚本会在启动终端时自动调用
/etc/profile.d

# USER密码系统配置文件
/etc/passwd
/etc/shadow
# GROUP密码系统配置文件
/etc/group
/etc/gshadow

# 系统本地时间
/etc/localtime # 其本质其实是链接到/usr/share/zoneinfo 时区目录下的某个时区文件

# 最大进程数
/proc/sys/kernel/pid_max

# 指定进程的基本信息
/proc/<pid_num>/status

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

# kernel info 
/proc/sys/kernel/ostype
/proc/sys/kernel/osrelease
/proc/sys/kernel/version
/proc/version
