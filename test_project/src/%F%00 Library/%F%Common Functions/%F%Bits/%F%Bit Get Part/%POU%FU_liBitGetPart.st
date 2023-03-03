//This function gets only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_liBitGetPart : LINT
VAR_INPUT
	value			:LINT;		//Variable to get value from
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
(*%!%__DELIMITER__%!%*)
FU_liBitGetPart		:=		TO_LINT(SHR(TO_ULINT(value),offset) AND TO_ULINT(GConstants.binaryMaskLint[amount]));