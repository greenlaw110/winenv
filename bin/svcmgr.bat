@echo off

setlocal & pushd
if {%1} == {} goto _HELP

set _CC_EXEC_=rem
set _SMS_EXEC_=rem
set _NAV_EXEC_=rem
set _INT_EXEC_=rem
set _NET_EXEC_=rem
set _MIS_EXEC_=rem
set _MED_EXEC_=rem
set _RAT_EXEC_=rem
set _TP_EXEC_=rem

rem probe for media services
if /I {%1} == {+tp} (
	set _TP_EXEC_=
	set _TP_ACT_=start
)
if /I {%1} == {-tp} (
	set _TP_EXEC_=
	set _TP_ACT_=stop
)

if /I {%1} == {+med} (
	set _MED_EXEC_=
	set _MED_ACT_=start
)
if /I {%1} == {-med} (
	set _MED_EXEC_=
	set _MED_ACT_=stop
)

rem probe for clearcase
if /I {%1} == {+cc} (
	set _CC_EXEC_=
	set _CC_ACT_=start
)
if /I {%1} == {-cc} (
	set _CC_EXEC_=
	set _CC_ACT_=stop
)

rem probe for other rational services
if /I {%1} == {+rat} (
	set _RAT_EXEC_=
	set _RAT_ACT_=start
)
if /I {%1} == {-rat} (
	set _RAT_EXEC_=
	set _RAT_ACT_=stop
)

rem probe for SMS
if /I {%1} == {+sms} (
	set _SMS_EXEC_=
	set _SMS_ACT_=start
)
if /I {%1} == {-sms} (
	set _SMS_EXEC_=
	set _SMS_ACT_=stop
)

rem probe for NAV
if /I {%1} == {+nav} (
	set _NAV_EXEC_=
	set _NAV_ACT_=start
)
if /I {%1} == {-nav} (
	set _NAV_EXEC_=
	set _NAV_ACT_=stop
)

rem probe for Intel
if /I {%1} == {+int} (
	set _INT_EXEC_=
	set _INT_ACT_=start
)
if /I {%1} == {-int} (
	set _INT_EXEC_=
	set _INT_ACT_=stop
)

rem probe for Network miscs
if /I {%1} == {+net} (
	set _NET_EXEC_=
	set _NET_ACT_=start
)
if /I {%1} == {-net} (
	set _NET_EXEC_=
	set _NET_ACT_=stop
)

rem probe for Other services
if /I {%1} == {+mis} (
	set _MIS_EXEC_=
	set _MIS_ACT_=start
)
if /I {%1} == {-mis} (
	set _MIS_EXEC_=
	set _MIS_ACT_=stop
)

rem probe for All services
if /I {%1} == {+all} (
	set _CC_EXEC_=
	set _SMS_EXEC_=
	set _NAV_EXEC_=
	set _INT_EXEC_=
	set _NET_EXEC_=
	set _MIS_EXEC_=
	set _MED_EXEC_=
	set _RAT_EXEC_=
	set _TP_EXEC_=
	
	set _CC_ACT_=start
	set _SMS_ACT_=start
	set _NAV_ACT_=start
	set _INT_ACT_=start
	set _NET_ACT_=start
	set _MIS_ACT_=start
	set _MED_ACT_=start
	set _RAT_ACT_=start
	set _TP_ACT_=start
)
if /I {%1} == {-all} (
	set _CC_EXEC_=
	set _SMS_EXEC_=
	set _NAV_EXEC_=
	set _INT_EXEC_=
	set _NET_EXEC_=
	set _MIS_EXEC_=
	set _MED_EXEC_=
	set _RAT_EXEC_=
	set _TP_EXEC_=

	set _CC_ACT_=stop
	set _SMS_ACT_=stop
	set _NAV_ACT_=stop
	set _INT_ACT_=stop
	set _NET_ACT_=stop
	set _MIS_ACT_=stop
	set _MED_ACT_=stop
	set _RAT_ACT_=stop
	set _TP_ACT_=stop
)


:_DOIT

rem Thinkpad services
	rem Thinkpad Ac Profile Manager Service
	%_TP_EXEC_% net %_TP_ACT_% AcPrfMgrSvc

	rem Thinkpad Access Connections Main Service
	%_TP_EXEC_% net %_TP_ACT_% AcSvc
	
	rem ThinkVantage System Update
	%_TP_EXEC_% net %_TP_ACT_% SUservice
	
	rem ThinkPad HDD APS Logging Service
	%_TP_EXEC_% net %_TP_ACT_% TPHDEXLGSVC
	
	rem ThinkVantage Registry Monitor Service
	%_TP_EXEC_% net %_TP_ACT_% "ThinkVantage Registry Monitor Service"
	
	rem ThinkVantage TVT Backup Protection Service
	%_TP_EXEC_% net %_TP_ACT_% "TVT Backup Protection Service"
	
	rem ThinkVantage TVT Backup Service
	%_TP_EXEC_% net %_TP_ACT_% "TVT Backup Service"
	
	rem ThinkVantage TVT Scheduler
	%_TP_EXEC_% net %_TP_ACT_% "TVT Scheduler"
	
	rem ThinkVantage TVT Windows Update Monitor
	%_TP_EXEC_% net %_TP_ACT_% "TVT_UpdateMonitor"
	
