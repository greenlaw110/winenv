@echo off

setlocal & pushd

:_DOIT

call lgl_set.bat

echo 823269426

goto _END

:_END
endlocal & popd
goto:EOF
