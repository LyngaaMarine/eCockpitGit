//This functions deletes a part of a string values are counted from the right instead of the left
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 22-02-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_sDeleteRight : STRING(255)
VAR_INPUT
	sStr		:STRING(255);		//Input String
	wLen		:WORD;				//Amount to delete
	wPos		:WORD;				//Position to delete from
END_VAR
(*%!%__DELIMITER__%!%*)
FU_sDeleteRightBIBO(sOut:= FU_sDeleteRight, sStr:= sStr, wLen:= wLen,wPos:= wPos, wOutSize:= 255);