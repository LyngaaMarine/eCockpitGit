//This function changed only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_liBitPartThrough : LINT
VAR_INPUT
	valueChange		:LINT;		//Variable to change
	value			:LINT;		//Value to change bits to
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
(*%!%__DELIMITER__%!%*)
FU_liBitPartThrough		:=		TO_LINT((TO_LWORD(valueChange) AND ROL(GConstants.binaryInvMaskLWord[amount],offset)) OR SHL(TO_LWORD(value) AND GConstants.binaryMaskLWord[amount],offset));