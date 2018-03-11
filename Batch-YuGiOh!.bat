@echo off
title Batch-YuGiOh! - by Frederik Shull!
setlocal enabledelayedexpansion
color F0
title Settings - Batch-YuGiOh
echo Settings
echo.
set wip1=0
set wip2=0
set match=1
set /P p1=P1 Name: 
set /P p2=P2 Name: 
set /P lp=Start LP: 
set lpp1=%lp%
set lpp2=%lp%
cls
:main
set p=0
set a=0
title Match #%match% - Batch-YuGiOh by Frederik Shull
echo Match #%match%
echo.
echo P1 %p1% [VS] P2 %p2%
echo [P1] Wins: %wip1%, LP: %lpp1%
echo [P2] Wins: %wip2%, LP: %lpp2%
echo.
set /P ex=Action: 
if /I %ex:~0,2%==p1 set p=1
if /I %ex:~0,2%==p2 set p=2
if /I %ex:~3,2%==lp set /A lpp%p%=lpp%p%+%ex:~6,6%
if /I %ex:~3,2%==mw set /A wip%p%=wip%p%+1 & set /A match=%match%+1 & set lpp1=%lp% & set lpp2=%lp%
cls & goto main