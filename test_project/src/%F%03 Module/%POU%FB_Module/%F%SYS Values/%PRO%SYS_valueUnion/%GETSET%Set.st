VAR
END_VAR

(*%!%__DELIMITER__%!%*)
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueDigital		:=		SYS_valueUnion.digital;
	EValueType.float32:		SYS_valueFloat32			:=		SYS_valueUnion.float32;
	EValueType.enum:		SYS_valueSigned32		:=		SYS_valueUnion.signed32;
	
	EValueType.signed32:	SYS_valueSigned32		:=		SYS_valueUnion.signed32;
	EValueType.unsigned32:	SYS_valueUnsigned32		:=		SYS_valueUnion.unsigned32;
	EValueType.signed64:	SYS_valueSigned64		:=		SYS_valueUnion.signed64;
	EValueType.unsigned64:	SYS_valueUnsigned64		:=		SYS_valueUnion.unsigned64;
END_CASE