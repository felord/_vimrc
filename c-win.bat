@echo off

:: cd /d %~dp0
:: %1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
:: ǰ2���ʾ��bat�ļ�����Ϊ����ԱȨ��

md %USERPROFILE%\Documents\WindowsPowerShell
:: ��"�ĵ�"������Ӧ�ļ��� %USERPROFILE%��ʾ�û��ĵ�λ��

cd %USERPROFILE%\Documents\WindowsPowerShell 
:: Ĭ��·����Ϊ���ļ���

set today=%date:~0,10%
set ctime=%TIME: =0%
set tname=%today%T%ctime:~0,2%%ctime:~3,2%%ctime:~6,2%
:: ��ǰʱ�丳ֵ��tname����

if exist profile.ps1 ren profile.ps1 profile-%tname%.back
:: ���profile.ps1���� �Ѹ��ļ�������Ϊtname.back�ļ�

echo start-process -filepath "d:\CPL\colortool\.\colortool" -ArgumentList "-b galaxy" -NoNewWindow -wait>profile.txt 
::����txt�ļ�����д�����ݣ�����Ϊecho������>����֮����ַ�

echo set-location d:\CPL\>>profile.txt 
::׷�������ݵ�txt�ļ���

ren profile.txt profile.ps1
:: txt��Ϊps1��ʽ



powershell -noprofile -command "&{set-executionpolicy Remotesigned -Scope currentuser}"
:: ��powershell��currentuser�������б��ؽű���

pause