@echo off
setlocal enabledelayedexpansion
title VertText v1.0 - by Frederik Shull
REM PERSONAL START
cd "C:\Users\zlyfer\Documents\Batchscripts"
REM PERSONAL END
md VertText.data 2>nul
cd VertText.data
set char=0
set file=VertText
if not exist %file%.txt echo.>%file%.txt
set "cmd=findstr /R /N "^^" %file%.txt | find /C ":""
for /F %%a in ('!cmd!') do set number=%%a
set /A char=%number%-1
:loop
cls
echo Write down your text. Press Spacebar to see the full text.
type %file%.txt 2>nul|find "%key%"
set key=
set /A char=%char%+1
For /F "Delims=" %%K In ('xcopy /W "%~f0" "%~f0" 2^>nul') do (
if not defined key (
set "key=%%K"
set "key=!Key:~-1!"
)
)
If /I "!Key!" == "^" echo. & set key=
If /I "!Key!" NEQ "" echo %char%: %key%>>%file%.txt
goto loop