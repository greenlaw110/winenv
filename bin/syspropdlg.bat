@echo off

setlocal & pushd

:_DOIT

start sysdm.cpl

goto _END

:_END
endlocal & popd