@echo off

setlocal & pushd

if {%2}=={} goto _HELP

:_DOIT

t:
cd t:\lgl\bin
copy %1.bat %2.bat
call edttbat %2

goto _END

:_HELP
echo usage: 
echo       %~nx0 ^<from^> ^<to^>

:_END
endlocal & popd