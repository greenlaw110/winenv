@echo off

setlocal & pushd

:_DOIT

start notepad c:\windows\system32\drivers\etc\hosts

goto _END

:_END
endlocal & popd
goto:EOF