VAR
END_VAR

(*%!%__DELIMITER__%!%*)
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueUnsigned32	:=		TO_DWORD(SYS_valueDigital);
	EValueType.float32:		SYS_valueUnsigned32	:=		TO_DWORD(SYS_valueFloat32);
	EValueType.enum:			SYS_valueUnsigned32	:=		TO_DWORD(SYS_valueSigned32);
	
	EValueType.signed32:		SYS_valueUnsigned32	:=		TO_DWORD(SYS_valueSigned32);
	EValueType.signed64:		SYS_valueUnsigned32	:=		TO_DWORD(SYS_valueSigned64);
	EValueType.unsigned64:	SYS_valueUnsigned32	:=		TO_DWORD(SYS_valueUnsigned64);
END_CASE