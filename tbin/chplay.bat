@echo off

REM GREEN BATCH FILE TEMPLATE <you can replace this line with new bat desc>
REM VERSION 0.0.2.1
REM Last updated by greenlaw110@gmail.com at Nov-5-2007
REM created by greenlaw110@gmail.com at some time 2006

setlocal & pushd

if {%1}=={} goto _HELP
if {%1}=={-h} goto _HELP
if {%1}=={--help} goto _HELP

set _PLAY=play-%1

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

j:
cd \
rmdir play
mklink /d play %_PLAY%

goto _END


:_ERR_NO_ENV
echo Error: Sorry your green batch utility environment is not well setup, possible cause:
echo - You copied a green batch file from it's package directory and use it separately
echo or
echo - The lgl_set.bat file has been removed accidentially.
goto _END 

:_HELP
echo switch play version
echo usage: 
echo       %~nx0 ^<play-version^>
echo current play versions:
dir d:\jc\play*
goto _END

:_END
endlocal & popd
goto:EOF
