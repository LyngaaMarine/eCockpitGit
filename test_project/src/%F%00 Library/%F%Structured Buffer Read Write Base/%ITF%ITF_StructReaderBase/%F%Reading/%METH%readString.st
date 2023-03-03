//This method returns the string value of the currently selected item
//Returns true on output if value is valid
METHOD readString
VAR_INPUT
	str		:POINTER TO EASCII;		//Address of the name to find, only input string address or zero terminated byte array
	lenMax	:DWORD;					//Max lenght of string value
END_VAR
VAR_OUTPUT
	len		:WORD;					//Actual lenght of string value
END_VAR
(*%!%__DELIMITER__%!%*)
