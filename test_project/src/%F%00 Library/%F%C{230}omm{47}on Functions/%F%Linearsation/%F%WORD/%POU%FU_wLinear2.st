{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function, converts an x, value to an y value using and 2 points on the x and y scale
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 21-06-18 | Creation
// | 2         | NSN      | 24-05-22 | Fixed cases where y difference was negative
FUNCTION FU_wLinear2 : WORD
VAR_INPUT
	XIn		:WORD;
	X1		:WORD;
	X2		:WORD;
	Y1		:WORD;
	Y2		:WORD;
END_VAR
VAR
	a		:REAL;
	b		:REAL;
END_VAR
!__IMPLEMENTATION__!
IF X2 > X1 THEN
	//a value is calculated
	IF X2 - X1 = 0 THEN	a := 0; ELSE a := (TO_REAL(Y2) - TO_REAL(Y1)) / (TO_REAL(X2) - TO_REAL(X1)); END_IF
	//b value is calculated
	b 							:=		TO_REAL(Y1) - (a * TO_REAL(X1));
	//Output is calculated
	FU_wLinear2 				:=		TO_WORD(a * TO_REAL (XIn) + b);
ELSE
	//a value is calculated
	IF X2 - X1 = 0 THEN	a := 0; ELSE a := (TO_REAL(Y2) - TO_REAL(Y1)) / (TO_REAL(X2) - TO_REAL(X1)); END_IF
	//b value is calculated
	b 							:=		TO_REAL(Y1) - (a * TO_REAL(X1));
	//Output is calculated
	FU_wLinear2 				:=		TO_WORD(a * TO_REAL (XIn) + b);
END_IF