filetype on "开启文件类型检测功能
set softtabstop=4
filetype plugin on "根据侦测到的不同类型加载对应的插件
filetype indent on "vim为不同类型的文件定义不同的缩进格式
set guifont=Consolas:h18:cDEFAULT
set backspace=indent,eol,start "改成常用的backspace功能
autocmd! bufwritepost _vimrc source % "自动加载vimrc
colorscheme desert "配色改为desert
syntax on "语法高亮
"set cindent "类C的缩进
set nu "显示行号
set ruler "打开光标行列位置显示功能
set tabstop=4 "制表符占4个空格
set shiftwidth=4 "默认缩进4个空格
set expandtab    "用空格键替换制表符
set hls "高亮搜索
set is "即时搜索

"定义CompileRun函数，用来调用编译和运行  
func CompileRun()  
exec "w"  
  
if &filetype == 'c'  
exec "!gcc % -g -o -std=c11 %<.exe"  
  
elseif &filetype == 'cpp'  
exec "!g++ % -g -o -std=c++14 %<.exe"  
  
elseif &filetype == 'java'  
exec "!javac %"  
endif  
endfunc  
"结束定义ComplieRun  
  
"定义Run函数  
func Run()  
if &filetype == 'c' || &filetype == 'cpp'  
exec "!%<.exe"  
elseif &filetype == 'java'  
exec "!java %<"  
endif  
endfunc  
  
"定义Debug函数，用来调试程序  
func Debug()  
exec "w"  
  
if &filetype == 'c'  
exec "!gcc % -g -o %<.exe"  
exec "!gdb %<.exe"  
elseif &filetype == 'cpp'  
exec "!g++ % -g -o %<.exe"  
exec "!gdb %<.exe"  
elseif &filetype == 'java'  
exec "!javac %"  
exec "!jdb %<"  
endif  
endfunc  
  
"设置程序的运行和调试的快捷键F5和Ctrl-F5  
map <F5> :call CompileRun()<CR>  
map <F6> :call Run()<CR>  
map <C-F5> :call Debug()<CR>  
