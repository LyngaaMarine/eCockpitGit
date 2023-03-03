VAR
END_VAR

(*%!%__DELIMITER__%!%*)
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueDigital		:=		TO_BOOL(SYS_valueSigned64);
	EValueType.float32:		SYS_valueFloat32			:=		TO_REAL(SYS_valueSigned64);
	EValueType.enum:			SYS_valueSigned32		:=		TO_DINT(SYS_valueSigned64);

	EValueType.signed32:		SYS_valueSigned32		:=		TO_DINT(SYS_valueSigned64);
	EValueType.unsigned32:	SYS_valueUnsigned32		:=		TO_DWORD(SYS_valueSigned64);
	EValueType.unsigned64:	SYS_valueUnsigned64		:=		TO_LWORD(SYS_valueSigned64);
END_CASE