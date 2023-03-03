//This method outputs the start address and size of the currently selected value
//True when ok
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD exportValue : BOOL
VAR_OUTPUT
	position		:POINTER TO EASCII;
	size			:DWORD;
END_VAR
(*%!%__DELIMITER__%!%*)
exportValue		:=		reader.exportValue(position=>position,size=>size);