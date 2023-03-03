//Method for bit accessing the value of the module
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 15-03-22 | Creation
METHOD SYS_setBits
VAR_INPUT
	value		:DWORD;
	amount		:BYTE;
	offset		:BYTE;
END_VAR
(*%!%__DELIMITER__%!%*)
CASE SYS_valueType OF
	EValueType.digital:
		SYS_valueDigital					:=		value.0;
	EValueType.unsigned32:
		SYS_valueUnsigned32					:=		FU_dwBitPartThrough(valueChange:=SYS_valueUnsigned32,value:=value,amount:=amount,offset:=offset);
	EValueType.signed32,EValueType.enum:
		SYS_valueSigned32					:=		FU_diBitPartThrough(valueChange:=SYS_valueSigned32,value:=TO_DINT(value),amount:=amount,offset:=offset);
	EValueType.unsigned64:
		SYS_valueUnsigned64					:=		FU_lwBitPartThrough(valueChange:=SYS_valueUnsigned64,value:=value,amount:=amount,offset:=offset);
	EValueType.signed64:
		SYS_valueSigned64					:=		FU_liBitPartThrough(valueChange:=SYS_valueSigned64,value:=value,amount:=amount,offset:=offset);
END_CASE