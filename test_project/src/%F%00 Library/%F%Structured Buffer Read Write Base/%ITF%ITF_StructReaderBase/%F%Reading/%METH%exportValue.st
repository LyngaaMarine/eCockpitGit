//This method returns the buffer position and size of the currently selected struct/object
METHOD exportValue : BOOL
VAR_OUTPUT
	position		:POINTER TO EASCII;
	size			:DWORD;
END_VAR
(*%!%__DELIMITER__%!%*)