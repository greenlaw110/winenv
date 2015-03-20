echo on
rem customize lgl tool kit here

if {%__LGL%}=={} (
  setx __LGL C:\cygwin\home\luog
  set __LGL=C:\cygwin\home\luog
)

if {%__LGL_ENV%}=={} (
  setx __LGL_ENV %__LGL%\env
  set __LGL_ENV=%__LGL%\env
)
if {%RMT_USER%}=={} (
  setx RMT_USER luog
  set RMT_USER=luog
)
if {%_APP%}=={} (
  setx _APP c:\apps
  set _APP=c:\apps
)


@call %~dp0\..\_etc\lgl_boot.bat
