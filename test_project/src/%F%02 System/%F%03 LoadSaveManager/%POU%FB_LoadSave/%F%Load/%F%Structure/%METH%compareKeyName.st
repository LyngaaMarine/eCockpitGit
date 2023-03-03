//Returns true if the inputted string is the same as the read string
METHOD compareKeyName : EStructType
VAR_INPUT
	name				:POINTER TO EASCII;
END_VAR

(*%!%__DELIMITER__%!%*)
compareKeyName		:=		reader.compareKeyName(name:=name);