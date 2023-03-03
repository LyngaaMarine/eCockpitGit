{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions extracts a part of a string
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 13-06-18 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1.1       | NSN      | 05-02-19 | Made dependant on big output version                                                                                  |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_sMid : STRING(255)
VAR_INPUT
	sStr		:STRING(255);		//Input String
	wLen		:WORD;				//Amount to copy
	wPos		:WORD;				//Position to copy from
END_VAR
!__IMPLEMENTATION__!
FU_sMidBIBO(sOut:= FU_sMid,sStr:= sStr,wLen:= wLen,wPos:= wPos,wOutSize:= 255);