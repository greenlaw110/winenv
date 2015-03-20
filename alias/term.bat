@echo off 
if [%1]==[-s] (
	catdoc.bat terms "^%2:"
	goto _END
)
if [%1]==[--strict] (
	catdoc.bat terms "^%2:"
	goto _END
)
if [%1]==[-h] (
	goto _HELP
)
if [%1]==[--help] (
	goto _HELP
)
catdoc.bat terms       %* 

:_END
goto:EOF

:_HELP
echo usage: 
echo	term ^<options^> your-term
echo		-s, --strict	exact match, otherwise, approprate match
echo		-h, --help	show help
goto _END


