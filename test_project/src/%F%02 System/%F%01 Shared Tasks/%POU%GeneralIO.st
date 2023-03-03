PROGRAM GeneralIO
VAR_INPUT
	pouSpeed	:WORD := 250;
END_VAR

(*%!%__DELIMITER__%!%*)
IF Management.taskRun[ETask.GeneralIO] THEN
	Management.taskRunning[ETask.GeneralIO]		:=		TRUE;
	//GIO.ioSystem.SYS_cycle(pouSpeed:=pouSpeed);
	Management.taskRunning[ETask.GeneralIO]		:=		FALSE;
END_IF