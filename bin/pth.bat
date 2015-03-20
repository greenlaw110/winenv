@echo off

setlocal & pushd

if {%1}=={} goto _HELP

call lgl_set

:_DOIT

start c:\tools\PUTTY.EXE -i %KEY_STORE%\luog.ppk %*

goto _END

:_HELP
echo usage: 
echo       %~nx0 hostname

:_END
endlocal & popd
