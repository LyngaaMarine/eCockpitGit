{"external": false, "compiler_defines": "", "link_always": false, "exclude_from_build": false, "enable_system_call": false}
//This functions extracts a part of a string
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 13-06-18 | Creation                                                                                                              |
// | 1.1       | NSN      | 05-02-19 | Made dependant on big output version                                                                                  |
FUNCTION FU_sMidBI : STRING(255)
VAR_IN_OUT
	sStr		:STRING(1);			//Input String
END_VAR
VAR_INPUT
	wLen		:WORD;				//Amount to copy
	wPos		:WORD;				//Position to copy from
END_VAR
!__IMPLEMENTATION__!
FU_sMidBIBO(sOut:= FU_sMidBI,sStr:= sStr,wLen:= wLen,wPos:= wPos,wOutSize:= 255);