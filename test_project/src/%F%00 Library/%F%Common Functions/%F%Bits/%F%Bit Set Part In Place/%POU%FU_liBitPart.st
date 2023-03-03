//This function changed only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_liBitPart : BOOL
VAR_IN_OUT
	valueChange		:LINT;		//Variable to change
END_VAR
VAR_INPUT
	value			:LINT;		//Value to change bits to
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
(*%!%__DELIMITER__%!%*)
valueChange		:=		TO_LINT((TO_ULINT(valueChange) AND ROL(TO_ULINT(GConstants.binaryInvMaskLint[amount]),offset)) OR SHL(TO_ULINT(value) AND TO_ULINT(GConstants.binaryMaskLint[amount]),offset));