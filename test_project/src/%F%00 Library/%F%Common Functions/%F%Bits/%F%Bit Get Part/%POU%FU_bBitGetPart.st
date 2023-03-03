//This function gets only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_bBitGetPart : BYTE
VAR_INPUT
	value			:BYTE;		//Variable to get value from
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
(*%!%__DELIMITER__%!%*)
FU_bBitPartThrough		:=		SHR(value,offset) AND GConstants.binaryMaskByte[amount];