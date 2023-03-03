PROGRAM ModulesSuperSlow
VAR_INPUT
	pouSpeed		:WORD := 5000;
END_VAR
(*%!%__DELIMITER__%!%*)
IF Management.taskRun[ETask.ModulesSuperSlow] THEN
	Management.taskRunning[ETask.ModulesSuperSlow]		:=		TRUE;
	//GModules.hourCounterManager.SYS_cycle(pouSpeed:=pouSpeed);
	//GModules.modules.run5000msCycles(pouSpeed:=pouSpeed);
	Management.taskRunning[ETask.ModulesSuperSlow]		:=		FALSE;
END_IF