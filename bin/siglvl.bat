@echo off

setlocal & pushd

if {%1}=={-h} goto _HELP
if {%1}=={-e} (
  set _CMD=%LGL_EDITOR%
  goto _DOIT
)
if {%1}=={} (
  set _CMD=less
) else (
  head -1 %~p06sig.txt
  set _CMD=grep -w '%1'
)

:_DOIT

call lgl_set.bat

%_CMD% %~p06sig.txt

goto _END

:_HELP
echo usage: 
echo       %~nx0 ^<sigmal level|no of DPMO^>

:_END
endlocal & popd
goto:EOF
