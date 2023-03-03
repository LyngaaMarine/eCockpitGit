//This method returns the character of a given position from the key name
//Returns null if out of range
//1 is the first character, 0 is also the first character
METHOD readKeyNameChar : EASCII
VAR_INPUT
	charNum			:WORD;		//Character number
END_VAR
(*%!%__DELIMITER__%!%*)
readKeyNameChar		:=		reader.readKeyNameChar(charNum:=charNum);