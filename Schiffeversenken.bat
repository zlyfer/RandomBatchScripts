@echo off
setlocal enabledelayedexpansion
set version=0.9
set parameter=_%1 2>nul
if %parameter%==_ set parameter=_main
goto main%parameter% 2>nul
echo An unknown error has occured. Please exit.
pause >nul
exit

:transform_main
REM Variablen
REM END
start Schiffeversenken.bat ip %name% %enemy%
start Schiffeversenken.bat op %name% %enemy%
goto main_op2

:main_ip
REM Variablen
set name=%2
set enemy=%3
REM END
title Shoot %enemy%
mode con cols=40 lines=8
color f
call :draw_legend
call :echo. 1
call :shoot_enemy
ping -n 5 localhost >nul
goto main_ip

:main_op
REM Variablen
set name=%2
set enemy=%3
REM END
if %enemy:~-1,1%==s title %enemy%' Field
if not %enemy:~-1,1%==s title %enemy%'s Field
mode con cols=50 lines=20
color f
call :gen_main
:op
cls
call :draw_main
call :wait_name_main
call :check_shot
goto op

:main_op2
REM Variablen
REM END
if %name:~-1,1%==s title %name%' Field
if not %name:~-1,1%==s title %name%'s Field
mode con cols=50 lines=20
color f
call :draw_main
call :wait_enemy_main
call :check_hit
goto main_op2

:main_main
REM Variablen
REM END
mode con cols=50 lines=25
title Schiffeversenken v%version% by zlyfer
color f
call :names_main
cls
call :gen_main
call :draw_main
call :ships_set_main
call :transform_main
echo Unexpected error.
echo Game will now exit.
pause >nul
exit

:names_main
REM Variablen
set name=0
set enemy=0
REM END
set /p name=Your name: 
set /p enemy=Enemy name: 
exit /b

:gen_main
REM Variablen
set field_set_x=0
set field_set_y=0
REM END
:gen
set field%field_set_x%_%field_set_y%=0
set /a field_set_x+=1
if %field_set_x%==20 (
set field_set_x=0
set /a field_set_y+=1
)
if %field_set_y%==10 exit /b
goto gen

:draw_main
call :echo. 2
call :draw_bars_main
call :echo. 1
call :draw_field_main
call :echo. 1
call :draw_bars_main
exit /b

:draw_bars_main
REM Variablen
set bars_draw_1=00000000011111111112
set bars_draw_2=12345678901234567890
REM END
:draw_bars
echo                %bars_draw_1%
echo                %bars_draw_2%
exit /b

:draw_field_main
REM Variablen
set field_draw_x=0
set field_draw_y=0
set draw_field=
set display_ship=Û
set display_water=²
set display_destroyed=±
set display_miss=°
REM -sidebar
set sidebar_display_template=ABCDEFGHIJ
set sidebar_display=
REM END
:draw_field
if !field%field_draw_x%_%field_draw_y%!==0 set draw_field=%draw_field%%display_water%
if !field%field_draw_x%_%field_draw_y%!==1 set draw_field=%draw_field%%display_ship%
if !field%field_draw_x%_%field_draw_y%!==2 set draw_field=%draw_field%%display_destroyed%
if !field%field_draw_x%_%field_draw_y%!==3 set draw_field=%draw_field%%display_miss%
set /a field_draw_x+=1
call set sidebar_display=!sidebar_display_template:~%field_draw_y%,1%!
if %field_draw_x%==20 (
set /a field_draw_y+=1
echo            %sidebar_display%   %draw_field%   %sidebar_display%
set draw_field=
set field_draw_x=0
)
if %field_draw_y%==10 exit /b
goto draw_field

:ships_set_main
endlocal enabledelayedexpansion
REM Variablen
set ships_newship=%1
if not defined ships_available set ships_available=5
set ships_coord_x=0
set ships_coord_y=0
set ships_newship=0
set ships_set_x=-1
set ships_set_y=-1
REM END
call :echo. 2
:ships_set
if %ships_available% GTR 1 echo Place a new ship. You have %ships_available% ships left.
if %ships_available%==0 echo Place a new ship. You have %ships_available% ships left.
if %ships_available%==1 echo Place a new ship. You have %ships_available% ship left.
echo Example: "3 D" ^|x (01-20) ^| y (A-J)
set /p ships_newship=New Ship: 
if "%ships_newship%"=="0" goto ships_set
:ships_apply
set /a ships_coord_x=%ships_newship:~0,2%
set ships_coord_y=%ships_newship:~-2,2%
set ships_coord_y_alfa=0abcdefghijklmnopqrstuvwxyz
for /l %%A in (1 1 26) do for /f %%B in ("!ships_coord_y_alfa:~%%A,1!") do set "ships_coord_y=!ships_coord_y:%%B=%%A !"
set /a ships_coord_y-=1
set /a ships_coord_x-=1
set field%ships_coord_x%_%ships_coord_y%=1
set /a ships_available=%ships_available%-1
cls
if %ships_available%==0 exit /b
call :draw_main
goto ships_set_main

