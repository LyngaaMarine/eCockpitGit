//This functions extracts a part of a string, values are counted from the right instead of the left
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 22-02-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_sMidRightBI : STRING(255)
VAR_IN_OUT
	sStr		:STRING(1);			//Input String
END_VAR
VAR_INPUT
	wLen		:WORD;				//Amount to copy
	wPos		:WORD;				//Position to copy from
END_VAR
(*%!%__DELIMITER__%!%*)
FU_sMidRightBIBO(sOut:= FU_sMidRightBI,sStr:= sStr,wLen:= wLen,wPos:= wPos,wOutSize:= 255);