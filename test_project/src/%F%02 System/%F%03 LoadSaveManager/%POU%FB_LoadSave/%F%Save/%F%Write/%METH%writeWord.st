//This adds a value data to the buffer
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 16-05-21 | Creation
METHOD writeWord
VAR_INPUT
	value			:WORD;
END_VAR
(*%!%__DELIMITER__%!%*)
writer.writeWord(value:=value);
logChange(valPoint:=ADR(value),valType:=ESysType.tWORD);