@echo off

setlocal & pushd

if {%2}=={} goto _HELP

:_DOIT

call lgl_set

set _host=%1

D:\apps\putty\plink -ssh -i %KEY_STORE%\%_host%.ppk %RMT_USER%@%_host% %2 %3 %4 %5 %6 %7 %8 %9

goto _END

:_HELP
echo usage: 
echo       %~nx0 ^<host-name^> ^<remote-command^>

:_END
endlocal & popd
goto:EOF
