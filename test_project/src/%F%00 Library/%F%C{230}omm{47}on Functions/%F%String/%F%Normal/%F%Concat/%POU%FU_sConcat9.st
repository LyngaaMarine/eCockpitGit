{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions combines nine strings
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 03-12-18 | Creation
FUNCTION FU_sConcat9 : STRING(255)
VAR_INPUT
	s1			:STRING(255);			//Input String1
	s2			:STRING(255);			//Input String2
	s3			:STRING(255);			//Input String3
	s4			:STRING(255);			//Input String4
	s5			:STRING(255);			//Input String5
	s6			:STRING(255);			//Input String6
	s7			:STRING(255);			//Input String7
	s8			:STRING(255);			//Input String8
	s9			:STRING(255);			//Input String9
END_VAR
!__IMPLEMENTATION__!
FU_sConcat9BIBO(sOut:=ADR(FU_sConcat9),s1:=ADR(s1),s2:=ADR(s2),s3:=ADR(s3),s4:=ADR(s4),s5:=ADR(s5),s6:=ADR(s6),s7:=ADR(s7),s8:=ADR(s8),s9:=ADR(s9),wOutSize:=255);