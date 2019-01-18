set number " 设置行号
set ruler
set autochdir "自动将当前编辑文件所在路径转化为vim当前路径
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

"------------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
"------------------------------------------------------------------------------
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif
 
"------------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
"------------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
 
"------------------------------------------------------------------------------
"  < 编译、连接、运行配置 >
"------------------------------------------------------------------------------
" F5 一键保存、编译、连接存并运行
map <F5> :call Compile_Run()<CR>
 
" F8 一键调试
map <F8> :call Debug()<CR>
 
let s:windows_CFlags = "!gcc\ -Wall\ -g\ -O0\ %\ -o\ %<\ -lm"
let s:linux_CFlags = "!gcc\ -Wall\ -g\ -O0\ %\ -o\ %<\ -lm"
 
let s:windows_CPPFlags = "!g++\ -Wall\ -g\ -O0\ %\ -o\ %<"
let s:linux_CPPFlags = "!g++\ -Wall\ -g\ -O0\ %\ -o\ %<"
 
func! Compile_Run()
    exe "w"
    if expand("%:e") == "c"
        if g:iswindows
            exe s:windows_CFlags
            exe "!%<"
        else
            exe s:linux_CFlags
            exe "!".expand("%:p:h")."/%<"
        endif
    elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
        if g:iswindows
            exe s:windows_CPPFlags
            exe "!%<"
        else
            exe s:linux_CPPFlags
            exe "!".expand("%:p:h")."/%<"
        endif
    endif
endfunc
 
func! Debug()
    exe "w"
    if expand("%:e") == "c"
        if g:iswindows
            exe s:windows_CFlags
            exe "!gdb %<"
        else
            exe s:linux_CFlags
            exe "!gdb ".expand("%:p:h")."/%<"
        endif
    elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
        if g:iswindows
            exe s:windows_CPPFlags
            exe "!gdb %<"
        else
            exe s:linux_CPPFlags
            exe "!gdb ".expand("%:p:h")."/%<"
        endif
    endif
endfunc
