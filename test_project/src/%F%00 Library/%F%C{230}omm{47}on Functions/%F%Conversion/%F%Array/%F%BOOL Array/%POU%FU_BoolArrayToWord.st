{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions converts an array of bools to a word, a maximum of 16 bools can be converted
//It must be used in the following way
//FU_BoolArrayToWord(pArray:= ADR(BoolArray), usiSize:= SIZEOF(BoolArray));
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 08-03-18 | Creation
// | 1.1       | NSN      | 13-06-18 | Updated names and types
FUNCTION FU_BoolArrayToWord : WORD
VAR_INPUT
	pArray			:POINTER TO BOOL;	//Address of bool array
	usiSize			:USINT;				//Size of bool array
END_VAR
VAR
	i				:BYTE;
END_VAR
!__IMPLEMENTATION__!
IF NOT(usiSize = 0) THEN		//Array must be bigger than 0
	IF usiSize > 16 THEN		//Array must be 16 bools or less
		usiSize					:=		16;
	END_IF
	FOR i := 0 TO usiSize - 1 DO
		FU_wBitSet(bVar:=FU_BoolArrayToWord,bIndex:=i,xVal:=pArray^);
		pArray				:=		pArray + 1;		
	END_FOR
END_IF