//This method is called for module commands, any response created is send back
//Must returns a result code of 100 to send data
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 28-11-20 | Creation
METHOD SYS_serverCommand : SLMResult
VAR_INPUT
	client		:POINTER TO FB_DataServerClient;
	reader		:ITF_StructReaderBase;
	writer		:ITF_StructWriterBase;
END_VAR
(*%!%__DELIMITER__%!%*)
