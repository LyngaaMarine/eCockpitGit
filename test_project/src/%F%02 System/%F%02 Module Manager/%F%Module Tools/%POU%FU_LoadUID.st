{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function takes module id and returns the uid for
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 20-09-20 | Creation
FUNCTION FU_LoadUID : AModuleUID
VAR_INPUT
	loader		:ITF_StructReaderBase;
END_VAR
!__IMPLEMENTATION__!
FU_LoadUID		:=		TO_WORD(loader.readDint());