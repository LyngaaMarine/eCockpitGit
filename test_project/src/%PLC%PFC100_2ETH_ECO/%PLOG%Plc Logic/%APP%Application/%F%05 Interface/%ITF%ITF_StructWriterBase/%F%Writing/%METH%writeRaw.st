{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This method writes a string of any size to the buffer as raw data without qoutes and escape characters
//Should only be used for copying data
METHOD writeRaw
VAR_INPUT
	value			:POINTER TO EASCII;	//Address of string for the filler text
END_VAR
!__IMPLEMENTATION__!
