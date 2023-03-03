{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function, calculates the y value in a y = a * x + b equation
//This is the double precision version, which means all values are converted to LREAL before mathematics
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 29-01-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_rABXToYDP : REAL
VAR_INPUT
	rX		:REAL;
	rA		:REAL;
	rB		:REAL;
END_VAR


!__IMPLEMENTATION__!
FU_rABXToYDP	:=		TO_REAL(TO_LREAL(rA) * TO_LREAL(rX) + TO_LREAL(rB));