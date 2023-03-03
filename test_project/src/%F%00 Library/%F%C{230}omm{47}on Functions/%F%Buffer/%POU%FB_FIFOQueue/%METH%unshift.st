{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Gets the oldest element from the buffer if there are any
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
METHOD unshift : BOOL
VAR_INPUT
	value		:ANY;
END_VAR

!__IMPLEMENTATION__!
unshift			:=		unshiftManuel(valuePoint:=value.pValue,valueSize:=TO_DWORD(value.diSize));