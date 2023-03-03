{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method for writing module name to writer
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 15-05-21 | Creation
METHOD structWriteModuleName : SLMResult
VAR_INPUT
	module		:POINTER TO FB_Module;
	writer		:ITF_StructWriterBase;
	mode		:BYTE;
END_VAR
VAR
	name		:AModuleName;
END_VAR
!__IMPLEMENTATION__!
CASE mode OF
	0:	//Name Formatted
		name			:=		getModuleName(module:=module,layer:=0);
	1:	//Name Raw
		IF module^._name <> 0 THEN
			name		:=		module^._name^;
		END_IF
ELSE
	RETURN;
END_CASE
writer.writeString(value:=ADR(name));