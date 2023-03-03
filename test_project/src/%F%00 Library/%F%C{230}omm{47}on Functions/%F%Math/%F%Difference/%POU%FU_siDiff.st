{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function calculates the difference between two values, and outputs it positively
//
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 02-08-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_siDiff : SINT
VAR_INPUT
	A			:SINT;
	B			:SINT;
END_VAR

!__IMPLEMENTATION__!
IF A > B THEN
	FU_siDiff			:=		A - B;
ELSE
	FU_siDiff			:=		B - A;
END_IF
