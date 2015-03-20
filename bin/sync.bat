@echo off

setlocal & pushd

:_DOIT

start D:\apps\SyncToy\SyncToy.exe -R

goto _END

:_END
endlocal & popd
goto:EOF
