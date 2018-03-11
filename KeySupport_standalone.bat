@echo off
REM KeySupport_standalone - by Frederik Shull!
REM Note: This code includes parts from Unknown!
setlocal enabledelayedexpansion
title KeySupport_standalone
:loop
For /F "Delims=" %%K In ('Xcopy /W "%~f0" "%~f0" 2^>Nul') Do (
If Not Defined Key (
Set "key=%%K"
Set "key=!Key:~-1!"
)
)
If /i "!Key!" == "^" echo. & set key=
If /i "!Key!" NEQ "" echo %key%>>txt.txt
set key=
goto loop