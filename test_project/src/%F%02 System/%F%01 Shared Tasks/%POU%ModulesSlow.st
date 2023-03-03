PROGRAM ModulesSlow
VAR_INPUT
	pouSpeed		:WORD := 1000;
END_VAR
(*%!%__DELIMITER__%!%*)
IF Management.taskRun[ETask.ModulesSlow] THEN
	Management.taskRunning[ETask.ModulesSlow]		:=		TRUE;
	//GModules.modules.run1000msCycles(pouSpeed:=pouSpeed);
	Management.taskRunning[ETask.ModulesSlow]		:=		FALSE;
END_IF