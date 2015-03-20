@echo off

REM GREEN BATCH FILE TEMPLATE <you can replace this line with new bat desc>
REM VERSION 0.0.2.1
REM Last updated by greenlaw110@gmail.com at Nov-5-2007
REM created by greenlaw110@gmail.com at some time 2006

setlocal & pushd

if {%1}=={-h} goto _HELP
if {%1}=={--help} goto _HELP

if {%1}=={} goto _HELP
if {%1}=={-v} (
	if {%2}=={} goto _HELP
	set _CMD=%LGL_VIEWER%
	set _F="%2"
	if not {%3}=={} set _G=%3
) else (
	set _CMD=%LGL_EDITOR%
	set _F=%1
)

if not exist %_F% (
	echo supplied file "%2" not exists
	goto _END
)

:_FILEFOUND
set _SET_=lgl_set.bat

:_DOIT
call %_SET_%
if %errorlevel% GTR 0 goto _ERR_NO_ENV

if {%_G%}=={} (
	%__EXEC% %_CMD% %_F%
) else (
	%__EXEC% %_CMD% %_F% | grep %_G%
)

goto _END


:_ERR_NO_ENV
echo Error: Sorry your green batch utility environment is not well setup, possible cause:
echo - You copied a green batch file from it's package directory and use it separately
echo or
echo - The lgl_set.bat file has been removed accidentially.
goto _END 

:_HELP
echo Edit or view file
echo usage: 
echo       %~nx0 ^<-v^> file
echo if -v option, then view the file, otherwise edit the file
goto _END

:_END
endlocal & popd
goto:EOF
