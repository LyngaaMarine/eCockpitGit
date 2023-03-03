{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions copies the contents of one string into another (s1 to s2)
//It stops when string 1 ends
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-02-19 | Creation
FUNCTION FU_sCopyBI
VAR_IN_OUT
	s1			:STRING(1);			//Input String1
	s2			:STRING(1);			//Input String2
END_VAR
VAR_INPUT
	s2MaxSize	:DWORD;
END_VAR
VAR
	s1pb		:POINTER TO BYTE;
	s2pb		:POINTER TO BYTE;
END_VAR
!__IMPLEMENTATION__!
s1pb			:=		ADR(s1);
s2pb			:=		ADR(s2);
WHILE TRUE DO
	IF s1pb^ = 0 OR s2MaxSize = 0 THEN
		RETURN;
	END_IF
	s2pb^		:=		s1pb^;
	s2pb		:=		s2pb + 1;
	s1pb		:=		s1pb + 1;
	s2MaxSize	:=		s2MaxSize - 1;
END_WHILE