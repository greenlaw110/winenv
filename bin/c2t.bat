@echo off

setlocal & pushd

set _HOME=%~dp0.
if not exist %_HOME%\lgl_set.bat goto _ERR_NO_ENV 

if {%1}=={} goto _HELP

:_DOIT


call lgl_set
copy %BAT_DIR%\%1.bat %TEMP_BAT_DIR%\%1.bat 
del %BAT_DIR%\%1.bat 

goto _END

:_ERR_NO_ENV
echo Sorry your green batch utility environment is not well setup, possible cause:
echo - You copied a green batch file from it's package directory and use it separately
echo or
echo - The lgl_set.bat file has been removed accidentially.
goto _END 

:_HELP
echo This tool move a constant batch file to temporary batch folder
echo usage: 
echo       %~nx0 ^<temp-batch-name^>
goto _END

:_END
endlocal & popd


