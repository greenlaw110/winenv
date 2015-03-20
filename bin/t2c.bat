@echo off

setlocal & pushd

if {%1}=={} goto _HELP

:_DOIT
call lgl_set
copy %TEMP_BAT_DIR%\%1.bat %BAT_DIR%\%1.bat
del %TEMP_BAT_DIR%\%1.bat

goto _END

:_HELP
echo usage: 
echo       %~nx0 ^<temp-batch-name^>

:_END
endlocal & popd
