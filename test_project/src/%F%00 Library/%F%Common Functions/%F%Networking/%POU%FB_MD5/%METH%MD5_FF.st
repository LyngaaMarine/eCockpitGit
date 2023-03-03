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

(*%!%__DELIMITER__%!%*)
dwF			:=		((dwB AND dwC)) OR ((NOT(dwB) AND dwD));
MD5_FF	:=		dwB + ROL(dwA + dwF + dwX + dwT,dwS);