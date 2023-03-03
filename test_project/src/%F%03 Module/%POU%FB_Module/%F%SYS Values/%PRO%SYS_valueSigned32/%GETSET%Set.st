VAR
END_VAR

(*%!%__DELIMITER__%!%*)
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueDigital		:=		TO_BOOL(SYS_valueSigned32);
	EValueType.float32:		SYS_valueFloat32			:=		TO_REAL(SYS_valueSigned32);

	EValueType.unsigned32:	SYS_valueUnsigned32		:=		TO_DWORD(SYS_valueSigned32);
	EValueType.signed64:		SYS_valueSigned64		:=		TO_LINT(SYS_valueSigned32);
	EValueType.unsigned64:	SYS_valueUnsigned64		:=		TO_LWORD(SYS_valueSigned32);
END_CASE