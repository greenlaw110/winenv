@echo off

REM GREEN BATCH FILE: create an alias for an existing batch file
REM VERSION 0.0.1
REM Last updated by greenlaw110@gmail.com at Oct-31-2007
REM created by greenlaw110@gmail.com at Oct-31-2007

setlocal & pushd

set _HOME=%~dp0.

if {%1}=={-h} goto _HELP
if {%1}=={--help} goto _HELP
if {%2}=={} goto _HELP

if not exist %_ALIAS% goto _ERR_NO_ALIAS

set _SRC=%_BIN%\%2.bat
REM if no batch file exists for the alias, then try to call in PATH
if not exist %_SRC% (
  set _CALL=start
  set _TITLE="alias - %2"
  set _SRC=%2
) else (
  set _CALL=call
  set _TITLE=
  set _SRC=%2.bat
)

set _TGT=%_ALIAS%\%1.bat
if exist %_TGT% goto _ERR_TARGET_EXIST

:_DOIT

call lgl_set.bat
if NOT ERRORLEVEL 0 goto _ERR_NO_ENV

set _P=%%
set _S=*

set _PARAM=%3 %4 %5 %6 %7 %8 %9
%__LOG% %_PARAM%

echo @echo off > %_TGT%
echo %_CALL% %_TITLE% "%_SRC%" %_PARAM% %_P%%_S% >> %_TGT%
echo Alias [%_TGT%] for [%_SRC%] has been created successfully.

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

:_ERR_NO_SOURCE
echo Error: No source batch file found: %1
goto _END

:_ERR_TARGET_EXIST
echo Error: The target alias batch file already exists
goto _END

:_HELP
echo alias: create an alias for an existing batch file
echo.
echo usage: 
echo       %~nx0 new-alias exist-batch [parm1 param2...] 
echo.
echo Existing aliases:
dir %_ALIAS%\*.bat | sed '1,5d' | rvrtline | sed '1,2d' | sed 's/  */\t/g' |cut -f 5 | cut -d . -f 1

rem dir %_ALIAS%\*.bat | grep -v 'bat~' | sed '1,5d' | rvrtline | sed '1,2d' | awk '{print $4}' | cut -d . -f 1

rem dir %_ALIAS%\*.bat | grep -v "bat~"

goto _END

:_END
endlocal & popd
goto:EOF
