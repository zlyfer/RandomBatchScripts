@echo off
setlocal enabledelayedexpansion
set sub=0
set subspace=
set subtemplate=	
set outputfile=OutPut
:loop
title Subchannel = %sub% ^| "-child" ".parent"
set channelname=
set channeldesc=
set /p channelname=Channel name: 
set /p channeldesc=Channel description: 
:checkchild
if %channelname:~0,1%==- call :dochild & goto skip1
if %channelname:~0,1%==. call :doparent & goto skip1
:skip1
set subtmp=%sub%
set subspace=
:sub
if %subtmp% GTR 0 set subspace=%subspace%%subtemplate%
if %subtmp%==0 goto skip2
set /a subtmp=%subtmp%-1
goto sub
:skip2
echo %subspace%^<channelname^>%channelname%^<^/channelname^>>>"%outputfile%".txt
echo %subspace%^<channeldesc^>%channeldesc%^<^/channeldesc^>>>"%outputfile%".txt
goto loop
:dochild
set /a sub=%sub%+1
set channelname=%channelname:~1%
if %channelname:~0,1%==- call :dochild
exit /b
:doparent
set /a sub=%sub%-1
set channelname=%channelname:~1%
if %channelname:~0,1%==. call :doparent
exit /b