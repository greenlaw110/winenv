@echo off

setlocal & pushd

if {%1}=={} goto _HELP

:_DOIT

call lgl_set.bat
if not exist %~dp0\%1.bat goto _E_NOFILE

%LGL_VIEWER% %~dp0\%1.bat

goto _END

:_E_NOFILE
echo Error: %~dp0\%1.bat does not exists.
exit /b 1

:_HELP
echo usage: 
echo       %~nx0 ^<name^>

:_END
endlocal & popd
