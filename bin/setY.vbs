Dim WshShell, WshEnv
Set WshShell = WScript.CreateObject("WScript.Shell")
Set WshEnv = WshShell.Environment("SYSTEM")
WshEnv("TestVar") = "Windows Script Host"
WScript.Echo WshShell.ExpandEnvironmentStrings("The value of the test variable is: '%TestVar%'")
WshEnv.Remove "TestVar"
WScript.Echo WshShell.ExpandEnvironmentStrings("The value of the test variable is: '%TestVar%'") 