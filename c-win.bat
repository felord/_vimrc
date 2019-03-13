@echo off

:: cd /d %~dp0
:: %1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
:: 前2句表示把bat文件提升为管理员权限

for /F "skip=2 tokens=1,2*" %%N in ('%SystemRoot%\System32\reg.exe query "HKCU\Environment" /v "Path" 2^>nul') do if /I "%%N" == "Path" call set "UserPath=%%P" & goto UserPathRead
:: 获取用户路径的方法

echo There is no user PATH defined.
echo/
pause
goto :EOF
:: 未获得结束程序

:UserPathRead
echo The user PATH is: %UserPath%
echo %UserPath%
:: 显示用户路径

set /p new_path=请输入环境变量目录：
:: 用户输入自定义用户路径
echo %new_path%
set new_path1="%new_path%"
echo %new_path1%
echo %UserPath%|find /I %new_path1% >nul && echo 环境变量存在 || setx path %UserPath%%new_path%;
:: 环境变量中是否存在自定义路径,如果不存在，添加到用户环境变量

md %USERPROFILE%\Documents\WindowsPowerShell
:: 在"文档"建立对应文件夹 %USERPROFILE%表示用户文档位置

cd %USERPROFILE%\Documents\WindowsPowerShell 
:: 默认路径变为该文件夹

set today=%date:~0,10%
set ctime=%TIME: =0%
set tname=%today%T%ctime:~0,2%%ctime:~3,2%%ctime:~6,2%
:: 当前时间赋值给tname变量

if exist profile.ps1 ren profile.ps1 profile-%tname%.back
:: 如果profile.ps1存在 把该文件重命名为tname.back文件

echo start-process -filepath "d:\CPL\colortool\.\colortool" -ArgumentList "-b galaxy" -NoNewWindow -wait>profile.txt 
::建立txt文件，并写入内容，内容为echo到大于>符号之间的字符

echo set-location d:\CPL\>>profile.txt 
::追加新内容到txt文件中

ren profile.txt profile.ps1
:: txt改为ps1格式

powershell -noprofile -command "&{set-executionpolicy Remotesigned -Scope currentuser}"
:: 把powershell的currentuser允许运行本地脚本打开

pause
