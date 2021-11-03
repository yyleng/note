# All Useful Command
# 内存
## free
```sh
#用来查看内存的使用情况
free
#查看更多使用方法
free --help
```

# 挂载
##  df
```sh
#查看文件系统挂载情况
df -Th
#查看更多使用方法
df --help
```

## mount
```sh
#查看所有已挂载的设备
mount
#挂载一个设备到指定目录，设备名到/dev目录下找（或使用lsblk查看），目录随意指定
mount <设备名> <目录>
#查看更过使用方法
mount --help
```

## umount
```sh
#卸载已挂载的设备
umount <设备名>
```

## lsblk
```sh
#列出块设备信息,以树形展示你的磁盘以及磁盘分区信息
lsblk
```

# 会话进程
## pstree
```sh
#显示进程树,可以很直观地分析进程之间的关系
pstree -pl
```

## pgrep
```sh
#根据进程的名字过滤进程
pgrep <progress_name>
#更多方式
tldr pgrep
```

## pkill 
```sh
#根据进程的名字向指定进程发送信号
pkill <progres_name>
#更多方式
tldr pkill
```

## jobs
```sh
#显示与当前会话绑定的后台进程,其序号给fg/bg使用
jobs
```

## fg
```sh
#将后台STOP了的进程提到前台运行
fg %序号
```

## bg
```sh
#将后台STOP了的进程提到后台运行
bg %序号
```

## disown
```sh
#解绑与当前会话(终端)绑定的后台进程
disown %序号
```

# 磁盘
## fdisk
```sh
#输出当前系统拥有的磁盘设备
sudo fdisk -l
#对磁盘设备进行分区
fdisk <设备名>
```

## mkfs
```sh
#制作磁盘文件系统
#格式化磁盘
```

## dd
```sh
tldr dd
#备份磁盘中的文件
#导入其他文件到磁盘
#制作启动盘
```

## fsck
```sh
#检测设备文件是否有坏
fsck <设备名>
```

## lscpu
```sh
#查看本机cpu详细信息
lscpu
```

#远程登陆
## rsync
```sh
#同步远端文件和目录，而且是一种通用的远程(本地)文件复制工具
#更过使用方法
tldr rsync
man sync
```

# 时间
## date
```sh
#打印当前时间
date
```

## cal
```sh
#打印当前日历
cal
```

# 分析命令
## brctl 
```sh
#显示网桥信息
brctl show
```
## type
```sh
#显示命令的类型
type <command>
```

## which
```sh
#显示一个可执行文件的位置
which <command>
```
## readlink
```sh
#查看一个软链接所指向的真实文件
readlink filename
#查看一个文件的绝对路径
readlink -f filename
```

## apropos
```sh
#基于关键字搜索命令
apropos <command>
```

## whereis
```sh
#查找与命令相关的所有文件
whereis <command>
```

## whatis
```sh
#查找命令在man中的内容布局
whatis <command>
```

# 文件
## cmp diff
```sh
#比较两个文件的内容
cmp <file1> <file2>
diff <file1> <file2>
```

## dos2unix
```sh
#将DOS格式的文件转换成UNIX下的文本文件
dos2unix [选项] <文件名>
```

## lsattr
```sh
#显示文件的隐藏属性
lsattr [选项] 文件
#有关更多选项
man lsattr
```

## chattr
```sh
#修改文件的隐藏属性
chattr [选项] 文件
#有关更多选项
man chattr
```

## chmod 
```sh
#修改普通权限
chmod [选项] <[0-7][0-7][0-7]> 文件或目录
#使普通用户的可执行文件具有root权限 SUID
chmod u+s 文件
#使当前用户组中的其他用户都具有当前用户的权限执行这个可执行文件 SGID
chmod g+s 文件
#使当前目录具有t权限
chmod o+t 目录名
## 其他用户都可以在该目录下创建或修改文件，但只有root和文件的创建者可以删除文件
```

## find
```sh
#寻找文件
会基本的寻找文件即可
#有关更多用法
tldr find
man find
```

## locate
```sh
#寻找文件，基于文件数据库，比find快
locate <文件或目录名>
#更新文件数据库
updatedb
```
## gzip gunzip
```sh
#压缩与解压缩单个文件
tldr gzip
tldr gunzip
```

## tar
```sh
#打包压缩文件与解包解压缩文件
tldr tar
```

## basename
```sh
#查看文件的名字(不包含路径)
basename <文件名>
#更多用法
tldr basename
```

