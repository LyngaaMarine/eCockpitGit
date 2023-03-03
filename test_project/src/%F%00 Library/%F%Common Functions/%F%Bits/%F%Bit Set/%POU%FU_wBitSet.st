//This function sets the bit value from a variable
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 11-01-19 | Creation
FUNCTION FU_wBitSet : BOOL
VAR_IN_OUT
	bVar	:WORD;		//The value to work with
END_VAR
VAR_INPUT
	bIndex	:BYTE;		//Which bit to get
	xVal	:BOOL;		//What to set the bit to
END_VAR
(*%!%__DELIMITER__%!%*)
bVar		:=		(bVar AND NOT(SHL(TO_WORD(1),bIndex))) OR (SHL(TO_WORD(xVal),bIndex));