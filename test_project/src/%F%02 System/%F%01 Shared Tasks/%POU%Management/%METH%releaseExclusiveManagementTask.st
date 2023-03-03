METHOD releaseExclusiveManagementTask
VAR
	i			:BYTE;
END_VAR
(*%!%__DELIMITER__%!%*)
FOR i := 0 TO GConstants.maxTasks - 1 DO
	taskRun[i]			:=		TRUE;
END_FOR