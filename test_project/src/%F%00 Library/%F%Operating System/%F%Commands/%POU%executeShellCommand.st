{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function calls the FU_ExecuteShellCommandBig, with a fixed string size
//To get a return value use printf "$$(command)"
FUNCTION executeShellCommand : STRING(200)
VAR_INPUT
	command: STRING(200);
END_VAR
VAR_OUTPUT
	result: RTS_IEC_RESULT;
END_VAR

!__IMPLEMENTATION__!
result		:=		executeShellCommandBig(command:=command,stdOut:=executeShellCommand,stdOutLength:=200);