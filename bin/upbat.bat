@echo off

setlocal & pushd

if {%1}=={} goto _HELP

:_DOIT

call lgl_set.bat
move %TEMP_BAT_DIR%\%1.bat %BAT_DIR%

goto _END

:_HELP
echo upgrade a batch from temporary folder to permanent folder
echo usage: 
echo       %~nx0 batch-filename

:_END
endlocal & popd
goto:EOF

