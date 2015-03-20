@echo off

setlocal & pushd

call lgl_set
if {%__BATDIR__%}=={} goto _E_INVALID_ENV

:_DOIT
if not exist %__BATDIR__%\%1.bat goto _E_NOFILE

start %LGL_EDITOR% %__BATDIR__%\%1.bat

goto _END

:_E_NOFILE
echo Error: %__BATDIR__%\%1.bat does not exist.
exit /b 1

:_E_INVALID_ENV
echo %~nx0 shall not be called explictly!
exit /b 1

:_END
endlocal & popd
