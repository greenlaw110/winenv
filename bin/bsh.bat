@echo off
setlocal & pushd

set _HOME=%~dp0.
set classpath=%classpath%;%_HOME%\bsh-2.0b1.jar
echo %CLASSPATH%
java bsh.Interpreter

popd
exit /b 0