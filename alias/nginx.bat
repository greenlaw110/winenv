@echo off 
setlocal & pushd
cd c:\apps\nginx-1.2.3
"c:\apps\nginx-1.2.3\nginx.exe"        %* 
endlocal & popd
