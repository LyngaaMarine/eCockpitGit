//This function, calculates the y value in a y = a * x + b equation
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 29-01-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_rABXToY : REAL
VAR_INPUT
	rX		:REAL;
	rA		:REAL;
	rB		:REAL;
END_VAR


(*%!%__DELIMITER__%!%*)
FU_rABXToY	:=		rA * rX + rB;