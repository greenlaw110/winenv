@echo off

setlocal & pushd
call LGL_SET

if {%2}=={} goto _HELP

:_DOIT

copy %BAT_DIR%\%1.bat %BAT_DIR%\%2.bat
call edtbat %2

goto _END

:_HELP
echo usage: 
echo       %~nx0 ^<from^> ^<to^>

:_END
endlocal & popd
