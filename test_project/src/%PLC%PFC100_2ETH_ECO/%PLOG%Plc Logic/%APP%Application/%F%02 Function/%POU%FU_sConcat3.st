{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This functions combines three strings
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 03-12-18 | Creation
FUNCTION FU_sConcat3 : STRING(255)
VAR_INPUT
	s1			:STRING(255);			//Input String1
	s2			:STRING(255);			//Input String2
	s3			:STRING(255);			//Input String3
END_VAR
!__IMPLEMENTATION__!
FU_sConcat3BIBO(sOut:=ADR(FU_sConcat3),s1:=ADR(s1),s2:=ADR(s2),s3:=ADR(s3),wOutSize:=255);