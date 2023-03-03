{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions combines two strings
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 13-06-18 | Creation
// | 1.1       | NSN      | 03-12-18 | Made pointers update in declaration
FUNCTION FU_sConcat : STRING(255)
VAR_INPUT
	s1			:STRING(255);			//Input String1
	s2			:STRING(255);			//Input String2
END_VAR
!__IMPLEMENTATION__!
FU_sConcatBIBO(sOut:=ADR(FU_sConcat),s1:=ADR(s1),s2:=ADR(s2),wOutSize:= 255);