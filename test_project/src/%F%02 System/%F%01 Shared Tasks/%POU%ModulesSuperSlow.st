{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
PROGRAM ModulesSuperSlow
VAR_INPUT
	pouSpeed		:WORD := 5000;
END_VAR
!__IMPLEMENTATION__!
IF Management.taskRun[ETask.ModulesSuperSlow] THEN
	Management.taskRunning[ETask.ModulesSuperSlow]		:=		TRUE;
	//GModules.hourCounterManager.SYS_cycle(pouSpeed:=pouSpeed);
	//GModules.modules.run5000msCycles(pouSpeed:=pouSpeed);
	Management.taskRunning[ETask.ModulesSuperSlow]		:=		FALSE;
END_IF