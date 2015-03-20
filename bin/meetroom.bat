@echo off

setlocal & pushd


:_DOIT

call lgl_set.bat

set _MR_=%_DOC%\meeting_room.txt

if {%1}=={-h} goto _HELP

if {%1}=={-e} (
  set _CMD_=start %LGL_EDITOR%
  goto _EXEC
)

set _CMD_=type

if not {%1}=={} (
  %_CMD_% %_MR_% | grep %1
  goto _END
)

:_EXEC

%__EXEC% %_CMD_% %_MR_% %_GRP_%

goto _END

:_HELP
echo term: display or launch editor to edit the meeting room list
echo .
echo usage:
echo       %~nx0 (-e^|-h^|meeting_room)
echo         -e edit term file
echo         -h display this help information
echo         meeting_room the meeting room name or number you want to look up
goto _END

:_END
endlocal & popd
goto:EOF
