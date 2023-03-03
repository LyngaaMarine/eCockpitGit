//This function changed only the needed bits of a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-03-22 | Creation
FUNCTION FU_dwBitPartThrough : DWORD
VAR_INPUT
	valueChange		:DWORD;		//Variable to change
	value			:DWORD;		//Value to change bits to
	amount			:BYTE;		//Amount of bits to change
	offset			:BYTE;		//Offset in variable to change bits at
END_VAR
(*%!%__DELIMITER__%!%*)
FU_dwBitPartThrough		:=		(valueChange AND ROL(GConstants.binaryInvMaskDWord[amount],offset)) OR SHL(value AND GConstants.binaryMaskDWord[amount],offset);