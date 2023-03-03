//This functions replaces all instances of a character with another
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 13-06-18 | Creation                                                                                                              |
FUNCTION FU_sReplaceCharBI
VAR_IN_OUT
	str			:STRING(1);			//Input String
END_VAR
VAR_INPUT
	eOGChar		:EASCII;				//Character to replace
	eReplaceChar:EASCII;				//Character to replace by
END_VAR
VAR
	pStr		:POINTER TO BYTE;	//Address of the string
END_VAR
(*%!%__DELIMITER__%!%*)
pStr					:=		ADR(str);
WHILE pStr^ <> 0 DO
	IF pStr^ = eOGChar THEN
		pStr^			:=		eReplaceChar;
	END_IF
	pStr				:=		pStr + 1;
END_WHILE