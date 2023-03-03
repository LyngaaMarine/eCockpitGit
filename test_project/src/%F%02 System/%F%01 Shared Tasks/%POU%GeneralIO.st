{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
PROGRAM GeneralIO
VAR_INPUT
	pouSpeed	:WORD := 250;
END_VAR

!__IMPLEMENTATION__!
IF Management.taskRun[ETask.GeneralIO] THEN
	Management.taskRunning[ETask.GeneralIO]		:=		TRUE;
	//GIO.ioSystem.SYS_cycle(pouSpeed:=pouSpeed);
	Management.taskRunning[ETask.GeneralIO]		:=		FALSE;
END_IF