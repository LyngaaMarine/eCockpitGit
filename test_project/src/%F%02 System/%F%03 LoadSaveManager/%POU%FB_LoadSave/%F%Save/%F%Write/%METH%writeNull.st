//This adds a value data to the buffer
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 22-06-20 | Creation
METHOD writeNull
(*%!%__DELIMITER__%!%*)
writer.writeNull();
logChange(valPoint:=0,valType:=ESysType.tNONE);