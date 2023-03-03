{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
PROGRAM ModulesSlow
VAR_INPUT
	pouSpeed		:WORD := 1000;
END_VAR
!__IMPLEMENTATION__!
IF Management.taskRun[ETask.ModulesSlow] THEN
	Management.taskRunning[ETask.ModulesSlow]		:=		TRUE;
	//GModules.modules.run1000msCycles(pouSpeed:=pouSpeed);
	Management.taskRunning[ETask.ModulesSlow]		:=		FALSE;
END_IF