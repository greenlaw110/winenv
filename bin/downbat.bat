@echo off

setlocal & pushd

if {%1}=={} goto _HELP

:_DOIT

call lgl_set.bat
move %BAT_DIR%\%1.bat %TEMP_BAT_DIR%

goto _END

:_HELP
echo downgrade a batch from permanent folder to  temporary folder
echo usage: 
echo       %~nx0 batch-filename

:_END
endlocal & popd
goto:EOF

