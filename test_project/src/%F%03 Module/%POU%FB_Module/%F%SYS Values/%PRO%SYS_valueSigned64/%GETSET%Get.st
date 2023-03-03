VAR
END_VAR

(*%!%__DELIMITER__%!%*)
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueSigned64	:=		TO_LINT(SYS_valueDigital);
	EValueType.float32:		SYS_valueSigned64	:=		TO_LINT(SYS_valueFloat32);
	EValueType.enum:			SYS_valueSigned64	:=		TO_LINT(SYS_valueSigned32);
	
	EValueType.signed32:		SYS_valueSigned64	:=		TO_LINT(SYS_valueSigned32);
	EValueType.unsigned32:	SYS_valueSigned64	:=		TO_LINT(SYS_valueUnsigned32);
	EValueType.unsigned64:	SYS_valueSigned64	:=		TO_LINT(SYS_valueUnsigned64);
END_CASE