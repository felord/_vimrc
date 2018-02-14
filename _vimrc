filetype on "�����ļ����ͼ�⹦��
set softtabstop=4
filetype plugin on "������⵽�Ĳ�ͬ���ͼ��ض�Ӧ�Ĳ��
filetype indent on "vimΪ��ͬ���͵��ļ����岻ͬ��������ʽ
set guifont=Consolas:h18:cDEFAULT
set backspace=indent,eol,start "�ĳɳ��õ�backspace����
autocmd! bufwritepost _vimrc source % "�Զ�����vimrc
colorscheme desert "��ɫ��Ϊdesert
syntax on "�﷨����
"set cindent "��C������
set nu "��ʾ�к�
set ruler "�򿪹������λ����ʾ����
set tabstop=4 "�Ʊ��ռ4���ո�
set shiftwidth=4 "Ĭ������4���ո�
set expandtab    "�ÿո���滻�Ʊ��
set hls "��������
set is "��ʱ����

"����CompileRun�������������ñ��������  
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
"��������ComplieRun  
  
"����Run����  
func Run()  
if &filetype == 'c' || &filetype == 'cpp'  
exec "!%<.exe"  
elseif &filetype == 'java'  
exec "!java %<"  
endif  
endfunc  
  
"����Debug�������������Գ���  
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
  
"���ó�������к͵��ԵĿ�ݼ�F5��Ctrl-F5  
map <F5> :call CompileRun()<CR>  
map <F6> :call Run()<CR>  
map <C-F5> :call Debug()<CR>  
