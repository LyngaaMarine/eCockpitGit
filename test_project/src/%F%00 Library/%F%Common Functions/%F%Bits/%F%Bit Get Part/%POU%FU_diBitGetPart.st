//This function gets only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_diBitGetPart : DINT
VAR_INPUT
	value			:DINT;		//Variable to get value from
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
(*%!%__DELIMITER__%!%*)
FU_diBitGetPart		:=		TO_DINT(TO_UDINT(SHR(value,offset)) AND TO_UDINT(GConstants.binaryMaskDint[amount]));