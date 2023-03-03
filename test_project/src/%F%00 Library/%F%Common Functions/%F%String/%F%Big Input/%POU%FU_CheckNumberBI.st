//This function checks if a string only contains numbers, dot (.) and dash (-) are also permitted as they are required for some numbers
//Returns true if string only contains numbers
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 10-12-18 | Creation
FUNCTION FU_CheckNumberBI : BOOL
VAR_IN_OUT
	str			:STRING(1);	//String
END_VAR
VAR
	pStr		:POINTER TO BYTE;	//Address of source string
END_VAR
(*%!%__DELIMITER__%!%*)
pStr					:=		ADR(str);	//Address of source string
//It runs until string ends
WHILE pStr^ <> 0 DO
	//This checks if the selected character is in the range of numbers
	IF NOT((pStr^ >= 48 AND pStr^ <= 57) OR pStr^ = 46 OR pStr^ = 45) THEN
		RETURN;
	END_IF 
	pStr				:=		pStr + 1;		
END_WHILE
FU_CheckNumberBI		:=		TRUE;