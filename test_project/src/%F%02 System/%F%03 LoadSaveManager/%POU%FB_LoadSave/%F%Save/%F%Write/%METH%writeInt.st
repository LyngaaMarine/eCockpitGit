//This adds a value data to the buffer
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 22-06-20 | Creation
METHOD writeInt
VAR_INPUT
	value			:INT;
END_VAR
(*%!%__DELIMITER__%!%*)
writer.writeInt(value:=value);
logChange(valPoint:=ADR(value),valType:=ESysType.tINT);