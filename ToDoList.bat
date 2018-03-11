@echo off
REM ToDoList - by Frederik Shull!
REM Coding: Charset: Arabic: OEM 720.
setlocal enabledelayedexpansion
mode con cols=120
REM PERSONAL START
cd "C:\Users\zlyfer\Documents\Batchscripts"
REM PERSONAL END
md ToDoList.data 2>nul
cd ToDoList.data
set v=1.6
title ToDoList v%v%
:main
del tmp.dat 2>nul
set page=Main
set ex=no_input
call :header
set /P ex=Task: 
if /I %ex%==add goto add
if /I %ex%==remove_tdl goto remove_tdl
if /I %ex%==remove_dl goto remove_dl
if /I %ex%==remove_tdl_date goto remove_tdl_date
if /I %ex%==remove_dl_date goto remove_dl_date
if /I %ex%==finish goto finish
if /I %ex%==clear_tdl del todolist.dat 2>nul & goto main
if /I %ex%==clear_dl del donelist.dat 2>nul & goto main
if /I %ex%==help goto help
if /I %ex%==exit exit
goto help
:add
set page=Add
set ex=no_input
call :header
set /P ex=Add task: 
set id=%random%%random%%random%%random%
type todolist.dat 2>nul|find "%id%">nul 2>nul
if %errorlevel%==0 goto add
type todolist.dat|find "%date%"
if %errorlevel%==1 echo ---ÿ%date%ÿ--->>todolist.dat
echo [%id:~0,4%]ÿ"%ex:~0,100%">>todolist.dat
goto main
:finish
set page=Finish
set ex=no_input
call :header
set /P ex=Finish ID: 
type todolist.dat 2>nul|find "[%ex%]">nul 2>nul
if %errorlevel%==1 (
echo Error: ID "[%ex%]" not found. 
pause >nul
goto main
)
type donelist.dat 2>nul|find "%date%" 2>nul
if %errorlevel%==1 echo ---ÿ%date%ÿ--->>donelist.dat
type todolist.dat 2>nul|find "[%ex%]">>donelist.dat 2>nul
type todolist.dat 2>nul|find /V "[%ex%]">tmp.dat 2>nul
type tmp.dat>todolist.dat 2>nul
type todolist.dat 2>nul|find "ÿ" 2>nul
if %errorlevel%==1 (
del todolist.dat 2>nul
goto main
)
cls
goto main
:remove_tdl
set page=Remove (ToDoList)
set ex=no_input
call :header
set /P ex=Remove ID: 
type todolist.dat 2>nul|find "[%ex%]">nul
if %errorlevel%==1 (
echo Error: ID "[%ex%]" not found. 
pause >nul
goto main
)
type todolist.dat 2>nul|find /V "[%ex%]">tmp.dat 2>nul
type tmp.dat>todolist.dat 2>nul
type todolist.dat 2>nul|find "ÿ" 2>nul
if %errorlevel%==1 (
del todolist.dat 2>nul
goto main
)
cls
goto main
:remove_dl
set page=Remove (DoneList)
set ex=no_input
call :header
set /P ex=Remove ID: 
type donelist.dat 2>nul|find "[%ex%]">nul
if %errorlevel%==1 (
echo Error: ID "[%ex%]" not found. 
pause >nul
goto main
)
type donelist.dat 2>nul|find /V "[%ex%]">tmp.dat 2>nul
type tmp.dat>donelist.dat 2>nul
type donelist.dat 2>nul|find "ÿ" 2>nul
if %errorlevel%==1 (
del donelist.dat 2>nul
goto main
)
cls
goto main
:remove_tdl_date
set page=Remove (Date, ToDoList)
set ex=no_input
call :header
set /P ex=Remove Dateline: 
type todolist.dat 2>nul|find "---ÿ%ex%ÿ---">nul
if %errorlevel%==1 (
echo Error: Date "---ÿ%ex%ÿ---" not found. 
pause >nul
goto main
)
type todolist.dat 2>nul|find /V "---ÿ%ex%ÿ---">tmp.dat 2>nul
type tmp.dat>todolist.dat 2>nul
type todolist.dat 2>nul|find "ÿ" 2>nul
if %errorlevel%==1 (
del todolist.dat 2>nul
goto main
)
cls
goto main
:remove_dl_date
set page=Remove (Date, DoneList)
set ex=no_input
call :header
set /P ex=Remove Dateline: 
type donelist.dat 2>nul|find "---ÿ%ex%ÿ---">nul
if %errorlevel%==1 (
echo Error: Date "---ÿ%ex%ÿ---" not found. 
pause >nul
goto main
)
type donelist.dat 2>nul|find /V "---ÿ%ex%ÿ---">tmp.dat 2>nul
type tmp.dat>donelist.dat 2>nul
type donelist.dat 2>nul|find "ÿ" 2>nul
if %errorlevel%==1 (
del donelist.dat 2>nul
goto main
)
cls
goto main
:help
set page=Help
echo.
echo HELP:
echo ADD             - Adds a new task to the todolist.
echo FINISH          - Removes a task from the todolist and adds it to the donelist.
echo REMOVE_TDL      - Removes a task from the todolist.
echo REMOVE_DL       - Removes a task from the donelist.
echo REMOVE_TDL_DATE - Removes a left date line from the todolist.
echo REMOVE_DL_DATE  - Removes a left date line from the donelist.
echo CLEAR_TDL       - Deletes the current todolist.
echo CLEAR_DL        - Deletes the current donelist.
echo HELP            - Shows this page.
echo EXIT            - Exits ToDoList v%v%.
echo ...
pause >nul
goto main
:header
cls
echo ToDoList v%v% - %page%
echo.
if exist todolist.dat set lines=0 & type todolist.dat|find "[">tmp.dat & for /F %%i in ('type tmp.dat') do set /A lines=lines+1 & del tmp.dat 2>nul
if exist todolist.dat (
echo ToDoList: %lines%
echo.
type todolist.dat 2>nul
echo.
)
if exist donelist.dat set lines=0 & type donelist.dat|find "[">tmp.dat & for /F %%i in ('type tmp.dat') do set /A lines=lines+1 & del tmp.dat 2>nul
if exist donelist.dat (
echo Finished Tasks: %lines%
echo.
type donelist.dat 2>nul
echo.
)
exit /B