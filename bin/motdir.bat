@echo off

setlocal & pushd

set _ME=%~nx0

if {%1}=={} goto _HELP

:_DOIT

call lgl_set.bat

if {%1}=={-b} (
    if not {%2}=={} (
        perl %BAT_DIR%\motdir.pl -b %2
        goto _END
    )
    goto _HELP
)

set _REFRESH=0
if {%1}=={-f} (
	set _REFRESH=1
	shift
)

:_SET_ENV
set _COREID=%1
if {%_COREID%}=={} goto _HELP
set _TMPFILE=%TEMP%\%_COREID%.motdir

if not exist %_TMPFILE% (
	goto _REFRESH
)
if {%_REFRESH%}=={1} (
	goto _REFRESH
)

goto _EXECUTE

:_REFRESH
perl %BAT_DIR%\motdir.pl %_COREID% | perl %BAT_DIR%\parsemotdir.pl > %_TMPFILE%

:_EXECUTE
shift
if {%1}=={} (
	type %_TMPFILE%	
	goto _END
)

:_GREP
cat  %_TMPFILE% | glep -i %1

goto _END

:_HELP
echo usage: 
echo       %_ME% [-f^|-b] ^<core-id^>
echo		-f	force refresh cache from http://dir.mot.com
echo		-b	display LDAP information of ^<core-id^> in browser

:_END
endlocal & popd
goto:EOF
