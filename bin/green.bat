@echo off

REM Go straght to Green home
REM VERSION 0.0.1
REM Last updated by greenlaw110@gmail.com at Oct-31-2007
REM created by greenlaw110@gmail.com at Oct-31-2007

setlocal & pushd

if {%1}=={-h} goto _HELP
if {%1}=={--help} goto _HELP

if exist %~dp0.\lgl_set.bat (
	set _SET_=%~dp0.\lgl_set.bat
	goto _DOIT
)

if exist %_ETC%\lgl_set.bat (
	set _SET_=%_ETC%\lgl_set.bat
	goto _DOIT
)

set _SET_=lgl_set.bat

:_DOIT
call %_SET_%
if %errorlevel% GTR 0 goto _ERR_NO_ENV

if {%1}=={} (
  set _GOTO=cmd /k cd
  set _EXIT=exit
  goto _DOIT_2
)

set _GOTO=start explorer /e, /root,
set _SUBFOLDER=%1
if {%1}=={-e} (
  set _SUBFOLDER=%2
)

:_DOIT_2
%__EXEC% %_GOTO% "%__LGL%\%_SUBFOLDER%" 
%__EXEC% %_EXIT%

goto _END


:_ERR_NO_ENV
echo Sorry your green batch utility environment is not well setup, possible cause:
echo - You copied a green batch file from it's package directory and use it separately
echo or
echo - The lgl_set.bat file has been removed accidentially.
goto _END 

:_HELP
echo Go straight to Green home
echo usage: 
echo       %~nx0 ^<-e^>
echo       -e start Windows Explorer with Green home as the root folder
goto _END

:_END
endlocal & popd
goto:EOF
