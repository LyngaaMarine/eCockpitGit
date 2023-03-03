//This adds a value data to the buffer
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 22-06-20 | Creation
METHOD writeBool
VAR_INPUT
	value			:BOOL;				//Address of string for the filler text
END_VAR
(*%!%__DELIMITER__%!%*)
writer.writeBool(value:=value);
logChange(valPoint:=ADR(value),valType:=ESysType.tBool);