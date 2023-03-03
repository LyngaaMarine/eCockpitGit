{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Method for bit accessing the value of the module
//|**Version**|**Author**| **Date** |**Changes**
//| 1         | NSN      | 15-03-22 | Creation
METHOD SYS_getBits : DWORD
VAR_INPUT
	amount		:BYTE;
	offset		:BYTE;
END_VAR
VAR
	buffer		:UValue;
END_VAR
!__IMPLEMENTATION__!
CASE SYS_valueType OF
	EValueType.digital:
		SYS_getBits			:=		TO_DWORD(SYS_valueDigital);
	EValueType.unsigned32:
		SYS_getBits			:=		FU_dwBitGetPart(value:=SYS_valueUnsigned32,amount:=amount,offset:=offset);
	EValueType.signed32,EValueType.enum:
		SYS_getBits			:=		FU_dwBitGetPart(value:=TO_DWORD(SYS_valueSigned32),amount:=amount,offset:=offset);
	EValueType.unsigned64:
		SYS_getBits			:=		FU_dwBitGetPart(value:=TO_DWORD(SYS_valueUnsigned64),amount:=amount,offset:=offset);
	EValueType.signed64:
		SYS_getBits			:=		FU_dwBitGetPart(value:=TO_DWORD(SYS_valueSigned64),amount:=amount,offset:=offset);
END_CASE
