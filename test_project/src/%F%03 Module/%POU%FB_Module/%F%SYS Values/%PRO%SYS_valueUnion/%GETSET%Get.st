VAR
END_VAR

(*%!%__DELIMITER__%!%*)
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueUnion.digital		:=		SYS_valueDigital;
	EValueType.float32:		SYS_valueUnion.float32		:=		SYS_valueFloat32;
	EValueType.enum:		SYS_valueUnion.signed32		:=		SYS_valueSigned32;
	EValueType.signed32:	SYS_valueUnion.signed32		:=		SYS_valueSigned32;
	EValueType.unsigned32:	SYS_valueUnion.unsigned32	:=		SYS_valueUnsigned32;
	EValueType.signed64:	SYS_valueUnion.signed64		:=		SYS_valueSigned64;
	EValueType.unsigned64:	SYS_valueUnion.unsigned64	:=		SYS_valueUnsigned64;
END_CASE