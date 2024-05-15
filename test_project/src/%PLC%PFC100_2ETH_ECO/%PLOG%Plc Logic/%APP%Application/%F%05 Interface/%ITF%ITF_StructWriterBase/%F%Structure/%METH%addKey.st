{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method adds a key of any size to the current stuct/object
//It only works within structs/objects
METHOD addKey : BOOL
VAR_INPUT
	name			:POINTER TO EASCII;	//Address of string for the tag name text
END_VAR

!__IMPLEMENTATION__!
