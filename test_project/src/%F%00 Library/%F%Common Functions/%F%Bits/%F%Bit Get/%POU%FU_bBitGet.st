//This function get the bit value from a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 11-01-19 | Creation
FUNCTION FU_bBitGet : BOOL
VAR_INPUT
	bVar	:BYTE;		//The value to work with
	bIndex	:BYTE;		//Which bit to get	
END_VAR
(*%!%__DELIMITER__%!%*)
FU_bBitGet			:=		(bVar AND SHL(1,bIndex)) <> 0;