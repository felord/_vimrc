set number " 设置行号
set ruler
color ron "颜色主题
set colorcolumn=81 "设置81列处颜色
set is
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=indent,eol,start "退格键修改为默认
set guifont=Microsoft\ Yahei\ Mono:h18 "字体字号
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%] "显示文件名：总行数，总的字符数
set cindent
"set fdm=marker
set smartindent
set mouse=a
set hlsearch
filetype plugin indent on
syntax on

"设置程序的运行和调试的快捷键F5和Ctrl-F5
map <F5> :call CompileRun()<CR>
map <F6> :call Run()<CR>
map <C-F5> :call Debug()<CR>
"定义CompileRun函数，用来调用进行编译和运行
func CompileRun()
exec "w"
"C程序
if &filetype == 'c'
exec "!gcc -Wl,-enable-auto-import % -g -o %<.exe"
"c++程序
elseif &filetype == 'cpp'
exec "!g++ -Wl,-enable-auto-import % -g -o %<.exe"
"Java程序
elseif &filetype == 'java'
exec "!javac %"
endif
endfunc
"结束定义CompileRun

"定义Run函数
func Run()
if &filetype == 'c' || &filetype == 'cpp'
exec "!%<.exe"
elseif &filetype == 'java'
exec "!java %<"
endif
endfunc
"结束定义Run

"定义Debug函数，用来调试程序
func Debug()
exec "w"
"C程序
if &filetype == 'c'
exec "!gcc % -g -o %<.exe"
exec "!gdb %<.exe"
"c++程序
elseif &filetype == 'cpp'
exec "!g++ % -g -o %<.exe"
exec "!gdb %<.exe"
"Java程序
elseif &filetype == 'java'
exec "!javac %"
exec "!jdb %<"
endif
endfunc
"结束定义Debug
