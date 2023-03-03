//This function, returns the lenght of a string
// |**Version**|**Author**| **Date** |**Changes**
// | 1         | NSN      | 13-06-18 | Creation
FUNCTION FU_wFind : WORD
VAR_INPUT
	s1			:STRING(255);		//Input String1
	s2			:STRING(255);		//Input String2
END_VAR
(*%!%__DELIMITER__%!%*)
FU_wFind	:=		FU_wFindBI(s1:=s1,s2:=s2);