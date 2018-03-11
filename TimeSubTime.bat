@echo off
setlocal EnableDelayedExpansion
set /P time1=Time1: 
set time2=%time:~0,8%
if %time1:~0,2%== 0 set time1=24%time1:~2%
if %time2:~0,2%== 0 set time2=24%time2:~2%
set /A time3=((%time1:~0,2%*60)*60)+(%time1:~3,2%*60)+%time1:~6,2%
set /A time4=((%time2:~0,2%*60)*60)+(%time2:~3,2%*60)+%time2:~6,2%
if %time3% GTR %time4% set /A time5=%time3%-%time4%
if %time3% LSS %time4% set /A time5=%time4%-%time3%
if %time3% EQU %time4% set /A time5=%time3%-%time4%
cls
set /A htime=(%time5%/60)/60
set /A time5=%time5%-((%htime%*60)*60)
set /A mtime=(%time5%/60)
set /A time5=%time5%-(%mtime%*60)
set /A stime=%time5%
if %htime% LSS 10 set htime=0%htime%
if %mtime% LSS 10 set mtime=0%mtime%
if %stime% LSS 10 set stime=0%stime%
set time5=%htime%:%mtime%:%stime%
echo %time1%
echo %time2%
echo %time5%
pause >nul
exit