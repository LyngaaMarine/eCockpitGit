//This method is called by the management task to change configuration of the module
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 16-02-22 | Creation
METHOD SYS_changeConfig : SLMResult
VAR_INPUT
	reader			:ITF_StructReaderBase;
	client			:POINTER TO FB_DataServerClient;
	duringCreation	:BOOL;		//Is set true during creation of module
END_VAR
(*%!%__DELIMITER__%!%*)
