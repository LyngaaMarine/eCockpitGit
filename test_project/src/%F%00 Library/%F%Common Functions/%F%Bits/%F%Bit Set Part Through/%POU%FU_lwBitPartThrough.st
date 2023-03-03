//This function changed only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_lwBitPartThrough : LWORD
VAR_INPUT
	valueChange		:LWORD;		//Variable to change
	value			:LWORD;		//Value to change bits to
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
(*%!%__DELIMITER__%!%*)
FU_lwBitPartThrough		:=		(valueChange AND ROL(GConstants.binaryInvMaskLWord[amount],offset)) OR SHL(value AND GConstants.binaryMaskLWord[amount],offset);