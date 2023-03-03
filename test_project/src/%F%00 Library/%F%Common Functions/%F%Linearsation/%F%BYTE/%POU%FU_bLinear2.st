//This function, converts an x, value to an y value using and 2 points on the x and y scale
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 21-06-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_bLinear2 : BYTE
VAR_INPUT
	XIn		:BYTE;
	X1		:BYTE;
	X2		:BYTE;
	Y1		:BYTE;
	Y2		:BYTE;
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
	FU_bLinear2 				:=		TO_BYTE(a * TO_REAL (XIn) + b);
ELSE
	//a value is calculated
	IF X2 - X1 = 0 THEN	a := 0; ELSE a := TO_REAL((Y2 - Y1)) / (X2 - X1); END_IF
	//b value is calculated
	b 							:=		TO_REAL(Y1) - (a * TO_REAL(X1));
	//Output is calculated
	FU_bLinear2 				:=		TO_BYTE(a * TO_REAL (XIn) + b);
END_IF