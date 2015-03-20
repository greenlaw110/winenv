@echo off

echo ^>^>^>^>^>^>^>^>^> umount clearcase vobs
call cltvob -u

echo ^>^>^>^>^>^>^>^>^> end clearcase views
call cltview -u

echo ^>^>^>^>^>^>^>^>^> stop clearcase services
call svcmgr -cc


