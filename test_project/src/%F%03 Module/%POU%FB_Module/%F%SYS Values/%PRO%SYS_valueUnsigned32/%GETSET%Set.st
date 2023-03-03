VAR
END_VAR

(*%!%__DELIMITER__%!%*)
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueDigital		:=		TO_BOOL(SYS_valueUnsigned32);
	EValueType.float32:		SYS_valueFloat32			:=		TO_REAL(SYS_valueUnsigned32);
	EValueType.enum:			SYS_valueSigned32		:=		TO_DINT(SYS_valueUnsigned32);
	EValueType.signed32:		SYS_valueSigned32		:=		TO_DINT(SYS_valueUnsigned32);
	EValueType.signed64:		SYS_valueSigned64		:=		TO_LINT(SYS_valueUnsigned32);
	EValueType.unsigned64:	SYS_valueUnsigned64		:=		TO_LWORD(SYS_valueUnsigned32);
END_CASE