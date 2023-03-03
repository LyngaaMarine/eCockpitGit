{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function, calculates the x value in a x = (y - b) / a equation
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 29-01-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_rABYToX : REAL
VAR_INPUT
	rY		:REAL;
	rA		:REAL;
	rB		:REAL;
END_VAR


!__IMPLEMENTATION__!
IF rA <> 0 THEN
	FU_rABYToX	:=		(rY - rB) / rA;
ELSE
	FU_rABYToX	:=		0;
END_IF