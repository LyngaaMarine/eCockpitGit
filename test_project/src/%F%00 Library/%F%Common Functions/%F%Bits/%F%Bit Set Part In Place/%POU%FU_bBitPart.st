//This function changed only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_bBitPart : BOOL
VAR_IN_OUT
	valueChange		:BYTE;		//Variable to change
END_VAR
VAR_INPUT
	value			:BYTE;		//Value to change bits to
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
(*%!%__DELIMITER__%!%*)
valueChange		:=		(valueChange AND ROL(GConstants.binaryInvMaskByte[amount],offset)) OR SHL(value AND GConstants.binaryMaskByte[amount],offset);