//Returns true if the inputted string is the same as the read string
METHOD compareString : BOOL
VAR_INPUT
	str				:POINTER TO EASCII;
END_VAR
(*%!%__DELIMITER__%!%*)
compareString		:=		reader.compareString(str:=str);