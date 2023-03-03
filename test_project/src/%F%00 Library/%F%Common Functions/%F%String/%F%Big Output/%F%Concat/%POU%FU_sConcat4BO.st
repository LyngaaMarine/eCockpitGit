//This functions combines four strings
//This is the big output version, it has no limits to input or output size
//The wOutSize must be correct otherwise the function can write to unwanted addresses
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-02-19 | Creation
// | 2         | NSN      | 14-10-21 | Changed to pointer based
FUNCTION FU_sConcat4BO : BOOL
VAR_IN_OUT
	sOut		:POINTER TO EASCII;			//Output String
END_VAR
VAR_INPUT
	s1			:STRING(255);			//Input String1
	s2			:STRING(255);			//Input String2
	s3			:STRING(255);			//Input String3
	s4			:STRING(255);			//Input String4
	wOutSize	:WORD;				//Output String Size
END_VAR
(*%!%__DELIMITER__%!%*)
FU_sConcat4BIBO(sOut:=sOut,s1:=ADR(s1),s2:=ADR(s2),s3:=ADR(s3),s4:=ADR(s4),wOutSize:=wOutSize);