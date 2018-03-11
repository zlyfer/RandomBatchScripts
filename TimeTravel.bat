@echo off
setlocal enabledelayedexpansion
mode con cols=15 lines=8
set m=0
set h=0
set r=0
set inc=0
set dec=0
:loop
ping -n 1 localhost >nul
cls
echo Time: %h%:%m%
echo Inc: %inc%
echo Dec: %dec%
echo R: %r%
time %h%:%m%

set r=%random:~0,1%
if %r% GTR 2 call :inc
if %r% LSS 2 call :dec

if %m%==-1 (
set /a h=%h%-1
set m=59
)
if %h%==-1 (
set h=23
)
if %m%==60 (
set /a h=%h%+1
set m=0
if %h%==23 (
set h=0
)
)
goto loop

:inc
set /a m=%m%+1
set /a inc=%inc%+1
exit /b

:dec
set /a m=%m%-1
set /a dec=%dec%+1
exit /b