//This functions combines three strings
//This is the big input version which means any size string can be inputted, but only string variables will be accepted
//It is also faster on bigger strings
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-02-19 | Creation
// | 2         | NSN      | 14-10-21 | Changed to pointer based
FUNCTION FU_sConcat3BI : STRING(255)
VAR_INPUT
	s1			:POINTER TO EASCII;						//Input String1
	s2			:POINTER TO EASCII;						//Input String2
	s3			:POINTER TO EASCII;						//Input String3
END_VAR
(*%!%__DELIMITER__%!%*)
FU_sConcat3BIBO(sOut:=ADR(FU_sConcat3BI),s1:=s1,s2:=s2,s3:=s3,wOutSize:=255);