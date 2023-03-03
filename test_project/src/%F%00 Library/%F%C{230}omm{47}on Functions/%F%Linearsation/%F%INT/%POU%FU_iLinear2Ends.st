{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function, converts an x, value to an y value using and 2 points on the x and y scale
//This function has ends, which means the output is never greater or smaller than the range of y
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 03-01-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1.1       | NSN      | 04-01-18 | Value name changes                                                                                                    |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1.2       | NSN      | 13-06-18 | Updated names and types                                                                                               |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_iLinear2Ends : INT
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
!__IMPLEMENTATION__!
IF X2 > X1 THEN
	IF XIn <= X1 THEN	//When input is out of bounds
		FU_iLinear2Ends 			:=		Y1;
	ELSIF XIn >= X2 THEN	//When input is out of bounds
		FU_iLinear2Ends 			:=		Y2;
	ELSIF XIn > X1 AND XIn < X2 THEN	//When input is with the 
		//a value is calculated
		IF X2 - X1 = 0 THEN	a := 0; ELSE a := TO_REAL((Y2 - Y1)) / (X2 - X1); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y1) - (a * TO_REAL(X1));
		//Output is calculated
		FU_iLinear2Ends 			:=		TO_INT(a * TO_REAL (XIn) + b);
	END_IF
ELSE
	IF XIn >= X1 THEN
		FU_iLinear2Ends 			:=		Y1;
	ELSIF XIn <= X2 THEN
		FU_iLinear2Ends 			:=		Y2;
	ELSIF XIn < X1 AND XIn > X2 THEN
		//a value is calculated
		IF X2 - X1 = 0 THEN	a := 0; ELSE a := TO_REAL((Y2 - Y1)) / (X2 - X1); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y1) - (a * TO_REAL(X1));
		//Output is calculated
		FU_iLinear2Ends 			:=		TO_INT(a * TO_REAL (XIn) + b);
	END_IF
END_IF