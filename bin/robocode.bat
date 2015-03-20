@echo off

setlocal & pushd

:_DOIT

call lgl_set.bat

d:
cd \robocode

call robocode.bat

goto _END

:_END
endlocal & popd
Exit
goto:EOF
