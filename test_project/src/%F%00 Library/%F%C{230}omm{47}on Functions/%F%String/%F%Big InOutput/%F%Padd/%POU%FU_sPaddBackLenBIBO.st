{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function padds the back of a string with the given character, the given amount
//If the padd amount plus the string is longer than the output string, the input string will be cut off to make space for the padding
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 04-02-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_sPaddBackLenBIBO : BOOL
VAR_IN_OUT
	sOut		:STRING(1);			//Output String
	sStr		:STRING(1);			//Input String
END_VAR
VAR_INPUT
	wLen		:WORD;				//How much to padd it
	wOutSize	:WORD;				//Output String Size
	eChar		:EASCII;		//Which character to padd with
END_VAR
VAR
	
	In1Add		:POINTER TO BYTE;	//Address of first string
	StrAdd		:POINTER TO BYTE;	//Address of output string
END_VAR
!__IMPLEMENTATION__!
In1Add			:=		ADR(sStr);
StrAdd			:=		ADR(sOut);
FU_wMinMaxValue(Variable:= wLen, MinVal:= 0, MaxVal:= wOutSize);
wOutSize		:=		FU_wLenBI(Str:= sStr);
IF wOutSize < wLen THEN
	wOutSize	:=		wLen - wOutSize;
ELSE
	wOutSize	:=		0;	
END_IF
FU_sPaddBackBIBO(sOut:= sOut, sStr:= sStr, wPadds:= wOutSize,wOutSize:=wLen,eChar:=eChar);