## dirname
```sh
#查看目录的名字
dirname 
#更多用法
tldr dirname
```

# 用户与组
## w
```sh
#获取当前登陆系统的所有用户信息(更详细)
w
```

## who
```sh   
#获取当前登陆系统的所有用户信息(不详细)
```

## users
```sh
获取当前登陆系统的所有用户信息(最不详细)
users
```

## finger
```sh
#获取当前登陆系统的所有用户信息(最详细)，而且可以指定用户
finger [username]
```

## useradd
```sh
#新增用户
useradd [选项] 用户名
##实现机制：会在/etc/passwd和/etc/shadow中追加账号信息和密码字段，同时默认使用/etc/skel目录做为骨架目录
#用户选项的用法，使用如下命名查看
useradd --help
```

## passwd
```sh
#修改当前用户密码
passwd
#修改其他用户的密码，需要root执行
passwd <用户名>
```

## usermod
```sh
#修改用户信息
usermod [选项] 用户名
#有关选项，使用如下命令
usermod --help
```

## userdel
```sh
#删除用户,但不会删除用户主目录和邮件
userdel <用户名>
#删除用户，同时删除用户主目录和邮件
userdel -r <用户名>
#有关其他用法
userdel --help
```

## groupadd
```sh
#新增用户组，其实也就是修改/etc/group文件
groupadd [选项] <组名>
#有关选项的详细信息
groupadd --help
```

## groupdel
```sh
#删除用户组
groupdel [选项] 用户组名
##如果用户组下有其他用户是无法删除的
#有关选项的更多用法
groupdel --help
```

## su
```sh
##切换到具有自身环境的root
su -
##切换到没有自身环境的root
su
##切换到其他用户
su <用户名>
```

## sudo
```sh
#提升命令的执行权限
sudo <命令>
## 要使用这个，需要修改/etc/sudoers文 件，使普通用户具有提升权限的权限
aico     ALL=(ALL)      NOPASSWD: ALL
```

# 终端相关
```sh
#使用快捷键切换(恢复)tty会话
Ctrl+Alt+F1...7
```

# 系统
## sysctl
```sh
#在内核运行时动态地查看和修改内核的运行参数
sysctl
```

## lscpu
```sh
#查看系统cpu的详细信息
lscpu
```
## lsmem
```sh
#查看系统内存的信息
lsmem
```

## lsipc
```sh
#查卡系统IPC的信息
lsipc
```

## lspci
```sh
#查看系统各设备的版本信息
lspci
```

## getconf
```sh
#查看系统的位数
getconf LONG_BIT

#查看系统内存页的大小
getconf PAGE_SIZE
```

## cat
```sh
#查看进程的内存布局
cat /proc/$PID/maps
#查看进程更详细的内存布局
cat /proc/$PID/smaps
#查看进程的状态
cat /proc/$PID/stat
#查看进程更详细的状态
cat /proc/$PID/status
```

## uname
```sh
#获取内核版本
uname -a
#更多用法
tldr uname
uname --help
```

## limit 使用优先级1
```sh
#查看系统限制
limit
```

## ulimit 使用优先级2
```sh
#查看系统限制
ulimit -a
#查看栈空间的大小
ulimit -s
#修改栈空间的大小
ulimit -s 16384 # 16M
```

## prlimit 使用优先级3
```sh
#查看系统限制
prlimit --help
```

## uptime
```sh
#显示系统开机运行到现在经过的时间
uptime
```

## hostname
```sh
#显示系统主机名
hostname
#设置系统主机名
hostname <name>
#显示主机的 IP 地址
hostname -i
```

## man hier
```sh
#描述文件系统目录结构
man hier
```

## ls
```sh
#查看安装了的内核
ls -1 /lib/modules
```

# 网络
## htop 一般友好
```sh
#查看磁盘/cpu/网络的状态
htop
```

## gtop 更加友好
```sh
#查看磁盘/cpu/网络的状态
gtop
```

## dstat
```sh
#显示cpu/memory/等信息
dstat
#更多用法
tldr dstat
```

# 其他
## apg
```sh
#随机生成密码
apg
```

## ag
```sh
#代码查找，比grep快
ag <string> <path>
```

# 软件安装
## yum
```sh
# fedora安装具有依赖包的包
yum localinstall -y teamviewer_15.21.4.x86_64.rpm
```

## nmap 
```sh 
#端口扫描
nmap -A -v -p1-10000 192.168.110.92 
```

