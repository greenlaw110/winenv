@echo off

setlocal & pushd

if {%1}=={} goto _HELP

:_DOIT

dot -Tgif -ot.gif %1
start t.gif

goto _END

:_HELP
echo usage: 
echo       %~nx0 ^<path-to-dot-file^>

:_END
endlocal & popd
goto:EOF