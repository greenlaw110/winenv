@echo off
REM GREEN BATCH UTILITY[ lgl_boot.bat ] init GREEN BATCH environments
REM VERSION 0.0.1
REM Last updated by greenlaw110@gmail.com at Feb-13-2007
REM created by greenlaw110@gmail.com at Feb-13-2007

if {%1}=={-h} goto _HELP

:_DOIT
rem set default variables if they are not set yet
call %~dp0\lgl_set.bat

REM check PATH env setting
set TMPF=%~dp0%RANDOM%.path
echo "creating temp path file:... %TMPF%"
set PATH > %TMPF%
echo "setting path..."
findstr alias %TMPF% >nul 2>nul
if errorlevel 1 (
  setx PATH %_ETC%;%_ALIAS%;%_BIN%;%TEMP_BAT_DIR%;%_IMPORT%;"%PATH%" -m
  rem set PATH=%_ETC%;%_ALIAS%;%_BIN%;%TEMP_BAT_DIR%;%_IMPORT%;"%PATH%"
)
del %TMPF%
set TMPF=

goto _END

:_HELP
echo lgl_boot.bat - set initial green command environment

:_END

goto:EOF
