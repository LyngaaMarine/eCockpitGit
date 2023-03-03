PROGRAM LocalIO
VAR_INPUT
	pouSpeed		:WORD := 25;
END_VAR
VAR
	i						:WORD;
	cycleModules			:POINTER TO ARRAY[0..19] OF POINTER TO FB_Module;
	cycleModulesHandler		:FB_DynamicArray(pArray:=cycleModules,wIncrement:=4,wElementSize:=SIZEOF(POINTER TO BYTE),wMaxSize:=0,xStringArray:=FALSE,xMap:=FALSE);
END_VAR
(*%!%__DELIMITER__%!%*)
IF Management.taskRun[ETask.LocalIO] THEN
	Management.taskRunning[ETask.LocalIO]		:=		TRUE;
	//GWago.localCards.SYS_cycle(pouSpeed:=pouSpeed);
	IF cycleModulesHandler.S_lenght > 0 THEN
		FOR i := 0 TO cycleModulesHandler.S_lenght - 1 DO
			cycleModules^[i]^.SYS_cycle(pouSpeed:=pouSpeed);			
		END_FOR
	END_IF
	Management.taskRunning[ETask.LocalIO]		:=		FALSE;
END_IF