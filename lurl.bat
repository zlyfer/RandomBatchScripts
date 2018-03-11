@echo off
setlocal enabledelayedexpansion
REM Nicht "by" Frederik Shull!
mode con cols=25 lines=9
title lurl
:loop
set /p room=Raum: 
set /p pc=PC Nummer: 
set /p time=Sekunden: 
set /p comment=Kommentar: 
echo.
echo Enter um zu starten..
pause >nul
shutdown -s -t %time% -m r%room%-%pc% -c "%comment%"
echo Gestartet.
echo Enter um abzubrechen..
pause >nul
shutdown -a -m r%room%-%pc%
cls
echo Abgebrochen.
goto loop