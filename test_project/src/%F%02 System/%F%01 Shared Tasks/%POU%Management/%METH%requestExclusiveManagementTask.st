{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
METHOD requestExclusiveManagementTask
VAR
	i			:BYTE;
END_VAR
!__IMPLEMENTATION__!
FOR i := 0 TO GConstants.maxTasks - 1 DO
	taskRun[i]			:=		FALSE;
END_FOR