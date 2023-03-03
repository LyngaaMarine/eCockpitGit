{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method makes the module creates it's unique init values
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 29-11-20 | Creation
METHOD SYS_serverInitData : SLMResult
VAR_INPUT
	client			:POINTER TO FB_DataServerClient;
	writer			:ITF_StructWriterBase;
	reservedData	:POINTER TO BYTE;					//This is a pointer to a fixed amount of data reserved for buffers and counters and such (check dataServerClient for the size of this)
END_VAR
!__IMPLEMENTATION__!
