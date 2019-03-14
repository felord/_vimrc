@echo off

cd /d %~dp0
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
:: 前2句表示把bat文件提升为管理员权限

for /F "skip=2 tokens=1,2*" %%N in ('%SystemRoot%\System32\reg.exe query "HKCU\Environment" /v "Path" 2^>nul') do if /I "%%N" == "Path" call set "UserPath=%%P" & goto UserPathRead
:: 注册表获取用户环境变量成功，跳转到userpathread

echo There is no user PATH defined.
:: 显示无用户环境变量
echo/
pause
goto :EOF
:: 跳转到文件结束

:UserPathRead
:: 跳转userpathread

echo %UserPath%
:: 显示用户环境变量

set  new_path=C:\vim
:: 设定变量new_path 值为c:\vim

echo %new_path%
:: 显示变量

set new_path1="%new_path%"
:: 设定变量new_path1,值为new_path的文本型

echo %new_path1%
:: 显示变量new_path1

echo %UserPath%|find /I %new_path1% >nul && echo 环境变量存在 || setx "path" "%UserPath%%new_path%;C:\MinGW\bin;"
:: find命令测试c:\vim是否在用户环境变量中，如不在则添加c:\vim和c:\mingw\bin

md %USERPROFILE%\Documents\WindowsPowerShell
:: 在"文档"建立对应文件夹 %USERPROFILE%表示用户文档位置

pushd %USERPROFILE%\Documents\WindowsPowerShell
:: 默认路径跳转到系统"文档"文件夹

set today=%date:~0,10%
set ctime=%TIME: =0%
set tname=%today%T%ctime:~0,2%%ctime:~3,2%%ctime:~6,2%
:: 当前时间赋值给tname变量

if exist profile.ps1 ren profile.ps1 profile-%tname%.back
:: 如果profile.ps1存在则把该文件重命名为tname.back文件

SETLOCAL ENABLEDELAYEDEXPANSION
:: for变量的延迟扩展

FOR %%c in (H G F E D C) do (
       if exist %%c:\cpl (
	set var=%%c
	goto:zz
)
)
:: for语句详解:把cdefgh盘符赋值给变量c
:: 如果这些盘符中存在cpl文件夹
:: 就把c赋值给var变量
:: 跳转到zz语句

goto:eof
:: 如果没找到cpl文件夹结束程序

:zz
:: zz语句

echo start-process -filepath "!var!:\CPL\colortool\.\colortool" -ArgumentList "-b galaxy" -NoNewWindow -wait>profile.txt 
:: 建立txt文件，并写入内容，内容为echo到大于>符号之间的字符

echo set-location !var!:\CPL\>>profile.txt 
:: 追加新内容到txt文件中

ren profile.txt profile.ps1
:: txt改为ps1格式

powershell -noprofile -command "&{set-executionpolicy Remotesigned -Scope currentuser}"
:: 把powershell的currentuser的remotesigned打开 允许运行本地脚本打开

pause
