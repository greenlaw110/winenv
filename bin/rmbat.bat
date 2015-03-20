@echo off

setlocal & pushd

if {%1}=={} goto _HELP

:_DOIT

call lgl_set

del %BAT_DIR%\%1.bat
if errorlevel 0 echo %1.bat has been removed

goto _END

:_HELP
echo Remove a constant bat utility usage: 
echo       %~nx0 ^<bat-file-name^>

:_END
endlocal & popd
goto:EOF