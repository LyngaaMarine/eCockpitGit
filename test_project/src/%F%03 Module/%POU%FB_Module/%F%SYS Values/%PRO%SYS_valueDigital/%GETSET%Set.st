VAR
END_VAR

(*%!%__DELIMITER__%!%*)
CASE SYS_valueType OF
	EValueType.float32:		SYS_valueFloat32			:=		TO_REAL(SYS_valueDigital);
	EValueType.enum:			SYS_valueSigned32		:=		TO_DINT(SYS_valueDigital);

	EValueType.signed32:		SYS_valueSigned32		:=		TO_DINT(SYS_valueDigital);
	EValueType.unsigned32:	SYS_valueUnsigned32		:=		TO_DWORD(SYS_valueDigital);
	EValueType.signed64:		SYS_valueSigned64		:=		TO_LINT(SYS_valueDigital);
	EValueType.unsigned64:	SYS_valueUnsigned64		:=		TO_LWORD(SYS_valueDigital);
END_CASE