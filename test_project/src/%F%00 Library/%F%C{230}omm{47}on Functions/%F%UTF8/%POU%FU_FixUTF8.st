{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This fixes an utf8 string of fixed lenght
//Meaning it checks if the string cuts off in the middle of an utf8 string
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 18-12-20 | Creation
FUNCTION FU_FixUTF8 : BOOL
VAR_INPUT
	str			:ANY;
END_VAR
VAR
	strPoint	:POINTER TO BYTE;
END_VAR
!__IMPLEMENTATION__!
CASE TO_BYTE(str.TypeClass) OF
	ESysType.tSTRING:
		strPoint			:=		str.pValue + TO_WORD(str.diSize) - 2;
ELSE
	strPoint				:=		str.pValue + TO_WORD(str.diSize) - 1;
END_CASE
IF strPoint^ <> 0 THEN
	CASE FU_CheckUTF8(strStart:=str.pValue,char:=strPoint, start=>str.pValue) OF
		1,2,4:str.pValue^	:=		0;
	END_CASE
END_IF