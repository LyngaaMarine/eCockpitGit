//This method outputs the start address and size of the currently selected object
//True when ok
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD exportSelection : BOOL
VAR_OUTPUT
	position		:POINTER TO EASCII;
	size			:DWORD;
END_VAR
(*%!%__DELIMITER__%!%*)
exportSelection		:=		reader.exportSelection(position=>position,size=>size);