@echo off

if {%1} == {} (
	cmd /c net use A: \\zch49app02\Mailattach
	REM cmd /c net use O: \\zch49app08\trinity
	cmd /c net use H: \\cd10\home
	cmd /c net use L: \\zch49app08\Embedded_App\Team_Member\greenl
) else (
	if /I {%1} == {-d} goto _UNMNT
	if /I {%1} == {-u} goto _UNMNT
	goto _HELP
)

goto _END

:_UNMNT
cmd /c net use A: /delete
REM cmd /c net use O: /delete
cmd /c net use H: /delete
cmd /c net use L: /delete
goto _END

:_HELP
echo Usage: 
echo        1. mntndsk - mount all network disk
echo        2. mntndsk -[du] - unmount all network disk

goto _END

:_END
