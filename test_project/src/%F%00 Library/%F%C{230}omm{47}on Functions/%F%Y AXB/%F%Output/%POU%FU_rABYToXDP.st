{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function, calculates the x value in a x = (y - b) / a equation
//This is the double precision version, which means all values are converted to LREAL before mathematics
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 29-01-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_rABYToXDP : REAL
VAR_INPUT
	rY		:REAL;
	rA		:REAL;
	rB		:REAL;
END_VAR


!__IMPLEMENTATION__!
IF rA <> 0 THEN
	FU_rABYToXDP	:=		TO_REAL((TO_LREAL(rY) - TO_LREAL(rB)) / TO_LREAL(rA));
ELSE
	FU_rABYToXDP	:=		0;
END_IF