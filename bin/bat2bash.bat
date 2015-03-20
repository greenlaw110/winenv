@echo off

setlocal & pushd

if {%1}=={} goto _HELP
if {%2}=={} goto _HELP

:_DOIT

echo #!/bin/sh > %2\%1
echo cmd /c %1.bat $* >> %2\%1
cd %2
chmod 777 %1

goto _END

:_HELP
echo usage: 
echo       %~nx0 ^<batch-file-name^> ^<bash-file-path^>

:_END
endlocal & popd