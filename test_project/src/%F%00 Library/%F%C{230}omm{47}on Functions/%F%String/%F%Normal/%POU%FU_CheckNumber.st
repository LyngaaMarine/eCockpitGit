{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function checks if a string only contains numbers, dot (.) and dash (-) are also permitted as they are required for some numbers
//Returns true if string only contains numbers
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 10-12-18 | Creation
FUNCTION FU_CheckNumber : BOOL
VAR_INPUT
	str			:STRING(255);	//String
END_VAR
!__IMPLEMENTATION__!
FU_CheckNumber		:=		FU_CheckNumberBI(str:=str);