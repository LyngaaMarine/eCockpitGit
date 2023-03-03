{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
METHOD structWriteMinMaxModule
VAR_INPUT
	module		:POINTER TO FB_Module;
	writer		:ITF_StructWriterBase;
END_VAR
VAR
	valType		:EValueType;
END_VAR

!__IMPLEMENTATION__!
valType				:=		module^.SYS_valueType;
writer.addKey(name:=GTSmall.Smin);
FU_writeUValue(value:=module^.SYS_valueMin,valueType:=valType,writer:=writer);
writer.addKey(name:=GTSmall.Smax);
FU_writeUValue(value:=module^.SYS_valueMax,valueType:=valType,writer:=writer);
