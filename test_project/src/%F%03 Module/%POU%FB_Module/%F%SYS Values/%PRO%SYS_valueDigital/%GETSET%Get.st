VAR
END_VAR

(*%!%__DELIMITER__%!%*)
CASE SYS_valueType OF
	EValueType.float32:		SYS_valueDigital		:=		TO_BOOL(SYS_valueFloat32);
	EValueType.enum:			SYS_valueDigital	:=		TO_BOOL(SYS_valueSigned32);

	EValueType.signed32:		SYS_valueDigital	:=		TO_BOOL(SYS_valueSigned32);
	EValueType.unsigned32:	SYS_valueDigital		:=		TO_BOOL(SYS_valueUnsigned32);
	EValueType.signed64:		SYS_valueDigital	:=		TO_BOOL(SYS_valueSigned64);
	EValueType.unsigned64:	SYS_valueDigital		:=		TO_BOOL(SYS_valueUnsigned64);
END_CASE