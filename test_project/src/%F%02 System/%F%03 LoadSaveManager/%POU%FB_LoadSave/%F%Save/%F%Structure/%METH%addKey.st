//This adds a key and a value to the buffer
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 22-06-20 | Creation
METHOD addKey : BOOL
VAR_INPUT
	name			:POINTER TO EASCII;	//Address of string for the tag name text
END_VAR
(*%!%__DELIMITER__%!%*)
addKey			:=		writer.addKey(name:=name);
IF doLogInt THEN
	keyFound	:=		reader.findKey(name:=name) <> EStructType.none;
END_IF