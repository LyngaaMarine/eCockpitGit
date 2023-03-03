//This adds a value data to the buffer
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 22-06-20 | Creation
METHOD writeReal
VAR_INPUT
	value			:REAL;
END_VAR
(*%!%__DELIMITER__%!%*)
writer.writeReal(value:=value);
logChange(valPoint:=ADR(value),valType:=ESysType.tREAL);