@echo off

setlocal & pushd

:_DOIT

call lgl_set.bat

start D:\apps\mozilla\firefox\firefox.exe %*

goto _END

:_END
endlocal & popd
goto:EOF
