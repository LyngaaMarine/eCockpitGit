//Method for setting the unit of the module
//Returns outofmemory, when out of memory
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 27-07-19 | Creation
METHOD setModuleUnit : SLMResult
VAR_INPUT
	module		:POINTER TO FB_Module;
	unit		:AModuleUnit;
END_VAR

(*%!%__DELIMITER__%!%*)
IF module^.SYS_unitWrite THEN
	setModuleUnit				:=		FU_SetDynamicString(pStr:=module^._unit,str:=ADR(unit), maxSize := SIZEOF(AModuleName) - 1);
ELSE
	setModuleUnit.success		:=		FALSE;
	setModuleUnit.reason		:=		GTErrors.EunitNotWritable;
END_IF
