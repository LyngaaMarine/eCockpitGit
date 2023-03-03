{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method writes the values for a dedicated module instrument to a struct
//Values are written as a struct with keys
//Max size of struct must not exceed 400 bytes
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 17-03-22 | Creation
METHOD SYS_instrumentCommand
VAR_INPUT
	command		:AModuleInstrumentCommand;
	client		:POINTER TO FB_DataServerClient;
	reader		:ITF_StructReaderBase;
	writer		:ITF_StructWriterBase;
END_VAR
!__IMPLEMENTATION__!
