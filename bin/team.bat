@echo off

setlocal & pushd

if {%1}=={} goto _HELP

set _GLEP_= ^| glep %2
if {%2}=={} (set _GLEP_=)

:_DOIT

call lgl_set.bat

if not exist %~dp0\%1.team (
	echo Error: Team[%1] not found.
	echo Teams found:
	for /R %~dp0 %%i in (*.team) do (
		for /f "tokens=3 delims=\" %%j in ("%%i") do (
		    for /f "tokens=1 delims=." %%k in ("%%j") do echo 	%%k
		)
	)
	goto _END
)
type %~dp0\%1.team %_GLEP_% 2>null

if ERRORLEVEL 1 (goto _HELP)

goto _END

:_HELP
	echo usage: %~nx0 ^<teamname^>

:_END
endlocal & popd
goto:EOF
