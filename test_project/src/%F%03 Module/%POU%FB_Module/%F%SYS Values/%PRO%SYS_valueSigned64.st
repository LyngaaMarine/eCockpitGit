{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Property for getting and setting the raw value of the module
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 26-07-19 | Creation
PROPERTY SYS_valueSigned64 : LINT

!__GETTER__!
VAR
END_VAR

!__IMPLEMENTATION__!
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueSigned64	:=		TO_LINT(SYS_valueDigital);
	EValueType.float32:		SYS_valueSigned64	:=		TO_LINT(SYS_valueFloat32);
	EValueType.enum:			SYS_valueSigned64	:=		TO_LINT(SYS_valueSigned32);
	
	EValueType.signed32:		SYS_valueSigned64	:=		TO_LINT(SYS_valueSigned32);
	EValueType.unsigned32:	SYS_valueSigned64	:=		TO_LINT(SYS_valueUnsigned32);
	EValueType.unsigned64:	SYS_valueSigned64	:=		TO_LINT(SYS_valueUnsigned64);
END_CASE
!__SETTER__!
VAR
END_VAR

!__IMPLEMENTATION__!
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueDigital		:=		TO_BOOL(SYS_valueSigned64);
	EValueType.float32:		SYS_valueFloat32			:=		TO_REAL(SYS_valueSigned64);
	EValueType.enum:			SYS_valueSigned32		:=		TO_DINT(SYS_valueSigned64);

	EValueType.signed32:		SYS_valueSigned32		:=		TO_DINT(SYS_valueSigned64);
	EValueType.unsigned32:	SYS_valueUnsigned32		:=		TO_DWORD(SYS_valueSigned64);
	EValueType.unsigned64:	SYS_valueUnsigned64		:=		TO_LWORD(SYS_valueSigned64);
END_CASE