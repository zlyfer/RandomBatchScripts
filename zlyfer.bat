@echo off
REM zlyfer - by Frederik Shull!:
REM Note: This code includes parts from Unknown!
REM Note: This batch-file is badly written and useless! :D
REM Version 0.6
REM Bug-report, feature ideas, self-made plugins and update-requests to frederik.shull@web.de.
REM Note: I recommend to use Windows XP SP3 32bit for zlyfer.
REM [HIDDEN] You'll not see this line with the source-code viewer. xD
REM END
REM Misc:
setlocal enabledelayedexpansion
if not %0==zlyfer goto ws
set ltmp=0
set mandebug=0
set manerrs=0
set mancont=0
md %userprofile%\zlyfer 2>nul
move /Y %userprofile%\zlyfer\zly_config.dat %userprofile%\zlyfer\zly_config.bat >nul 2>nul
call %userprofile%\zlyfer\zly_config.bat 2>nul
move /Y %userprofile%\zlyfer\zly_config.bat %userprofile%\zlyfer\zly_config.dat >nul 2>nul
set ver=0.6
set lran=%random:~0,4%
set od=%CD%
cd /D %userprofile%\
set /A size=0
set /A files=0
set /A folders=0
set ext=0
set lle=0
set llc=0
set dvlt=0
set var1=%1
cls
REM END
REM Headers:
echo zlyfer v%ver% (04.15), copyright by Frederik Shull.
type zlyfer.bat|find "[CON]"|find /V "type zlyfer.bat">zlyfer\tmp.dat 2>nul
for /F %%i in ('type zlyfer\tmp.dat') do set /A mancont=mancont+1
type zlyfer.bat|find "[BUG]"|find /V "type zlyfer.bat">zlyfer\tmp.dat 2>nul
for /F %%i in ('type zlyfer\tmp.dat') do set /A manerrs=manerrs+1
if not %mancont%==0 echo ManCon: %mancont%
if not %manerrs%==0 echo ManBug: %manerrs%
del zlyfer\tmp.dat >nul 2>nul
REM END
cd /D %od%\
REM Parameters sys:
if /I -%1-==-- goto parameters
if /I -%1-==-/?- goto parameters
if /I -%1-==-?- goto parameters
echo %*|find /I "/X">nul 2>&1 && set ext=1
echo %*|find /I "/T">nul 2>&1 && set ltmp=1
echo %*|find /I "/L">nul 2>&1 && goto lister
echo %*|find /I "/S">nul 2>&1 && goto dellists
echo %*|find /I "/C">nul 2>&1 && goto checker
echo %*|find /I "/E">nul 2>&1 && goto source
echo %*|find /I "/F">nul 2>&1 && goto leftlists
REM END
REM Parameters print:
echo Unknown parameter/s "%*".
:parameters
echo.
echo ZLYFER             [/E] [/F]
echo [+] FOLDER         [/L] [/T] [/X] [/N]
echo [+] IP/DOMAIN      [/C]
echo Syntax: [ZLYFER ["PATH\"] [IP] [WWW.DOMAINNAME.DOMAIN] [.EXTENSION] /PRAMETERS]
echo.
echo /E       Shows the source-code of zlyfer.
echo /F       Lists all zlylists on this computer.
echo /L       Creates and shows a list of all files and folders in PATH.
echo /T       Only creates a temporary list.
echo /X       Only creates a list of a specific extension.
echo /N       
echo /C       Checks connection to IP/DOMAIN.
exit /B
REM END
REM FileLister (As plugin for zlyfer) - by Frederik Shull:
REM Version 3.4
:lister
echo.
cd /D %1\ 2>nul
if not exist %1 echo The folder %1 does not exist. & exit /B
set lran=%random:~0,1%%random:~0,1%%random:~0,1%%random:~0,1%%random:~0,1%
if exist zlylist.zlylist%lran% goto lister
set s0=%time%
set /A s1=%s0:~0,2% 2>nul
set /A s2=%s0:~3,2% 2>nul
set /A s3=%s0:~6,2% 2>nul
set /A s4=%s0:~9,2% 2>nul
echo Please wait, receiving information...
if %ltmp%==1 echo WARNING. THIS FILE DOES NOT EXIST ANYMORE. SAVE NOW TO KEEP THE LIST.>>zlylist.zlylist%lran% & echo.>>zlylist.zlylist%lran%
if %ext%==0 echo Following list contains all files, folders and subfolders in %1:>>zlylist.zlylist%lran%
if %ext%==1 echo Following list contains all %2-files in all folders and subfolders in %1:>>zlylist.zlylist%lran%
if %ext%==0 for /F %%i in ('dir /B /OE /S /A-D') do set /A files=files+1
if %ext%==0 for /F %%i in ('dir /B /OE /S /AD') do set /A folders=folders+1
if %ext%==0 echo Total amount of files/folders: %files%/%folders%.>>zlylist.zlylist%lran%
if %ext%==1 for /F %%i in ('dir *%2 /B /OE /S /A-d') do set /A files=files+1
if %ext%==1 echo Total amount of %2-files: %files%.>>zlylist.zlylist%lran%
echo.>>zlylist.zlylist%lran%
echo -Filelist start->>zlylist.zlylist%lran%
echo.>>zlylist.zlylist%lran%
if %ext%==2 dir %3%2  /B /OE /S /X>>zlylist.zlylist%lran%
if %ext%==1 dir *%2  /B /OE /S /X>>zlylist.zlylist%lran%
if %ext%==0 dir *.* /B /OE /S /X>>zlylist.zlylist%lran%
echo.>>zlylist.zlylist%lran%
echo -Filelist end->>zlylist.zlylist%lran%
echo.>>zlylist.zlylist%lran%
for /f "tokens=1-3" %%i in ('dir zlylist.zlylist%lran% /-C /S ^|find "Datei(en)" ^|find "Bytes"') do set size=%%k
if %size% GEQ 1000000 (
set /A size=%size%/1000000
set scale=MB
goto CS1
)
set /A size=%size%/1000
set scale=KB
:CS1
if %size%==0 set size=Less than 1
if %ltmp%==0 echo Size of listfile (this window): %size%%scale%.>>zlylist.zlylist%lran%
if %ltmp%==1 echo Size of tempfile (this window): %size%%scale%.>>zlylist.zlylist%lran%
echo zlyfer v%ver%, copyright by Frederik Shull. All rights reserved.>>zlylist.zlylist%lran%
start /MAX notepad.exe zlylist.zlylist%lran%
set e0=%time%
set /A e1=%e0:~0,2% 2>nul
set /A e2=%e0:~3,2% 2>nul
set /A e3=%e0:~6,2% 2>nul
set /A e4=%e0:~9,2% 2>nul
set /A d1=%e1%-%s1% 2>nul
set /A d2=%e2%-%s2% 2>nul
set /A d3=%e3%-%s3% 2>nul
set /A d4=%e4%-%s4% 2>nul
if %d4% LSS 0 set /A d3=%d3%-1 & set /A d4=100+%d4% 2>nul
if %d3% LSS 0 set /A d2=%d2%-1 & set /A d3=60+%d3% 2>nul
if %d2% LSS 0 set /A d1=%d1%-1 & set /A d2=60+%d3% 2>nul
if %d1% LSS 0 set /A d1=24-%e1% 2>nul
if %d4% LSS 10 set d4=0%d4% 2>nul
if %d3% LSS 10 set d3=0%d3% 2>nul
if %d2% LSS 10 set d2=0%d2% 2>nul
if %d1% LSS 10 set d1=0%d1% 2>nul
set ldiff=%d1:~0,2%:%d2:~0,2%,%d3:~0,2%.%d4:~0,2%.
if %ltmp%==0 echo List where saved to: "%var1:~1,-1%zlylist.zlylist%lran%".
if %ltmp%==1 echo WARNING - List does not exist, save text manually to keep it. & ping -n 3 localhost >nul & del %CD%\zlylist.zlylist%lran% 2>nul
echo Progresstime: %ldiff%
exit /B
REM END
REM ListFinder (As addon for FileLister) - by Frederik Shull:
REM Version 1.1
:leftlists
echo.
cd C:\
echo Searching for zlylists..
echo.
dir zlylist.* /B /OE /S /X 2>nul
if %errorlevel%==1 (
echo No lists found.
echo.
echo Lists left: 0.
set lle=1
)
if %lle%==0 echo.
if %lle%==0 for /F %%i in ('dir zlylist.* /B /OE /S /A-d') do set /A llc=llc+1
if %lle%==0 echo Lists left: %llc%.
exit /B
REM END
REM END
REM OnlineCheck (As plugin for zlyfer) - by Frederik Shull:
REM Version 1.8
:checker
echo.
echo Please wait, trying to connect to "%~1"..
ping -n 1 %~1 -w 2000 >nul
if %errorlevel%==1 echo Failed to connect to "%~1". (offline) & exit /B
echo Succesfully connected to "%~1". (online)
exit /B
REM END
REM WrongStart (As plugin for zlyfer) - by Frederik Shull:
REM Version 1.3
:ws
mode con cols=120 lines=60
color 0A
cls
echo zlyfer, copyright by Frederik Shull.
echo.
title zlyfer - Wrong start
echo WRONG START - TROUBLESHOOTING
echo =============================
echo.
echo Hello %username%, you did something wrong, please read this:
echo.
echo zlyfer is not a stand-alone script, you need to start zlyfer via cmd.
echo Start CMD and execute following command:
echo.
echo XCOPY /Y "%CD%\zlyfer.bat" "%windir%\System32"
echo.
echo Then execute the command ZLYFER in cmd.
echo [NOTE] If this doesn't work use following command:
echo.
echo XCOPY /Y "%CD%\zlyfer.bat" "%userprofile%"
echo.
echo [NOTE] Rightclick - mark and press enter to copy.
echo [NOTE] You may need to run CMD.exe as administrator.
echo [NOTE] DO NOT RENAME zlyfer.bat.
echo.
echo Or press any key to execute XCOPY automatically...
echo [NOTE] This may not work.
pause >nul
echo.
echo Choose the directory you want zlyfer.bat to be copied to:
echo.
echo [1] %windir%\system32
echo [2] %userprofile%
echo [3] Both
:tsre1
set tsdir=0
set tsvar1=0
set /P tsdir=Directory: 
if %tsdir%==0 goto tsre1
if %tsdir%==1 echo. & goto tsdir1
if %tsdir%==2 echo. & goto tsdir2
if %tsdir%==3 echo. & set tsvar1=1 & goto tsdir1
goto tsre1
:tsdir1
echo Trying to copy "%CD%\zlyfer.bat" to "%windir%\System32".
if exist "%windir%\System32\zlyfer.bat" (
echo [ERROR] "%windir%\System32\zlyfer.bat" does already exist, delete before retrying.
echo.
echo Press any key to delete and retry automatically...
echo [NOTE] This may not work.
pause >nul
echo.
del "%windir%\System32\zlyfer.bat" >nul 2>nul
if %errorlevel%==1 goto wse2
echo Deleted successfully.
)
XCOPY /Y "%CD%\zlyfer.bat" "%windir%\System32" >nul 2>nul
if %errorlevel%==1 goto wse2
echo Copied successfully.
echo.
if %tsvar1%==0 echo Run CMD and execute the command ZLYFER.
if %tsvar1%==0 goto wssk
:tsdir2
echo Trying to copy "%CD%\zlyfer.bat" to "%userprofile%".
if exist "%userprofile%\zlyfer.bat" (
echo [ERROR] "%userprofile%\zlyfer.bat" does already exist, delete before retrying.
echo.
echo Press any key to delete and retry automatically...
echo [NOTE] This may not work.
pause >nul
echo.
del "%userprofile%\zlyfer.bat" >nul 2>nul
if %errorlevel%==1 goto wse2
echo Deleted successfully.
)
XCOPY /Y "%CD%\zlyfer.bat" "%userprofile%" >nul 2>nul
if %errorlevel%==1 goto wse2
echo Copied successfully.
echo.
echo Run CMD and execute the command ZLYFER.
goto wssk
:wse2
echo [ERROR] A unknown error appeard because of one of the following conflicts:
echo.
echo [1] No rights or not enough rights for CMD.
echo [How to solve] Run CMD as Administrator.
echo.
echo [2] Your version of Windows may not support this kind of the XCOPY-Command.
echo [How to solve] Copy manually: 
echo "%CD%\zlyfer.bat" to "%windir%\System32"
echo [NOTE] If this doesn't work, copy manually as below:
echo "%CD%\zlyfer.bat" to "%userprofile%"
echo.
echo [3] Your version of Windows may not support this kind of the DEL-Command.
echo [How to solve] Delete manually: 
echo "%windir%\System32\zlyfer.bat"
echo [NOTE] If this doesn't work, delete manually as below:
echo "%userprofile%\zlyfer.bat"
echo.
echo For more informations or troubleshooting send me an E-Mail: frederik.shull@web.de
:wssk
echo.
echo Press any key to exit...
pause >nul
exit
REM END
REM SourceCodeViewer (As plugin for zlyfer) - by Frederik Shull:
REM Version 1.0
:source
echo.
echo You are now seeing the source-code of zlyfer.bat...
echo Source Code: zlyfer.bat> zlyfer.txt & echo.>> zlyfer.txt & type zlyfer.bat|find /V "[HIDDEN]">> zlyfer.txt & start zlyfer.txt & goto [HIDDEN]
echo Source Code: zlyfer.bat> zlyfer.txt & echo.>> zlyfer.txt & type zlyfer.bat>> zlyfer.txt & start zlyfer.txt
:[HIDDEN]
exit /B
REM END
REM ZlyReset (As plugin for zlyfer) - by Frederik Shull:
REM Version 1.2
:reset
echo.
echo [RESET] Press any key to continue...
echo.
pause >nul
echo Deleting lists...
move /Y %userprofile%\zlyfer\sys0.dat %userprofile%\zlyfer\sys0.bat >nul 2>nul
call %userprofile%\zlyfer\sys0.bat >nul 2>nul
ping -n 3 localhost >nul
echo Removing zlyfer directory...
rd /S /Q %userprofile%\zlyfer >nul 2>nul
echo Done.
echo You may delete zlyfer.bat manually now.
echo You may use 'zlyfer /F' to find unlisted zlylists and delete them manually.
exit /B
REM END
exit /B
REM END