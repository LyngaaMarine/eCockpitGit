{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function, converts an x, value to an y value using and 2 points on the x and y scale
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 10-01-18 | Creation
// | 1.1       | NSN      | 13-06-18 | Updated names and types
// | 1.2       | NSN      | 29-03-22 | Minor optimization
FUNCTION FU_rLinear2 : REAL
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
!__IMPLEMENTATION__!
IF X2 > X1 THEN
	//a value is calculated
	IF X2 - X1 = 0 THEN
		a			:=		0;
	ELSE
		a			:=		(Y2 - Y1) / (X2 - X1);
	END_IF
	FU_rLinear2 	:=		a * XIn + (Y1 - (a * X1));
ELSE
	//a value is calculated
	IF X2 - X1 = 0 THEN
		a			:=		0;
	ELSE
		a			:=		(Y2 - Y1) / (X2 - X1);
	END_IF
	FU_rLinear2 	:=		a * XIn + (Y1 - (a * X1));
END_IF