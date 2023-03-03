//This function executes a command on the shell, the command must be written as a bash script
//To get a return value use printf "$$(command)"
FUNCTION executeShellCommandBig : RTS_IEC_RESULT
VAR_INPUT
	command			:REFERENCE TO STRING;
	stdOut			:REFERENCE TO STRING;
	stdOutLength	:WORD;
END_VAR

(*%!%__DELIMITER__%!%*)
SysProcess.SysProcessExecuteCommand2(pszCommand:=command,pszStdOut:=stdOut,udiStdOutLen:=stdOutLength,pResult:=ADR(executeShellCommandBig));