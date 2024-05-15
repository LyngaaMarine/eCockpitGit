{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//Unsupported
METHOD writeRawLen
VAR_INPUT
	value			:POINTER TO EASCII;	//Address of string for the filler text
	len				:DWORD;				//Amount of bytes to write
END_VAR
!__IMPLEMENTATION__!
;