@echo off

if {%1}=={-s} (
	net stop tomcat5
) else (
	if {%1}=={-r} (
		net stop tomcat5
		call tc_log -c
		net start tomcat5
	) else (
		call tc_log -c
		net start tomcat5
	)
)