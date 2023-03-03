//Run this shared task at 100 ms
PROGRAM Management
VAR_INPUT
	pouSpeed		:WORD := 100;
	taskRunning		:ARRAY[0..GConstants.maxTasks - 1] OF BOOL;
END_VAR
VAR_OUTPUT
	taskRun			:ARRAY[0..GConstants.maxTasks - 1] OF BOOL;
END_VAR

(*%!%__DELIMITER__%!%*)
IF PRG_BootManager.bootFinished THEN
	GMod.modMan.SYS_cycle(pouSpeed:=pouSpeed);
	///GLicense.licenseSystem.SYS_cycle(pouSpeed:=pouSpeed);
	///GPLC.plc.SYS_cycle(pouSpeed:=pouSpeed);
ELSE
	PRG_BootManager(pouSpeed:=pouSpeed);
END_IF