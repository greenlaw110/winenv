@echo off

REM Lunch Self Drill Study Note
REM VERSION 0.0.1
REM Last updated by greenlaw110@gmail.com at Nov-1-2007
REM created by greenlaw110@gmail.com at Nov-1-2007

setlocal & pushd

if not exist %_BIN%\lgl_set.bat goto _ERR_NO_ENV 

if {%1}=={-h} goto _HELP
if {%1}=={--help} goto _HELP

:_DOIT

call lgl_set.bat

%__EXEC% start %LGL_EDITOR% %_DOC%\stdynote.txt

goto _END


:_ERR_NO_ENV
echo Error: Sorry your green batch utility environment is not well setup, possible cause:
echo - You copied a green batch file from it's package directory and use it separately
echo or
echo - The lgl_set.bat file has been removed accidentially.
goto _END 

:_HELP
echo studynote: Lunch Self Drill Study Note
echo usage: 
echo       %~nx0
goto _END

:_END
endlocal & popd
goto:EOF
