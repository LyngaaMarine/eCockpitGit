{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function calculates the difference between two values, and outputs it positively
//if the two value are 
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 02-08-18 | Creation
FUNCTION FU_wDiffWrap : WORD
VAR_INPUT
	A			:WORD;
	B			:WORD;
END_VAR
!__IMPLEMENTATION__!
IF A > B THEN
	IF A > 49150 AND B < 16383 THEN
		FU_wDiffWrap			:=		B - A;
	ELSE
		FU_wDiffWrap			:=		A - B;		
	END_IF
ELSE
	IF B > 49150 AND A < 16383 THEN
		FU_wDiffWrap			:=		A - B;
	ELSE
		FU_wDiffWrap			:=		B - A;
	END_IF
END_IF