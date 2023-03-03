//This function, calculates the y value in a y = a * x + b equation
//This is the double precision version, which means all values are converted to LREAL before mathematics
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 29-01-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_rABXToYDPDir : BOOL
VAR_IN_OUT
	rX		:REAL;
	rA		:REAL;
	rB		:REAL;
	rY		:REAL;
END_VAR
(*%!%__DELIMITER__%!%*)
rY		:=		TO_REAL(TO_LREAL(rA) * TO_LREAL(rX) + TO_LREAL(rB));