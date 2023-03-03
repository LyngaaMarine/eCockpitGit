{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions converts a word value to a bool array
//It must be used in the following way
//FU_WordToBoolArray(wIn:=InputWord,pArray:= ADR(BoolArray), usiSize:= SIZEOF(BoolArray));
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 09-03-18 | Creation
// | 1.1       | NSN      | 13-06-18 | Updated names and types
FUNCTION FU_WordToBoolArray : BOOL
VAR_INPUT
	wIn				:WORD;				//Input value
	pArray			:POINTER TO BOOL;	//Address of bool array
	usiSize			:USINT;				//Size of bool array
END_VAR
VAR
	i				:BYTE;
END_VAR
!__IMPLEMENTATION__!
IF NOT(usiSize = 0) THEN		//Array must be bigger than 0
	IF usiSize > 16 THEN		//Array must be 16 bools or less
		usiSize				:=		16;
	END_IF
	FOR i := 0 TO usiSize - 1 DO
		pArray^				:=		FU_wBitGet(wVar:=wIn,bIndex:=i);
		pArray				:=		pArray + 1;		
	END_FOR
END_IF