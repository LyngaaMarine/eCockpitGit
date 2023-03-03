//This function, converts an x, value to an y value using and 2 points on the x and y scale
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 10-01-18 | Updated to new format                                                                                                 |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1.1       | NSN      | 13-06-18 | Updated names and types                                                                                               |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_iLinear2 : INT
VAR_INPUT
	XIn		:INT;
	X1		:INT;
	X2		:INT;
	Y1		:INT;
	Y2		:INT;
END_VAR
VAR
	a		:REAL;
	b		:REAL;
END_VAR
(*%!%__DELIMITER__%!%*)
IF X2 > X1 THEN
	//a value is calculated
	IF X2 - X1 = 0 THEN	a := 0; ELSE a := TO_REAL((Y2 - Y1)) / (X2 - X1); END_IF
	//b value is calculated
	b 							:=		TO_REAL(Y1) - (a * TO_REAL(X1));
	//Output is calculated
	FU_iLinear2 				:=		TO_INT(a * TO_REAL (XIn) + b);
ELSE
	//a value is calculated
	IF X2 - X1 = 0 THEN	a := 0; ELSE a := TO_REAL((Y2 - Y1)) / (X2 - X1); END_IF
	//b value is calculated
	b 							:=		TO_REAL(Y1) - (a * TO_REAL(X1));
	//Output is calculated
	FU_iLinear2 				:=		TO_INT(a * TO_REAL (XIn) + b);
END_IF