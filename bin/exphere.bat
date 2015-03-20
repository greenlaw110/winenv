@echo off

setlocal & pushd

call lgl_set.bat

if {%1}=={} (
	cd > %temp%\curdir
	for /f "tokens=*" %%i in (%temp%\curdir) do set _PWD=%%i
) else (
	set _PWD=%*
)

%__LOG% "%_PWD%"
%__EXEC% start explorer /e, /root, "%_PWD%"

:_END
popd
