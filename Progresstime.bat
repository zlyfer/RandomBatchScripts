@echo off
REM Progresstime - by Frederik Shull!
title Progresstime
setlocal enabledelayedexpansion
cls
:loop
set /P pi=Ping: 
cls
echo Ping: %pi% miliseconds:
echo. 
set s0=%time%
set /A s1=%s0:~0,2% 2>nul
set /A s2=%s0:~3,2% 2>nul
set /A s3=%s0:~6,2% 2>nul
set /A s4=%s0:~9,2% 2>nul
ping -n 1 1.1.1.1 -w %pi% >nul
set e0=%time%
set /A e1=%e0:~0,2% 2>nul
set /A e2=%e0:~3,2% 2>nul
set /A e3=%e0:~6,2% 2>nul
set /A e4=%e0:~9,2% 2>nul
set d0=%time%
set /A d1=%e1%-%s1% 2>nul
set /A d2=%e2%-%s2% 2>nul
set /A d3=%e3%-%s3% 2>nul
set /A d4=%e4%-%s4% 2>nul
if %d4% LSS 0 set /A d3=%d3%-1 & set /A d4=100+%d4%
if %d3% LSS 0 set /A d2=%d2%-1 & set /A d3=60+%d3%
if %d2% LSS 0 set /A d1=%d1%-1 & set /A d2=60+%d3%
if %d1% LSS 0 set /A d1=24-%e1%
if %d4% LSS 10 set d4=0%d4%
if %d3% LSS 10 set d3=0%d3%
if %d2% LSS 10 set d2=0%d2%
if %d1% LSS 10 set d1=0%d1%
if %s4% LSS 10 set s4=0%s4%
if %s3% LSS 10 set s3=0%s3%
if %s2% LSS 10 set s2=0%s2%
if %s1% LSS 10 set s1=0%s1%
if %e4% LSS 10 set e4=0%e4%
if %e3% LSS 10 set e3=0%e3%
if %e2% LSS 10 set e2=0%e2%
if %e1% LSS 10 set e1=0%e1%
set d0=%d1%:%d2%,%d3%.%d4%
echo S0: %s0%. S1: %s1%. S2: %s2%. S3: %s3%. S4: %s4%.
echo E0: %e0%. E1: %e1%. E2: %e2%. E3: %e3%. E4: %e4%.
echo D0: %d0%. D1: %d1%. D2: %d2%. D3: %d3%. D4: %d4%.
echo     -- -- -- --      --      --      --      --
echo.
echo Progresstime: %d0%.
echo.
echo LEGEND:
echo.
echo S=Start
echo E=End
echo D=Difference
echo.
echo 0=All together
echo 1=Hours
echo 2=Minutes
echo 3=Seconds
echo 4=Hundredths of a second
echo.
goto loop