@echo off
REM set host=127.0.0.1
REM net view \\%host%\home$
REM if errorlevel 1 goto _END
REM cmd /c net use h: \\%host%\home$
echo mouting home directory...
subst h: C:\home\luog
subst j: C:\l\j
subst l: C:\l
subst d: C:\home\luog\Downloads
subst e: C:\home\luog\env
subst p: C:\p
subst t: C:\home\luog\tst

:_END
