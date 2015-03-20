@echo off

setlocal & pushd

set _CMD=%~n0

rem %1: path-to-file
rem %2: group-id
rem %3: artifact-id
rem %4: version

if {%1}=={} goto _HELP
if {%2}=={} goto _HELP
if {%3}=={} goto _HELP
if {%4}=={} goto _HELP

mvn -o install:install-file -Dfile=%1 -DgroupId=%2 -DartifactId=%3 -Dversion=%4 -Dpackaging=jar

:_HELP
echo usage: %~n0 ^<path-to-file^> ^<group-id^> ^<artifact-id^> ^<version^>

:_END
endlocal & popd