:shoot_enemy
echo Example: "3 D" ^|x (01-20) ^| y (A-J)
set /p shoot_enemy=Shoot: 
set /a shoot_coord_x=%shoot_enemy:~0,2%
set shoot_coord_y=%shoot_enemy:~-2,2%
set shoot_coord_y_alfa=0abcdefghijklmnopqrstuvwxyz
for /l %%C in (1 1 26) do for /f %%D in ("!shoot_coord_y_alfa:~%%C,1!") do set "shoot_coord_y=!shoot_coord_y:%%D=%%C !"
set /a shoot_coord_x-=1
set /a shoot_coord_y-=1
echo x%shoot_coord_x%>%name%.shot
echo y%shoot_coord_y%>>%name%.shot
exit /b

:wait_enemy_main
REM Variablen
set wait_enemy_main=0
REM END
:wait_enemy_main2
REM Variablen
set enemy_coord_x_o=
set enemy_coord_y_o=
REM END
ping -n 3 localhost >nul
if not exist %enemy%.shot (
set wait_enemy_main=1
goto wait_enemy_main2
)
REM if %wait_enemy_main%==1 (
REM set wait_enemy_main=0
REM exit /b
REM )
if exist %enemy%.shot (
(
set /p enemy_coord_x_o=
set /p enemy_coord_y_o=
)<%enemy%.shot 2>nul
)
:wait_enemy
ping -n 3 localhost >nul
(
set /p enemy_coord_x=
set /p enemy_coord_y=
)<%enemy%.shot 2>nul
if %enemy_coord_x%==%enemy_coord_x_o% (
if %enemy_coord_y%==%enemy_coord_y_o% goto wait_enemy
)
exit /b

:wait_name_main
REM Variablen
set wait_name_main=0
REM END
:wait_name_main2
REM Variablen
set name_coord_x_o=
set name_coord_y_o=
REM END
ping -n 5 localhost >nul
if not exist %name%.shot (
set wait_name_main=1
goto wait_name_main2
)
REM if %wait_name_main%==1 (
REM set wait_name_main=0
REM exit /b
REM )
if exist %name%.shot (
(
set /p name_coord_x_o=
set /p name_coord_y_o=
)<%name%.shot 2>nul
)
:wait_name
ping -n 3 localhost >nul
(
set /p name_coord_x=
set /p name_coord_y=
)<%name%.shot 2>nul
if %name_coord_x%==%name_coord_x_o% (
if %name_coord_y%==%name_coord_y_o% goto wait_name
)
exit /b

:check_hit
REM Variablen
set shot_coord_x=-1
set shot_coord_y=-1
REM END
if not exist %enemy%.shot goto check_hit
ping -n 3 localhost >nul
(
set /p shot_coord_x=
set /p shot_coord_y=
)<%enemy%.shot 2>nul
set /a shot_coord_x=%shot_coord_x:~1,2%
set /a shot_coord_y=%shot_coord_y:~1,2%
if !field%shot_coord_x%_%shot_coord_y%!==2 echo t2>>%enemy%.shot
if !field%shot_coord_x%_%shot_coord_y%!==1 (
set field%shot_coord_x%_%shot_coord_y%=2
echo t2>>%enemy%.shot
)
if !field%shot_coord_x%_%shot_coord_y%!==3 echo t3>>%enemy%.shot
if !field%shot_coord_x%_%shot_coord_y%!==0 (
set field%shot_coord_x%_%shot_coord_y%=3
echo t3>>%enemy%.shot
)
exit /b

:check_shot
REM Variablen
set shot_coord_x=-1
set shot_coord_y=-1
set shot_type=-1
REM END
if not exist %name%.shot goto check_shot
ping -n 5 localhost >nul
(
set /p shot_coord_x=
set /p shot_coord_y=
set /p shot_type=
)<%name%.shot
set /a shot_coord_x=%shot_coord_x:~1,2%
set /a shot_coord_y=%shot_coord_y:~1,2%
if %shot_type:~1,1%==2 set field%shot_coord_x%_%shot_coord_y%=2
if %shot_type:~1,1%==3 set field%shot_coord_x%_%shot_coord_y%=3
exit /b

:draw_legend
echo Ship:      %display_ship% ^| This legend indicates
echo Water:     %display_water% ^| the symbols on the
echo Destroyed: %display_destroyed% ^| battlefield.
echo Miss:      %display_miss% ^| Good luck, solidier^^!
exit /b

:echo.
for /L %%n in (1, 1, %1) do echo.
exit /b

REM DEVELOPER SECTION

REM Û²±°
REM echo Û²±°
REM pause >nul

:debug
echo %1
pause >nul
exit /b