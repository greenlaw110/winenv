@echo off

setlocal & pushd

if {%1}=={} goto _HELP

:_DOIT

call lgl_set

set _X_EXEC=REM
if {%2}=={-x} (
	set _X_EXEC=
) 

rem switch tor resource
if {%1}=={-h} (
	rem copy "%APPDATA%\Tor\torrc.home" "%APPDATA%\Tor\torrc"
	rem copy D:\data\firefox\foxyproxy.h.xml D:\data\firefox\foxyproxy.xml
	rem %_X_EXEC% stopcc
	rem net use /d s: 
	copy %__LGL%\wgetrc_h.txt %__LGL%\.wgetrc
	goto _END
)
if {%1}=={-c} (
	rem copy "%APPDATA%\Tor\torrc.corp" "%APPDATA%\Tor\torrc"
	rem copy D:\data\firefox\foxyproxy.c.xml D:\data\firefox\foxyproxy.xml
	rem %_X_EXEC% startcc
	rem net use s: \\nsn-intra.net\DFS
  copy %__LGL%\wgetrc_c.txt %__LGL%\.wgetrc
	goto _END
)

goto _HELP

:_HELP
echo Switch working environment between corporation and home
echo usage: 
echo       %~nx0 -h	switch to home
echo       %~nx0 -c	switch to corporation

:_END
endlocal & popd
goto:EOF
