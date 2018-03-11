@echo off
setlocal enabledelayedexpansion
set /p path=Ordner hier reinziehen: 
cd %path%
echo.
echo.

for %%i in ("*.png") do (
set file1="%%i"
set file2="!file1:~1,-5!"
echo !file1! gefunden.
md !file2! 2>nul
echo Unterordner !file2! erstellt.
move /Y !file1! !file2! >nul
echo !file1! nach !file2! verschoben.
echo.
)
for %%i in ("*.jpg") do (
set file1="%%i"
set file2="!file1:~1,-5!"
echo !file1! gefunden.
md !file2! 2>nul
echo Unterordner !file2! erstellt.
move /Y !file1! !file2! >nul
echo !file1! nach !file2! verschoben.
echo.
)
for %%i in ("*.jpeg") do (
set file1="%%i"
set file2="!file1:~1,-6!"
echo !file1! gefunden.
md !file2! 2>nul
echo Unterordner !file2! erstellt.
move /Y !file1! !file2! >nul
echo !file1! nach !file2! verschoben.
echo.
)
echo.
echo.
echo Operation beendet.
pause >nul
exit