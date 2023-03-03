METHOD PROTECTED MD5_HH : DWORD
//MD5 transformations for rounds 3
VAR_INPUT
	dwA		:DWORD;
	dwB		:DWORD;
	dwC		:DWORD;
	dwD		:DWORD;
	dwX		:DWORD;
	dwS		:UINT;
	dwT		:DWORD;
END_VAR

(*%!%__DELIMITER__%!%*)
MD5_HH	:=		dwB + ROL( (dwA + (dwB XOR dwC XOR dwD) + dwX + dwT) , dwS);