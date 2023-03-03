{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method for setting the name of the module, to a fixed size
//Returns outofmemory, when out of memory
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 27-07-19 | Creation
METHOD setModuleName : SLMResult
VAR_INPUT
	module		:POINTER TO FB_Module;
	name		:AModuleName;
END_VAR

!__IMPLEMENTATION__!
IF module^.SYS_nameWrite THEN
	setModuleName				:=		FU_SetDynamicString(pStr:=module^._name,str:=ADR(name), maxSize := SIZEOF(AModuleName) - 1);
ELSE
	setModuleName.success		:=		FALSE;
	setModuleName.reason		:=		GTErrors.EnameNotWritable;
END_IF
