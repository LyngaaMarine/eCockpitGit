//This function, returns the lenght of a string of any size from a pointer
//Input string must be zero terminated
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 16-09-20 | Creation
FUNCTION FU_LenAI : DWORD
VAR_INPUT
	str			:POINTER TO EASCII;			//Input String
END_VAR
(*%!%__DELIMITER__%!%*)
IF str <> 0 THEN
	WHILE str^ <> 0 DO
		FU_LenAI		:=		FU_LenAI + 1;
		str				:=		str + 1;
	END_WHILE
END_IF