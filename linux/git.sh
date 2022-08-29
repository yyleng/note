#!/bin/sh
#====== git快捷命令 ======
#提交
gaa
ggpush
# 撤销对文件的修改
grs file_name
# 取消暂存文件
grst file_name
#查看提交日志
glg
glgg
glo
glol
#同步repo依赖
git submodule sync
git submodule update --init --progress
#git-svn 并基
gsr
#git-svn 上传
gsb
#代码比对
gd
git difftool -t nvimdiff
#
#commit 撤销操作
git reset --mixed HEAD~1 // 不删除空间改动代码，撤销commit和gaa，同时可以回退多个旧commit
git reset --soft HEAD~1  // 不删除空间改动代码，撤销commit，不撤销gaa
git reset --hard HEAD~1  // 删除空间改动代码，撤销commit，撤销gaa
git reset --hard 345613  //硬切到指定分支
git reset --soft 345613  //软切到指定分支
#查看状态
gst
gss
gsb
#拉取远程分支
gcb feature-branch origin/feature-branch    #检出远程的feature-branch分支到本地
#本地传建分支并推到远程
gcb feature-branch    #创建并切换到分支feature-branch
gp origin feature-branch:feature-branch    #推送本地的feature-branch(冒号前面的)分支到远程origin的feature-branch(冒号后面的)分支(没有会自动创建)
#删除远程分支
gp origin --delete feature-branch
#删除变基操作
git rebase --abort
#查看代码是谁修改的
在vim 中,:Git blame
在vim 中,:G
在vim 中,:Gvd
[c
]c
dp

########################################## 拉取远程分支
# 拉取远程的当前分支并合并
ggpull
# 拉取远程origin分支但不合并
gfo
# 拉取远程的指定分支但不合并
gf branch-name
# 拉取远程的所有分支但不合并
gfa

########################################## 远程仓库管理
# 查看远程信息
grv
# 增加远程仓库
gra origin ssh://git@192.168.30.140:2222/ksp/ksp_web.git
# 移除远程仓库
grrm origin
# 重命名远程仓库名
grmv origin

######################################### 打标签
# 为当前提交打标签
g tag -a v1.0 -m "版本1.0"
# 为历史提交打标签
g tag -a v1.0 commit-sha -m "版本1.0"
# 删除本地标签
git tag -d v1.0
# 删除远程标签
gp origin -d v1.0
# 列出所有标签
gtv
# 推送仓库和所有标签到远程仓库
gpoat
# 检出分支
gco v1.0
# 检出分支并修改提交
gcb new-branch tag-name

######################################### 分支管理
#显示所有分支
gba
#删除本地分支
gb -D sub-branch
#切换到某一个分支
gsw -c 分支名 # -c 创建
#合并分支
gm origin/分支名
#查看重要的提交记录
git reflog

######################################### 提交记录
# 配合nvim coc-conventional 插件规范提交
gc
# 非规范提交
gcam
#修改提交注释并再次提交
#或者创建新的提交代替旧的提交
git commit --amend

######################################### 配置
#全局修改核心编辑器--最终作用于~/.gitconfig文件
git config --global core.editor nvim
#查看全局配置
git config --global --list
#查看局部配置
git config --local --list
