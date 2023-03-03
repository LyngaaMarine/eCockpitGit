{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions combines five strings
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 03-12-18 | Creation
FUNCTION FU_sConcat5 : STRING(255)
VAR_INPUT
	s1			:STRING(255);			//Input String1
	s2			:STRING(255);			//Input String2
	s3			:STRING(255);			//Input String3
	s4			:STRING(255);			//Input String4
	s5			:STRING(255);			//Input String5
END_VAR
!__IMPLEMENTATION__!
FU_sConcat5BIBO(sOut:=ADR(FU_sConcat5),s1:=ADR(s1),s2:=ADR(s2),s3:=ADR(s3),s4:=ADR(s4),s5:=ADR(s5),wOutSize:=255);