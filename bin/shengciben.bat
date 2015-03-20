@echo off

setlocal & pushd

if {%1}=={-h} goto _HELP

:_DOIT

call lgl_set.bat

call "C:\Program Files\Kingsoft\Powerword 2003\NewWord.exe"

goto _END

:_HELP
echo 金山生词本，usage: 
echo       %~nx0 

:_END
endlocal & popd
goto:EOF
