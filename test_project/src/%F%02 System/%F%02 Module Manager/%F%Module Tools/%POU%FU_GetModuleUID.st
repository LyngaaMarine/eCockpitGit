{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function takes module id and returns the uid for
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 20-09-20 | Creation
FUNCTION FU_GetModuleUID : AModuleUID
VAR_INPUT
	modID		:AModuleUID;					//Module id to get uid from
END_VAR
VAR
	modBuf		:POINTER TO FB_Module;		//Module buffer
END_VAR

!__IMPLEMENTATION__!
//Module is retrived
modBuf					:=		GMod.modMan.getModuleByUID(ModUID:=modID);
//Null pointer protection
IF modBuf <> 0 THEN
	FU_GetModuleUID		:=		modBuf^._UID;
END_IF