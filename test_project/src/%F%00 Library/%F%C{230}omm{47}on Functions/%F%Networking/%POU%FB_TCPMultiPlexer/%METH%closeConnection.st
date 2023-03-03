{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Called to close and clean up all connections in the multiplexer
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
METHOD closeConnection
VAR
	i			:WORD;
END_VAR
!__IMPLEMENTATION__!
IF S_controllersSize > 0 THEN
	FOR i := 0 TO S_controllersSize - 1 DO
		S_controllers^[i].closeConnection();
	END_FOR	
END_IF
