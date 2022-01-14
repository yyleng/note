https://yianwillis.github.io/vimcdoc/doc/help.html
https://github.com/nanotee/nvim-lua-guide
https://github.com/neoclide/coc.nvim
https://github.com/wsdjeg/vim-galore-zh_cn
https://github.com/rhysd/git-messenger.vim
https://github.com/rafi/vim-config
https://github.com/amix/vimrc
https://github.com/josa42/coc-go
https://github.com/cweill/gotests
https://github.com/fatih/vim-go
https://github.com/rockerBOO/awesome-neovim #ok
https://github.com/NvChad/NvChad
https://github.com/gelguy/wilder.nvim
https://github.com/github/copilot.vim




------ nvim plugin -------
Plug 'nvim-lua/popup.nvim' // 忽略
Plug 'nvim-lua/plenary.nvim' // 忽略
Plug 'neoclide/coc.nvim', {'branch': 'release'} // lsp补全
Plug 'fatih/vim-go'                             // go工具 
Plug 'github/copilot.vim'                       // ai补全
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} // 高亮
Plug 'morhetz/gruvbox'                            // 高亮
Plug 'sheerun/vim-polyglot'                        // 高亮
Plug 'kyazdani42/nvim-web-devicons'                 // 高亮图标
Plug 'akinsho/bufferline.nvim'                       // 最上面标签栏, ;number 选择标签
Plug 'famiu/feline.nvim'                          // 最下面状态栏
Plug 'nvim-telescope/telescope.nvim'            // 搜索, ;ff ;fc ;fg ;fm
Plug 'scrooloose/nerdcommenter'       // 注释 ctrl-alt-/
Plug 'windwp/nvim-autopairs'         // 自动括号
Plug 'tpope/vim-surround'             // 添加括号
Plug 'tpope/vim-repeat'               // 与上面的配对

#___________________________________________________
Plug 'tpope/vim-abolish'#修改变量形式
# normal mode
### example AbcDef
crc # to abcDef
crU # to ABC_DEF 
cr[s|_] # to abc_def
crm # to AbcDef

cr. # to abc.def
cr- # to abc-def
cr<space> # to abc def
crt # to Abc Def
#____________________________________________________
Plug 'chaoren/vim-wordmotion'#大小写移动
# normal mode
alt+e # to next
alt+b # to before
#____________________________________________________
Plug 'terryma/vim-expand-region'#v V 框选
v # to expand
V # to shrink
vip # code segement
#____________________________________________________
Plug 'AndrewRadev/splitjoin.vim'#自动换行
gS # oneline to multiline
gJ # multiline to oneline
#____________________________________________________
Plug 'justinmk/vim-sneak'     // 搜索
?????????????????????????????????
#____________________________________________________
Plug 'junegunn/vim-easy-align'#对齐
ga <rule>
### <rule> is [num|*|**]< =|<space>|:|.|,|&|#|">
#____________________________________________________
Plug 'tpope/vim-fugitive' // git
?????????????????????????????????
#____________________________________________________
Plug 'voldikss/vim-floaterm'#显示终端
F7
F8
F9
F12
#____________________________________________________
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }#vim命令行
:
#____________________________________________________

#############all##############
ctrl-q #缩小方法屏幕
alt-l  #ls
alt-h  #收起屏幕

#############kitty############
# 1.搜索
alt-c  # 目录搜索并转入
ctrl-r # 命令搜索
ctrl-d # 关闭会话

# 2.界面移动
ctrl-alt-[<left>|<right>]       #用户界面移动
shift-ctrl-alt-[<left>|<right>] #会话移动到用户界面

# 3.会话切换
shift-ctrl-h #左移
shift-trl-l  #右移
shift-trl-j  #下移
shift-trl-k  #上移

# 4.会话切割
alt-v #垂直切割
alt-h #水平切割

#############nvim##############
------ normal mode ------

# 1.通用方式
L  #到行末
$  #到行末非空字符
0  #到行首
H  #到行首非空字符
tx #光标位置到字符 x 之前(向后跳)
fx #光标位置到字符 x 之处(向后跳)
Tx #光标位置到字符 x 之前(向前跳)
Fx #光标位置到字符 x 之处(向前跳)
iw #整个单词（不包括分隔符）
iW #整个WORD（包括分隔符）
ib #小括号内
ab #小括号内（包含小括号本身）
iB #大括号内
aB #大括号内（包含大括号本身）
i] #中括号内
a] #中括号内（包含中括号本身）
i' #单引号内
a' #单引号内（包含单引号本身）
i" #双引号内
a" #双引号内（包含双引号本身）

# 2.屏幕滚动
ctrl-f #下一页
ctrl-b #一页
ctrl-u #移半屏
ctrl-d #移半屏
ctrl-e #上滚动屏幕
ctrl-y #下滚动屏幕
zz     #整光标所在行到屏幕中央
zt     #整光标所在行到屏幕上方
zb     #整光标所在行到屏幕下方

# 3.撤销操作
ctrl-r #反撤销
u      #撤销

# 4.命令操作
:registers          显示所有寄存器内容
:set all            列出所有选项设置情况
:set ff=unix        设置换行为 unix
:set ff=dos         设置换行为 dos
:set ff?            查看换行设置

# 5.进入编辑操作
o #下一行开始编辑
O #上一行开始编辑
i #当前光标前插入
I #当前行首非空字符插入
a #当前光标后插入
A #当前行末插入

# 6.数字操作
ctrl-a          #++
ctrl-x          #--
ctrl-v-g-ctrl-a #列递增
ctrl-v-g-ctrl-x #列递减

