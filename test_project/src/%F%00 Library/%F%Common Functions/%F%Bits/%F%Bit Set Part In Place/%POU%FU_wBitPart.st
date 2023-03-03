//This function changed only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_wBitPart : BOOL
VAR_IN_OUT
	valueChange		:WORD;		//Variable to change
END_VAR
VAR_INPUT
	value			:WORD;		//Value to change bits to
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
(*%!%__DELIMITER__%!%*)
valueChange		:=		(valueChange AND ROL(GConstants.binaryInvMaskWord[amount],offset)) OR SHL(value AND GConstants.binaryMaskWord[amount],offset);