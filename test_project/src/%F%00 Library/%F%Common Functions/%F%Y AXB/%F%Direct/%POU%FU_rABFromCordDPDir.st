//This function calculates an a and a b value for a line equation based on given coordinates
//This is the double precision version, which means all values are converted to LREAL before mathematics
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 29-01-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_rABFromCordDPDir : BOOL
VAR_IN_OUT
	rX1		:REAL;
	rX2		:REAL;
	rY1		:REAL;
	rY2		:REAL;
	rA		:REAL;
	rB		:REAL;
END_VAR
(*%!%__DELIMITER__%!%*)
//a value is calculated
IF TO_LREAL(rX2) - TO_LREAL(rX1) = 0 THEN rA := 0; ELSE rA := TO_REAL((TO_LREAL(rY2) - TO_LREAL(rY1)) / (TO_LREAL(rX2) - TO_LREAL(rX1))); END_IF
//b value is calculated
rB			:=		TO_REAL(TO_LREAL(rY1) - (TO_LREAL(rA) * TO_LREAL(rX1)));
