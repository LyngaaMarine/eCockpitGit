{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function, returns the lenght of a string
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 13-06-18 | Creation
FUNCTION FU_wFindRight : WORD
VAR_INPUT
	s1			:STRING(255);		//Input String1
	s2			:STRING(255);		//Input String2
END_VAR
!__IMPLEMENTATION__!
FU_wFindRight	:=		FU_wFindRightBI(s1:=s1,s2:=s2);