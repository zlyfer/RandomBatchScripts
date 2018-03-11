@echo off
setlocal enabledelayedexpansion
REM Nicht "by" Frederik Shull!
mode con cols=14 lines=2
title lurl
:loop
shutdown -a 2>nul
echo shutdown -a
goto loop