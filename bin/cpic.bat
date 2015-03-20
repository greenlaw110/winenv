@echo off

setlocal & pushd

if {%1}=={-h} goto _HELP

:_DOIT

call lgl_set.bat

start rundll32.exe C:\WINDOWS\System32\shimgvw.dll,ImageView_Fullscreen %*

goto _END

:_HELP
echo usage: 
echo       %~nx0 ^<filename^>

:_END
endlocal & popd
goto:EOF
