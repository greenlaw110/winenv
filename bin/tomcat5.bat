@echo off

setlocal & pushd

# set JPDA_TRANSPORT=dt_socket
# set JPDA_ADDRESS=8000

call %CATALINA_HOME%\bin\catalina.bat start

endlocal & popd
