//This program needs to be added to a task to run the alarm system, preferably run at 250ms
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            
// | 1         | NSN      | 11-07-19 | Creation                                                                                                              
PROGRAM AlarmSystemTask
VAR_INPUT
	pouSpeed		:WORD := 250;
END_VAR
(*%!%__DELIMITER__%!%*)
IF Management.taskRun[ETask.AlarmSystem] THEN
	Management.taskRunning[ETask.AlarmSystem]			:=		TRUE;
	//GAlarm.alarmSystem.SYS_cycle(pouSpeed:=pouSpeed);
	Management.taskRunning[ETask.AlarmSystem]			:=		FALSE;
END_IF