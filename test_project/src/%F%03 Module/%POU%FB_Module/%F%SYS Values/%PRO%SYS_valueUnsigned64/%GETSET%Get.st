VAR
END_VAR

(*%!%__DELIMITER__%!%*)
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueUnsigned64	:=		TO_LWORD(SYS_valueDigital);
	EValueType.float32:		SYS_valueUnsigned64	:=		TO_LWORD(SYS_valueFloat32);
	EValueType.enum:			SYS_valueUnsigned64	:=		TO_LWORD(SYS_valueSigned32);
	
	EValueType.signed32:		SYS_valueUnsigned64	:=		TO_LWORD(SYS_valueSigned32);
	EValueType.unsigned32:	SYS_valueUnsigned64	:=		TO_LWORD(SYS_valueUnsigned32);
	EValueType.signed64:		SYS_valueUnsigned64	:=		TO_LWORD(SYS_valueSigned64);
END_CASE