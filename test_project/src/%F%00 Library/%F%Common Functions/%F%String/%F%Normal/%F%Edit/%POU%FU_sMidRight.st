//This functions extracts a part of a string, values are counted from the right instead of the left
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 22-02-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_sMidRight : STRING(255)
VAR_INPUT
	sStr		:STRING(255);		//Input String
	wLen		:WORD;				//Amount to copy
	wPos		:WORD;				//Position to copy from
END_VAR
(*%!%__DELIMITER__%!%*)
FU_sMidRightBIBO(sOut:= FU_sMidRight,sStr:= sStr,wLen:= wLen,wPos:= wPos,wOutSize:= 255);