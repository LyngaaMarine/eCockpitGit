VAR
END_VAR

(*%!%__DELIMITER__%!%*)
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueDigital		:=		TO_BOOL(SYS_valueFloat32);
	EValueType.enum:			SYS_valueSigned32		:=		TO_DINT(SYS_valueFloat32);

	EValueType.signed32:		SYS_valueSigned32		:=		TO_DINT(SYS_valueFloat32);
	EValueType.unsigned32:	SYS_valueUnsigned32		:=		TO_DWORD(SYS_valueFloat32);
	EValueType.signed64:		SYS_valueSigned64		:=		TO_LINT(SYS_valueFloat32);
	EValueType.unsigned64:	SYS_valueUnsigned64		:=		TO_LWORD(SYS_valueFloat32);
END_CASE