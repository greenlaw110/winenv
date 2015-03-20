@echo off
REM GREEN BATCH UTILITY[ lgl_set.bat ] set GREEN BATCH environments
REM VERSION 0.0.2 - fix bug: each time called this batch, errorlevel set to 1
REM Last updated by greenlaw110@gmail.com at Nov-12-2007
REM created by greenlaw110@gmail.com at some time 2006


if {%1}=={-h} goto _HELP

:_DOIT

REM Debugging settings
set __EXEC=
REM need to do this coz the upper command will set ERRORLEVEL to 1 whic
REM is not expected
set ERRORLEVEL=0
set __LOG=REM

if {%__D%}=={Y} goto _SET_DEBUG
if {%__D%}=={T} goto _SET_DEBUG
if {%__D%}=={1} goto _SET_DEBUG
if {%__D%}=={y} goto _SET_DEBUG
if {%__D%}=={t} goto _SET_DEBUG
if {%__D%}=={yes} goto _SET_DEBUG
if {%__D%}=={true} goto _SET_DEBUG
goto _EXIT_DEBUG_SETTNG

:_SET_DEBUG

set __EXEC=echo
set __LOG=echo
goto _EXIT_DEBUG_SETTNG

:_EXIT_DEBUG_SETTNG
REM prepare network drive
dir h: > nul 2>nul
if errorlevel 1 call %~dp0_set_net.bat 2>nul

set SETX=%~dp0setx.exe
REM Core Environment Settings
if {%__LGL%}=={} (
  echo "Warning: __LGL env variable not found. Please run lgl_boot to setup environment"
  exit 1
)
if {%__LGL_ENV%}=={} (CALL:_SET __LGL_ENV %__LGL%\env)

REM if {%_APP%}=={} (%SETX% _APP d:\app)

if {%_ETC%}=={} (call:_SET _ETC %__LGL_ENV%\etc)
if {%_BIN%}=={} (call:_SET _BIN %__LGL_ENV%\bin)
if {%_TBIN%}=={} (call:_SET _TBIN %__LGL_ENV%\tbin)
if {%_IMPORT%}=={} (call:_SET _IMPORT %__LGL_ENV%\import)
if {%_ALIAS%}=={} (call:_SET _ALIAS %__LGL_ENV%\alias)

if {%_DATA%}=={} (call:_SET _DATA %__LGL%\data)
if {%_DOC%}=={} (call:_SET _DOC %_DATA%\doc)

REM utility environment settings
REM if {%RMT_USER%}=={} (call:_SET RMT_USER greenl)
if {%KEY_STORE%}=={} (call:_SET KEY_STORE %_DATA%\keystore)
if {"%LGL_VIEWER%"}=={""} (call:_SET LGL_VIEWER type)
if {"%LGL_EDITOR%"}=={""} (call:_SET LGL_EDITOR notepad2)
REM if {%LGL_EDITOR%}=={} (call:_SET LGL_EDITOR vim)

if {%BAT_DIR%}=={} (call:_SET BAT_DIR %_BIN%)
if {%TEMP_BAT_DIR%}=={} (call:_SET TEMP_BAT_DIR %__LGL%\tbin)
if {%BATCH_TEMPLATE%}=={} (call:_SET BATCH_TEMPLATE %_BIN%\batch.tem)
if {%EMPTY_TEMPLATE%}=={} (call:_SET EMPTY_TEMPLATE %_BIN%\empty.tem)

REM extended environment settings
if {"%ENGLISH_TEXT%"}=={""} (call:_SET ENGLISH_TEXT "%_DOC%\english.txt")
if {"%MINDMAP_HOME%"}=={""} (call:_SET MINDMAP_HOME "%_DOC%\_artifacts\mindmaps")
if {%MM_EXE%}=={} (call:_SET MM_EXE C:\apps\freemind\FreeMind64.exe)

REM call %__LGL_ENV%\_etc\setproxy.bat
goto _END

:_HELP

rem set default variables if they are not set yet
rem call lgl_set

echo %~n0: Check setting of global env vars used by green's batch toolkit
set LGL_EDITOR
set BAT_DIR
set TEMP_BAT_DIR

:_END

goto:EOF

:_SET
echo setting %~1 to %~2
%SETX% %~1 %~2 -m
set %~1=%~2
goto:eof
