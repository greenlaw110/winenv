@ECHO OFF
REM Reset variables
FOR %%A IN (1 10 100) DO SET ERR%%A=

REM Check error level hundredfolds
FOR %%A IN (0 1 2) DO IF ERRORLEVEL %%A00 SET ERR100=%%A
IF %ERR100%==2 GOTO 200
IF %ERR100%==0 IF NOT "%1"=="/0" SET ERR100=

REM Check error level tenfolds
FOR %%A IN (0 1 2 3 4 5 6 7 8 9) DO IF ERRORLEVEL %ERR100%%%A0 SET ERR10=%%A
IF "%ERR100%"=="" IF %ERR10%==0 SET ERR10=

:1
REM Check error level units
FOR %%A IN (0 1 2 3 4 5) DO IF ERRORLEVEL %ERR100%%ERR10%%%A SET ERR1=%%A
REM Modification necessary for errorlevels 250+
IF NOT ERRORLEVEL 250 FOR %%A IN (6 7 8 9) DO IF ERRORLEVEL %ERR100%%ERR10%%%A SET ERR1=%%A
GOTO End

:200
REM In case of error levels over 200 both
REM tenfolds and units are limited to 5
REM since the highest DOS error level is 255
FOR %%A IN (0 1 2 3 4 5) DO IF ERRORLEVEL 2%%A0 SET ERR10=%%A
IF ERR10==5 FOR %%A IN (0 1 2 3 4 5) DO IF ERRORLEVEL 25%%A SET ERR1=%%A
IF NOT ERR10==5 GOTO 1

:End
REM Clean up the mess and show results
SET ERRORLEV=%ERR100%%ERR10%%ERR1%
FOR %%A IN (1 10 100) DO SET ERR%%A=
ECHO ERRORLEVEL  %ERRORLEV%