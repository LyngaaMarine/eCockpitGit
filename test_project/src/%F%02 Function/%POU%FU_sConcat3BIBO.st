{
  "external": false, 
  "compiler_defines": "", 
  "link_always": false, 
  "exclude_from_build": false, 
  "enable_system_call": false
}
!__DECLARATION__!
//This functions combines 3 strings
//This is the big output version, it has no limits to input or output size
//The wOutSize must be correct otherwise the function can write to unwanted addresses
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-02-19 | Creation
// | 2         | NSN      | 14-10-21 | Changed to pointer based
FUNCTION FU_sConcat3BIBO : BOOL
VAR_INPUT
	sOut		:POINTER TO EASCII;			//Output String
	s1			:POINTER TO EASCII;						//Input String1
	s2			:POINTER TO EASCII;						//Input String2
	s3			:POINTER TO EASCII;						//Input String3
END_VAR
VAR_INPUT
	wOutSize	:WORD;				//Output String Size
END_VAR

!__IMPLEMENTATION__!
WHILE wOutSize > 0 DO
	wOutSize		:=		wOutSize - 1;
	IF s1^ <> 0 THEN
		sOut^		:=		s1^;
		s1			:=		s1 + 1;
	ELSIF s2^ <> 0 THEN
		sOut^		:=		s2^;
		s2			:=		s2 + 1;
	ELSIF s3^ <> 0 THEN
		sOut^		:=		s3^;
		s3			:=		s3 + 1;
	ELSE
		EXIT;
	END_IF
	sOut			:=		sOut + 1;
END_WHILE
sOut^				:=		EASCII.Null;