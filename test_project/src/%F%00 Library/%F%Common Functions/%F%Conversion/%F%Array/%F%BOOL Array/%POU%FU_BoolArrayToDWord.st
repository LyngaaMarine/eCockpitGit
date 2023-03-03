//This functions converts an array of bools to a word, a maximum of 32 bools can be converted
//It must be used in the following way
//FU_BoolArrayToDWord(pArray:= ADR(BoolArray), usiSize:= SIZEOF(BoolArray));
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 28-03-18 | Creation
// | 1.1       | NSN      | 13-06-18 | Updated names and types
FUNCTION FU_BoolArrayToDWord : DWORD
VAR_INPUT
	pArray			:POINTER TO BOOL;	//Address of bool array
	usiSize			:USINT;				//Size of bool array
END_VAR
VAR
	i				:BYTE;
END_VAR
(*%!%__DELIMITER__%!%*)
IF NOT(usiSize = 0) THEN		//Array must be bigger than 0
	IF usiSize > 32 THEN		//Array must be 32 bools or less
		usiSize				:=		32;
	END_IF
	FOR i := 0 TO usiSize - 1 DO
		FU_dwBitSet(dbVar:=FU_BoolArrayToDWord,bIndex:=i,xVal:=pArray^);
		pArray				:=		pArray + 1;		
	END_FOR
END_IF