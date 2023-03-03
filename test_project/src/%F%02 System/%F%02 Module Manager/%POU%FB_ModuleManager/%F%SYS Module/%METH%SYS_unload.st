//Method called before system software is closed (updated)
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 09-01-22 | Creation
METHOD SYS_unload : SLMResult
VAR
	i			:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
///S_systemModbusMultiPlexer.closeConnection();