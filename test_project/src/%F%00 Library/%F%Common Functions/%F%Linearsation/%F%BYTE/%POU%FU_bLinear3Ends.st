//This function, converts an x, value to an y value using and 3 points on the x and y scale
//This function has ends, which means the output is never greater or smaller than the range of y
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 10-01-18 | Updated to new format                                                                                                 |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 13-06-18 | Updated names and types                                                                                               |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_bLinear3Ends : BYTE
VAR_INPUT
	XIn		:BYTE;
	X1		:BYTE;
	X2		:BYTE;
	X3		:BYTE;
	Y1		:BYTE;
	Y2		:BYTE;
	Y3		:BYTE;
END_VAR
VAR
	a		:REAL;
	b		:REAL;
END_VAR
(*%!%__DELIMITER__%!%*)
IF X3 > X1 THEN
	IF XIn <= X1 THEN	//When input is out of bounds
		FU_bLinear3Ends 			:=		Y1;
	ELSIF XIn >= X3 THEN	//When input is out of bounds
		FU_bLinear3Ends 			:=		Y3;
	ELSIF XIn > X1 AND XIn <= X2 THEN	//When input is with the 
		//a value is calculated
		IF X2 - X1 = 0 THEN	a := 0; ELSE a := TO_REAL((Y2 - Y1)) / (X2 - X1); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y1) - (a * TO_REAL(X1));
		//Output is calculated
		FU_bLinear3Ends 			:=		TO_BYTE(a * TO_REAL (XIn) + b);
	ELSIF XIn > X2 AND XIn < X3 THEN
		//a value is calculated
		IF X3 - X2 = 0 THEN	a := 0; ELSE a := TO_REAL((Y3 - Y2)) / (X3 - X2); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y2) - (a * TO_REAL(X2));
		//Output is calculated
		FU_bLinear3Ends 			:=		TO_BYTE(a * TO_REAL (XIn) + b);
	END_IF
ELSE
	IF XIn >= X1 THEN
		FU_bLinear3Ends 			:=		Y1;
	ELSIF XIn <= X3 THEN
		FU_bLinear3Ends 			:=		Y3;
	ELSIF XIn < X1 AND XIn >= X2 THEN	
		//a value is calculated
		IF X2 - X1 = 0 THEN	a := 0; ELSE a := TO_REAL((Y2 - Y1)) / (X2 - X1); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y1) - (a * TO_REAL(X1));
		//Output is calculated
		FU_bLinear3Ends 			:=		TO_BYTE(a * TO_REAL (XIn) + b);
	ELSIF XIn < X2 AND XIn > X3 THEN
		//a value is calculated
		IF X3 - X2 = 0 THEN	a := 0; ELSE a := TO_REAL((Y3 - Y2)) / (X3 - X2); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y2) - (a * TO_REAL(X2));
		//Output is calculated
		FU_bLinear3Ends 			:=		TO_BYTE(a * TO_REAL (XIn) + b);
	END_IF
END_IF