{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions deletes a part of a string
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 13-06-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1.1       | NSN      | 05-02-19 | Made dependant on big output version                                                                                  |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_sDelete : STRING(255)
VAR_INPUT
	sStr		:STRING(255);		//Input String
	wLen		:WORD;				//Amount to delete
	wPos		:WORD;				//Position to delete from
END_VAR
!__IMPLEMENTATION__!
FU_sDeleteBIBO(sOut:= FU_sDelete,sStr:= sStr,wLen:= wLen,wPos:= wPos,wOutSize:= 255);