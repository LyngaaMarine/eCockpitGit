{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function changed only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_iBitPart : BOOL
VAR_IN_OUT
	valueChange		:INT;		//Variable to change
END_VAR
VAR_INPUT
	value			:INT;		//Value to change bits to
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
!__IMPLEMENTATION__!
valueChange		:=		TO_INT((TO_UINT(valueChange) AND ROL(TO_UINT(GConstants.binaryInvMaskInt[amount]),offset)) OR SHL(TO_UINT(value) AND TO_UINT(GConstants.binaryMaskInt[amount]),offset));