{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method for writing module name to writer
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 15-05-21 | Creation
METHOD structWriteDesignator : SLMResult
VAR_INPUT
	module		:POINTER TO FB_Module;
	writer		:ITF_StructWriterBase;
END_VAR
VAR
	des			:AModuleDes;
END_VAR
!__IMPLEMENTATION__!
des			:=		module^.SYS_designator;
writer.writeString(value:=ADR(des));