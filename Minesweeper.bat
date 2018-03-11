@echo off
setlocal enabledelayedexpansion
set version=1.2
title Minesweeper v%version% by Frederik Shull
mode con cols=135 lines=60
color f

:restart
REM Engine 1 or 2:
REM del Minesweeper.dat 2>nul
REM del MSSelect.dat 2>nul
REM del MSCalc.dat 2>nul
REM del MSDraw.dat 2>nul
REM END
cls

:ostart
echo Û Welcome to Minesweeper for Batch,
echo Û
echo Û INTRODUCTION
echo Û This game is a little bit different to the original one. There are no numbers shown,
echo Û instead you have to shot in the dark to reach the highest score.
echo Û
echo Û DISCLAIMER
echo Û Please be aware that because of performance restrictions in
echo Û batch the game might load several seconds based on the field size.
echo Û
if exist minesweeper_scores.dat (
echo Û SCORES:
type minesweeper_scores.dat 2>nul
echo Û
)
echo Û
echo Û Please select the window size dimensions.
set /p mcol=Û Columns (Width)(3-130): 
set /p mrow=Û Rows (Height)(3-45):    
set /a wcol=%mcol%+5
set /a wrow=%mrow%+20
if %wcol% GTR 135 cls & call :error invalid_window_size_col & goto ostart
if %wcol% LSS 8 cls & call :error invalid_window_size_col & goto ostart
if %wrow% GTR 65 cls & call :error invalid_window_size_row & goto ostart
if %wrow% LSS 23 cls & call :error invalid_window_size_row & goto ostart

:start
cls
set mine=²
set free=°
set ukwn=Û
set untouched=±
set crow=1
set ccol=0
set dtoprow=0
set stoprow=0
set /a field=%mcol%*%mrow%
set op1=
set op2=
set op3=
set rnd=
set statmine1=0
set statmine2=0
set totalstat=0
set ysel=0
set xsel=0
set dcol=0
set drow=1
set score=0
set maxscore=0
set name=Anon_%date:~0,2%%date:~3,2%_%time:~0,2%%time:~3,2%
set won=0

:mloop
set /a ccol+=1
call :minegen
if %ccol%==%mcol% (
set ccol=0
set /a crow+=1
)
if %crow% GTR %mrow% (
goto select
)
goto mloop

:select
cls
call :draw
title Minesweeper v%version% by Frederik Shull ^| Fields %mcol%x%mrow% - %field% ^| Free %statmine1% ^| Mines %statmine2% ^| Score: %score%
REM Engine 1 or 2:
REM del MSSelect.dat 2>nul
REM END
echo Û
:select2
echo Û Select a field.
set ysel=0
set xsel=0
set /p ysel=Û Row (1-%mrow%): 
set /p xsel=Û Column (1-%mcol%): 
if %ysel% LSS 1 call :error invalid_selection & goto select2
if %ysel% GTR %mrow% call :error invalid_selection & goto select2
if %xsel% LSS 1 call :error invalid_selection & goto select2
if %xsel% GTR %mcol% call :error invalid_selection & goto select2
echo.
call :calcfield
if %score%==%statmine1% (
set won=1
goto endgame
)
goto select

:minegen
set rnd=%random:~0,2%
if %rnd% LSS 80 (
REM Engine 1 or 2:
REM echo ROW%crow%COL%ccol%_0>>Minesweeper.dat
REM END
REM Engine 3:
set ROW%crow%COL%ccol%=0
REM END
set /a statmine1+=1
)
if %rnd% GTR 79 (
REM Engine 1 or 2:
REM echo ROW%crow%COL%ccol%_1>>Minesweeper.dat
REM END
REM Engine 3:
set ROW%crow%COL%ccol%=1
REM END
set /a statmine2+=1
)
set /a totalstat=%statmine1%+%statmine2%
set /a statpercent=(%totalstat%*100)/%field%) 2>nul
title Minesweeper v%version% by Frederik Shull ^| Fields %mcol%x%mrow% - %field% ^| Free %statmine1% ^| Mines %statmine2% ^| Score: %score% ^| Generating: (%totalstat%/%field% ^| %statpercent%%%)
cls
echo Û Generating..
exit /b

:calcfield
REM Engine 1 or 2:
REM type Minesweeper.dat | find "ROW%ysel%COL%xsel%_" > MSCalc.dat
REM set /p calcthis=<MSCalc.dat
REM set calcthis=%calcthis:~-1%
REM END
REM Engine 3:
set calcthis=!ROW%ysel%COL%xsel%!
REM END
if %calcthis%==1 goto endgame
if %calcthis%==0 (
REM Engine 1 or 2:
REM type Minesweeper.dat | find /v "ROW%ysel%COL%xsel%_" > MSCalc.dat
REM echo ROW%ysel%COL%xsel%_2>>MSCalc.dat
REM type MSCalc.dat > Minesweeper.dat
REM END
REM Engine 3:
set /a score+=1
set ROW%ysel%COL%xsel%=2
REM END
)
exit /b

