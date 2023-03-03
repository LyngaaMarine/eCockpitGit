{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function, converts an x, value to an y value using and 3 points on the x and y scale
//This function has ends, which means the output is never greater or smaller than the range of y
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 30-05-18 | Updated to new format
// | 2         | NSN      | 24-05-22 | Fixed cases where y difference was negative
FUNCTION FU_wLinear4Ends : WORD
VAR_INPUT
	XIn		:WORD;
	X1		:WORD;
	X2		:WORD;
	X3		:WORD;
	X4		:WORD;
	Y1		:WORD;
	Y2		:WORD;
	Y3		:WORD;
	Y4		:WORD;
END_VAR
VAR
	a		:REAL;
	b		:REAL;
END_VAR
!__IMPLEMENTATION__!
IF X4 > X1 THEN
	IF XIn <= X1 THEN	//When input is out of bounds
		FU_wLinear4Ends 			:=		Y1;
	ELSIF XIn >= X4 THEN	//When input is out of bounds
		FU_wLinear4Ends 			:=		Y4;
	ELSIF XIn > X1 AND XIn <= X2 THEN	//When input is with the 
		//a value is calculated
		IF X2 - X1 = 0 THEN	a := 0; ELSE a := (TO_REAL(Y2) - TO_REAL(Y1)) / (TO_REAL(X2) - TO_REAL(X1)); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y1) - (a * TO_REAL(X1));
		//Output is calculated
		FU_wLinear4Ends 			:=		TO_WORD(a * TO_REAL (XIn) + b);
	ELSIF XIn > X2 AND XIn <= X3 THEN
		//a value is calculated
		IF X3 - X2 = 0 THEN	a := 0; ELSE a := (TO_REAL(Y3) - TO_REAL(Y2)) / (TO_REAL(X3) - TO_REAL(X2)); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y2) - (a * TO_REAL(X2));
		//Output is calculated
		FU_wLinear4Ends 			:=		TO_WORD(a * TO_REAL (XIn) + b);
	ELSIF XIn > X3 AND XIn < X4 THEN
		//a value is calculated
		IF X4 - X3 = 0 THEN	a := 0; ELSE a := (TO_REAL(Y4) - TO_REAL(Y3)) / (TO_REAL(X4) - TO_REAL(X3)); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y3) - (a * TO_REAL(X3));
		//Output is calculated
		FU_wLinear4Ends 			:=		TO_WORD(a * TO_REAL (XIn) + b);
	END_IF
ELSE
	IF XIn >= X1 THEN
		FU_wLinear4Ends 			:=		Y1;
	ELSIF XIn <= X4 THEN
		FU_wLinear4Ends 			:=		Y4;
	ELSIF XIn < X1 AND XIn >= X2 THEN
		//a value is calculated
		IF X2 - X1 = 0 THEN	a := 0; ELSE a := (TO_REAL(Y2) - TO_REAL(Y1)) / (TO_REAL(X2) - TO_REAL(X1)); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y1) - (a * TO_REAL(X1));
		//Output is calculated
		FU_wLinear4Ends 			:=		TO_WORD(a * TO_REAL (XIn) + b);
	ELSIF XIn < X2 AND XIn >= X3 THEN
		//a value is calculated
		IF X3 - X2 = 0 THEN	a := 0; ELSE a := (TO_REAL(Y3) - TO_REAL(Y2)) / (TO_REAL(X3) - TO_REAL(X2)); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y2) - (a * TO_REAL(X2));
		//Output is calculated
		FU_wLinear4Ends 			:=		TO_WORD(a * TO_REAL (XIn) + b);
	ELSIF XIn < X3 AND XIn > X4 THEN
		//a value is calculated
		IF X4 - X3 = 0 THEN	a := 0; ELSE a := (TO_REAL(Y4) - TO_REAL(Y3)) / (TO_REAL(X4) - TO_REAL(X3)); END_IF
		//b value is calculated
		b 							:=		TO_REAL(Y3) - (a * TO_REAL(X3));
		//Output is calculated
		FU_wLinear4Ends 			:=		TO_WORD(a * TO_REAL (XIn) + b);
	END_IF
END_IF