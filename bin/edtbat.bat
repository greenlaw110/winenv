@echo off

setlocal & pushd

call lgl_set

if {%1}=={} goto _HELP

:_DOIT

set __BATDIR__=%BAT_DIR%
call _edtbat %*

goto _END

:_HELP
echo usage: 
echo       %~nx0 ^<name^>

:_END
endlocal & popd
