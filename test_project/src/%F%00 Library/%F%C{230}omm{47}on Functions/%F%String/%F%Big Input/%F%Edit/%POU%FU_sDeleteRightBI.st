{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions deletes a part of a string values are counted from the right instead of the left
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// |**Version**|**Author**| **Date** |**Changes**                                                                                                            |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
// | 1         | NSN      | 22-02-19 | Creation                                                                                                              |
// +-----------+----------+----------+-----------------------------------------------------------------------------------------------------------------------+
FUNCTION FU_sDeleteRightBI : STRING(255)
VAR_IN_OUT
	sStr		:STRING(1);			//Input String	
END_VAR
VAR_INPUT
	wLen		:WORD;				//Amount to trim from end
	wPos		:WORD;				//Position to delete from
END_VAR
!__IMPLEMENTATION__!
FU_sDeleteRightBIBO(sOut:= FU_sDeleteRightBI, sStr:= sStr, wLen:= wLen,wPos:= wPos, wOutSize:= 255);