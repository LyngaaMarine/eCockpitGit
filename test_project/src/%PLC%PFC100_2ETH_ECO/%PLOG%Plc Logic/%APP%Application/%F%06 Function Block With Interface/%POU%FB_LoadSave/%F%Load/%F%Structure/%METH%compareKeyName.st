{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//Returns true if the inputted string is the same as the read string
METHOD compareKeyName : EStructType
VAR_INPUT
	name				:POINTER TO EASCII;
END_VAR

!__IMPLEMENTATION__!
compareKeyName		:=		reader.compareKeyName(name:=name);