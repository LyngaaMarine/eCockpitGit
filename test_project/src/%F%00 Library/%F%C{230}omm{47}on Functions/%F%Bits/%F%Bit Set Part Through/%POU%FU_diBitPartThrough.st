{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function changed only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_diBitPartThrough : DINT
VAR_INPUT
	valueChange		:DINT;		//Variable to change
	value			:DINT;		//Value to change bits to
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
!__IMPLEMENTATION__!
FU_diBitPartThrough		:=		TO_DINT((TO_DWORD(valueChange) AND ROL(GConstants.binaryInvMaskDWord[amount],offset)) OR SHL(TO_DWORD(value) AND GConstants.binaryMaskDWord[amount],offset));