{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions combines two strings
//This is the big input version which means any size string can be inputted, but only string variables will be accepted
//It is also faster on bigger strings
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-02-19 | Creation
// | 2         | NSN      | 14-10-21 | Changed to pointer based
FUNCTION FU_sConcatBI : STRING(255)
VAR_INPUT
	s1			:POINTER TO EASCII;			//Input String1
	s2			:POINTER TO EASCII;			//Input String2
END_VAR
!__IMPLEMENTATION__!
FU_sConcatBIBO(sOut:=ADR(FU_sConcatBI),s1:=s1,s2:=s2,wOutSize:=255);