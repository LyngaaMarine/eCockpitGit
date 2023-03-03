//This function padds the back of a string with the given character, the given amount
//If the padd amount plus the string is longer than the output string, the input string will be cut off to make space for the padding
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 04-02-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_sPaddBackBI : STRING(255)
VAR_IN_OUT
	sStr		:STRING(1);			//Input String
END_VAR
VAR_INPUT
	wPadds		:WORD;				//How much to padd it
	eChar		:EASCII;		//Which character to padd with
END_VAR
(*%!%__DELIMITER__%!%*)
FU_sPaddBackBIBO(sOut:=FU_sPaddBackBI,sStr:=sStr,wPadds:=wPadds,wOutSize:=255,eChar:=eChar);