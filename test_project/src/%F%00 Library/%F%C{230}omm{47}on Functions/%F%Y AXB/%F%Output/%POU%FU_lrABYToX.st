{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function, calculates the x value in a x = (y - b) / a equation
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 29-01-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_lrABYToX : LREAL
VAR_INPUT
	rY		:LREAL;
	rA		:LREAL;
	rB		:LREAL;
END_VAR

!__IMPLEMENTATION__!
IF rA <> 0 THEN
	FU_lrABYToX	:=		(rY - rB) / rA;
ELSE
	FU_lrABYToX	:=		0;
END_IF