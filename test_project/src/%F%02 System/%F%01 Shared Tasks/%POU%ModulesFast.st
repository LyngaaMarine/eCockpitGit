{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
PROGRAM ModulesFast
VAR_INPUT
	pouSpeed		:WORD := 250;
END_VAR
!__IMPLEMENTATION__!
IF Management.taskRun[ETask.ModulesFast] THEN
	Management.taskRunning[ETask.ModulesFast]		:=		TRUE;
	//GModules.modules.run250msCycles(pouSpeed:=pouSpeed);
	Management.taskRunning[ETask.ModulesFast]		:=		FALSE;
END_IF