@echo off

setlocal & pushd

if {%1}=={-h} goto _HELP

:_DOIT

call lgl_set.bat

start %_DATA%\my_schedule.or5

goto _END

:_HELP
echo usage: 
echo       %~nx0 ^<I^>

:_END
endlocal & popd
goto:EOF
