//This function, calculates the x value in a x = (y - b) / a equation
//This is the double precision version, which means all values are converted to LREAL before mathematics
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 29-01-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_rABYToXDPDir : BOOL
VAR_IN_OUT
	rY		:REAL;
	rA		:REAL;
	rB		:REAL;
	rX		:REAL;
END_VAR
(*%!%__DELIMITER__%!%*)
IF rA <> 0 THEN
	rX	:=		TO_REAL((TO_LREAL(rY) - TO_LREAL(rB)) / TO_LREAL(rA));
ELSE
	rX	:=		0;
END_IF