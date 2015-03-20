@echo off

setlocal & pushd

:_DOIT

call lgl_set.bat

start D:\apps\Skype\Phone\skype.exe

goto _END

:_HELP
echo usage: 
echo       %~nx0 <I>

:_END
endlocal & popd
goto:EOF
