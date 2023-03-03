//This adds a value data to the buffer
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 16-05-21 | Creation
METHOD writeDword
VAR_INPUT
	value			:DWORD;
END_VAR
(*%!%__DELIMITER__%!%*)
writer.writeDword(value:=value);
logChange(valPoint:=ADR(value),valType:=ESysType.tDWORD);