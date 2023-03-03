//Method for setting the name of the module, to a fixed size
//Returns outofmemory, when out of memory
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 15-05-21 | Creation
METHOD setModuleNameStruct : SLMResult
VAR_INPUT
	module		:POINTER TO FB_Module;
	reader		:ITF_StructReaderBase;
END_VAR
VAR
	name		:AModuleName;
END_VAR

(*%!%__DELIMITER__%!%*)
IF reader.valueType = EStructType.tString THEN
	reader.readString(str:=ADR(name),lenMax:=SIZEOF(AModuleName)-1);
	setModuleNameStruct				:=		setModuleName(module:=module,name:=name);
ELSE
	setModuleNameStruct.success		:=		FALSE;
	setModuleNameStruct.reason		:=		GTErrors.EwrongVariableType;
END_IF