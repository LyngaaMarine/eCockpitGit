METHOD checkExclusiveManagementTask : BOOL
VAR
	i			:BYTE;
END_VAR
(*%!%__DELIMITER__%!%*)
FOR i := 0 TO GConstants.maxTasks - 1 DO
	IF taskRunning[i] THEN
		RETURN;
	END_IF
END_FOR
checkExclusiveManagementTask		:=		TRUE;