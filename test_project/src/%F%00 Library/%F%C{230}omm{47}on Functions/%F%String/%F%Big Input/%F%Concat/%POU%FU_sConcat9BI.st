{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions combines nine strings
//This is the big input version which means any size string can be inputted, but only string variables will be accepted
//It is also faster on bigger strings
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 05-02-19 | Creation
// | 2         | NSN      | 14-10-21 | Changed to pointer based
FUNCTION FU_sConcat9BI : STRING(255)
VAR_INPUT
	s1			:POINTER TO EASCII;			//Input String1
	s2			:POINTER TO EASCII;			//Input String2
	s3			:POINTER TO EASCII;			//Input String3
	s4			:POINTER TO EASCII;			//Input String4
	s5			:POINTER TO EASCII;			//Input String5
	s6			:POINTER TO EASCII;			//Input String6
	s7			:POINTER TO EASCII;			//Input String7
	s8			:POINTER TO EASCII;			//Input String8
	s9			:POINTER TO EASCII;			//Input String9
END_VAR
!__IMPLEMENTATION__!
FU_sConcat9BIBO(sOut:=ADR(FU_sConcat9BI),s1:=s1,s2:=s2,s3:=s3,s4:=s4,s5:=s5,s6:=s6,s7:=s7,s8:=s8,s9:=s9,wOutSize:=255);