{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function finds a uid by the given name, checks if it is the correct type, then reads it
//change value is set true if uid has changed from stored value, and is left unchanged if uid is unchanged
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 20-09-20 | Creation
FUNCTION FU_ReadUID : BOOL
VAR_INPUT
	uid			:REFERENCE TO AModuleUID;
	loader		:ITF_StructReaderBase;
	change		:REFERENCE TO BOOL;
END_VAR
VAR
	uidBuff		:AModuleUID;
END_VAR
!__IMPLEMENTATION__!
uidBuff		:=		TO_WORD(loader.readDint());
IF uid <> uidBuff THEN
	uid		:=		uidBuff;
	change	:=		TRUE;
END_IF