{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Called cyclicly to cause messages to be processed via event system
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
METHOD messageCycle
VAR
	i			:WORD;
END_VAR
!__IMPLEMENTATION__!
IF S_controllersSize > 0 THEN
	FOR i := 0 TO S_controllersSize - 1 DO
		WHILE S_controllers^[i].readyToRecieve DO ; END_WHILE
	END_FOR	
END_IF
