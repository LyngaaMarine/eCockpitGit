//This function gets only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_lwBitGetPart : LWORD
VAR_INPUT
	value			:LWORD;		//Variable to get value from
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
(*%!%__DELIMITER__%!%*)
FU_lwBitGetPart		:=		SHR(value,offset) AND GConstants.binaryMaskLWord[amount];