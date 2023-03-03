//This function, converts an x, value to an y value using and x amount of points on the x and y scale
//This function has ends, which means the output is never greater or smaller than the range of y
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 03-01-18 | Creation
FUNCTION FU_diLinearXEnds : DINT
VAR_INPUT
	xIn			:DINT;				//Input value to be linearised
	pXArray		:POINTER TO DINT;	//Address of x array
	pYArray		:POINTER TO DINT; 	//Address of y array
	uiSize		:UINT;				//Amount of points in 
END_VAR
VAR
	LowerLimit	:BOOL;
	UpperLimit	:BOOL;
	UpperXAdr	:POINTER TO DINT;	//Buffer for current x address
	LowerXAdr	:POINTER TO DINT;	//Buffer for current x address
	UpperYAdr	:POINTER TO DINT; 	//Buffer for current y address
	LowerYAdr	:POINTER TO DINT; 	//Buffer for current y address
	FOR1		:UINT;
	a			:REAL;
	b			:REAL;
	d			:BOOL;
END_VAR
(*%!%__DELIMITER__%!%*)
IF uiSize > 1 THEN
	//Direction is found
	UpperXAdr					:=		pXArray + 4;
	d							:=		UpperXAdr^ > pXArray^;
	
	//Pointers are set
	UpperXAdr					:=		pXArray;
	UpperYAdr					:=		pYArray;
	
	FOR FOR1 := 1 TO uiSize DO
		IF d THEN
			IF UpperXAdr^ <= xIn THEN
				IF FOR1 = uiSize AND UpperXAdr^ <> xIn THEN
					UpperLimit	:=		TRUE;
				ELSIF FOR1 <> uiSize THEN
					UpperXAdr	:=		UpperXAdr + 4;
					UpperYAdr	:=		UpperYAdr + 4;
				END_IF
			ELSE
				IF pXArray = UpperXAdr THEN
					LowerLimit	:=		TRUE;
				ELSE
					LowerXAdr	:=		UpperXAdr - 4;
					LowerYAdr	:=		UpperYAdr - 4;
				END_IF
				Exit;
			END_IF		
		ELSE
			IF UpperXAdr^ >= xIn THEN
				IF FOR1 = uiSize AND UpperXAdr^ <> xIn THEN
					UpperLimit	:=		TRUE;
				ELSIF FOR1 <> uiSize THEN
					UpperXAdr	:=		UpperXAdr + 4;
					UpperYAdr	:=		UpperYAdr + 4;
				END_IF
			ELSE
				IF pXArray = UpperXAdr THEN
					LowerLimit	:=		TRUE;
				ELSE
					LowerXAdr	:=		UpperXAdr - 4;
					LowerYAdr	:=		UpperYAdr - 4;
				END_IF
				Exit;
			END_IF		
		END_IF
	END_FOR
	
	IF LowerLimit THEN
		FU_diLinearXEnds			:=		pYArray^;
	ELSIF UpperLimit THEN
		FU_diLinearXEnds			:=		UpperYAdr^;
	ELSE
		IF xIn = UpperXAdr^ THEN
			FU_diLinearXEnds		:=		UpperYAdr^;
		ELSIF xIn = LowerXAdr^ THEN
			FU_diLinearXEnds		:=		LowerYAdr^;
		ELSE	
			IF UpperXAdr^ - LowerXAdr^ = 0 THEN
				a				:=		0;
			ELSE
				a				:=		TO_REAL(UpperYAdr^ - LowerYAdr^) / TO_REAL(UpperXAdr^ - LowerXAdr^);
			END_IF
			b					:=		TO_REAL(LowerYAdr^) - (a * TO_REAL(LowerXAdr^));
			FU_diLinearXEnds 	:=		TO_INT(a * TO_REAL(xIn) + b);	
		END_IF
	END_IF
END_IF