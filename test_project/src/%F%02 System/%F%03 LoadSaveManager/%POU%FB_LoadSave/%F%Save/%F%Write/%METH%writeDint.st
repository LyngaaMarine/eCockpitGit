//This adds a value data to the buffer
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 22-06-20 | Creation
METHOD writeDint
VAR_INPUT
	value			:DINT;
END_VAR
(*%!%__DELIMITER__%!%*)
writer.writeDint(value:=value);
logChange(valPoint:=ADR(value),valType:=ESysType.tDINT);