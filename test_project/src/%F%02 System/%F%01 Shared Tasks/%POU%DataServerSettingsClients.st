PROGRAM DataServerSettingsClients
VAR_INPUT
	pouSpeed		:WORD := 100;
END_VAR
VAR
	i				:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
IF Management.taskRun[ETask.DataServerClients] THEN
	Management.taskRunning[ETask.DataServerClients]		:=		TRUE;
	//GDataServer.dataServer.SYS_cycle(pouSpeed:=pouSpeed);	
	FOR i  := 0 TO GParameters.amountSettingsClients DO
		;//GDataServer.settingsClients[i].SYS_cycle(pouSpeed:=pouSpeed);	
	END_FOR
	Management.taskRunning[ETask.DataServerClients]		:=		FALSE;
END_IF