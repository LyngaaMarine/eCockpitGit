PROGRAM DataServerFixedClients
VAR_INPUT
	pouSpeed		:WORD := 100;
END_VAR
VAR
	i				:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
IF Management.taskRun[ETask.DataServerClients] THEN
	Management.taskRunning[ETask.DataServerClients]		:=		TRUE;
	//GDataServer.dataServer.SYS_fixedClientsCycle(pouSpeed:=pouSpeed);
	Management.taskRunning[ETask.DataServerClients]		:=		FALSE;
END_IF