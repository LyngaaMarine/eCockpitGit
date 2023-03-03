//Gets the oldest element from the buffer if there are any, without removing it from the buffer
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
METHOD peek : BOOL
VAR_INPUT
	value		:ANY;
END_VAR

(*%!%__DELIMITER__%!%*)
peek			:=		peekManuel(valuePoint:=value.pValue,valueSize:=TO_DWORD(value.diSize));