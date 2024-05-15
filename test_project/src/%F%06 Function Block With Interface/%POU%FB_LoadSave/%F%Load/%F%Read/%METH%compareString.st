{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//Returns true if the inputted string is the same as the read string
METHOD compareString : BOOL
VAR_INPUT
	str				:POINTER TO EASCII;
END_VAR
!__IMPLEMENTATION__!
compareString		:=		reader.compareString(str:=str);