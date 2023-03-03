{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function compares two strings and ignores case
// Eg. Test = test is true
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 08-03-22 | Creation
FUNCTION FU_sCompareCaseInsensitive : BOOL
VAR_IN_OUT
	s1			:STRING(1);			//Input String1
	s2			:STRING(1);			//Input String2
END_VAR
VAR
	i			:WORD;
	s1pb		:POINTER TO EASCII;
	s2pb		:POINTER TO EASCII;
END_VAR
!__IMPLEMENTATION__!
s1pb			:=		ADR(s1);
s2pb			:=		ADR(s2);
WHILE TRUE DO
	IF s1pb^ = 0 AND s2pb^ = 0 THEN
		FU_sCompareCaseInsensitive		:=		TRUE;
		RETURN;
	ELSIF s1pb^ <> s2pb^ THEN
		IF NOT(FU_bCompareCharCaseInsensitive(char1:=s1pb^,char2:=s2pb^)) THEN
			RETURN;
		END_IF
	END_IF
	s2pb		:=		s2pb + 1;
	s1pb		:=		s1pb + 1;	
END_WHILE