//This function, converts an x, value to an y value using and 3 points on the x and y scale
//This function has ends, which means the output is never greater or smaller than the range of y
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 11-12-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_diLinear4Ends : DINT
VAR_INPUT
	XIn		:DINT;
	X1		:DINT;
	X2		:DINT;
	X3		:DINT;
	X4		:DINT;
	Y1		:DINT;
	Y2		:DINT;
	Y3		:DINT;
	Y4		:DINT;
END_VAR
VAR
	a		:REAL;
	b		:REAL;
END_VAR
(*%!%__DELIMITER__%!%*)
IF X4 > X1 THEN
	IF XIn <= X1 THEN	//When input is out of bounds
		FU_diLinear4Ends 			:=		Y1;
	ELSIF XIn >= X4 THEN	//When input is out of bounds
		FU_diLinear4Ends 			:=		Y4;
	ELSIF XIn > X1 AND XIn <= X2 THEN	//When input is with the 
		//a value is calculated
		IF X2 - X1 = 0 THEN	a := 0; ELSE a := TO_REAL(Y2 - Y1) / TO_REAL(X2 - X1); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y1) - (a * TO_REAL(X1));
		//Output is calculated
		FU_diLinear4Ends 			:=		TO_DINT(a * TO_REAL (XIn) + b);
	ELSIF XIn > X2 AND XIn <= X3 THEN
		//a value is calculated
		IF X3 - X2 = 0 THEN	a := 0; ELSE a := TO_REAL(Y3 - Y2) / TO_REAL(X3 - X2); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y2) - (a * TO_REAL(X2));
		//Output is calculated
		FU_diLinear4Ends 			:=		TO_INT(a * TO_REAL (XIn) + b);
	ELSIF XIn > X3 AND XIn < X4 THEN
		//a value is calculated
		IF X4 - X3 = 0 THEN	a := 0; ELSE a := TO_REAL(Y4 - Y3) / TO_REAL(X4 - X3); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y3) - (a * TO_REAL(X3));
		//Output is calculated
		FU_diLinear4Ends 			:=		TO_INT(a * TO_REAL (XIn) + b);
	END_IF
ELSE
	IF XIn >= X1 THEN
		FU_diLinear4Ends 			:=		Y1;
	ELSIF XIn <= X4 THEN
		FU_diLinear4Ends 			:=		Y4;
	ELSIF XIn < X1 AND XIn >= X2 THEN
		//a value is calculated
		IF X2 - X1 = 0 THEN	a := 0; ELSE a := TO_REAL(Y2 - Y1) / TO_REAL(X2 - X1); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y1) - (a * TO_REAL(X1));
		//Output is calculated
		FU_diLinear4Ends 			:=		TO_INT(a * TO_REAL (XIn) + b);
	ELSIF XIn < X2 AND XIn >= X3 THEN
		//a value is calculated
		IF X3 - X2 = 0 THEN	a := 0; ELSE a := TO_REAL(Y3 - Y2) / TO_REAL(X3 - X2); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y2) - (a * TO_REAL(X2));
		//Output is calculated
		FU_diLinear4Ends 			:=		TO_INT(a * TO_REAL (XIn) + b);
	ELSIF XIn < X3 AND XIn > X4 THEN
		//a value is calculated
		IF X4 - X3 = 0 THEN	a := 0; ELSE a := TO_REAL(Y4 - Y3) / TO_REAL(X4 - X3); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y3) - (a * TO_REAL(X3));
		//Output is calculated
		FU_diLinear4Ends 			:=		TO_INT(a * TO_REAL (XIn) + b);
	END_IF
END_IF