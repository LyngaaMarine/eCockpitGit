{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Pushes the given element to the queue
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 15-02-22 | Creation
METHOD push : BOOL
VAR_INPUT
	value		:ANY;
END_VAR
!__IMPLEMENTATION__!
push		:=		pushManuel(valuePoint:=value.pValue,valueSize:=TO_DWORD(value.diSize));