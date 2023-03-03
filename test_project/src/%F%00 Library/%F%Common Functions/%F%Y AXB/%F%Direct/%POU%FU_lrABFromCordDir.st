//This function calculates an a and a b value for a line equation based on given coordinates
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 29-01-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_lrABFromCordDir : BOOL
VAR_IN_OUT
	rX1		:LREAL;
	rX2		:LREAL;
	rY1		:LREAL;
	rY2		:LREAL;
	rA		:LREAL;
	rB		:LREAL;
END_VAR
(*%!%__DELIMITER__%!%*)
//a value is calculated
IF rX2 - rX1 = 0 THEN rA := 0; ELSE rA := (rY2 - rY1) / (rX2 - rX1); END_IF
//b value is calculated
rB			:=		rY1 - (rA * rX1);
