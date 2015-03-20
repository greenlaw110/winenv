@echo off

echo ^>^>^>^>^>^>^>^>^> start clearcase services
call svcmgr +cc

echo ^>^>^>^>^>^>^>^>^> start clearcase views
call cltview

echo ^>^>^>^>^>^>^>^>^> mount clearcase vobs
call cltvob
