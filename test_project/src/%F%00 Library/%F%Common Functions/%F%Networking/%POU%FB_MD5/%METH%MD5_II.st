METHOD PROTECTED MD5_II : DWORD
//MD5 transformations for rounds 4
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
	dwI		:DWORD;
END_VAR

(*%!%__DELIMITER__%!%*)
dwI			:=		dwC XOR (dwB OR  NOT(dwD));
MD5_II	:=		dwB + ROL( (dwA + dwI + dwX + dwT), dwS );