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
IF ready AND NOT(afterKey OR inArray) AND inObject THEN
	addChar(char:=EASCII.DoubleQoute);
	addString(pString:=name);
	addChar(char:=EASCII.DoubleQoute);
	//Open tag ends
	addChar(char:=EASCII.Colon);
	afterKey			:=		TRUE;
	addKey				:=		TRUE;
END_IF
