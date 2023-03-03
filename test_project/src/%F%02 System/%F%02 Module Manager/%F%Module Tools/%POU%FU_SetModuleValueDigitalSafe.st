{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function safely sets a module by its id, works for digital value
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 21-01-22 | Creation
FUNCTION FU_SetModuleValueDigitalSafe
VAR_INPUT
	value		:BOOL;							//Value to set
	modID		:AModuleUID;					//Module id to get uid from
END_VAR
VAR
	modBuf		:POINTER TO FB_Module;			//Module buffer
END_VAR

!__IMPLEMENTATION__!
//Module is retrived
modBuf									:=		GMod.modMan.getModuleByUID(ModUID:=modID);
//Null pointer protection
IF modBuf <> 0 THEN
	modBuf^.SYS_valueDigital				:=		value;
END_IF