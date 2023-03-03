//This function safely gets the value of a module by the uid
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 19-01-22 | Creation
FUNCTION FU_GetModuleValueDigitalSafe : BOOL
VAR_INPUT
	modID		:AModuleUID;				//Module id to get uid from
END_VAR
VAR
	modBuf		:POINTER TO FB_Module;		//Module buffer
END_VAR

(*%!%__DELIMITER__%!%*)
//Module is retrived
modBuf									:=		GMod.modMan.getModuleByUID(ModUID:=modID);
//Null pointer protection
IF modBuf <> 0 THEN
	FU_GetModuleValueDigitalSafe		:=		modBuf^.SYS_valueDigital;
END_IF