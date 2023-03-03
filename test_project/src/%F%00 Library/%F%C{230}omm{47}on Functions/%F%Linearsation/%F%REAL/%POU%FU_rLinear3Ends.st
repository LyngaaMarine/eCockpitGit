{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function, converts an x, value to an y value using and 3 points on the x and y scale
//This function has ends, which means the output is never greater or smaller than the range of y
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 29-03-22 | Creation
FUNCTION FU_rLinear3Ends : REAL
VAR_INPUT
	XIn		:REAL;
	X1		:REAL;
	X2		:REAL;
	X3		:REAL;
	Y1		:REAL;
	Y2		:REAL;
	Y3		:REAL;
END_VAR
VAR
	a		:REAL;
END_VAR
!__IMPLEMENTATION__!
IF X3 > X1 THEN
	IF XIn <= X1 THEN	//When input is out of bounds
		FU_iLinear3Ends 			:=		Y1;
	ELSIF XIn >= X3 THEN	//When input is out of bounds
		FU_iLinear3Ends 			:=		Y3;
	ELSIF XIn <= X2 THEN	//When input is with the 
		IF X2 - X1 = 0 THEN
			a						:=		0;
		ELSE
			a						:=		(Y2 - Y1) / (X2 - X1);
		END_IF
		FU_iLinear3Ends 			:=		a * XIn + (Y1 - (a * X1));
	ELSE
		IF X3 - X2 = 0 THEN
			a						:=		0;
		ELSE
			a						:=		(Y3 - Y2) / (X3 - X2);
		END_IF
		FU_iLinear3Ends 			:=		a * XIn + (Y2 - (a * X2));
	END_IF
ELSE
	IF XIn >= X1 THEN
		FU_iLinear3Ends 			:=		Y1;
	ELSIF XIn <= X3 THEN
		FU_iLinear3Ends 			:=		Y3;
	ELSIF XIn >= X2 THEN	
		IF X2 - X1 = 0 THEN
			a						:=		0;
		ELSE
			a						:=		(Y2 - Y1) / (X2 - X1);
		END_IF
		FU_iLinear3Ends 			:=		a * XIn + (Y1 - (a * X1));
	ELSE
		IF X3 - X2 = 0 THEN	
			a						:=		0;
		ELSE 
			a						:=		(Y3 - Y2) / (X3 - X2); 
		END_IF
		FU_iLinear3Ends 			:=		a * XIn + (Y2 - (a * X2));
	END_IF
END_IF