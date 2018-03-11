@echo off
setlocal enabledelayedexpansion
title Scan
set /P file=Filename: 
echo Searching for:
echo                %file%.lnk
echo                %file%.url
dir "%cd%\%file%.*" /B /OE /S /X>scan1.dat 2>nul
type scan1.dat|find "%file%.lnk" >scan2.dat
type scan1.dat|find "%file%.url" >>scan2.dat
type scan2.dat|find "%file%" 2>nul >nul
if %errorlevel%==1 echo No files found. & goto exit
ping -n 1 localhost >nul
echo.
echo Files found:
type scan2.dat 2>nul
echo.
set /P start=<scan2.dat
echo Press any key to start "%start%"..
pause >nul
call "%start%" 2>nul
if %errorlevel%==1 echo File could not be started.
:exit
del scan1.dat 2>nul
del scan2.dat 2>nul
del scan3.dat 2>nul
echo.
echo Press any key to exit..
pause >nul
exit