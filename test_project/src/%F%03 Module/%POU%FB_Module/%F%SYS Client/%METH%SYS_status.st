{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method makes the module return it's status variables
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 28-11-20 | Creation
METHOD SYS_status : SLMResult
VAR_INPUT
	client		:POINTER TO FB_DataServerClient;
	writer		:ITF_StructWriterBase;
END_VAR
!__IMPLEMENTATION__!
