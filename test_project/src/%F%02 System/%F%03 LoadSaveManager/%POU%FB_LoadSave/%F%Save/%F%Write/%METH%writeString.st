//This adds a value data to the buffer
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 22-06-20 | Creation
METHOD writeString
VAR_INPUT
	value			:POINTER TO EASCII;	//Address of string for the filler text
END_VAR

(*%!%__DELIMITER__%!%*)
writer.writeString(value:=value);
logChange(valPoint:=value,valType:=ESysType.tSTRING);