{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function calculates the difference between two values, and outputs it positively
//
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 02-08-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_lwDiff : LWORD
VAR_INPUT
	A			:LWORD;
	B			:LWORD;
END_VAR

!__IMPLEMENTATION__!
IF A > B THEN
	FU_lwDiff			:=		A - B;
ELSE
	FU_lwDiff			:=		B - A;
END_IF
