{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This function padds the front of a string with the given character, the given amount
//If the padd amount plus the string is longer than the output string, the input string will be cut off to make space for the padding
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 04-02-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_sPaddFrontLen : STRING(255)
VAR_INPUT
	sStr		:STRING(255);		//Input String
	wLen		:WORD;				//How much to padd it
	eChar		:EASCII;		//Which character to padd with
END_VAR
!__IMPLEMENTATION__!
FU_sPaddFrontLenBIBO(sOut:=FU_sPaddFrontLen,sStr:=sStr,wLen:=wLen,wOutSize:=255,eChar:=eChar);