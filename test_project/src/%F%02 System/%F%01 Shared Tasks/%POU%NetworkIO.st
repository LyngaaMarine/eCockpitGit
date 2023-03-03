//Runs this shared task at 100 ms or change the pouSpeed input
PROGRAM NetworkIO
VAR_INPUT
	pouSpeed				:WORD := 100;
END_VAR
VAR
	i						:WORD;
	networkModules			:POINTER TO ARRAY[0..19] OF POINTER TO FB_Module;
	networkModulesHandler	:FB_DynamicArray(pArray:=networkModules,wIncrement:=4,wElementSize:=SIZEOF(POINTER TO BYTE),wMaxSize:=0,xStringArray:=FALSE,xMap:=FALSE);
END_VAR
(*%!%__DELIMITER__%!%*)
IF Management.taskRun[ETask.NetworkIO] THEN
	Management.taskRunning[ETask.NetworkIO]		:=		TRUE;
	//GMod.modMan.modbusCycle(pouSpeed:=pouSpeed);
	IF networkModulesHandler.S_lenght > 0 THEN
		FOR i := 0 TO networkModulesHandler.S_lenght - 1 DO
			networkModules^[i]^.SYS_cycle(pouSpeed:=pouSpeed);			
		END_FOR
	END_IF
	Management.taskRunning[ETask.NetworkIO]		:=		FALSE;
END_IF