:draw
cls
set drow=1
set dcol=0
set stoprow=0
set dtoprow=0
set op2=
set op3=
set totalstat=0
call :toprow
:drawengine
set /a dcol+=1
REM Engine 1:
REM set "cmd=type Minesweeper.dat | find "ROW%drow%COL%dcol%_""
REM for /F %%a in ('!cmd!') do set sdraw=%%a
REM END
REM Engine2:
REM type Minesweeper.dat | find "ROW%drow%COL%dcol%_" > MSDraw.dat
REM set /p sdraw=<MSDraw.dat
REM END
REM Engine 1 or 2:
REM set sdraw=%sdraw:~-1%
REM END
REM Engine 3
set sdraw=!ROW%drow%COL%dcol%!
REM END
if %sdraw%==0 (
set op1=%op1%%ukwn%
)
if %sdraw%==1 (
set op1=%op1%%ukwn%
)
if %sdraw%==2 (
set op1=%op1%%free%
)
if %sdraw%==3 (
set op1=%op1%%mine%
)
if %sdraw%==4 (
set op1=%op1%%untouched%
)
if %sdraw%==5 (
set op1=%op1%%ukwn%
)
if %dcol%==%mcol% (
set dcol=0
set /a drow+=1
if %drow% LSS 10 echo Û%drow%  %op1%^|
if %drow% GTR 9 echo Û%drow% %op1%^|
set op1=
)
set /a totalstat+=1
set /a statpercent=(%totalstat%*100)/%field% 2>nul
title Minesweeper v%version% by Frederik Shull ^| Fields %mcol%x%mrow% - %field% ^| Free %statmine1% ^| Mines %statmine2% ^| Score: %score% ^| Drawing: (%totalstat%/%field% ^| %statpercent%%%)
if %drow% GTR %mrow% (
exit /b
)
goto drawengine

:toprow
set /a stoprow+=1
set /a dtoprow+=1
if %dtoprow%==10 set dtoprow=0
set op3=%op3% 
set op2=%op2%%dtoprow%
if %stoprow%==%mcol% (
echo Û  C%op2%^|
echo ÛR  %op3%^|
exit /b
)
goto toprow

:endgame
set ccol=0
set crow=1
set totalstat=0
set /a scorepercent=(%score%*100)/%statmine1%
:endgame2
set /a ccol+=1 2>nul
if %ccol% GTR %mcol% (
set ccol=0
set /a crow+=1 2>nul
)
set /a totalstat+=1
set /a statpercent=(%totalstat%*100)/%field% 2>nul
title Minesweeper v%version% by Frederik Shull ^| Fields %mcol%x%mrow% - %field% ^| Free %statmine1% ^| Mines %statmine2% ^| Score: %score% ^| Drawing: (%totalstat%/%field% ^| %statpercent%%%)
if %crow% GTR %mrow% if %won%==1 goto endgame4
if %crow% GTR %mrow% if %won%==0 goto endgame3
if !ROW%crow%COL%ccol%!==0 set ROW%crow%COL%ccol%=4
if !ROW%crow%COL%ccol%!==1 set ROW%crow%COL%ccol%=3
if %won%==0 set ROW%ysel%COL%xsel%=5
goto endgame2
:endgame3
call :draw
title Minesweeper v%version% by Frederik Shull ^| Fields %mcol%x%mrow% - %field% ^| Free %statmine1% ^| Mines %statmine2% ^| Score: %score% ^| GAME OVER
if exist minesweeper_scores.dat (
echo Û
echo Û
echo Û SCORES
type minesweeper_scores.dat 2>nul
)
echo Û
echo Û
echo Û You trapped on a mine @ row: %ysel%, column: %xsel%. ^| Your score: %score%.
set /p name=Û Enter name for score: 
echo %ukwn% Name: %name% - Score: (%score% / %statmine1% ^| ~%scorepercent%%%) - Dimensions: (%mcol% x %mrow% ^| %field%) - Mines: %statmine2% - LOST>>minesweeper_scores.dat
REM Engine 1 or 2:
REM del Minesweeper.dat 2>nul
REM END
goto restart
:endgame4
call :draw
title Minesweeper v%version% by Frederik Shull ^| Fields %mcol%x%mrow% - %field% ^| Free %statmine1% ^| Mines %statmine2% ^| Score: %score% ^| GAME OVER
if exist minesweeper_scores.dat (
echo.
echo.
echo Û SCORES
type minesweeper_scores.dat 2>nul
)
echo Û
echo Û
echo Û You cleared every %statmine1% fields. Congratulations.
set /p name=Û Enter name for score: 
echo %ukwn% Name: %name% - Score: (%score% / %statmine1% ^| ~%scorepercent%%%) - Dimensions: (%mcol% x %mrow% ^| %field%) - Mines: %statmine2% - WON>>minesweeper_scores.dat
REM Engine 1 or 2:
REM del Minesweeper.dat 2>nul
REM END
goto restart

:error
if %1==invalid_window_size_col echo Û ERROR: You entered a wrong number. Column range is from 3-130. (error: %1)
if %1==invalid_window_size_row echo Û ERROR: You entered a wrong number. Row range is from 3-45. (error: %1)
if %1==invalid_selection echo Û ERROR: You entered a wrong number. Please select a field withing the fieldsize (Columns: %mcol%, Rows: %mrow%). (error: %1)
echo Û
exit /b


REM DEVELOPER SECTION

REM Û²±°
REM echo Û²±°
REM pause >nul

:debug
echo %1
pause >nul
exit /b