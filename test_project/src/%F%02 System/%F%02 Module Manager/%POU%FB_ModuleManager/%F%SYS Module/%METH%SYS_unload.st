{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method called before system software is closed (updated)
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 09-01-22 | Creation
METHOD SYS_unload : SLMResult
VAR
	i			:WORD;
END_VAR
!__IMPLEMENTATION__!
///S_systemModbusMultiPlexer.closeConnection();