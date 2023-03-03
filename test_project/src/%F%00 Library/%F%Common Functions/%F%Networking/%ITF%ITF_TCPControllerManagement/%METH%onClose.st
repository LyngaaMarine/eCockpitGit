//Called when controller conection is closed
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 20-05-22 | Creation
METHOD onClose
VAR_INPUT
	index			:WORD;				//Index set to controller
END_VAR
VAR_IN_OUT
	controller		:FB_TCPController;	//Controller which is closed
END_VAR
(*%!%__DELIMITER__%!%*)
