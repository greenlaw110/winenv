@echo off 

set __EXT=%1
if {%__EXT%}=={} goto _HELP

start %_DOC%\_nsn\process_%__EXT%.png
goto _END

:_HELP
echo procdiag: 	Display the NSN process diagram
echo usage:
echo 	procdiag m_c
echo		- Display NSN M milestone and C milestone relationship
echo.
echo 	procdiag c_p 
echo		- Display NSN C milestone and P milestone relationship
echo.
echo 	procdiag summary
echo		- Display NSN process summary
echo.
echo 	procdiag mapping
echo		- Display NSN/Siemens/Nokia process mapping table
echo.
echo 	procdiag mapping2
echo		- Display NSN/Siemens/Nokia process mapping table II

:_END