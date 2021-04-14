@echo off
setlocal enabledelayedexpansion

set light=7:00
set dark=17:30

if "%1"=="auto" goto auto
if "%1"=="toggle" goto toggle

start /B cmd /C call "spauto" auto >_spauto 2>&1
goto end

:auto
set color_scheme=0
:auto2
set t=%time:~0,5%
if %t%==%light% set color_scheme=light
if %t%==%dark% set color_scheme=dark
if not %color_scheme%==0 (
	spicetify config color_scheme %color_scheme%
	spicetify apply
	timeout /t 60 >nul
	goto auto
)
timeout /t 1 >nul
goto auto2

:toggle
spicetify config color_scheme > .tmp
set /p color_scheme=<.tmp
del .tmp
if %color_scheme%==dark spicetify config color_scheme light
if %color_scheme%==light spicetify config color_scheme dark
spicetify apply
goto end

:end