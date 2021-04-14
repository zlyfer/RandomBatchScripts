@echo off
setlocal EnableDelayedExpansion
title Graphical Column
set freak_=0
:re1
set /P width1=Width: 
if %width1% LSS 20 (
cls
echo Width must be at least 20.
goto re1
)
if %width1% GTR 230 (
cls
echo Width must be 230 or below.
goto re1
)
:re2
set /P freak=Freakmode: 
if %freak% LSS 0 (
cls
echo Freakmode must be at least 0.
goto re2
)
if %freak% GTR 25 (
cls
echo Freakmode must be 25 or below.
goto re2
)
if %freak%==0 set freak_=1 & set freak=1
mode con cols=%width1% lines=80
set /A width2=%width1%-5
set mm=0
set cm=0
set m=0
set km=0
call :initializing
call :algorythm1
:loop1
set /A percent1=%width2%*10
set /A percent2=(%place%*1000)/%percent1%
set /A mm=%mm%+1
if %mm%==10 (
set mm=0
set /A cm=%cm%+1
)
if %cm%==100 (
set cm=0
set /A m=%m%+1
)
if %m%==1000 (
set m=0
set /A km=%km%+1
)
if %percent2% GTR 9 title Graphical Column - 0%percent2:~0,1%0%% - %km%km, %m%m, %cm%cm, %mm%mm.
if %percent2% LSS 10 title Graphical Column - 00%percent2:~0,1%%% - %km%km, %m%m, %cm%cm, %mm%mm.
if %percent2%==100 title Graphical Column - 100%% - %km%km, %m%m, %cm%cm, %mm%mm.
call :algorythm2
:color
set color=%random:~0,2%
if %color% LSS 10 goto color
if %color% GTR 24 goto color
if %color%==10 set color=A
if %color%==11 set color=B
if %color%==12 set color=C
if %color%==13 set color=D
if %color%==14 set color=E
if %color%==15 set color=0
if %color%==16 set color=1
if %color%==17 set color=2
if %color%==18 set color=3
if %color%==19 set color=4
if %color%==20 set color=5
if %color%==21 set color=6
if %color%==22 set color=7
if %color%==23 set color=8
if %color%==24 set color=9
color %color%
if %freak_%==1 (
:re3
set freak=%random:~0,2%
if %freak% GTR 25 goto re3
)
if %freak%==1 echo !line%place%!##
if %freak%==2 echo !line%place%!##!line%place%!##
if %freak%==3 echo !line%place%!##!line%place%!##!line%place%!##
if %freak%==4 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==5 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==6 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==7 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==8 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==9 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==10 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==11 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==12 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==13 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==14 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==15 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==16 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==17 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==18 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==19 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==20 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==21 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==22 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==23 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==24 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
if %freak%==25 echo !line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##!line%place%!##
goto loop1
:initializing
echo init..
set space= 
set numline=0
set line%numline%=%space%
:loop2
set line%numline%=%preline%%space%
set preline=!line%numline%!
set /A numline=%numline%+1
if %numline%==%width1% (
cls
exit /B
)
goto loop2
:algorythm1
if %width2% LSS 100 set place=%random%%random%
if %width2% LSS 100 set place=%place:~0,2%
if %width2% GTR 99 set place=%random%%random%%random%
if %width2% GTR 99 set place=%place:~0,3%
if %place% GTR %width2% goto algorythm1
:algorythm2
set move1=%random:~0,1%
if %move1%==1 exit /B
if %place% LSS %width2% (
if %move1%==2 (
set /A place=%place%+1
exit /B
)
)
if %place% GTR 0 (
if not %move1%==2 (
set /A place=%place%-1
exit /B
)
)
goto algorythm2