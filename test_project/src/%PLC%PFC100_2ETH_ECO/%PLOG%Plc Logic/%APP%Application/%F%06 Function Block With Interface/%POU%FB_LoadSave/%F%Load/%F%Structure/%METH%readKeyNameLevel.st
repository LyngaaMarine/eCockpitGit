{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
METHOD readKeyNameLevel : BOOL
VAR_INPUT
	name			:POINTER TO EASCII;		//Address of the name to find, only input string address or zero terminated byte array
	lenMax			:DWORD;					//Max lenght of string value
	level			:BYTE;					//The level to get from
END_VAR
VAR_OUTPUT
	len				:WORD;					//Actual lenght of string value
END_VAR
!__IMPLEMENTATION__!
readKeyNameLevel		:=		reader.readKeyNameLevel(name:=name,lenMax:=lenMax,level:=level,len=>len);