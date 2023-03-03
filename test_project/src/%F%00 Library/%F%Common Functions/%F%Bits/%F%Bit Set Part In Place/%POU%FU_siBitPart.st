//This function changed only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_siBitPart : BOOL
VAR_IN_OUT
	valueChange		:SINT;		//Variable to change
END_VAR
VAR_INPUT
	value			:SINT;		//Value to change bits to
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
(*%!%__DELIMITER__%!%*)
valueChange		:=		TO_SINT((TO_USINT(valueChange) AND ROL(TO_USINT(GConstants.binaryInvMaskSint[amount]),offset)) OR SHL(TO_USINT(value) AND TO_USINT(GConstants.binaryMaskSint[amount]),offset));