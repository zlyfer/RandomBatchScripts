@echo off
setlocal enabledelayedexpansion
cls
title Shortcut
echo Welcome.
echo.
set name=%1
set name=%name:"=%
if not "%name:~-4%"==".lnk" set name=%name%.lnk
set name="%name%"
echo 1 ^| Name of shortcut	^| %name%
echo 2 ^| Target file		^| %2
echo 3 ^| Arguments		^| %3
echo 4 ^| Icon location	^| %4
echo.
echo Press any key to create..
pause >nul

echo Set oWS = WScript.CreateObject("WScript.Shell") > tmp.vbs
echo sLinkFile = %name% >> tmp.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> tmp.vbs
echo oLink.TargetPath = %2 >> tmp.vbs
echo oLink.Arguments = %3 >> tmp.vbs
echo oLink.IconLocation = %4 >> tmp.vbs
echo oLink.Save >> tmp.vbs

cscript /nologo tmp.vbs
del tmp.vbs
echo.
echo %name% created.
echo Press any key to exit..
pause >nul
exit