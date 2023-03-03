{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This method packs the module into a struct
//Super should always be called on this method
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 28-11-20 | Creation
METHOD SYS_setInstrumentData
VAR_INPUT
	client		:POINTER TO FB_DataServerClient;
	reader		:ITF_StructReaderBase;
END_VAR
!__IMPLEMENTATION__!
