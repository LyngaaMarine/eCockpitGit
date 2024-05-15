{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This adds a key and a value to the buffer
// |**Version**|**Author**| **Date** |**Changes** 
// | 1         | NSN      | 22-06-20 | Creation
METHOD addKey : BOOL
VAR_INPUT
	name			:POINTER TO EASCII;	//Address of string for the tag name text
END_VAR
!__IMPLEMENTATION__!
addKey			:=		writer.addKey(name:=name);
IF doLogInt THEN
	keyFound	:=		reader.findKey(name:=name) <> EStructType.none;
END_IF