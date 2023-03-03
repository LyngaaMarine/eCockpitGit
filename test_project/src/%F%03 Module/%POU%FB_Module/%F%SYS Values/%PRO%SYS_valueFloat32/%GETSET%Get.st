VAR
END_VAR

(*%!%__DELIMITER__%!%*)
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueFloat32	:=		TO_REAL(SYS_valueDigital);
	EValueType.enum:			SYS_valueFloat32	:=		TO_REAL(SYS_valueSigned32);
	
	EValueType.signed32:		SYS_valueFloat32	:=		TO_REAL(SYS_valueSigned32);
	EValueType.unsigned32:	SYS_valueFloat32	:=		TO_REAL(SYS_valueUnsigned32);
	EValueType.signed64:		SYS_valueFloat32	:=		TO_REAL(SYS_valueSigned64);
	EValueType.unsigned64:	SYS_valueFloat32	:=		TO_REAL(SYS_valueUnsigned64);
END_CASE