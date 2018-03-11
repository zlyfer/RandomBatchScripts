@echo off
REM Color - by Frederik Shull!
REM Note: This code includes parts from GrellesLicht28!
title Color
color F0
:re
cls
call :table
set /P bgcolor1=Select the background color: 
color %bgcolor1%F
cls
echo Select the background color: %bgcolor1%
echo.
call :table
set /P bgcolor2=Select the font color: 
color %bgcolor1%%bgcolor2%
cls
echo Select the background color: %bgcolor1%
echo Select the font color: %bgcolor2%
set /p text1=Text 1: 
cls
echo Select the background color: %bgcolor1%
echo Select the font color: %bgcolor2%
set /p text2=Text 1: %text1% Text 2: 
echo.
call :table
set /p color1=Select a color for Text 1: "%text1%": 
cls
echo Select the background color: %bgcolor1%
echo Select the font color: %bgcolor2%
echo Text 1: %text1% Text 2: %text2%
echo Select a color for Text 1 "%text1%": %color1%
echo.
call :table
set /p color2=Select a color for Text 2: "%text2%": 
cls
echo Select the background color: %bgcolor1%
echo Select the font color: %bgcolor2%
echo Text 1: %text1% Text 2: %text2%
echo Select a color for Text 1 "%text1%": %color1%
echo Select a color for Text 2 "%text2%": %color2%
echo.
md Color.data 2>nul
cd Color.data

set /p ".=|"<nul>"%text1%"
set /p ".=|"<nul>"%text2%"
set /p ".=|"<nul
findstr /a:%bgcolor1%%color1% /s "|" "%text1%"
findstr /a:%bgcolor1%%color2% /s "|" "%text2%"

echo.
echo.
echo Press any key to restart...
pause >nul
goto re

:table
echo 0 = Black        8 = Deep grey
echo 1 = Deep blue    9 = Blue
echo 2 = Deep green   A = Green
echo 3 = Blue-green   B = Cyanogen
echo 4 = Deep red     C = Red
echo 5 = Purple       D = Magenta
echo 6 = Ocher        E = Yellow
echo 7 = Lightgrey    F = White
exit /b