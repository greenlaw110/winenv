@echo off 
if [%1]==[-s] (
	catdoc.bat rfc "^%2:"
	goto _END
)
if [%1]==[--strict] (
	catdoc.bat rfc "^%2:"
	goto _END
)
if [%1]==[-w] (
	goto _WWW
)
if [%1]==[--web] (
	goto _WWW
)
if [%1]==[-h] (
	goto _HELP
)
if [%1]==[--help] (
	goto _HELP
)
catdoc.bat rfc       %* 

:_END
goto:EOF

:_HELP
echo usage: 
echo	rfc ^<options^> your-rfc-no
echo		-s, --strict	exact match, otherwise, approprate match
echo    -w, --web     fetch rfc document from WWW
echo		-h, --help	show help
goto _END


:_WWW
cd %__LGL%\cache
if exist rfc%2.txt (
	echo use rfc in cache
) else (
	wget -Y on http://www.ietf.org/rfc/rfc%2.txt
)
cat rfc%2.txt
goto _END