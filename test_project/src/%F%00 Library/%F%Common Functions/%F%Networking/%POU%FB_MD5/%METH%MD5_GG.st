METHOD PROTECTED MD5_GG : DWORD
//MD5 transformations for round 2
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
	dwG		:DWORD;
END_VAR

(*%!%__DELIMITER__%!%*)
dwG			:=		(dwB AND dwD) OR (dwC AND NOT dwD);
MD5_GG	:=		dwB + ROL(dwA + dwG + dwX + dwT, dwS);