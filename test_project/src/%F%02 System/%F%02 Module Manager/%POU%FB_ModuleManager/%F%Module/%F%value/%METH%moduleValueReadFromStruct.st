{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method for reading module value from reader
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 25-05-21 | Creation
METHOD moduleValueReadFromStruct
VAR_INPUT
	module		:POINTER TO FB_Module;
	reader		:ITF_StructReaderBase;
END_VAR
!__IMPLEMENTATION__!
CASE module^.SYS_valueType OF
	EValueType.digital:
		module^.SYS_valueDigital		:=		reader.readBool();
	EValueType.signed32,EValueType.enum:
		module^.SYS_valueSigned32		:=		reader.readDint();
	EValueType.unsigned32:
		module^.SYS_valueUnsigned32		:=		reader.readDword();
	EValueType.signed64:
		module^.SYS_valueSigned64		:=		reader.readLint();
	EValueType.unsigned64:
		module^.SYS_valueUnsigned64		:=		reader.readLword();
ELSE
	module^.SYS_valueFloat32			:=		reader.readReal();
END_CASE