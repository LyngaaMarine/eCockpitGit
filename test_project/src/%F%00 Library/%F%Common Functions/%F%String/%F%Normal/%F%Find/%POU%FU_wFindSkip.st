//This function, returns the lenght of a string
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 13-06-18 | Creation
FUNCTION FU_wFindSkip : WORD
VAR_INPUT
	s1			:STRING(255);		//Input String1
	s2			:STRING(255);		//Input String2
	skipAmount	:BYTE;				//Amount to skip
END_VAR
(*%!%__DELIMITER__%!%*)
FU_wFindSkip	:=		FU_wFindSkipBI(s1:=s1,s2:=s2,skipAmount:=skipAmount);