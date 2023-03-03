{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//Returns the element at the given index
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 18-05-22 | Creation
METHOD getElementByIndex : SLMResult
VAR_INPUT
	index			:WORD;
END_VAR
VAR_OUTPUT
	element			:WORD;
END_VAR
!__IMPLEMENTATION__!
IF index < S_lenght THEN
	element								:=		S_array^[index];
ELSE
	getElementByIndex.success		:=		FALSE;
	getElementByIndex.code			:=		ERCodes.FB_DynamicArray_removeElementByIndex;
	getElementByIndex.reason		:=		GTErrors.EindexOutOfRange;
END_IF