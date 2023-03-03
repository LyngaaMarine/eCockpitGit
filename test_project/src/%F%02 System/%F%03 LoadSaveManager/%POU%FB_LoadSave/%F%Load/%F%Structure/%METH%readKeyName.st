METHOD readKeyName : BOOL
VAR_INPUT
	name			:POINTER TO EASCII;		//Address of the name to find, only input string address or zero terminated byte array
	lenMax			:DWORD;
END_VAR
VAR_OUTPUT
	len				:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
readKeyName		:=		reader.readKeyName(name:=name,lenMax:=lenMax,len=>len);