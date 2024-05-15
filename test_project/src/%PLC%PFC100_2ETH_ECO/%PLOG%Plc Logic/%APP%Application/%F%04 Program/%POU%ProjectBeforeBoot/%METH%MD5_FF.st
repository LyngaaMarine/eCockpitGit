{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
METHOD PROTECTED MD5_FF : DWORD
//MD5 transformations for round 1
VAR_INPUT
	dwA		:DWORD;
	dwB		:DWORD;
	dwC		:DWORD;
	dwD		:DWORD;
	dwX		:DWORD;
	dwS		:UINT;
	dwT		:DWORD;
END_VAR
VAR
	dwF		:DWORD;
END_VAR

!__IMPLEMENTATION__!
dwF			:=		((dwB AND dwC)) OR ((NOT(dwB) AND dwD));
MD5_FF	:=		dwB + ROL(dwA + dwF + dwX + dwT,dwS);