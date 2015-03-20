@echo off

setlocal & pushd

:_DOIT

call lgl_set.bat

call refreshres -l

goto _END

:_END
endlocal & popd
goto:EOF
