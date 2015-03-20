@echo off
set _LIB=%JAVA_HOME%\jre\lib
_jikes.exe -bootclasspath %_LIB%\rt.jar;%_LIB%\plugin.jar;%_LIB%\charsets.jar;%_LIB%\jce.jar;%_LIB%\jsse.jar %1 %2 %3 %4 %5 %6 %7 %8 %9
