PROGRAM Logging
VAR_INPUT
	pouSpeed		:WORD := 2000;
END_VAR
(*%!%__DELIMITER__%!%*)
IF Management.taskRun[ETask.Logging] THEN
	Management.taskRunning[ETask.Logging]		:=		TRUE;
	///GIO.ioSystem.SYS_cycle(pouSpeed:=pouSpeed);
	///Logs.externalLog();
	Management.taskRunning[ETask.Logging]		:=		FALSE;
END_IF