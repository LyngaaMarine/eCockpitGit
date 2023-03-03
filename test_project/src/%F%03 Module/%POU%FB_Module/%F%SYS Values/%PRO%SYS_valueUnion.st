{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Property for getting and setting the raw value of the module
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 26-07-19 | Creation
PROPERTY SYS_valueUnion : UValue

!__GETTER__!
VAR
END_VAR

!__IMPLEMENTATION__!
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueUnion.digital		:=		SYS_valueDigital;
	EValueType.float32:		SYS_valueUnion.float32		:=		SYS_valueFloat32;
	EValueType.enum:		SYS_valueUnion.signed32		:=		SYS_valueSigned32;
	EValueType.signed32:	SYS_valueUnion.signed32		:=		SYS_valueSigned32;
	EValueType.unsigned32:	SYS_valueUnion.unsigned32	:=		SYS_valueUnsigned32;
	EValueType.signed64:	SYS_valueUnion.signed64		:=		SYS_valueSigned64;
	EValueType.unsigned64:	SYS_valueUnion.unsigned64	:=		SYS_valueUnsigned64;
END_CASE
!__SETTER__!
VAR
END_VAR

!__IMPLEMENTATION__!
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueDigital		:=		SYS_valueUnion.digital;
	EValueType.float32:		SYS_valueFloat32			:=		SYS_valueUnion.float32;
	EValueType.enum:		SYS_valueSigned32		:=		SYS_valueUnion.signed32;
	
	EValueType.signed32:	SYS_valueSigned32		:=		SYS_valueUnion.signed32;
	EValueType.unsigned32:	SYS_valueUnsigned32		:=		SYS_valueUnion.unsigned32;
	EValueType.signed64:	SYS_valueSigned64		:=		SYS_valueUnion.signed64;
	EValueType.unsigned64:	SYS_valueUnsigned64		:=		SYS_valueUnion.unsigned64;
END_CASE