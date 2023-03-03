//This function, converts an x, value to an y value using and 3 points on the x and y scale
//This function has ends, which means the output is never greater or smaller than the range of y
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 30-05-18 | Creation
// | 1.1       | NSN      | 13-06-18 | Updated names and types
// | 1.2       | NSN      | 29-03-22 | Minor optimization
FUNCTION FU_rLinear2Ends : REAL
VAR_INPUT
	XIn		:REAL;
	X1		:REAL;
	X2		:REAL;
	Y1		:REAL;
	Y2		:REAL;
END_VAR
VAR
	a		:REAL;
END_VAR
(*%!%__DELIMITER__%!%*)
IF X2 > X1 THEN
	IF XIn <= X1 THEN	//When input is out of bounds
		FU_rLinear2Ends 			:=		Y1;
	ELSIF XIn >= X2 THEN	//When input is out of bounds
		FU_rLinear2Ends 			:=		Y2;
	ELSE
		IF X2 - X1 = 0 THEN
			a						:=		0;
		ELSE
			a						:=		(Y2 - Y1) / (X2 - X1);
		END_IF
		FU_rLinear2Ends 			:=		a * XIn + (Y1 - (a * X1));
	END_IF
ELSE
	IF XIn >= X1 THEN
		FU_rLinear2Ends 			:=		Y1;
	ELSIF XIn <= X2 THEN
		FU_rLinear2Ends 			:=		Y2;
	ELSE
		IF X2 - X1 = 0 THEN
			a						:=		0;
		ELSE
			a						:=		(Y2 - Y1) / (X2 - X1);
		END_IF
		FU_rLinear2Ends 			:=		a * XIn + (Y1 - (a * X1));
	END_IF
END_IF