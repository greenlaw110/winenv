@echo off

REM GREEN BATCH UTILITY[ newbat.bat ] create an new batch 
REM       with predefined tempate
REM VERSION 0.0.2
REM Last updated by greenlaw110@gmail.com at Nov-12-2007
REM created by greenlaw110@gmail.com at some time 2006

setlocal & pushd

if {%1}=={} goto _HELP
if {%1}=={-h} goto _HELP
if {%1}=={--help} goto _HELP

if exist %~dp0.\lgl_set.bat (
	set _SET_=%~dp0.\lgl_set.bat
	goto _DOIT
)

if exist %_BIN%\lgl_set.bat (
	set _SET_=%_BIN%\lgl_set.bat
	goto _DOIT
)

set _SET_=lgl_set.bat

:_DOIT
call %_SET_%
if %errorlevel% GTR 0 goto _ERR_NO_ENV

%__EXEC% copy %BATCH_TEMPLATE% %_BIN%\%1.bat
%__EXEC% start %LGL_EDITOR% %_BIN%\%1.bat

goto _END


:_ERR_NO_ENV
echo Error: Sorry your green batch utility environment is not well setup, possible cause:
echo - You copied a green batch file from it's package directory and use it separately
echo or
echo - The lgl_set.bat file has been removed accidentially.
goto _END 

:_HELP
echo create new bat file in bin folder
echo usage: 
echo       %~nx0 ^<bat_name^>
goto _END

:_END
endlocal & popd
goto:EOF
