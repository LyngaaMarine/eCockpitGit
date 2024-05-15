{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method finds the key of the given name in the object
//Returns cursor to where it was before if no tag is found
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 04-06-18 | Creation
METHOD findKey : EStructType
VAR_INPUT
	name			:POINTER TO EASCII;		//Address of the name to find, only input string address or zero terminated byte array
END_VAR
!__IMPLEMENTATION__!
findKey		:=		reader.findKey(name:=name);