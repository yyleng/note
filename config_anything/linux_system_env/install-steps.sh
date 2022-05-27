#!/bin/sh
#File Name    : a.sh
#Author       : aico
#Mail         : 2237616014@qq.com
#Github       : https://github.com/TBBtianbaoboy
#Site         : https://www.lengyangyu520.cn
#Create Time  : 2021-12-23 23:31:48
#Description  :

##: 1: Install Clash
wget https://github.com/Dreamacro/clash/releases/download/v1.8.0/clash-linux-amd64-v1.8.0.gz
gunzip clash-linux-amd64-v1.8.0.gz
chmod +x clash-linux-amd64-v1.8.0
mv clash-linux-amd64-v1.8.0 /usr/bin/clash

##: 2: Download MonoCloud Config File
mkdir /etc/clash
wget -O /etc/clash/config.yaml https://mymonocloud.com/clash/473347/uJCPHbHrZZ8P

##: 3: Make Clash Auto Start
# change selinux config
vim /etc/selinux/config
vim /usr/lib/systemd/system/clash.service
#-----
[Unit]
Description=Clash Daemon

[Service]
ExecStart=/usr/bin/clash -d /etc/clash/
Restart=on-failure

[Install]
WantedBy=multi-user.target
#-----
systemctl enable clash.service
systemctl start clash
systemctl restart clash

##: 4: Install oh-my-zsh
yum install -y zsh

##: 5: Enable Proxy
export http_proxy=http://127.0.0.1:7890 && export https_proxy=http://127.0.0.1:7890
# Disable Proxy
# unset https_proxy http_prox

##: 6: Download zsh script
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

##: 7: Download zsh plugin
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

##: 8: Modify ~/.zshrc
#-----
ZSH_THEME="juanghurtado"
CASE_SENSITIVE="true"
DISABLE_MAGIC_FUNCTIONS="true"
plugins=(
    git
    z
    gitfast
    docker
    docker docker-compose
    golang
    sudo     #自动添加sudo ,两下esc
    extract #万能解压 x 压缩包名
    ripgrep
    kubectl
    zsh-autosuggestions
    zsh-syntax-highlighting
)
#-----

##: 9: Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
source ~/.zshrc

##: 10: Install nvim
yum install -y install fuse-libs
curl -o /usr/local/bin/nvim -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod +x /usr/local/bin/nvim

##: 11: Download vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

##: 12: Download nvim config file
mkdir ~/.config/nvim
git clone https://github.com/TBBtianbaoboy/nvim-zsh.git && mv nvim-zsh/init.vim ~/.config/nvim && rm -fr nvim-zsh

##: 13: Install Node.js 10+
curl -sL https://rpm.nodesource.com/setup_12.x | sudo bash -
yum install -y nodejs

##: 14: Install Plugin
nvim
#if stop for a long time ,run again
:PlugInstall
nvim
nvim
nvim

##: 15: change default sh
chsh -s /bin/zsh

##: 16: change default editor
vim ~/.zshrc
export EDITOR=nvim
