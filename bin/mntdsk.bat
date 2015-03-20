@echo off

if {%1} == {} (
cmd /c subst A: D:\apps
cmd /c subst H: D:\home
cmd /c subst V: D:\vm
cmd /c subst J: D:\java
cmd /c subst W: D:\workspace
cmd /c subst P: "C:\Documents and Settings"
cmd /c subst S: D:\store
	cmd /c subst T: D:\Temp
) else (
	if /I {%1} == {-d} goto _UNMNT
	if /I {%1} == {-u} goto _UNMNT
	goto _HELP
)

goto _END

:_UNMNT
cmd /c subst A: /D
cmd /c subst H: /D
cmd /c subst V: /D
cmd /c subst J: /D
cmd /c subst W: /D
cmd /c subst P: /D
cmd /c subst S: /D
cmd /c subst T: /D
goto _END

:_HELP
echo Usage: 
echo        1. mntdsk - mount all network disk
echo        2. mntdsk -[du] - unmount all network disk

goto _END

:_END


