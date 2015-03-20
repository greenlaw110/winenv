@echo off

setlocal & pushd

if {%1}=={} goto _HELP

call lgl_set

:_DOIT

C:\tools\PSFTP.EXE -l %RMT_USER% -i %KEY_STORE%\cd18.ppk %1

goto _END

:_HELP
echo usage: 
echo       %~nx0 hostname

:_END
endlocal & popd
