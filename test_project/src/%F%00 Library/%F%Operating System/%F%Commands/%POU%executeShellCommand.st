//This function calls the FU_ExecuteShellCommandBig, with a fixed string size
//To get a return value use printf "$$(command)"
FUNCTION executeShellCommand : STRING(200)
VAR_INPUT
	command: STRING(200);
END_VAR
VAR_OUTPUT
	result: RTS_IEC_RESULT;
END_VAR

(*%!%__DELIMITER__%!%*)
result		:=		executeShellCommandBig(command:=command,stdOut:=executeShellCommand,stdOutLength:=200);