{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function calculates the difference between two values, and outputs it positively
//
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 02-08-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_uliDiff : ULINT
VAR_INPUT
	A			:ULINT;
	B			:ULINT;
END_VAR

!__IMPLEMENTATION__!
IF A > B THEN
	FU_uliDiff			:=		A - B;
ELSE
	FU_uliDiff			:=		B - A;
END_IF
