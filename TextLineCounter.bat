@echo off
setlocal EnableDelayedExpansion
set "cmd=findstr /R /N "^^" textfile.txt | find /C ":""
for /F %%a in ('!cmd!') do set number=%%a
echo %number%
pause >nul