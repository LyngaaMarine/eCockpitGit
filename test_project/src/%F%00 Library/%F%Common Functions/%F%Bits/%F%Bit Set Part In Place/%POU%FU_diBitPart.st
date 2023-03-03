//This function changed only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_diBitPart : BOOL
VAR_IN_OUT
	valueChange		:DINT;		//Variable to change
END_VAR
VAR_INPUT
	value			:DINT;		//Value to change bits to
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
(*%!%__DELIMITER__%!%*)
valueChange		:=		TO_DINT((TO_UDINT(valueChange) AND ROL(TO_UDINT(GConstants.binaryInvMaskDint[amount]),offset)) OR SHL(TO_UDINT(value) AND TO_UDINT(GConstants.binaryMaskDint[amount]),offset));