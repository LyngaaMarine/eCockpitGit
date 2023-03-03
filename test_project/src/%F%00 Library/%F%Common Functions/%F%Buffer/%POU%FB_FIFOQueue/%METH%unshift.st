//Gets the oldest element from the buffer if there are any
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
METHOD unshift : BOOL
VAR_INPUT
	value		:ANY;
END_VAR

(*%!%__DELIMITER__%!%*)
unshift			:=		unshiftManuel(valuePoint:=value.pValue,valueSize:=TO_DWORD(value.diSize));