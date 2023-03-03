//This function, returns the lenght of a string of any size
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 10-12-18 | Creation
FUNCTION FU_LenBI : DWORD
VAR_IN_OUT
	str			:STRING(1);			//Input String
END_VAR
VAR
	pStr		:POINTER TO BYTE;	//Address of the string
END_VAR
(*%!%__DELIMITER__%!%*)
pStr					:=		ADR(str);
WHILE pStr^ <> 0 DO
	FU_LenBI			:=		FU_LenBI + 1;
	pStr				:=		pStr + 1;
END_WHILE