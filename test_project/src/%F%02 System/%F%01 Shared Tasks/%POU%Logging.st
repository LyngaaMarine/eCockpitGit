{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
PROGRAM Logging
VAR_INPUT
	pouSpeed		:WORD := 2000;
END_VAR
!__IMPLEMENTATION__!
IF Management.taskRun[ETask.Logging] THEN
	Management.taskRunning[ETask.Logging]		:=		TRUE;
	///GIO.ioSystem.SYS_cycle(pouSpeed:=pouSpeed);
	///Logs.externalLog();
	Management.taskRunning[ETask.Logging]		:=		FALSE;
END_IF