//This function gets only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_siBitGetPart : SINT
VAR_INPUT
	value			:SINT;		//Variable to get value from
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
(*%!%__DELIMITER__%!%*)
FU_siBitGetPart		:=		TO_SINT(SHR(TO_USINT(value),offset) AND TO_USINT(GConstants.binaryMaskSint[amount]));