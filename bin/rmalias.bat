@echo off

REM GREEN BATCH FILE: remove an alias file
REM VERSION 0.0.1
REM Last updated by greenlaw110@gmail.com at Oct-31-2007
REM created by greenlaw110@gmail.com at Oct-31-2007

setlocal & pushd

set _HOME=%~dp0.

if {%1}=={-h} goto _HELP
if {%1}=={--help} goto _HELP
if {%1}=={} goto _HELP

if not exist %_ALIAS% goto _ERR_NO_ALIAS

set _TGT=%_ALIAS%\%1.bat
if not exist %_TGT% goto _ERR_NO_ALIAS_FILE

:_DOIT

call lgl_set.bat
if not errorlevel 0 goto _ERR_NO_ENV

echo %_TGT%
del %_TGT%

echo alias[%1] successfully removed

goto _END

:_ERR_NO_ENV
echo Error: Sorry your green batch utility environment is not well setup, possible cause:
echo - You copied a green batch file from it's package directory and use it separately
echo or
echo - The lgl_set.bat file has been removed accidentially.
goto _END 

:_ERR_NO_ALIAS
echo Error: No Alias directory found, please check your ^%_ALIAS^% environment
goto _END

:_ERR_NO_ALIAS_FILE
echo Error: The target alias batch file not exists
goto _END

:_HELP
echo rmalias: remove an alias file
echo usage: 
echo       %~nx0 exist-alias
goto _END

:_END
endlocal & popd
goto:EOF