rem Media services
	rem SSDP discovery services
	%_MED_EXEC_% net %_MED_ACT_% SSDPSRV

	rem Universal Plug and Play Device Host
	%_MED_EXEC_% net %_MED_ACT_% upnphost

	rem Windows Media Networking Sharing Service
	%_MED_EXEC_% net %_MED_ACT_% WMPNetworkSvc

	rem Windows Image Acquisition(WIA)
	%_MED_EXEC_% net %_MED_ACT_% stisvc

	rem Portable Media Serial Number Service
	%_MED_EXEC_% net %_MED_ACT_% WmdmPmSN

	rem Windows Driver Foundation - User-mode Driver Framework Platform Driver
	%_MED_EXEC_% net %_MED_ACT_% WudfPf

	rem Windows Driver Foundation - User-mode Driver Framework Platform Driver
	%_MED_EXEC_% net %_MED_ACT_% ccosm


rem ClearCase services
	rem Atria Location Broker
	%_CC_EXEC_% net %_CC_ACT_% albd

	rem Atria Cred Manager
	%_CC_EXEC_% net %_CC_ACT_% cccredmgr

	rem Atria Lock Manager
	%_CC_EXEC_% net %_CC_ACT_% LockMgr

rem Other rational services
rem none

rem SMS services
	rem SMS Agent Host
	%_SMS_EXEC_% net %_SMS_ACT_% CcmExec

	rem SMS Remote Control Agent
	%_SMS_EXEC_% net %_SMS_ACT_% Wuser32

	rem Managed Client Service
	%_SMS_EXEC_% net %_SMS_ACT_% MCSvc

	rem Remote Registry
	rem %_SMS_EXEC_% net %_SMS_ACT_% RemoteRegistry

rem Symantec services
	rem Symantec AntiVirus Roaming Service
	%_NAV_EXEC_% net %_NAV_ACT_% SavRoam
	
	rem Symantec AntiVirus
	%_NAV_EXEC_% net %_NAV_ACT_% "Symantec AntiVirus"

	rem Symantec AntiVirus Definition Watcher
	%_NAV_EXEC_% net %_NAV_ACT_% DefWatch

	rem Symantec Event Manager
	%_NAV_EXEC_% net %_NAV_ACT_% ccEvtMgr

	rem Symantec Settings Manager
	%_NAV_EXEC_% net %_NAV_ACT_% ccSetMgr

rem Other network services
	rem BlackICE
	%_NET_EXEC_% net %_NET_ACT_% BlackICE

	rem Hummingbird Exceed Display Management
	%_NET_EXEC_% net %_NET_ACT_% HumDisplayServer

rem Intel services
	rem Spectrum24 Event Monitor
	%_INT_EXEC_% net %_INT_ACT_% S24EventMonitor
	
	rem Intel Event Trace Manager
	%_INT_EXEC_% net %_INT_ACT_% EvtEng
	
	rem Intel Registry Service
	%_INT_EXEC_% net %_INT_ACT_% RegSrvc
	
	rem WLANKEEPER
	%_INT_EXEC_% net %_INT_ACT_% WLANKEEPER

	rem Wireless Zero Configuratoin
	%_INT_EXEC_% net %_INT_ACT_% WZCSVC
	
	rem Windows User Mode Driver Framework
	%_INT_EXEC_% net %_INT_ACT_% UMWdf
	
	rem Shell Hardware Detection
	%_INT_EXEC_% net %_INT_ACT_% ShellHWDetection
	
rem Other services
	rem Help and Support
	%_MIS_EXEC_% net %_MIS_ACT_% HelpSvc
	
goto _END

:_HELP
echo Usage: 
echo        %~n0 [+-]'grp-id' - start/stop services of certain group.
echo        grp-id can be any one of the following:
echo           cc - clearcase services
echo           med - Media Devices related services
echo           sms - SMS services
echo           nav - symantec services
echo           int - intel services
echo           net - other network services (blackice, exceed, remote registry, wlankeeper)
echo           mis - other services (user mode driver framework, shell hardware detection)
echo           all - all services listed above

goto _END

endlocal & popd
:_END
