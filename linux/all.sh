#====== unrar & rar ====== 

sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-34.noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-34.noarch.rpm
sudo dnf install -y unrar

#====== 无线网卡驱动安装 ======
unzip ../tools/Qualcomm-Atheros-QCA9377-Wifi-Linux-master.zip
# see *.doc 

#====== 获取外网的ip地址 ======
curl ipecho.net/plain
curl -s http://myip.ipip.net

#====== 端口扫描 ======
#扫描tcp指定端口
alias nctcp='nc -vz -w10'
#扫描udp指定端口
alias ncudp='nc -vzu -w10'
#用法
#nctcp ip port
#ncudp ip port

#====== svn 免密登陆 ======
- K num: key的长度
- V num: value的长度

```sh
K 15
svn:realmstring
V 65
<svn://192.168.199.199:3690> a76b6178-e184-4093-9dc7-128c5e359fa8
K 8
username
V 10
lengyangyu
K 8
passtype
V 6
simple
K 8
password
V 16
Nex7Z0aAZXlrpwJg
END

~/.subversion/auth/svn.simple/a3d387b9f7ce46307d61960657c118d8
```

#====== git快捷命令 ======
```sh
gaa
gcam
ggpush
#查看提交日志
glg
glgg
#全局修改核心编辑器--最终作用于~/.gitconfig文件
git config --global core.editor nvim
#修改提交注释并再次提交
git commit --amend
#查看全局配置
git config --global --list
#查看局部配置
git config --list
#查看远程信息
grv
#增加远程仓库
git remote add origin ssh://git@192.168.30.140:2222/ksp/ksp_web.git
#移除远程仓库
git remote remove origin
#切换到某一个分支
gsw 分支名
#获取远程所有分支
gfa
#合并分支
git merge origin/分支名
#git-svn 并基
gsr
#git-svn 上传
gsb
#代码比对
gd
git difftool -t nvimdiff
#commit 撤销操作
git reset --mixed HEAD~1 // 不删除空间改动代码，撤销commit和gaa，同时可以回退多个旧commit
git reset --soft HEAD~1  // 不删除空间改动代码，撤销commit，不撤销gaa
git reset --hard HEAD~1  // 删除空间改动代码，撤销commit，撤销gaa
#查看状态
gst
gss
gsb
#查看代码是谁修改的
在vim 中,:Git blame
```

#====== dnf 加速下载
```
/etc/dnf/dnf.conf
[main]
proxy=http://127.0.0.1:7890
```

#====== weather reporter
```
curl wttr.in
```

#======= tranlate software
```
yum install goldendict
whereis goldendict
#config directory
~/.goldendict
#goldendict is hard link
```

#====== lockfile
```
#加密
lockfile a.c b.c
#解密
lockfile a.c.bfe
```

#====== nvim 
```sh
sudo dnf install -y neovim python3-neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
:PluginInstall
```

#====== fonts
```sh
https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip
mkdir ~/.local/share/fonts
auto-extract DroidSansMono.zip
mv ~/Downloads/Droid\ Sans\ Mono\ Nerd\ Font\ Complete* ~/.local/share/fonts
rm -fr DroidSansMono.zip
```

#====== supervisorctl supervisord
```sh
# control process group
#offical site 
http://supervisord.org/
```

#====== 密码破解
```sh 
# -l username 
# -P password dict 
# -t thread 
hydra -l root -P /root/pass.txt -t 16 192.168.110.7 ssh
```

#====== grpc_cli
```sh
#show service 
grpc_cli ls localhost:50051
#show service details
grpc_cli ls localhost:50051 helloworld.Greeter -l
#show methods
grpc_cli ls localhost:50051 helloworld.Greeter.SayHello -l
#show message type
grpc_cli type localhost:50051 helloworld.HelloRequest
#call a remote method 
grpc_cli call localhost:50051 SayHello "name: 'gRPC CLI'"
```
