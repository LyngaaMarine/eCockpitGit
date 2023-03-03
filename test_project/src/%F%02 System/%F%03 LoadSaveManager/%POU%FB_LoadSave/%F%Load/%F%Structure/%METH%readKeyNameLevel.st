METHOD readKeyNameLevel : BOOL
VAR_INPUT
	name			:POINTER TO EASCII;		//Address of the name to find, only input string address or zero terminated byte array
	lenMax			:DWORD;					//Max lenght of string value
	level			:BYTE;					//The level to get from
END_VAR
VAR_OUTPUT
	len				:WORD;					//Actual lenght of string value
END_VAR
(*%!%__DELIMITER__%!%*)
readKeyNameLevel		:=		reader.readKeyNameLevel(name:=name,lenMax:=lenMax,level:=level,len=>len);