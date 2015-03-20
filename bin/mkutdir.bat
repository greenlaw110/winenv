@echo off

if {%1A}=={A} goto HELP_

set ROOT=%1

echo creating UT directory structure for LTD_APP ...

mkdir %ROOT%\ltd_apps\code\applications\appcore
mkdir %ROOT%\ltd_apps\code\applications\rs\mobile\core
mkdir %ROOT%\ltd_apps\code\applications\rs\mobile\app
mkdir %ROOT%\ltd_apps\code\applications\rs\portable\core
mkdir %ROOT%\ltd_apps\code\applications\rs\portable\app
mkdir %ROOT%\ltd\code\radios_vris\config\release\mobile\includes
mkdir %ROOT%\ltd\code\radios_vris\config\release\portable\includes
mkdir %ROOT%\ltd\code\connectivity\release\include

goto END_

:HELP_
echo Usage: mkutdir (root-dir)
goto END_

:END_

