@echo off

setlocal & pushd


:_DOIT

start "C:\Program Files\MSN Messenger\msnmsgr.exe"

goto _END


:_END
endlocal & popd
goto:EOF