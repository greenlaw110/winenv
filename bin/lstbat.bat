@echo off

setlocal & pushd

:_DOIT

call lgl_set
dir %TEMP_BAT_DIR%\*.bat %*

goto _END

:_END
endlocal & popd
goto:EOF
