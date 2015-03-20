@echo off

setlocal & pushd

call lgl_set

if {%1}=={} goto _HELP

:_DOIT

%LGL_VIEWER% %_ALIAS%\%1.bat

goto _END

:_HELP
echo usage: 
echo       %~nx0 ^<name^>

:_END
endlocal & popd
