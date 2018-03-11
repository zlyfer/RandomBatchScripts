@echo off
setlocal EnableDelayedExpansion
set file1=%1
if not exist %file1% (
echo "%file1%" konnte nicht gefunden werden.
pause >nul
exit /B
)
echo Debug von "%file1%" wird vorbereitet..
set "cmd=findstr /R /N "^^" %file1% | find /C ":""
for /F %%a in ('!cmd!') do set lines=%%a
set algorythm=0
echo (>tmp.bat
:algorythm1
set /A algorythm=%algorythm%+1
echo set /P var%algorythm%=>>tmp.bat
if not %algorythm%==%lines% goto algorythm1
echo )^<%file1%>>tmp.bat
call tmp.bat 2>nul
set algorythm=0
set file2=%random:~0,1%%random:~0,1%%random:~0,1%%random:~0,1%
del %desktop%\debug%file2%.bat 2>nul
:algorythm2
set /A algorythm=%algorythm%+1
echo MSG /W * Befehl #%algorythm%: "!var%algorythm%!">>%desktop%\debug%file2%.bat
echo !var%algorythm%!>>%desktop%\debug%file2%.bat
if not %algorythm%==%lines% goto algorythm2
echo.
echo Debug von "%file1% wird gestartet..
ping -n 3 localhost >nul
cls
del tmp.bat 2>nul
%desktop%\debug%file2%.bat
pause >nul
cls
echo Debug von %file1% beendet.
del tmp.bat 2>nul
del %desktop%\debug%file2%.bat 2>nul
pause >nul
exit /B