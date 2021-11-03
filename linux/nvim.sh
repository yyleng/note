------ all ------
CTRL-c              返回 normal 模式
CTRL-q              缩小方法屏幕
------ normal ------
#
`
L                   到行末
0                   到行首
H                   到行首非空字符
tx                  光标位置到字符 x 之前
fx                  光标位置到字符 x 之处
iw                  整个单词（不包括分隔符）
iW                  整个 WORD（不包括分隔符）
ib                  小括号内
ab                  小括号内（包含小括号本身）
iB                  大括号内
aB                  大括号内（包含大括号本身）
i]                  中括号内
a]                  中括号内（包含中括号本身）
i'                  单引号内
a'                  单引号内（包含单引号本身）
i"                  双引号内
a"                  双引号内（包含双引号本身）

#======屏幕屏幕滚动
CTRL-F              下一页
CTRL-B              上一页
CTRL-U              上移半屏
CTRL-D              下移半屏
CTRL-E              向上滚动屏幕
CTRL-Y              向下滚动屏幕
zz                  调整光标所在行到屏幕中央
zt                  调整光标所在行到屏幕上方
zb                  调整光标所在行到屏幕下方

#======撤销操作
CTRL-R              反撤销
u                   撤销

#======数字操作
CTRL-A              ++
CTRL-X              --




#======屏幕切换
CTRL-H           
CTRL-L
CTRL-J
CTRL-K    

#======窗口控制
CTRL-W v            
CTRL-W s 
CTRL-W c
CTRL-W H
CTRL-W J
CTRL-W L
CTRL-W K
CTRL-W o
CTRL-W +
CTRL-W -
CTRL-W <
CTRL-W >
CTRL-W =
CTRL-W x
CTRL-W f
CTRL-W gf
CTRL-\              打开文件目录

#====== 跳转
CTRL-O              跳转到上一个标记
CTRL-I              跳转到下一个标记
CTRL-6              跳转到当前窗口的上一个文件

w                   跳转到下一个单词开头
e                   跳转到下一个单词结尾
b                   跳转到上一个单词开头

-                   跳转到上一行行首
0                   跳转到当前行行首
H                   跳转到当前行首第一个单词开头
L                   跳转到当前行尾最后一个单词结尾
<enter>             跳转到下一行行首
fx                  向后跳转到x字符处，在可视模式下，使用;依次往下走，使用，依次往上走
Fx                  与fx相反 
:n                  跳转到第 n 行

#====== 改写
`
cc                  改写当前行
cw                  改写光标开始处的当前单词
ciw                 改写光标处的当前单词
ci"                 改写“”中的内容
ci'                 改写''中的内容
ci)                 改写()中的内容
ci]                 改写[]中的内容
ci}                 改写{}中的内容
cH                  改写光标开始处至行首
cL                  改写光标开始处至行尾
c/apple             改写到光标后的第一个apple前
`

#=======删除
`
x                  删除当前字符，前面可以接数字，如3x
X                  向前删除字符，前面可以接数字，如3X
dd                 删除当前行 
d0                 删除到行首
dH                 删除到行首(第一个非空字符)
dL                 删除到行尾
dw                 删除光标开始处的当前单词
diw                删除光标处的当前单词
di"                 删除“”中的内容
di'                 删除''中的内容
di)                 删除()中的内容
di]                 删除[]中的内容
di}                 删除{}中的内容
d/apple             删除到光标后的第一个apple前
dgg                删除到文件头
dG                 删除到文件尾
`
#======标记
`
v                   开始标记
vH                  选中当前位置到行首(第一个非空字符)
vL                  选中当前位置到行尾
viw                 选中当前光标处的单词
vi"                 选中“”中的内容
vi'                 选中''中的内容
vi)                 选中()中的内容
vi]                 选中[]中的内容
vi}                 选中{}中的内容
V                   行标记
CTRL-V              列标记
gv                  重新选中上一次选中的标记
`

#======复制粘贴
`
y                   复制
yy                  复制当前行
nyy                 复制光标下 n 行内容
y0                  复制当前位置到行首
yH                  复制当前位置到行首(第一个非空字符)
yL                  复制当前位置到行尾
yiw                 复制当前光标处的单词
yi"                 复制“”中的内容
yi'                 复制''中的内容
yi)                 复制()中的内容
yi]                 复制[]中的内容
yi}                 复制{}中的内容

p                   粘贴到光标后
P                   粘贴到光标前
`

#======杂项
`
CTRL-G              显示当前文件名与当前所在行
.                  重复上一次操作
<Backspace>        去除高亮
J                   将下一行添加到本行行尾
K                   在cpp 中查看类信息
:registers          显示所有寄存器内容
g CTRL-G            显示所选区域的统计信息
:set all            列出所有选项设置情况
g8                  显示光标下字符的utf-8 编码字节序
CTRL-R CTRL-W       命令模式下插入光标下的单词
:set ff=unix        设置换行为 unix
:set ff=dos         设置换行为 dos
:set ff?            查看换行设置
`

#======缩进
`
<<                  减少缩进
>>                  增加缩进
==                  自动缩进
`

#======大小写转换
`
~                   替换大小写
g~iw                替换当前单词的大小写
guiw                将当前单词转为小写
gUiw                将当前单词转为大写
guu                 全行转为小写
gUU                 全行转为大写
`

#======查找替换
`
/pattern            正向搜索
?pattern            反向搜索
n                   向同一方向执行上次搜索
N                   向相反方向执行上次搜索
*                   向前搜索光标下的单词
#                   向后搜索光标下的单词
:s/p1/p2/g          将当前行中全替换 p1 为 p2
:%s/p1/p2/g         将当前文件中全替换 p1 为 p2
`

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


#----------------------------------------------zsh------------------------------------------------------
ALT-L                ls
