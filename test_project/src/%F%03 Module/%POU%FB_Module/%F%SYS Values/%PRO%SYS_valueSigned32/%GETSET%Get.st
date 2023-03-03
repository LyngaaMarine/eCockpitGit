VAR
END_VAR

(*%!%__DELIMITER__%!%*)
CASE SYS_valueType OF
	EValueType.digital:		SYS_valueSigned32	:=		TO_DINT(SYS_valueDigital);
	EValueType.float32:		SYS_valueSigned32	:=		TO_DINT(SYS_valueFloat32);

	EValueType.unsigned32:	SYS_valueSigned32	:=		TO_DINT(SYS_valueUnsigned32);
	EValueType.signed64:		SYS_valueSigned32	:=		TO_DINT(SYS_valueSigned64);
	EValueType.unsigned64:	SYS_valueSigned32	:=		TO_DINT(SYS_valueUnsigned64);
END_CASE