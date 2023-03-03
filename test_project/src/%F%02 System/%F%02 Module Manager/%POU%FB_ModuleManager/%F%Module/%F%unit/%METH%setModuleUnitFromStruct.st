{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method for setting the name of the module, to a fixed size
//Returns outofmemory, when out of memory
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 15-05-21 | Creation
METHOD setModuleUnitFromStruct : SLMResult
VAR_INPUT
	module		:POINTER TO FB_Module;
	reader		:ITF_StructReaderBase;
END_VAR
VAR
	unit		:AModuleUnit;
END_VAR

!__IMPLEMENTATION__!
IF reader.valueType = EStructType.tString THEN
	reader.readString(str:=ADR(unit),lenMax:=SIZEOF(AModuleUnit)-1);
	setModuleUnitFromStruct				:=		setModuleUnit(module:=module,unit:=unit);
ELSE
	setModuleUnitFromStruct.success		:=		FALSE;
	setModuleUnitFromStruct.reason		:=		GTErrors.EwrongVariableType;
END_IF