# 7:窗口控制
ctrl-h #左移
ctrl-l #右移
ctrl-j #下移
ctrl-k #上移
ctrl-w-v #垂直复制分屏
ctrl-w-s #水平复制分屏
ctrl-w-c #关闭当前分屏
ctrl-w-o #关闭其他分屏
ctrl-w-+ #垂直修改分屏大小
ctrl-w-- #垂直修改分屏大小
ctrl-w-< #水平修改分屏大小
ctrl-w-> #水平修改分屏大小
ctrl-w-= #水平恢复分屏大小
ctrl-\   #打开文件目录

# 8:跳转
CTRL-O  #转到上一个标记
CTRL-I  #转到下一个标记
w       #转到下一个单词开头
e       #转到下一个单词结尾
b       #转到上一个单词开头
-       #转到上一行行首
<enter> #跳转到下一行行首
:n      #跳转到第 n 行
gf      #跳转到当前光标所指向的文件

# 9:改写
cc      #改写当前行
C       #改写当前光标所在行后的内容
cw      #改写光标开始处的当前单词
ciw     #写光标处的当前单词
ci"     #改写“”中的内容
ci'     #改写''中的内容
ci)     #改写()中的内容
ci]     #改写[]中的内容
ci}     #改写{}中的内容
cH      #改写光标开始处至行首
cL      #改写光标开始处至行尾
c/apple #改写到光标后的第一个apple前

# 10:删除
x       #删除当前字符，前面可以接数字，如3x
X       #向前删除字符，前面可以接数字，如3X
dd      #删除当前行
d0      #删除到行首
dH      #删除到行首(第一个非空字符)
dL      #删除到行尾
dw      #删除光标开始处的当前单词
diw     #删除光标处的当前单词
di"     #删除“”中的内容
di'     #删除''中的内容
di)     #删除()中的内容
di]     #删除[]中的内容
di}     #删除{}中的内容
d/apple #删除到光标后的第一个apple前
dgg     #删除到文件头
dG      #删除到文件尾

# 11:标记
v...   #开始标记
vH     #选中当前位置到行首(第一个非空字符)
vL     #选中当前位置到行尾
viw    #选中当前光标处的单词
vi"    #选中“”中的内容
vi'    #选中''中的内容
vi)    #选中()中的内容
vi]    #选中[]中的内容
vi}    #选中{}中的内容
V      #行标记
CTRL-V #列标记
gv     #重新选中上一次选中的标记

# 12:复制粘贴
y   #复制
yy  #复制当前行
nyy #复制光标下 n 行内容
y0  #复制当前位置到行首
yH  #复制当前位置到行首(第一个非空字符)
yL  #复制当前位置到行尾
yiw #复制当前光标处的单词
yi" #复制“”中的内容
yi' #复制''中的内容
yi) #复制()中的内容
yi] #复制[]中的内容
yi} #复制{}中的内容

p   #粘贴到光标后
P   #粘贴到光标前

# 13:杂项
ctrl-g        #显示当前文件名与当前所在行
.             #重复上一次操作
<backspace>   #去除高亮
j             #将下一行添加到本行行尾
k             #在cpp 中查看类信息
g-ctrl-g      #显示所选区域的统计信息
g8            #显示光标下字符的utf-8 编码字节序
ctrl-r-ctrl-w #命令模式下插入光标下的单词

# 14:缩进
<< #减少缩进
>> #增加缩进
== #自动缩进

# 15:大小写转换
~    #替换大小写
g~iw #替换当前单词的大小写
guiw #将当前单词转为小写
gUiw #将当前单词转为大写
guu  #全行转为小写
gUU  #全行转为大写

#======查找替换
/pattern    #正向搜索
?pattern    #反向搜索
n           #向同一方向执行上次搜索
N           #向相反方向执行上次搜索
*           #向前搜索光标下的单词
#           #向后搜索光标下的单词
:s/p1/p2/g  #将当前行中全替换 p1 为 p2
:%s/p1/p2/g #将当前文件中全替换 p1 为 p2

#======文件操作
:w                  保存当前文件
:e <filename>       打开文件并编辑
:saveas <filename>  另存为文件
:r <filename>       读取文件并将内容插入到光标后
:r !dir             将 dir 命令的输出捕获并插入到光标后
:wa                 保存所有文件
:pwd                显示vim 当前路径
:cd <path>          切换 vim 当前路径
:new                水平切割当前窗口并编辑新文件
:vnew               垂直切割当前窗口并编辑新文件
:enew               在新的标签页中创建新文件
gf                  跳转到当前光标指定的文件
ZZ                  保存文件并关闭窗口
ZQ                  不保存文件并关闭窗口

#======无映射关系
CTRL-[              >nomap

------ insert ------
CTRL-W              向前删除单词或删除一行前面所有空格
CTRL-R 0            插入寄存器内容
CTRL-R =            插入表达式计算结果，等号后面跟表达式
CTRL-F              向后移动一格
CTRL-B              向前移动一格
CTRL-U              删除当前光标前所在行的所有数据
CTRL-D              向后删除一格
CTRL-H              向前删除一格
CTRL-V              快速插入ascii 字符或unicode 字符
CTRL-T              向后缩进
CTRL-Y              按列复制上一列的内容
CTRL-I              tab 键
CTRL-O              临时退出插入模式，执行单条命令又返回插入模式
CTRL-A              跳转到当前所在行的第一列
CTRL-J/M            回车换行
CTRL-[              Esc

# CTRL-\                >nomap
# CTRL-E                >nomap
# CTRL-G                >nomap
# CTRL-L                >nomap
# CTRL-]                >nomap
# CTRL-Z                >nomap

# CTRL-S                >unknow
# CTRL-K                >unknow
# CTRL-X                >unknow
# CTRL-N                >unknow
