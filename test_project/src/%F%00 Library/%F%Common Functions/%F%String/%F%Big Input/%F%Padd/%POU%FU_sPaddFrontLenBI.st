//This function padds the front of a string with the given character, the given amount
//If the padd amount plus the string is longer than the output string, the input string will be cut off to make space for the padding
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 04-02-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_sPaddFrontLenBI : STRING(255)
VAR_IN_OUT
	sStr		:STRING(1);			//Input String
END_VAR
VAR_INPUT
	wLen		:WORD;				//How much to padd it
	eChar		:EASCII;		//Which character to padd with
END_VAR
(*%!%__DELIMITER__%!%*)
FU_sPaddFrontLenBIBO(sOut:=FU_sPaddFrontLenBI,sStr:=sStr,wLen:=wLen,wOutSize:=255,eChar:=eChar);