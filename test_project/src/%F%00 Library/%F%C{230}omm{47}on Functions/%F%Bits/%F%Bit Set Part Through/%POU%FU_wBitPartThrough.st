{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function changed only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_wBitPartThrough : WORD
VAR_INPUT
	valueChange		:WORD;		//Variable to change
	value			:WORD;		//Value to change bits to
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
!__IMPLEMENTATION__!
FU_wBitPartThrough		:=		(valueChange AND ROL(GConstants.binaryInvMaskWord[amount],offset)) OR SHL(value AND GConstants.binaryMaskWord[amount],offset);