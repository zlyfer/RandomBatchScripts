@echo off
setlocal EnableDelayedExpansion
echo Date: %date%
echo Time: %time%
if "%cd%\now.bat"==%0 pause >nul
exit /B